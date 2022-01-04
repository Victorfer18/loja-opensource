<?php echo $header;?>

<?php
  $custom_data = $this->welldone->get_settings('product-custom-data');
  $display_custom_right_block = false;
  
  $custom_tab_content_1 = '';
  $custom_tab_content_2 = '';
  $custom_tab_content_nav = '';
  
  if ($custom_data && isset($custom_data['html']))
  {
    $display_custom_right_block = true;
    
    $custom_tab_content = '';
            
    if ($custom_data && isset($custom_data['tabs']) && count($custom_data['tabs']))
    {
      $lng_id = $this->config->get('config_language_id');
      
      foreach($custom_data['tabs'] as $index=>$tab)
      {
        if (isset($tab['title'][$lng_id]) && isset($tab['html'][$lng_id]))
        {
          $tab_id = 'tab-custom-'.$custom_data['id'].'-'.$index; 
          $custom_tab_content_nav .= '<li><a href="#'.$tab_id.'" data-toggle="tab" class="text-uppercase">'.$tab['title'][$lng_id].'</a></li>';
          
          $custom_tab_content_1 .= '<div class="tab-pane" id="'.$tab_id.'">'.html_entity_decode($tab['html'][$lng_id], ENT_QUOTES, 'UTF-8').'</div>';
          $custom_tab_content_2 .= '<section class="product-additional__box" id="tab-review"><h3 class="text-uppercase">'.$tab['title'][$lng_id].'</h3>'.html_entity_decode($tab['html'][$lng_id], ENT_QUOTES, 'UTF-8').'</section>';

        }
        
      }
    }
  }
  
  /*if ($this->welldone->get_settings('product_page_layout','default') == 'simple')
  {
    $display_custom_right_block = false;
  }*/
  
  
  $youtube_code = '';
  if ($custom_data && strlen($custom_data['youtube_video']))
  {
    $youtube_code = '<li><a href="'.$custom_data['youtube_video'].'" class="video-link"><img src="image/welldone/products/product-small-empty.png" alt="" /></a></li>';
    
  }
?>

<section class="breadcrumbs  hidden-xs">
<div class="container">
  <ol class="breadcrumb breadcrumb--wd pull-left">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li itemscope itemtype="http://data-vocabulary.org/Breadcrumb"><a href="<?php echo $breadcrumb['href']; ?>" itemprop="url"><span itemprop="title"><?php echo $breadcrumb['text']; ?></span></a></li>
    <?php } ?>
  </ol>
</div>  
</section>

<?php if ($content_top){?>
  <?php echo $content_top; ?>
<?php }?>

<section class="content">
      <div class="container">
        <div class="row product-info-outer" itemscope itemtype="http://schema.org/Product">
       
        <?php $count_down_end = '';if ($thumb || $images) { ?>
        
         <?php if ($this->welldone->get_settings('product_page_image_view','bottom_slider') != 'vertical_slider') { ?> 
          <div class="col-md-offset-1 col-sm-5 col-md-5 hidden-xs">
          <?php if ($thumb) { ?>
            <div class="product-main-image">
              
              <?php $count_down_end = '';foreach($labels as $label_type=>$label_text){
                
                $color_options = array();
                
                if ($label_type == 'new' && $this->welldone->get_settings('label_product_page_main','show') == 'show')
                  echo '<div class="product-preview__label product-preview__label--left product-preview__label--new"><span>'.$label_text.'</span></div>';
                elseif ($label_type == 'discount' && $this->welldone->get_settings('label_product_page_main','show') == 'show')
                  echo '<div class="product-preview__label product-preview__label--right product-preview__label--sale"><span>'.$label_text.'</span></div>';
                elseif ($label_type == 'outofstock' && $this->welldone->get_settings('label_product_page_main','show') == 'show')
                  echo '<div class="product-preview__outstock">'.$label_text.'</div>';
                elseif ($label_type == 'countdown')
                  $count_down_end = $label_text;
                  
              }?>
              
              <div class="product-main-image__item"><img class="product-zoom" src='<?php echo $popup; ?>' data-zoom-image="<?php echo $popup; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>"/></div>
              <div class="product-main-image__zoom"></div>
            </div>
          <?php } ?>
          
          <?php if ($images) { ?>  
            <div class="product-images-carousel">
              <ul id="smallGallery">
              <li><a href="#" data-image="<?php echo $popup; ?>" data-zoom-image="<?php echo $popup; ?>" title="<?php echo $heading_title; ?>" class="active"><img src="<?php echo $thumb; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" itemprop="image"/></a></li>
              <?php foreach ($images as $image) { ?>
                <li><a href="#" data-image="<?php echo $image['popup']; ?>" data-zoom-image="<?php echo $image['popup']; ?>" title="<?php echo $heading_title; ?>"><img src="<?php echo $image['thumb']; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" itemprop="image"/></a></li>
              <?php } ?>
                <?php echo $youtube_code;?>
              </ul>
            </div>
          <?php } ?>  
          </div>
         
         <?php }else if ($this->welldone->get_settings('product_page_image_view','bottom_slider') == 'vertical_slider') { ?> 
          
          <?php if ($this->welldone->get_settings('product_page_layout','default') == 'simple' && !$display_custom_right_block) { ?>
           <div class="col-sm-5 col-md-5">
          <?php }else{ ?>
            <div class="col-sm-4 col-md-4">
          <?php } ?>
            <ul id="singleGalleryVertical">
              <?php if ($images) { ?>  
                  <li>
                  <?php $count_down_end = '';foreach($labels as $label_type=>$label_text){
                
                $color_options = array();
                
                if ($label_type == 'new')
                  echo '<div class="product-preview__label product-preview__label--left product-preview__label--new"><span>'.$label_text.'</span></div>';
                elseif ($label_type == 'discount')
                  echo '<div class="product-preview__label product-preview__label--right product-preview__label--sale"><span>'.$label_text.'</span></div>';
                elseif ($label_type == 'outofstock')
                  echo '<div class="product-preview__outstock">'.$label_text.'</div>';
                elseif ($label_type == 'countdown')
                  $count_down_end = $label_text;
                  
              }?>
                  <img src="<?php echo $popup; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" itemprop="image"/></li>
                  <?php foreach ($images as $image) { ?>
                    <li><img src="<?php echo $image['popup']; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" itemprop="image"/></li>
                  <?php } ?>
              <?php } ?>
            </ul>
          </div>
          
          <?php } ?>
        <?php } ?>  
          
          <div class="product-info <?php if ($this->welldone->get_settings('product_page_layout','default') == 'simple' && !$display_custom_right_block){ echo'col-sm-5 col-md-5';} elseif ($display_custom_right_block){?>col-sm-6 col-md-5<?php }else{echo 'col-sm-6 col-md-5';}?>">
            <div class="product-info__title">
              <h1 itemprop="name"><?php echo $heading_title; ?></h1>
              
              <ul class="list-unstyled">
                <?php if ($manufacturer) { ?>
                <li><?php echo $text_manufacturer; ?> <a href="<?php echo $manufacturers; ?>" class="custom-color"><?php echo $manufacturer; ?></a></li>
                <?php } ?>
                <li itemprop="model"><?php echo $text_model; ?> <?php echo $model; ?></li>
                <?php if ($reward) { ?>
                <li><?php echo $text_reward; ?> <?php echo $reward; ?></li>
                <?php } ?>
              </ul>
              
              <?php if ($review_status) { ?>
              <div class="rating product-info__rating"  itemscope itemtype="http://schema.org/AggregateRating">
                <meta itemprop="ratingValue" content="<?php echo $rating; ?>" />
                <meta itemprop="bestRating" content="5" />
                <meta itemprop="worstRating" content="1" />
                
                <?php for ($i = 1; $i <= 5; $i++) { ?>
                  <?php if ($rating < $i) { ?>
                  <span class="icon-star"></span>
                  <?php } else { ?>
                  <span class="icon-star-fill"></span>
                  <?php } ?>
                  <?php } ?>
                <?php if ($this->welldone->get_settings('product_page_layout','default') != 'simple'){?>  
                <a href="" onclick="$('a[href=\'#tab-review\']').trigger('click'); $.scrollTo('#tabs-section',800);return false;" class="custom-color"><?php echo $reviews; ?></a> / <a href="" onclick="$('a[href=\'#tab-review\']').trigger('click'); $.scrollTo('#review-heading',800);return false;" class="custom-color"><?php echo $text_write; ?></a>
                <?php }?>  
              </div>
            <?php } ?>
            </div>
            
            <div class="product-info__sku pull-right"><span class="label label-<?php echo $stock_status_class;?>"><?php echo $stock; ?></span></div>
            
            <ul id="singleGallery" class="visible-xs">
                <li><img src="<?php echo $popup; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" /></li>
            <?php if ($images) { ?>
              <?php foreach ($images as $image) { ?>
                <li><img src="<?php echo $image['popup']; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" /></li>
              <?php } ?>                
            <?php } ?>
            </ul>
            
           <?php if ($price) { ?>
            <div class="price-box product-info__price" itemprop="offers" itemscope itemtype="http://schema.org/Offer">
              <meta itemprop="itemCondition" content="http://schema.org/NewCondition" />
              <meta itemprop="priceCurrency" content="<?php echo $this->currency->getCode(); ?>" />
              <?php if (!$special) { ?>
                <span class="price-box__regular" itemprop="price"><span id="formated_price" price="<?php echo $price_value; ?>"><?php echo $price; ?></span></span>
              <?php } else { ?>
              <span class="price-box__new" itemprop="price"><span id="formated_special" price="<?php echo $special_value; ?>"><?php echo $special; /**/ ?></span></span> <span class="price-box__old"><span id="formated_price" price="<?php echo $price_value; ?>"><?php echo $price; ?></span></span>
              <?php } ?>
            
            <ul class="list-unstyled price-opts">
              <?php if ($tax) { ?>
              <li><?php echo $text_tax; ?> <span id="formated_tax" price="<?php echo $tax_value; ?>"><?php echo $tax; ?></span></li>
              <?php } ?>
              <?php if ($points) { ?>
              <li><?php echo $text_points; ?> <span id="formated_points" points="<?php echo $points; /**/ ?>"><?php echo $points; /**/ ?></span></li>
              <?php } ?>
              <?php if ($discounts) { ?>
              <li>
                <hr>
              </li>
              <?php foreach ($discounts as $discount) { ?>
              <li><?php echo $discount['quantity']; ?><?php echo $text_discount; ?><?php echo $discount['price']; ?></li>
              <?php } ?>
              <?php } ?>
            </ul>
          
              
            </div>
           <?php } ?> 
           
            <?php if ($column_right){?>
              <?php echo $column_right; ?>
            <?php }?>

           <div class="divider divider--xs product-info__divider"></div>
            
            <?php
            if ($count_down_end != ''){
               $ret = explode('-',$count_down_end);
               $y = (int)$ret[0];
               $m = (int)$ret[1]; 
               $d = (int)$ret[2];
               
               if ($y && $m && $d)
               {
                 $id = time();
                 echo '<div class="countdown_box"><div class="countdown_inner"><div class="title">'.$this->welldone->get_settings('countdown_title','special price valid:').'</div><div id="countdown-'.$id.'"></div></div></div>';
                 echo '<script type="text/javascript">jQuery(function ($) {if ($("#countdown-'.$id.'").length > 0){$(\'#countdown-'.$id.'\').countdown({until: new Date('.$y.', '.($m - 1).', '.$d.')});}});</script>';
                 echo '<div class="divider divider--xs product-info__divider"></div>'; 
               }
            ?>
              
            <?php }?>
            
            <?php if ($this->welldone->get_settings('product_page_layout','default') == 'simple') { ?>
            <div class="product-info__description"><?php echo $description; ?></div>
            <div class="divider divider--xs product-info__divider"></div>
            <?php }?>
            
            <div id="product">
<div class="options" id="product_options">
            
                <?php if ($options) { ?>
                <?php foreach ($options as $option) { ?>
                <?php if ($option['type'] == 'select') { ?>
                
                <?php if (in_array($option['option_id'],$this->welldone->get_settings('product_size_option_id',array()))) { ?>
                
                <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                  <label class="control-label"><?php echo $option['name']; ?></label>
                  <div id="input-option<?php echo $option['product_option_id']; ?>">
                    <ul class="options-swatch options-swatch--size options-swatch--lg">   
<?php $opt_checked="checked"; ?>
                     <?php foreach ($option['product_option_value'] as $option_value) { ?>               
                      <li data-toggle="tooltip" title="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" class="size-option">
                        <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" style="display:none;"/>
                        <?php echo $option_value['name']; ?>
                      </li>
                    <?php } ?>  
                    </ul>
                  </div>  
                </div>
                
                
                <?php }else{?>
                <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                  <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                  <select id="options-<?php echo $option['product_option_id']; ?>" name="option[<?php echo $option['product_option_id']; ?>]" onchange="recalculateprice();" id="input-option<?php echo $option['product_option_id']; ?>" class="selectpicker"  data-style="select--wd"  data-width="100%">
                    <option value=""  price_prefix="+" price="0.0"><?php echo $text_select; ?></option>
<?php $opt_checked="checked"; ?>
                    <?php foreach ($option['product_option_value'] as $option_value) { ?>
                    <option value="<?php echo $option_value['product_option_value_id']; ?>"  points="<?php echo $option_value['points_value']; ?>" price_prefix="<?php echo $option_value['price_prefix']; ?>" price="<?php echo $option_value['price_value']; ?>"><?php echo $option_value['name']; ?>
                    <?php if ($option_value['price']) { ?>
                    <?php
          if ($option_value['price_prefix'] == '*') {
            if ($option_value['price_value'] != 1.0)
              printf("(%+d%%)", ($option_value['price_value'] * 100) - 100 );
          } else {
            echo "(".$option_value['price_prefix'].$option_value['price'].")"; 
          }
          ?>
                    <?php } ?>
                    </option>
                    <?php } ?>
                  </select>
                </div>
                <?php } ?>
                <?php } ?>
                <?php if ($option['type'] == 'radio') { ?>
                <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                  <label class="control-label"><?php echo $option['name']; ?></label>
                  <div id="input-option<?php echo $option['product_option_id']; ?>">
<?php $opt_checked="checked"; ?>
                    <?php foreach ($option['product_option_value'] as $option_value) { ?>
                    <div class="radio">
                      <label>
                        <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" points="<?php echo $option_value['points_value']; ?>" price_prefix="<?php echo $option_value['price_prefix']; ?>" price="<?php echo $option_value['price_value']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" <?php echo $opt_checked; $opt_checked=""; ?> onchange="recalculateprice();" />
                        <span class="outer"><span class="inner"></span></span>
                        <?php echo $option_value['name']; ?>
                        <?php if ($option_value['price']) { ?>
                        <?php
          if ($option_value['price_prefix'] == '*') {
            if ($option_value['price_value'] != 1.0)
              printf("(%+d%%)", ($option_value['price_value'] * 100) - 100 );
          } else {
            echo "(".$option_value['price_prefix'].$option_value['price'].")"; 
          }
          ?>
                        <?php } ?>
                      </label>
                    </div>
                    <?php } ?>
                  </div>
                </div>
                <?php } ?>
                <?php if ($option['type'] == 'checkbox') { ?>
                <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                  <label class="control-label"><?php echo $option['name']; ?></label>
                  <div id="input-option<?php echo $option['product_option_id']; ?>">
<?php $opt_checked="checked"; ?>
                    <?php foreach ($option['product_option_value'] as $option_value) { ?>
                    <div class="checkbox">
                      <label class="">
                        <input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" points="<?php echo $option_value['points_value']; ?>" price_prefix="<?php echo $option_value['price_prefix']; ?>" price="<?php printf("%.5f", $option_value['price_value']); ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" onchange="recalculateprice();" />
                        <span class="check"></span> <span class="box"></span>
                        <?php echo $option_value['name']; ?>
                        <?php if ($option_value['price']) { ?>
                        <?php
          if ($option_value['price_prefix'] == '*') {
            if ($option_value['price_value'] != 1.0)
              printf("(%+d%%)", ($option_value['price_value'] * 100) - 100 );
          } else {
            echo "(".$option_value['price_prefix'].$option_value['price'].")"; 
          }
          ?>
                        <?php } ?>
                      </label>
                    </div>
                    <?php } ?>
                  </div>
                </div>
                <?php } ?>
                <?php if ($option['type'] == 'image') { ?>
                
                <?php if (in_array($option['option_id'],$this->welldone->get_settings('product_color_option_id',array()))) { ?>
                <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                  <label class="control-label"><?php echo $option['name']; ?></label>
                  <div id="input-option<?php echo $option['product_option_id']; ?>">
                    <ul class="options-swatch options-swatch--color options-swatch--lg">   
<?php $opt_checked="checked"; ?>
                     <?php foreach ($option['product_option_value'] as $option_value) { ?>               
                      <li>
                        <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" style="display:none;"/>
                        <a href="#" data-toggle="tooltip" title="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" class="color-option"><span class="swatch-label"><img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" /></span></a>
                      </li>
                    <?php } ?>  
                    </ul>
                  </div>  
                </div>  
                <?php }else{?>
                
                <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                  <label class="control-label"><?php echo $option['name']; ?></label>
                  <div id="input-option<?php echo $option['product_option_id']; ?>">
<?php $opt_checked="checked"; ?>
                    <?php foreach ($option['product_option_value'] as $option_value) { ?>
                    <div class="radio">
                      <label>
                        <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" points="<?php echo $option_value['points_value']; ?>" price_prefix="<?php echo $option_value['price_prefix']; ?>" price="<?php echo $option_value['price_value']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" <?php echo $opt_checked; $opt_checked=""; ?> onchange="recalculateprice();" />
                        <span class="outer"><span class="inner"></span></span>
                        <img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" class="img-thumbnail" /> <?php echo $option_value['name']; ?>
                        <?php if ($option_value['price']) { ?>
                        <?php
          if ($option_value['price_prefix'] == '*') {
            if ($option_value['price_value'] != 1.0)
              printf("(%+d%%)", ($option_value['price_value'] * 100) - 100 );
          } else {
            echo "(".$option_value['price_prefix'].$option_value['price'].")"; 
          }
          ?>
                        <?php } ?>
                      </label>
                    </div>
                    <?php } ?>
                  </div>
                </div>
                <?php } ?>
                <?php } ?>
                <?php if ($option['type'] == 'text') { ?>
                <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                  <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                  <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                </div>
                <?php } ?>
<script type="text/javascript"><!--
function price_format_sign(n)
{ 
    c = <?php echo (empty($currency['decimals']) ? "0" : $currency['decimals'] ); ?>;
    d = '<?php echo $currency['decimal_point']; ?>'; // decimal separator
    t = '<?php echo $currency['thousand_point']; ?>'; // thousands separator
    s_left = '<?php echo $currency['symbol_left']; ?>';
    s_right = '<?php echo $currency['symbol_right']; ?>';
      
    <?php // Process Tax Rates
      if (isset($tax_rates)) {
         foreach ($tax_rates as $tax_rate) {
           if ($tax_rate['type'] == 'F') {
             echo 'n += '.$tax_rate['rate'].';';
           } elseif ($tax_rate['type'] == 'P') {
             echo 'n += (n * '.$tax_rate['rate'].') / 100.0;';
           }
         }
      }
    ?>
    
    n = n * <?php echo $currency['value']; ?>;

    sign = (n < 0) ? '-' : '';

    //extracting the absolute value of the integer part of the number and converting to string
    i = parseInt(n = Math.abs(n).toFixed(c)) + ''; 

    j = ((j = i.length) > 3) ? j % 3 : 0; 
    return sign + s_left + (j ? i.substr(0, j) + t : '') + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t) + (c ? d + Math.abs(n - i).toFixed(c).slice(2) : '') + s_right; 
}
//--></script>


        <?php if ($option['type'] == 'checkbox_qty') { ?>
        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <b><?php echo $option['name']; ?>:</b><br />
          
          <?php $id = $option['product_option_id']; ?>
          
<script type="text/javascript"><!--
function clean_<?php echo $id; ?>() {
<?php $opt_checked="checked"; ?>
    <?php foreach ($option['product_option_value'] as $option_value) { ?>
            $('#opt-qty-<?php echo $option_value['product_option_value_id']; ?>').val(1);
            $('#option-value-<?php echo $option_value['product_option_value_id']; ?>').removeAttr('checked');
    <?php } ?>
    calc_opt_<?php echo $id; ?>();
    if(typeof recalculateprice == 'function') {
        recalculateprice();
    }
}
function calc_opt_<?php echo $id; ?>() {
    var price = 0;
    $('#option-<?php echo $id; ?> input:checked').each(function() {
        if ($(this).attr('price_prefix') == '+') {
            price += Number($(this).attr('price'));
        } else if ($(this).attr('price_prefix') == '-') {
            price -= Number($(this).attr('price'));
        }
    });
    $('#result-<?php echo $id; ?>').html( price_format_sign(price) );
    if(typeof recalculateprice == 'function') {
        recalculateprice();
    }
}
//--></script>
          
                 <table  border=1 border-color=red cellspacing=0 cellpadding=0 
 style='border-collapse:collapse;border:1px solid #d4d4d4;'>

         
            <tr style="height:36px; background-color:#E7E7E7; text-align:center;">
            
                <th colspan="3" style="font-size:15px; font-weight:normal; border-color:#fff;padding:0 3px">Nome</th>
                <th style="font-size:15px; font-weight:normal; border-color:#fff;text-align:center">Qtd.</th>
                <th style="font-size:15px; font-weight:normal; border-color:#fff;text-align:center">Preço Un.
              </th>
            </tr>
<?php $opt_checked="checked"; ?>
          <?php foreach ($option['product_option_value'] as $option_value) { ?>
            <tr>
              <td width=30px; style="text-align:center; border-color:#E7E7E7;">
                <input type="checkbox" name="option[<?php echo $id; ?>][]" 
                       value="<?php echo $option_value['product_option_value_id']; ?>|1" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" 
                       points="<?php echo $option_value['points_value']; ?>" price_prefix="<?php echo $option_value['price_prefix']; ?>" price="<?php printf("%.5f", $option_value['price_value_tax']); ?>"
                       onchange="calc_opt_<?php echo $id; ?>();"/>
              </td>
              
              <td style="text-align:center; border-color:#E7E7E7;">                  
             <label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php if ($option_value['image']) { ?><img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" /><?php } ?></label>
              </td>

              <td width=200px; style="border-color:#E7E7E7;">                  
                 <span style="margin-left:10px;"> <label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
                 </span> </label>
              </td>
              
              
              <td width=80px; style="text-align:center; border-color:#E7E7E7;">
                <input type="number" min="1" name="" id="opt-qty-<?php echo $option_value['product_option_value_id']; ?>" value="1" oninput="$(this).attr('value', $(this).val()<1?1:$(this).val());
                   $('#option-value-<?php echo $option_value['product_option_value_id']; ?>').val( <?php echo $option_value['product_option_value_id']; ?> + '|' + Number($(this).attr('value')) );
                   $('#option-value-<?php echo $option_value['product_option_value_id']; ?>').attr('price', Number($(this).attr('price')) * Number($(this).attr('value')) );
                   calc_opt_<?php echo $id; ?>();
                " size="4" price="<?php echo $option_value['price_value_tax']; ?>" style="width: 40px;" /></td>
                
                <td width=100px; style="text-align:center;border-color:#E7E7E7;">
                <?php if ($option_value['price']) { ?>
                    <?php echo ($option_value['price']); ?>
                  <?php } ?>
                  </td>
                
            </tr>
          <?php } ?>
              <tr style="height:30px;">
                  <td colspan="3" style="text-align:left;border-color:#E7E7E7;"><button" class="btn btn-default btn-xs" style="padding:2px 5px;margin-left:3px" onclick="clean_<?php echo $id; ?>();"><i class="fa fa-refresh"></i></td>
                  <td style="text-align:center; border-color:#E7E7E7;" > Total: </td> <td style="text-align:center; border-color:#E7E7E7;" > <b><span id="result-<?php echo $id; ?>"> </span></b> </td>
              </tr>
          </table>
        </div>
        <br />
<script type="text/javascript"><!--
calc_opt_<?php echo $id; ?>();
//--></script>
        <?php } ?>
            
            
        <?php if ($option['type'] == 'radio_qty') { ?>
        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <b><?php echo $option['name']; ?>:</b><br />
          
          <?php $id = $option['product_option_id']; ?>
          
<script type="text/javascript"><!--
function clean_<?php echo $id; ?>() {
<?php $opt_checked="checked"; ?>
    <?php foreach ($option['product_option_value'] as $option_value) { ?>
            $('#opt-qty-<?php echo $option_value['product_option_value_id']; ?>').val(1);
            $('#option-value-<?php echo $option_value['product_option_value_id']; ?>').removeAttr('checked');
    <?php } ?>
    calc_opt_<?php echo $id; ?>();
    if(typeof recalculateprice == 'function') {
        recalculateprice();
    }
}
function calc_opt_<?php echo $id; ?>() {
    var price = 0;
    $('#option-<?php echo $id; ?> input:checked').each(function() {
        if ($(this).attr('price_prefix') == '+') {
            price += Number($(this).attr('price'));
        } else if ($(this).attr('price_prefix') == '-') {
            price -= Number($(this).attr('price'));
        }
    });
    $('#result-<?php echo $id; ?>').html( price_format_sign(price) );
    if(typeof recalculateprice == 'function') {
        recalculateprice();
    }
}
//--></script>
          
           <table  border=1 border-color=red cellspacing=0 cellpadding=0 
 style='border-collapse:collapse;border:1px solid #d4d4d4;'>

         
            <tr style="height:36px; background-color:#E7E7E7; text-align:center;">
            
                <th colspan="3" style="font-size:15px; font-weight:normal; border-color:#fff;padding:0 3px">Nome</th>
                <th style="font-size:15px; font-weight:normal; border-color:#fff;text-align:center">Qtd.</th>
                <th style="font-size:15px; font-weight:normal; border-color:#fff;text-align:center">Preço Un.
              </th>
            </tr>
<?php $opt_checked="checked"; ?>
          <?php foreach ($option['product_option_value'] as $option_value) { ?>
            <tr>
               <td width=30px; style="text-align:center; border-color:#E7E7E7;">
                <input type="radio" name="option[<?php echo $id; ?>]" 
                       value="<?php echo $option_value['product_option_value_id']; ?>|1" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" 
                       points="<?php echo $option_value['points_value']; ?>" price_prefix="<?php echo $option_value['price_prefix']; ?>" price="<?php printf("%.5f", $option_value['price_value_tax']); ?>"
                       onchange="calc_opt_<?php echo $id; ?>();"/>
              </td>
              
              <td style="text-align:center; border-color:#E7E7E7;">                  
             <label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php if ($option_value['image']) { ?><img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" /><?php } ?></label>
              </td>

              <td width=200px; style="border-color:#E7E7E7;">                  
                 <span style="margin-left:10px;"> <label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
                 </span> </label>
              </td>
              
             <td width=80px; style="text-align:center; border-color:#E7E7E7;">
                <input type="number" min="1" name="" id="opt-qty-<?php echo $option_value['product_option_value_id']; ?>" value="1" oninput="$(this).attr('value', $(this).val()<1?1:$(this).val());
                   $('#option-value-<?php echo $option_value['product_option_value_id']; ?>').val( <?php echo $option_value['product_option_value_id']; ?> + '|' + Number($(this).attr('value')) );
                   $('#option-value-<?php echo $option_value['product_option_value_id']; ?>').attr('checked', true); 
                   $('#option-value-<?php echo $option_value['product_option_value_id']; ?>').attr('price', Number($(this).attr('price')) * Number($(this).attr('value')) );
                   calc_opt_<?php echo $id; ?>();
                " size="4" price="<?php echo $option_value['price_value_tax']; ?>" style="width: 40px;" /></td>
             
             <td width=100px; style="text-align:center;border-color:#E7E7E7;">
                  <?php if ($option_value['price']) { ?>
                    (<?php echo ($option_value['price']); ?>)
                  <?php } ?>
                  </label>
              </td>
            </tr>
          <?php } ?>
               <tr style="height:30px;">
                  <td colspan="3" style="text-align:center;border-color:#E7E7E7;"><button" class="btn btn-default btn-xs" style="padding:2px 5px;margin-left:3px" onclick="clean_<?php echo $id; ?>();"><i class="fa fa-refresh"></i></td>
                  <td style="text-align:center; border-color:#E7E7E7;" > Total: </td> <td style="text-align:center; border-color:#E7E7E7;" > <b><span id="result-<?php echo $id; ?>"> </span></b> </td>
              </tr>
          </table>
        </div>
        <br />
<script type="text/javascript"><!--
calc_opt_<?php echo $id; ?>();
//--></script>
        <?php } ?>
            
            
        <?php if ($option['type'] == 'select_qty') { ?>
        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <b><?php echo $option['name']; ?>:</b><br />
          
          <?php $id = $option['product_option_id']; ?>
          
<script type="text/javascript"><!--
function clean_<?php echo $id; ?>() {
    $('#opt-qty-s-<?php echo $id; ?>').val(1);
<?php $opt_checked="checked"; ?>
    //<?php foreach ($option['product_option_value'] as $option_value) { ?>
    //        $('#option-value-<?php echo $option_value['product_option_value_id']; ?>').attr('price', 0 );
    //        $('#option-value-<?php echo $option_value['product_option_value_id']; ?>').val( <?php echo $option_value['product_option_value_id']; ?> + '|0');
    //<?php } ?>
        
    $('#opt-qty-select-<?php echo $id; ?>').attr('selected', 'selected');
        
    calc_opt_<?php echo $id; ?>();
    if(typeof recalculateprice == 'function') {
        recalculateprice();
    }
}
function calc_opt_<?php echo $id; ?>() {
    var price = 0;
    
    qty = $('#opt-qty-s-<?php echo $id; ?>').attr('value');
        
<?php $opt_checked="checked"; ?>
    <?php foreach ($option['product_option_value'] as $option_value) { ?>
            opt_price = $('#option-value-<?php echo $option_value['product_option_value_id']; ?>').attr('p');
            //    alert(opt_price);
            $('#option-value-<?php echo $option_value['product_option_value_id']; ?>').attr('price', Number(opt_price) * qty );
            $('#option-value-<?php echo $option_value['product_option_value_id']; ?>').val( <?php echo $option_value['product_option_value_id']; ?> + '|' + qty);
    <?php } ?>
        
    $('#option-<?php echo $id; ?> option:selected').each(function() {
        if ($(this).attr('price_prefix') == '+') {
            price += Number($(this).attr('price'));
        } else if ($(this).attr('price_prefix') == '-') {
            price -= Number($(this).attr('price'));
        }
    });
    $('#result-<?php echo $id; ?>').html( price_format_sign(price) );
    if(typeof recalculateprice == 'function') {
        recalculateprice();
    }
}
//--></script>

		<table  border=1 border-color=red cellspacing=0 cellpadding=0 
 style='border-collapse:collapse;border:1px solid #d4d4d4;'>

         
            <tr style="height:36px; background-color:#E7E7E7; text-align:center;">
            
               
                <th style="font-size:15px; font-weight:normal; border-color:#fff;padding:0 3px">Nome</th>
                <th style="font-size:15px; font-weight:normal; border-color:#fff;text-align:center">Qtd.</th>
                <th style="font-size:15px; font-weight:normal; border-color:#fff;text-align:center">Preço Un.
              </th>
            </tr>

         
          
           <tr>
              <td width=310px; height=40px; style="text-align:center; border-color:#E7E7E7;">
          
          <select onchange="calc_opt_<?php echo $id; ?>();" id="opt-qty-<?php echo $id; ?>" name="option[<?php echo $option['product_option_id']; ?>]">
            <option value="" p="0" price="0" price_prefix="+" id="opt-qty-select-<?php echo $id; ?>"><?php echo $text_select; ?></option>
<?php $opt_checked="checked"; ?>
            <?php foreach ($option['product_option_value'] as $option_value) { ?>
            <option id="option-value-<?php echo $option_value['product_option_value_id']; ?>" value="<?php echo $option_value['product_option_value_id']; ?>" price="<?php printf("%.5f", $option_value['price_value_tax']); ?>" p="<?php printf("%.5f", $option_value['price_value_tax']); ?>" price_prefix="<?php echo $option_value['price_prefix']; ?>"><?php echo $option_value['name']; ?>
            &nbsp;&nbsp;&nbsp;<?php if ($option_value['price']) { ?>
            <?php echo $option_value['price']; ?>
            <?php } ?>
            </option>
            <?php } ?>
          </select>
         </td>
       
        
              <td style="text-align:center; border-color:#E7E7E7;">  
           <input type="text" name="" id="opt-qty-s-<?php echo $id; ?>" value="1" oninput="calc_opt_<?php echo $id; ?>();" size="4" style="width: 40px;" /> 
          </td>
          
          <td width=100px; style="text-align:center;border-color:#E7E7E7;">
          </td>
            
         <tr style="height:30px;">
                  <td colspan="1" style="text-align:center;border-color:#E7E7E7;"><button" class="btn btn-default btn-xs" style="padding:2px 5px;margin-left:3px" onclick="clean_<?php echo $id; ?>();"><i class="fa fa-refresh"></i></button></td>
                  <td style="text-align:center; border-color:#E7E7E7;" > Total: </td> <td style="text-align:center; border-color:#E7E7E7;" > <b><span id="result-<?php echo $id; ?>"> </span></b> </td>
              </tr>
          </table>
<script type="text/javascript"><!--
calc_opt_<?php echo $id; ?>();
//--></script>
         <br />
        <?php } ?>
                <?php if ($option['type'] == 'textarea') { ?>
                <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                  <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                  <textarea name="option[<?php echo $option['product_option_id']; ?>]" rows="5" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control"><?php echo $option['value']; ?></textarea>
                </div>
                <?php } ?>
                <?php if ($option['type'] == 'file') { ?>
                <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                  <label class="control-label"><?php echo $option['name']; ?></label>
                  <button type="button" id="button-upload<?php echo $option['product_option_id']; ?>" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-default btn-block"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>
                  <input type="hidden" name="option[<?php echo $option['product_option_id']; ?>]" value="" id="input-option<?php echo $option['product_option_id']; ?>" />
                </div>
                <?php } ?>
                <?php if ($option['type'] == 'date') { ?>
                <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                  <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                  <div class="input-group date">
                    <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="DD/MM/YYYY" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                    <span class="input-group-btn">
                    <button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
                    </span></div>
                </div>
                <?php } ?>
                <?php if ($option['type'] == 'datetime') { ?>
                <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                  <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                  <div class="input-group datetime">
                    <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="DD/MM/YYYY HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                    <span class="input-group-btn">
                    <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                    </span></div>
                </div>
                <?php } ?>
                <?php if ($option['type'] == 'time') { ?>
                <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                  <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                  <div class="input-group time">
                    <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                    <span class="input-group-btn">
                    <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                    </span></div>
                </div>
                <?php } ?>
                <?php } ?>
                <?php } ?>
                
                <?php if ($recurrings) { ?>
                <hr>
                <h3><?php echo $text_payment_recurring ?></h3>
                <div class="form-group required">
                  <select name="recurring_id" class="selectpicker">
                    <option value=""  price_prefix="+" price="0.0"><?php echo $text_select; ?></option>
                    <?php foreach ($recurrings as $recurring) { ?>
                    <option value="<?php echo $recurring['recurring_id'] ?>"><?php echo $recurring['name'] ?></option>
                    <?php } ?>
                  </select>
                  <div class="help-block" id="recurring-description"></div>
                </div>
                <?php } ?>
               
               
               <div class="divider divider--sm"></div>
            
            
                <label><?php echo $entry_qty; ?></label>
                <div class="outer">
                  <div class="input-group-qty pull-left"> <span class="pull-left"> </span>
                    <input type="text" name="quantity" class="input-number input--wd input-qty pull-left" value="<?php echo $minimum; ?>" min="<?php echo $minimum; ?>" max="1000"/>
                    <input type="hidden" name="product_id" value="<?php echo $product_id; ?>" />
                    <span class="pull-left btn-number-container">
                    <button type="button" class="btn btn-number btn-number--plus" data-type="plus" data-field="quantity"> + </button>
                    <button type="button" class="btn btn-number btn-number--minus" disabled="disabled" data-type="minus" data-field="quantity"> &#8211; </button>
                    </span> </div>
                  <div class="button-cart">
                    <button class="btn btn--wd btn-block-alt text-uppercase" id="button-cart" data-loading-text="<?php echo $text_loading; ?>"><span class="icon icon-bag-alt"></span> <?php echo $button_cart; ?></button>
                  </div>
                  
                  <?php if ($minimum > 1) { ?>
                    <div class="clearfix"></div>
                    <div class="alert alert-info" style="margin-bottom:0px !important;margin-top:20px;"><i class="fa fa-info-circle"></i> <?php echo $text_minimum; ?></div>
                  <?php } ?>
                
                </div> 
              
            </div>
            
            <div class="divider divider--xs"></div>
            <ul class="product-links product-links--inline">
              <li><a href="#" title="<?php echo $button_compare; ?>" onclick="welldone_add_to_compare('<?php echo $product_id; ?>');return false;"><span class="icon icon-bars"></span><?php echo $button_compare; ?></a></li>
              <li><a href="#" title="<?php echo $button_wishlist; ?>" onclick="welldone_add_to_whishlist('<?php echo $product_id; ?>');return false;"><span class="icon icon-favorite"></span><?php echo $button_wishlist; ?></a></li>
            </ul>
            <div class="divider divider--xs"></div>

            <div class="row">
                <div class="col-xs-12">
                    <h4><i class="icon icon-truck"></i> <?php echo $entry_simulate_shipping;?></h4>    
                </div>
                <div class="col-xs-6
                    ">
                    <div class="input-group"> 
                        <input type="text" class="form-control" placeholder="<?php echo $entry_postcode;?>" aria-describedby="basic-addon2" name="postcode" id="postcode">
                        <span class="input-group-addon btn btn-primary" data-loading-text="<?php echo $entry_calculate_loading;?>" id='button-calculate'><?php echo $entry_calculate_shipping;?></span> 
                    </div>  
                    <table class="table table-bordered">  
                        <tbody id="shipping-result"> 
                        </tbody> 
                    </table>                   
                </div>
            </div>            
            
            <?php echo html_entity_decode($this->welldone->get_settings('social_sharing_code',''), ENT_QUOTES, 'UTF-8');?>
          </div>
          
          <?php if (1) { ?>
<?php
  if ($display_custom_right_block)
  {
    if (isset($custom_data['html']))
    {
      echo '<div class="col-sm-12 col-md-4 col-lg-3">';
      echo html_entity_decode($custom_data['html'], ENT_QUOTES, 'UTF-8'); 
      echo '</div>';
    }
  }
?>          
          <?php }?>
        </div>
      </div>
    </section>
    
    <?php if ($this->welldone->get_settings('product_page_layout','default') == 'sticky' && $this->welldone->get_settings('product_page_layout','default') != 'simple') { ?>
      <section class="content">
      <div id="navProduct">
        <div class="nav-product">
          <div class="container">
            <ul>
              <li class="nav-product__item active" data-target="tab-description"><a href="#tab-description"><?php echo $tab_description; ?></a></li>
              <?php if ($attribute_groups) { ?>
                <li class="nav-product__item" data-target="tab-specification"><a href="#tab-specification"><?php echo $tab_attribute; ?></a></li>
              <?php } ?>
              <?php if ($review_status) { ?>
                <li class="nav-product__item" data-target="tab-review"><a href="#tab-review"><?php echo $tab_review; ?></a></li>
              <?php } ?>
              <?php if ($tags) { ?>
                <li class="nav-product__item" data-target="tab-tags"><a href="#tab-tags"><?php echo $text_tags; ?></a></li>
              <?php } ?>
              <?php echo $custom_tab_content_nav;?>
            </ul>
          </div>
        </div>
      </div>
    </section>
    
    <section class="content top-null">
      <div class="container product-additional">
        <section class="product-additional__box" id="tab-description"><h3 class="text-uppercase"><?php echo $tab_description; ?></h3><?php echo $description; ?></section>
          <?php if ($attribute_groups) { ?>
            <section class="product-additional__box" id="tab-specification">
            <h3 class="text-uppercase"><?php echo $tab_attribute; ?></h3>
              <table class="table table-bordered attribute">
                <?php foreach ($attribute_groups as $attribute_group) { ?>
                <thead>
                  <tr>
                    <td colspan="2"><strong><?php echo $attribute_group['name']; ?></strong></td>
                  </tr>
                </thead>
                <tbody>
                  <?php foreach ($attribute_group['attribute'] as $attribute) { ?>
                  <tr>
                    <td><?php echo $attribute['name']; ?></td>
                    <td><?php echo $attribute['text']; ?></td>
                  </tr>
                  <?php } ?>
                </tbody>
                <?php } ?>
              </table>
            </section>
            <?php } ?>
            
            <?php if ($review_status) { ?>
            <section class="product-additional__box" id="tab-review" itemprop="aggregateRating">
            <h3 class="text-uppercase"><?php echo $tab_review; ?></h3>
              <form class="form-horizontal" id="form-review">
                <div id="review"></div>
                <h2 id="review-heading"><?php echo $text_write; ?></h2>
                <?php if ($review_guest) { ?>
                <div class="form-group required">
                  <div class="col-sm-12">
                    <label class="control-label" for="input-name"><?php echo $entry_name; ?></label>
                    <input type="text" name="name" value="" id="input-name" class="form-control" />
                  </div>
                </div>
                <div class="form-group required">
                  <div class="col-sm-12">
                    <label class="control-label" for="input-review"><?php echo $entry_review; ?></label>
                    <textarea name="text" rows="5" id="input-review" class="form-control"></textarea>
                    <div class="help-block"><?php echo $text_note; ?></div>
                  </div>
                </div>
                <div class="form-group required">
                  <div class="col-sm-12">
                    <label class="control-label"><?php echo $entry_rating; ?></label>
                    &nbsp;&nbsp;&nbsp; <?php echo $entry_bad; ?>&nbsp;
                    <input type="radio" name="rating" value="1" />
                    &nbsp;
                    <input type="radio" name="rating" value="2" />
                    &nbsp;
                    <input type="radio" name="rating" value="3" />
                    &nbsp;
                    <input type="radio" name="rating" value="4" />
                    &nbsp;
                    <input type="radio" name="rating" value="5" />
                    &nbsp;<?php echo $entry_good; ?></div>
                </div>
                <?php echo $captcha; ?>
                <div class="buttons clearfix">
                  <div class="pull-left">
                    <button type="button" id="button-review" data-loading-text="<?php echo $text_loading; ?>" class="btn btn--wd text-uppercase wave"><?php echo $button_continue; ?></button>
                  </div>
                </div>
                <?php } else { ?>
                <?php echo $text_login; ?>
                <?php } ?>
              </form>
            </section>
            <?php } ?>
            
            <?php if ($tags) { ?>
              <section class="product-additional__box" id="tab-tags">
              <h3 class="text-uppercase"><?php echo $text_tags; ?></h3>
              
              <ul class="tags-list">
                <?php for ($i = 0; $i < count($tags); $i++) { ?>
                  <?php if ($i < (count($tags) - 1)) { ?>
                  <li><a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a></li>
                  <?php } else { ?>
                  <li><a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a></li>
                  <?php } ?>
                <?php } ?>
              </ul>  
              </section>
            <?php } ?>
            
            <?php echo $custom_tab_content_2;?>
            
      </div>
    </section>
    
    <?php }?>
    
    
    
    <?php if ($this->welldone->get_settings('product_page_layout','default') != 'sticky' && $this->welldone->get_settings('product_page_layout','default') != 'simple') { ?>
    <section class="content content--fill" id="tabs-section">
      <div class="container"> 
        <!-- Nav tabs -->
        
        
        <ul class="nav nav-tabs nav-tabs--wd" role="tablist">
          <li class="active"><a href="#tab-description" data-toggle="tab" class="text-uppercase"><?php echo $tab_description; ?></a></li>
          <?php if ($attribute_groups) { ?>
            <li><a href="#tab-specification" data-toggle="tab" class="text-uppercase"><?php echo $tab_attribute; ?></a></li>
          <?php } ?>
          <?php if ($review_status) { ?>
            <li><a href="#tab-review" data-toggle="tab" class="text-uppercase"><?php echo $tab_review; ?></a></li>
          <?php } ?>
          <?php if ($tags) { ?>
            <li><a href="#tab-tags" data-toggle="tab" class="text-uppercase"><?php echo $text_tags; ?></a></li>
          <?php } ?>
          <?php echo $custom_tab_content_nav;?>
        </ul>
        
        
        
        <!-- Tab panes -->
        <div class="tab-content tab-content--wd">
          <div class="tab-pane active" id="tab-description"><?php echo $description; ?></div>
          <?php if ($attribute_groups) { ?>
            <div class="tab-pane" id="tab-specification">
              <table class="table table-bordered attribute">
                <?php foreach ($attribute_groups as $attribute_group) { ?>
                <thead>
                  <tr>
                    <td colspan="2"><strong><?php echo $attribute_group['name']; ?></strong></td>
                  </tr>
                </thead>
                <tbody>
                  <?php foreach ($attribute_group['attribute'] as $attribute) { ?>
                  <tr>
                    <td><?php echo $attribute['name']; ?></td>
                    <td><?php echo $attribute['text']; ?></td>
                  </tr>
                  <?php } ?>
                </tbody>
                <?php } ?>
              </table>
            </div>
            <?php } ?>
            
            <?php if ($review_status) { ?>
            <div class="tab-pane" id="tab-review">
              <form class="form-horizontal" id="form-review">
                <div id="review"></div>
                <h2 id="review-heading"><?php echo $text_write; ?></h2>
                <?php if ($review_guest) { ?>
                <div class="form-group required">
                  <div class="col-sm-12">
                    <label class="control-label" for="input-name"><?php echo $entry_name; ?></label>
                    <input type="text" name="name" value="" id="input-name" class="form-control" />
                  </div>
                </div>
                <div class="form-group required">
                  <div class="col-sm-12">
                    <label class="control-label" for="input-review"><?php echo $entry_review; ?></label>
                    <textarea name="text" rows="5" id="input-review" class="form-control"></textarea>
                    <div class="help-block"><?php echo $text_note; ?></div>
                  </div>
                </div>
                <div class="form-group required">
                  <div class="col-sm-12">
                    <label class="control-label"><?php echo $entry_rating; ?></label>
                    &nbsp;&nbsp;&nbsp; <?php echo $entry_bad; ?>&nbsp;
                    <input type="radio" name="rating" value="1" />
                    &nbsp;
                    <input type="radio" name="rating" value="2" />
                    &nbsp;
                    <input type="radio" name="rating" value="3" />
                    &nbsp;
                    <input type="radio" name="rating" value="4" />
                    &nbsp;
                    <input type="radio" name="rating" value="5" />
                    &nbsp;<?php echo $entry_good; ?></div>
                </div>
                <?php echo $captcha; ?>
                <div class="buttons clearfix">
                  <div class="pull-left">
                    <button type="button" id="button-review" data-loading-text="<?php echo $text_loading; ?>" class="btn btn--wd text-uppercase wave"><?php echo $button_continue; ?></button>
                  </div>
                </div>
                <?php } else { ?>
                <?php echo $text_login; ?>
                <?php } ?>
              </form>
            </div>
            <?php } ?>
            
            <?php if ($tags) { ?>
              <div class="tab-pane" id="tab-tags">
              <ul class="tags-list">
                <?php for ($i = 0; $i < count($tags); $i++) { ?>
                  <?php if ($i < (count($tags) - 1)) { ?>
                  <li><a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a></li>
                  <?php } else { ?>
                  <li><a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a></li>
                  <?php } ?>
                <?php } ?>
              </ul>  
              </div>
            <?php } ?>
        <?php echo $custom_tab_content_1;?>  
        </div>
      </div>
    </section>
   
   <?php }?> 

<?php if ($products && $this->welldone->get_settings('product_page_related','show') == 'show') {   ?>    
    <section class="content<?php if ($this->welldone->get_settings('product_page_layout','default') == 'sticky') { echo ' content--fill';}?>">
      <div class="container"> 
        
        <h2 class="text-center text-uppercase"><?php echo $text_related; ?></h2>
        <?php
        $content_class = '';
        $category_products_in_row = $this->welldone->get_settings('category_products_in_row','four');
        
        if($category_products_in_row == 'two')
          $content_class = 'two-in-row';
        elseif($category_products_in_row == 'three')
          $content_class = 'three-in-row';
        elseif($category_products_in_row == 'four')
          $content_class = 'four-in-row';
        elseif($category_products_in_row == 'five')
          $content_class = 'five-in-row';
        elseif($category_products_in_row == 'six')
          $content_class = 'six-in-row';
        elseif($category_products_in_row == 'seven')
          $content_class = 'seven-in-row';
        elseif($category_products_in_row == 'eight')
          $content_class = 'eight-in-row';            
      ?>
<div class="row product-carousel mobile-special-arrows animated-arrows product-grid <?php echo $content_class;?>">
          
        <?php include("catalog/view/theme/welldone/template/welldone/listing.php");?> 
        
        </div>
      </div>
    </section>
    
  <?php }
  
  if ($content_bottom)
  {
    echo $content_bottom;
  }
  
  $custom_sliders = $this->welldone->get_settings('product-custom-sliders');
  
  if ($custom_sliders)
  {
    foreach($custom_sliders as $slider)
    {
      echo '<section class="content"><div class="container">'.$slider.'</div></section>';
    }
  } 
  
  
  ?>  
    
<script type="text/javascript"><!--
$('select[name=\'recurring_id\'], input[name="quantity"]').change(function(){
	$.ajax({
		url: 'index.php?route=product/product/getRecurringDescription',
		type: 'post',
		data: $('input[name=\'product_id\'], input[name=\'quantity\'], select[name=\'recurring_id\']'),
		dataType: 'json',
		beforeSend: function() {
			$('#recurring-description').html('');
		},
		success: function(json) {
			$('.alert, .text-danger').remove();

			if (json['success']) {
				$('#recurring-description').html(json['success']);
			}
		}
	});
});
//--></script>
<script type="text/javascript"><!--

$('#button-calculate').on('click', function() {
  $.ajax({
    url: 'index.php?route=total/shipping/quoteProduct',
    type: 'post',
    data: $('input[type=\'text\'], input[type=\'hidden\'], input[type=\'radio\']:checked, input[type=\'checkbox\']:checked, select, textarea'),
    dataType: 'json',
    beforeSend: function() {
      $('#button-calculate').button('loading');
    },
    complete: function() {
      $('#button-calculate').button('reset');
    },
    success: function(json) {
      $('.alert, .text-danger').remove();
      $('.form-group').removeClass('has-error');

      if (json['error']) {
        if (json['error']['option']) {
          for (i in json['error']['option']) {
            var element = $('#input-option' + i.replace('_', '-'));

            if (element.parent().hasClass('input-group')) {
              element.parent().after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
            } else {
              element.after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
            }
          }
        }

        if (json['error']['recurring']) {
          $('select[name=\'recurring_id\']').after('<div class="text-danger">' + json['error']['recurring'] + '</div>');
        }
        if (json['error']['postcode']) {
          $('input[name=\'postcode\']').parent().after('<div class="text-danger">' + json['error']['postcode'] + '</div>');
        }

        // Highlight any found errors
        $('.text-danger').parent().addClass('has-error');
      }
      $("#shipping-result").html('');
        if (!json['error']) {
          var html = '';
          for (i in json['shipping_method']) {
              for (j in json['shipping_method'][i]['quote']) {                
                  $("#shipping-result").append("<tr> <td>"+json['shipping_method'][i]['quote'][j]['title']+"</td> <td>"+json['shipping_method'][i]['quote'][j]['text']+"</td> </tr>");
              }
          }
          //   // $("#shipping-result").html(json);        
        }
    },
        error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
  });
});
            
$('#button-cart').on('click', function() {
var navbar_h = $("#navbar.stuck").height() * -1 - 30;

	$.ajax({
		url: 'index.php?route=checkout/cart/add',
		type: 'post',
		data: $('#product input[type=\'text\'], #product input[type=\'hidden\'], #product input[type=\'radio\']:checked, #product input[type=\'checkbox\']:checked, #product select, #product textarea'),
		dataType: 'json',
		beforeSend: function() {
			$('#button-cart').button('loading');
		},
		complete: function() {
			$('#button-cart').button('reset');
		},
		success: function(json) {
			$('.alert, .text-danger').remove();
			$('.form-group').removeClass('has-error');

			if (json['error']) {
        
        $.scrollTo('#product',800,{offset:navbar_h});
        
				if (json['error']['option']) {
					for (i in json['error']['option']) {
						var element = $('#input-option' + i.replace('_', '-'));

						if (element.parent().hasClass('input-group')) {
							element.parent().after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
						} else {
							element.after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
						}
					}
				}

				if (json['error']['recurring']) {
					$('select[name=\'recurring_id\']').after('<div class="text-danger">' + json['error']['recurring'] + '</div>');
				}

				// Highlight any found errors
				$('.text-danger').parent().addClass('has-error');
			}

			if (json['success']) {
				
        showModalNotification();
        ModalDialogResult(json['success']);

				setTimeout(function () {
						$('#cart .header__cart__indicator').html(json['total']);
					}, 100);

					$('#cart').load('index.php?route=common/cart/info');
			}
		},
        error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
	});
});
//--></script>
<script type="text/javascript"><!--
$('.date').datetimepicker({
  locale: moment().local('br'),
  format: 'DD/MM/YYYY',
	pickTime: false
});

$('.datetime').datetimepicker({
  locale: moment().local('br'),
	pickDate: true,
	pickTime: true
});

$('.time').datetimepicker({
  locale: moment().local('br'),
	pickDate: false
});

$('button[id^=\'button-upload\']').on('click', function() {
	var node = this;

	$('#form-upload').remove();

	$('body').prepend('<form enctype="multipart/form-data" id="form-upload" style="display: none;"><input type="file" name="file" /></form>');

	$('#form-upload input[name=\'file\']').trigger('click');

	if (typeof timer != 'undefined') {
    	clearInterval(timer);
	}

	timer = setInterval(function() {
		if ($('#form-upload input[name=\'file\']').val() != '') {
			clearInterval(timer);

			$.ajax({
				url: 'index.php?route=tool/upload',
				type: 'post',
				dataType: 'json',
				data: new FormData($('#form-upload')[0]),
				cache: false,
				contentType: false,
				processData: false,
				beforeSend: function() {
					$(node).button('loading');
				},
				complete: function() {
					$(node).button('reset');
				},
				success: function(json) {
					$('.text-danger').remove();

					if (json['error']) {
						$(node).parent().find('input').after('<div class="text-danger">' + json['error'] + '</div>');
					}

					if (json['success']) {
						alert(json['success']);

						$(node).parent().find('input').attr('value', json['code']);
					}
				},
				error: function(xhr, ajaxOptions, thrownError) {
					alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
				}
			});
		}
	}, 500);
});
//--></script>
<script type="text/javascript"><!--
$('#review').delegate('.pagination a', 'click', function(e) {
    e.preventDefault();

    $('#review').fadeOut('slow');

    $('#review').load(this.href);

    $('#review').fadeIn('slow');
});

$('#review').load('index.php?route=product/product/review&product_id=<?php echo $product_id; ?>');

$('#button-review').on('click', function() {
	$.ajax({
		url: 'index.php?route=product/product/write&product_id=<?php echo $product_id; ?>',
		type: 'post',
		dataType: 'json',
		data: $("#form-review").serialize(),
		beforeSend: function() {
			$('#button-review').button('loading');
		},
		complete: function() {
			$('#button-review').button('reset');
		},
		success: function(json) {
			$('.alert-success, .alert-danger').remove();

			if (json['error']) {
				$('#review').after('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '</div>');
			}

			if (json['success']) {
				$('#review').after('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + '</div>');

				$('input[name=\'name\']').val('');
				$('textarea[name=\'text\']').val('');
				$('input[name=\'rating\']:checked').prop('checked', false);
			}
		}
	});
});

$(document).ready(function() {
	$('.thumbnails').magnificPopup({
		type:'image',
		delegate: 'a',
		gallery: {
			enabled:true
		}
	});
  
  $(".color-option").click(function(){
    $(this).siblings("input[type=radio]").prop("checked", true);
    $(this).parents('ul').find('li.checked').removeClass('checked');
    $(this).parent('li').addClass('checked');
    return false;
  });
  
  $(".size-option").click(function(){
    $(this).find("input[type=radio]").prop("checked", true);
    $(this).parent('ul').find('li.checked').removeClass('checked');
    $(this).addClass('checked');
    return false;
  });
});
//--></script>

        <input type="hidden" id="fbProductID" value="<?php echo $product_id ?>" />
      
<script type="text/javascript"><!--

function price_format(n)
{ 
    c = <?php echo (empty($currency['decimals']) ? "0" : $currency['decimals'] ); ?>;
    d = '<?php echo $currency['decimal_point']; ?>'; // decimal separator
    t = '<?php echo $currency['thousand_point']; ?>'; // thousands separator
    s_left = '<?php echo $currency['symbol_left']; ?>';
    s_right = '<?php echo $currency['symbol_right']; ?>';
      
    n = n * <?php echo $currency['value']; ?>;

    //sign = (n < 0) ? '-' : '';

    //extracting the absolute value of the integer part of the number and converting to string
    i = parseInt(n = Math.abs(n).toFixed(c)) + ''; 

    j = ((j = i.length) > 3) ? j % 3 : 0; 
    return s_left + (j ? i.substr(0, j) + t : '') + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t) + (c ? d + Math.abs(n - i).toFixed(c).slice(2) : '') + s_right; 
}

function calculate_tax(price)
{
    <?php // Process Tax Rates
      if (isset($tax_rates)) {
         foreach ($tax_rates as $tax_rate) {
           if ($tax_rate['type'] == 'F') {
             echo 'price += '.$tax_rate['rate'].';';
           } elseif ($tax_rate['type'] == 'P') {
             echo 'price += (price * '.$tax_rate['rate'].') / 100.0;';
           }
         }
      }
    ?>
    return price;
}

function process_discounts(price, quantity)
{
    <?php
      foreach ($dicounts_unf as $discount) {
        echo 'if ((quantity >= '.$discount['quantity'].') && ('.$discount['price'].' < price)) price = '.$discount['price'].';'."\n";
      }
    ?>
    return price;
}

function recalculateprice()
{
    var main_price = Number($('#formated_price').attr('price'));
    var input_quantity = Number($('#product_buy_quantity').attr('value'));
    var special = Number($('#formated_special').attr('price'));
    var tax = Number($('#formated_tax').attr('price'));
    
    // Process Discounts.
    main_price = process_discounts(main_price, input_quantity);
    tax = process_discounts(tax, input_quantity);
    
    
   <?php if ($points) { ?>
     var points = Number($('#formated_points').attr('points'));
     $('#product_options input:checked').each(function() {
       points += Number($(this).attr('points'));
     });
     $('#product_options option:selected').each(function() {
       points += Number($(this).attr('points'));
     });
     $('#formated_points').html(points);
   <?php } ?>
    
    
    $('#product_options input:checked,option:selected').each(function() {
      if ($(this).attr('price_prefix') == '=') {
        main_price = Number($(this).attr('price'));
        special = main_price;
        tax = main_price;
      }
    });
    
    $('#product_options input:checked,option:selected').each(function() {
      if ($(this).attr('price_prefix') == '+') {
        main_price += Number($(this).attr('price'));
        special += Number($(this).attr('price'));
        tax += Number($(this).attr('price'));
      }
      if ($(this).attr('price_prefix') == '-') {
        main_price -= Number($(this).attr('price'));
        special -= Number($(this).attr('price'));
        tax -= Number($(this).attr('price'));
      }
      if ($(this).attr('price_prefix') == '*') {
        main_price = main_price * Number($(this).attr('price'));
        special = special * Number($(this).attr('price'));
        tax = tax * Number($(this).attr('price'));
      }
    });

    // Process TAX.
    main_price = calculate_tax(main_price);
    special = calculate_tax(special);
    
    // Display Main Price
    $('#formated_price').html( price_format(main_price) );
      
    <?php if ($special) { ?>
      $('#formated_special').html( price_format(special) );
    <?php } ?>

    <?php if ($tax) { ?>
      $('#formated_tax').html( price_format(tax) );
    <?php } ?>
}

recalculateprice();

//--></script>
<?php echo $footer; ?>
