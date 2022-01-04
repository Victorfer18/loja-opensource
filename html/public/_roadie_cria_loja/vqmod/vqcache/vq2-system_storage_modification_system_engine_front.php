<?php
//========== Installment Plan Info Module: BEGIN ==========
        if (is_file(DIR_SYSTEM . 'library/installment_plan_info/installment_plan_info.php')) {
          require_once \VQMod::modCheck(DIR_SYSTEM . 'library/installment_plan_info/installment_plan_info.php');
        }
        //========== Installment Plan Info Module: END ============
final class Front {
	private $registry;
	private $pre_action = array();
	private $error;


        private function runAction($actionName) {
          // added in defensive checks to ensure the
          // controller class is available and accessible
          try {
            if (is_file(
              DIR_APPLICATION . '/controller/' . $actionName . '.php')) {
              $facebookAction = new Action($actionName);
              $facebookAction->execute($this->registry);
            }
          } catch (Exception $e) {
            error_log($e->getMessage());
          }
        }
      
	public function __construct($registry) {
		$this->registry = $registry;
	}

	public function addPreAction($pre_action) {
		$this->pre_action[] = $pre_action;
	}

	public function dispatch($action, $error) {

        // tracking the last pre_action in the list
        $lastPreAction = end($this->pre_action);
      
		$this->error = $error;

		foreach ($this->pre_action as $pre_action) {
			$result = $this->execute($pre_action);

        // additional attempt to extract the pixel details after
        // executing the last preaction on the list of pre-actions
        // we have to wait for all the preactions to be executed as 
        // only then all the required information will be ready, eg
        // uri mapping, shopping cart
        if (isset($lastPreAction) && $pre_action == $lastPreAction) {
          $this->runAction('extension/facebookeventparameters');
        }
      

			if ($result) {
				$action = $result;

				break;
			}
		}


            /* Welldone Theme modification */
    require_once(\VQMod::modCheck(DIR_SYSTEM . 'welldone/startup.php'));
    /* End of Welldone Theme modification */    
            

        // redirecting the direct checkout URL to product details page
        $this->runAction('extension/facebookpageshopcheckoutredirect');

        // building up the information for pixel firing
        $this->runAction('extension/facebookeventparameters');
      
//========== Installment Plan Info Module: BEGIN ==========
        if (!$this->registry->has('installment_plan_info')) {
          if (class_exists('InstallmentPlanInfo')) {
            $installment_plan_info = new InstallmentPlanInfo($this->registry);
            $this->registry->set('installment_plan_info', $installment_plan_info);
          }
        }
        //========== Installment Plan Info Module: END ============
		while ($action) {
			$action = $this->execute($action);
		}
	}

	private function execute($action) {
		$result = $action->execute($this->registry);

		if (is_object($result)) {
			$action = $result;
		} elseif ($result === false) {
			$action = $this->error;

			$this->error = '';
		} else {
			$action = false;
		}

		return $action;
	}
}