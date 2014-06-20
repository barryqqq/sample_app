	
	// set studio bath and bed 
	$( "#studio_label" ).on( "click", function() {
		$( "#studio_label" ).addClass("active");
		$( "#others_label" ).removeClass("active");
		$( "#bed_bath" ).addClass("hide");
		$( "#bed_input" ).val('0');
		$( "#bath_input" ).val('1');
	});

	$( "#others_label" ).on( "click", function() {
		$( "#studio_label" ).removeClass("active");
		$( "#others_label" ).addClass("active");
		$( "#bed_bath" ).removeClass("hide");
		$( "#bed_input" ).val('');
		$( "#bath_input" ).val('');
	});		


	//$('#datepicker').datepicker();
	//set datepicker
  	$('#start_date').datepicker({ format: "yyyy-mm-dd"});
  	$('#end_date').datepicker({ format: "yyyy-mm-dd"});
	
	
	$(document).ready(function() {



	/////// counting photo number	
		// check if is there  still empty room for uploading
		// now is 4
		$( "#trigger_select_btn" ).on( "click", function() {
			var count = 0;
			var id_name;
			for ( i = 1; i <= 4; i++) {
		    	id_name = '#photo_' + i;
		        if ($(id_name).hasClass('empty')) {
		        	count++;
		        }    
		    }  
		    if (count ==  0) {
		    	alert("full");
		    } else {
		     	$("#upload_file").click();
		    }
			
		});	

		
/////// upload photo
		$("#upload_file").change(function(){
			//$("#file_name").html('');
			//var numFiles = $('#upload_file')[0].files.length;
	   		//$("#file_name").html("You've choiced " + numFiles + "Photos");
	   		//alert(numFiles);

	   		var form_data = new FormData();
	        form_data.append('image', $('#upload_file').prop('files')[0]);
	        $('.progress-striped').removeClass('hide');
					
				
			$('#trigger_select_btn').attr('disabled', true);

	        $.ajax({
	         
	          url: "<%= photos_path %>",
	          data: form_data,
	          type: 'POST',
	          cache: false,
	          contentType: false,
	          processData: false,
	          dataType: 'json',

	          success: function(data){
	          	alert('success');

		          // finding first empty class in photo
		          for ( i = 1; i <= 4; i++) {
		          	var id_name = '#photo_' + i;

		          	if ($(id_name).hasClass('empty')) {

		          		// set photo to div
		          		
		          		// /photos/" + data.id + "  data-method='delete'
		          		$(id_name).append("<div class='photo_" + i + "'><img height='160' width='245' class='thumbnail' src='" + data.image_url_medium + "'> </div>" );

						// show cancel link
						$(id_name + '_cancel').removeClass('hide');

						//set id to cookie
						$.cookie(id_name + '_cancel', data.id);


		          		// set photo to page 3
		          		$(id_name + '_p3').append("<div class='photo_" + i + "'><img height='160' width='245' class='thumbnail' src='" + data.image_url_medium + "'><input id='photo_" + i + "_input' name='photo[]' type='hidden' value=''/></div> " );

		          		//$('photo_' + i + '_img').attr('src', data.image_url_medium);


		          		$(id_name + '_p3').removeClass('non-visibile');
						
						// set id hidden input in page 3 
		          		$('#photo_' + i + '_input' ).val(data.id);

		          		// remove empty class
		          		$(id_name).removeClass('empty');

		          		//leave for loop
		          		break;

		          	}
		          }

	            $('.progress-striped').addClass('hide');
	          	$('#trigger_select_btn').removeAttr('disabled');
	          		
	          

	          }, 
	          error: function(){
	            //alert('failure');
	         	$('.progress-striped').addClass('hide');
	          	$('#trigger_select_btn').removeAttr('disabled');
	          

	          }

	        })
	 	



	 	});

///////////// cancel photo
		$(".photo-cancel").on( "click", function() {
		
			var id_name = $(this).parent().attr('id'); //id_name = photo_# 
			var photo_id = $.cookie('#' + id_name + '_cancel'); 

			//delete photo from s3
			$.ajax({
	             
	              url: "/photos/" + photo_id ,
	              type: 'DELETE',
	              cache: false,
	              contentType: false,
	              processData: false,
	              dataType: 'json',
	      
	              success: function(data){
	              	//alert('y');
	              	

	              	//add empty class to parent div
	              	$('#' + id_name).addClass('empty'); 

					//add hide class to $this 
					$('#' + id_name + '_cancel').addClass('hide');

					//for page3
					$('#' + id_name + '_img').attr('src', '');
		          	$('#' + id_name + '_p3').addClass('non-visibile');
		          	$('#' + id_name + '_photo').val('');	

		          	// remove cookie
		          	$.removeCookie('#' + id_name + '_cancel');

		          	//remove photo from div 
	              	$( "." + id_name).remove();
	              	//$("#" + id_name + "_p3").remove();


	              },error: function(){
	              	//alert('n');
	              }	
	        })     
			
			


		});


//////////////  step 1 checkbox

    	//set initial state.
    	//$('#textbox1').val($(this).is(':checked'));
		

		// check if ckb is checked
		$('#deposit_ckb').change(function() {
			if ($('#deposit_ckb').is(':checked')) {
				$('#deposit_input').removeAttr('disabled');			
			} else {

				$('#deposit_input').attr('disabled', true);
				$('#deposit_input').val('');
			}
		});

		// check if ckb is checked
		$('#contract_ckb').change(function() {
			if ($('#contract_ckb').is(':checked')) {
				$('#contract_input').removeAttr('disabled');			
			} else {

				$('#contract_input').attr('disabled', true);
				$('#contract_input').val('');
			}
		});

		// check if ckb is checked
		$('#broker_fee_ckb').change(function() {
			if ($('#broker_fee_ckb').is(':checked')) {
				$('#broker_fee_input').removeAttr('disabled');			
			} else {

				$('#broker_fee_input').attr('disabled', true);
				$('#broker_fee_input').val('');
			}
		});	




		//utilities group
		$('#hasElectricity').change(function() {
			if ($('#hasElectricity').is(':checked')) {
				$('#utilities_group').find('label').first().removeClass('active');
				$('#utility_none').attr('checked', false	);
			}	
		});	

		$('#hasHeat').change(function() {
			if ($('#hasHeat').is(':checked')) {
				$('#utilities_group').find('label').first().removeClass('active');
				$('#utility_none').attr('checked', false	);
			}	
		});	

		$('#hasInternet').change(function() {
			if ($('#hasInternet').is(':checked')) {
				$('#utilities_group').find('label').first().removeClass('active');
				$('#utility_none').attr('checked', false	);
			}	
		});	


		$('#utility_none').change(function() {
			
			//select none
			if ($('#utility_none').is(':checked')) {
				//remove checked on utilities
	  			$('#hasElectricity').attr('checked', false);
	  			$('#hasHeat').attr('checked', false);
	  			$('#hasInternet').attr('checked', false);

	  			$('#utilities_group').find('label').removeClass('active');

			}
			
		});	

		

		$( "#sublease_label" ).on( "click", function() {
			//alert('d');
			$( "#to_span" ).removeClass('non-visibile');
			$( "#end_date" ).removeClass('non-visibile');
			$( "#people" ).removeClass('hide');

			//set up slider	
			$('#slider').slider()
  				.on('slide', function(ev){
    
  			});

  			$( "#deposit" ).addClass('hide');
  			$( "#contract" ).addClass('hide');
  			$( "#broker_fee" ).addClass('hide');
  			$( "#utility" ).addClass('hide');	
  			$( "#pets" ).addClass('hide');

  			$( "#price_span" ).html('.00 /Day');


  			//remove checked on utilities
  			$('#hasElectricity').attr('checked', false);
  			$('#hasHeat').attr('checked', false);
  			$('#hasInternet').attr('checked', false);

  			$('#utilities_group').find('label').removeClass('active');
  			$('#utilities_group').find('label').first().addClass('active');
  			$('#utility_none').attr('checked', true);

		
		});


		$( "#rent_label" ).on( "click", function() {
			
			$( "#to_span" ).addClass('non-visibile');
			$( "#end_date" ).addClass('non-visibile');

			$( "#people" ).addClass('hide');

			$( "#deposit" ).removeClass('hide');
  			$( "#contract" ).removeClass('hide');
  			$( "#broker_fee" ).removeClass('hide');
  			$( "#utility" ).removeClass('hide');	
  			$( "#pets" ).removeClass('hide');
			
  			$( "#price_span" ).html('.00 /Month');
			
		
		});
		

		$( "#shared_label" ).on( "click", function() {
			//alert('d');
			$( "#to_span" ).addClass('non-visibile');
			$( "#end_date" ).addClass('non-visibile');
			
			$( "#people" ).addClass('hide');

			$( "#deposit" ).removeClass('hide');
  			$( "#contract" ).removeClass('hide');
  			$( "#broker_fee" ).removeClass('hide');
  			$( "#utility" ).removeClass('hide');	
  			$( "#pets" ).removeClass('hide');
			
			$( "#price_span" ).html('.00 /Month');
		
		});	

		



////// buttons actions

		// kick step 1 continue button
		$( "#step_1_con" ).on( "click", function() {
			if ( validation_step_1() ){
				set_value_step_1();
				$( ".step_1" ).addClass('hide');
				$( ".step_2" ).removeClass('hide');
				$( ".step_2_tab" ).addClass('active');

			}
			
		});	

		// kick step 2 previous button
		$( "#step_2_pre" ).on( "click", function() {
			
			$( ".step_2" ).addClass('hide');
			$( ".step_1" ).removeClass('hide');
			$( ".step_2_tab" ).removeClass('active');
		});	

		// kick step 2 continue button
		$( "#step_2_con" ).on( "click", function() {
			if (validation_step_2() ){	
				set_value_step_2();
				$( ".step_2" ).addClass('hide');
				$( ".step_3" ).removeClass('hide');
				$( ".step_3_tab" ).addClass('active');
			}
		});	



////// step2 

		// kick step 3 previous button
		$( "#step_3_pre" ).on( "click", function() {
			$( ".step_3" ).addClass('hide');
			$( ".step_2" ).removeClass('hide');
			$( ".step_3_tab" ).removeClass('active');
		});	



		
	 	$("#radio_exactly_addr").attr("checked",true);



		// exactly address radio
	    $( "#radio_exactly_addr" ).on( "click", function() {
	    	$( ".well" ).addClass('hide');
	    	$( ".star" ).addClass('hide');
	    	//$( ".exactly_addr" ).removeClass('hide');

	    });	

	    // blur address radio
	    $( "#radio_blur_addr" ).on( "click", function() {
	    	//alert('b');
	    //	$( ".exactly_addr" ).addClass('hide');
	    	$( ".well" ).removeClass('hide');
	    	$( ".star" ).removeClass('hide');
	    	
	    });	





	}); // end of ready function

   
	function validation_step_1() {

		if ($('#bed_input').val().length == 0 ){
			 $('#bed_input').closest('.form-group').addClass('has-error');
			 return false;
		} else {
			if ( $('#bed_input').val() >= 0 && $('#bed_input').val() < 36  ) {
				$('#bed_input').closest('.form-group').removeClass('has-error');
			} else {
				$('#bed_input').closest('.form-group').addClass('has-error');
			 	return false;
			}	
			 
		}


		if ($('#bath_input').val().length == 0 ){
			 $('#bath_input').closest('.form-group').addClass('has-error');
			 return false;
		} else {

			if ( $('#bath_input').val() >= 0 && $('#bath_input').val() < 36  ) {
				$('#bath_input').closest('.form-group').removeClass('has-error');
			} else {
				$('#bath_input').closest('.form-group').addClass('has-error');
			 	return false;

			}	
			
		}


		if ($('#price_input').val().length == 0 ){
			$('#price_input').closest('.form-group').addClass('has-error');
			return false;
		} else {

			if ( $('#price_input').val() >= 0 ) {
				$('#price_input').closest('.form-group').removeClass('has-error');
			} else {
				$('#price_input').closest('.form-group').addClass('has-error');
			 	return false;
			}	


		}

		if ($('#description_input').val().length == 0 ){
			$('#description_input').closest('.form-group').addClass('has-error');
			return false;
		} else {
			$('#description_input').closest('.form-group').removeClass('has-error');
		}


		if ($('#contact_name_input').val().length == 0 ){
			$('#contact_name_input').closest('.form-group').addClass('has-error');
			return false;
		} else {
			$('#contact_name_input').closest('.form-group').removeClass('has-error');
			
		}

		if ($('#contact_email_input').val().length == 0 ){
			$('#contact_email_input').closest('.form-group').addClass('has-error');
			return false;
		} else {
			 
			var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    		if ( re.test($('#contact_email_input').val()) ) {
    			$('#contact_email_input').closest('.form-group').removeClass('has-error');
    		} else {
    			$('#contact_email_input').closest('.form-group').addClass('has-error');
				return false;
    		}
			
		}

		

		// rent of share room
		if ($('input[name=type]:radio:checked').val() == 0 
			|| $('input[name=type]:radio:checked').val() == 1) {
			
			if ($('#deposit_ckb').is(':checked')) {

				if ($('#deposit_input').val().length == 0 ){
			 		$('#deposit_input').closest('.form-group').addClass('has-error');
			 		return false;
				} else {
			 		
			 		if ( $('#deposit_input').val() >= 0 && $('#deposit_input').val() < 36  ) {
				 		$('#deposit_input').closest('.form-group').removeClass('has-error');
					} else {
						$('#deposit_input').closest('.form-group').addClass('has-error');
			 			return false;
			 		}

				}
			}
			

			if ($('#contract_ckb').is(':checked')) {

				if ($('#contract_input').val().length == 0 ){
			 		$('#contract_input').closest('.form-group').addClass('has-error');
			 		return false;
				} else {
			 		
			 		if ( $('#contract_input').val() >= 0 && $('#contract_input').val() < 36  ) {
				 		$('#contract_input').closest('.form-group').removeClass('has-error');
					} else {
						$('#contract_input').closest('.form-group').addClass('has-error');
			 			return false;
			 		}	
				}

			}

			if ($('#broker_fee_ckb').is(':checked')) {

				if ($('#broker_fee_input').val().length == 0 ){
			 		$('#broker_fee_input').closest('.form-group').addClass('has-error');
			 		return false;
				} else {
			 		
			 		if ( $('#broker_fee_input').val() >= 0 ) {
				 		$('#broker_fee_input').closest('.form-group').removeClass('has-error');
					} else {
						$('#broker_fee_input').closest('.form-group').addClass('has-error');
			 			return false;
					}

				}

			}
		}// endof rent of share room
			
		return true;


	} // end of validation_step_1()

	function validation_step_2() {

		if ($('#address1_input').val().length == 0 ){
			$('#address1_input').closest('.form-group').addClass('has-error');
				return false;
		} else {
			$('#address1_input').closest('.form-group').removeClass('has-error');
		}


		if ($('#city_input').val().length == 0 ){
			$('#city_input').closest('.form-group').addClass('has-error');
				return false;
		} else {
			$('#city_input').closest('.form-group').removeClass('has-error');
		}

		if ($('.state_input').val().length == 0 ){
			$('.state_input').closest('.form-group').addClass('has-error');
				return false;
		} else {
			$('.state_input').closest('.form-group').removeClass('has-error');
		}

		if ($('#zipcode_input').val().length == 0 ){
			$('#zipcode_input').closest('.form-group').addClass('has-error');
				return false;
		} else {
			$('#zipcode_input').closest('.form-group').removeClass('has-error');
		}


		var r_addr =  $('input[name=radio_addr]:radio:checked').val();
		
		// blur address
		if (r_addr == 1) {
			if ($('#address2_input').val().length == 0 ){
			 		$('#address2_input').closest('.form-group').addClass('has-error');
			 		return false;
				} else {
			 		$('#address2_input').closest('.form-group').removeClass('has-error');
				}
		}

		// check photo number
		var count = 0;
		var id_name;
		for ( i = 1; i <= 4; i++) {
		    id_name = '#photo_' + i;
		    if ($(id_name).hasClass('empty')) {
		    	count++;
		    }    
		}  
		if (count ==  4) {
			alert("you need at least one photo");
			return false;
		} 

		return true;

	}	


	function set_value_step_1(){
		//remove  columns added before, prevending duplication
		$(".extand_table").remove();

		// type 
		var type_text = "#type_" + $('input[name=type]:radio:checked').val();
		
		//$('#table1 tr:last').after("<tr class='extand_table'><td>Utility</td><td>" + $(utility_text).text() + " <input type='hidden' name='property[utility]' value='" + checked + "'> </td></tr>");
			


		// necessary columns
		$('#property_category').html($(type_text).text() + " <input type='hidden' name='property[category]' value='" + $('input[name=type]:radio:checked').val() + "'>" );

		$('#property_bed').val($('#bed_input').val());

		$('#property_bath').val($('#bath_input').val());

		// studio
		if ( $('#bed_input').val() == "0" && $('#bath_input').val() == "1" ) {
			$('#tr_studio').removeClass('hide');
			$('#tr_bed').addClass('hide');
			$('#tr_bath').addClass('hide');

		} else {
			$('#tr_studio').addClass('hide');
			$('#tr_bed').removeClass('hide');
			$('#tr_bath').removeClass('hide');

		}


		$('#property_description').val($('#description_input').val());

		$('#property_contact_name').val($('#contact_name_input').val());

		$('#property_contact_phone').val($('#contact_phone_input').val());

		$('#property_contact_email').val($('#contact_email_input').val());

		$('#property_price').val($('#price_input').val());

		$('#property_hasDeposit').val($('#deposit_ckb').prop('checked'));
		$('#property_hasBrokerFee').val($('#broker_fee_ckb').prop('checked'));
		$('#property_HasContract').val($('#contract_ckb').prop('checked'));

		//optional columns

		//date
		if ( $('#end_date').val().length > 0 || $('#start_date').val().length > 0  ) {
			
			//<input name='property[start_date]' id='property_start_date' class='non-input' readonly >
			//<span class='to hide'> to 
			//<input name='property[end_date]' id='property_end_date' class='non-input' readonly>
			//</span>

			$('#table1 tr:last').after("<tr class='extand_table'><td>Date</td><td> " + $('#start_date').val() + "<span class='to hide'> to " + $('#end_date').val() + "</span><input name='property[start_date]' type='hidden' value='" + $('#start_date').val() + "'><input name='property[end_date]' type='hidden' value='" + $('#end_date').val() + "' ></td></tr>");

			$('#property_start_date').val($('#start_date').val());
			$('#property_end_date').val($('#end_date').val());
			
		}	

		if ($('input[name=type]:radio:checked').val() == 2) {
			// has end date
			if ( $('#end_date').val().length > 0    ) {
				$('.to').removeClass('hide');

			} else {
				$('.to').addClass('hide');
			}
			
		}


		//people
		if ($('input[name=type]:radio:checked').val() == 2) {
			if ( $('#slider').val().length > 0 ) {
				$('#table1 tr:last').after("<tr class='extand_table'><td>Peopele</td><td> <input name='property[people]' id='property_people' class='non-input' readonly> </td></tr>");

				$('#property_people').val($('#slider').val());
			}	
		}	

		// for rent and shared apt
		if ($('input[name=type]:radio:checked').val() != 2) {
			//deposit
			if ($('#deposit_ckb').prop('checked')) {
				if ( $('#deposit_input').val().length > 0 ) {
					$('#table2 tr:last').after("<tr class='extand_table'><td>Deposit</td><td> <input name='property[deposit]' id='property_deposit' class='non-input' readonly style='width: 40px'> Month(s)</td></tr>");

					$('#property_deposit').val($('#deposit_input').val());
				}	
			}	

			//contract
			if ($('#contract_ckb').prop('checked')) {
				if ( $('#contract_input').val().length > 0 ) {
					$('#table2 tr:last').after("<tr class='extand_table'><td>Contract</td><td> <input name='property[contract]' id='property_contract' class='non-input' readonly style='width: 40px'> Month(s)</td></tr>");
					$('#property_contract').val($('#contract_input').val());
				}	
			}

			//broker_fee
			if ($('#broker_fee_ckb').prop('checked')) {
				if ( $('#broker_fee_input').val().length > 0 ) {
					$('#table2 tr:last').after("<tr class='extand_table'><td>Broker fee</td><td> $ <input name='property[broker_fee]' id='property_broker_fee' class='non-input' readonly > </td></tr>");
					$('#property_broker_fee').val($('#broker_fee_input').val());
				}	
			}

			//utility
			

			if (! $('#utility_none').is(':checked')) {
				
				
				var utility_text = "";

				if( $('#hasElectricity').is(':checked')) {

					utility_text += $('#utility_1').html() + ", ";
				
					$('#property_hasElectricity').val('t');

				} else {
					$('#property_hasElectricity').val('f');;
				}

				if( $('#hasHeat').is(':checked')) {
					utility_text += $('#utility_2').html() + ", ";
					$('#property_hasHeat').val('t');

				}
				 else {
				 	$('#property_hasHeat').val('f');
				}

				if( $('#hasInternet').is(':checked')) {
					utility_text += $('#utility_3').html();
					$('#property_hasInternet').val('t');

				} else {
					$('#property_hasInternet').val('f');
				}

				$('#table1 tr:last').after("<tr class='extand_table'><td>Utility</td><td>" + utility_text + "</td></tr>");
				
			} 


			//pet
			var checked = $('input[name=pet]:radio:checked').val();
			var pet_text = "#pet_" + checked
			$('#table2 tr:last').after("<tr class='extand_table'><td>Pet</td><td>" + $(pet_text).text() +" <input type='hidden' name='property[pet]' value='" + checked + "'> </td></tr>");
			
			$('#property_pet').val($(pet_text).text());
			


		}// end if for rent and shared apt

		//gender
		var checked = $('input[name=gender]:radio:checked').val();
		var gender_text = "#gender_" + checked;

		$('#table2 tr:last').after("<tr class='extand_table'><td>Gender</td><td>" + $(gender_text).text() + " <input type='hidden' name='property[gender]' value='" + checked + "'> </td></tr>");
		
		
		// email public
		if ($('#contact_email_ckb').is(':checked')) {
			$('#property_isPublic').val('1');
		} else {
			$('#property_isPublic').val('0');
		}	




	}


	function set_value_step_2(){

		$('#property_radio_addr').val($('input[name=radio_addr]:radio:checked').val());
		// exactly address
		if ($('input[name=radio_addr]:radio:checked').val() == 0) {
			
			$('#property_address1').val($('#address1_input').val());
			$('#property_address2').val($('#address2_input').val());
			$('#property_city').val($('#city_input').val());
			$('#property_state').val($('.state_input').val());
			$('#property_zipcode').val($('#zipcode_input').val());

			$('#span_addr').html($('#address1_input').val() + " " + $('#address2_input').val() + " " + $('#city_input').val() + " " + $('.state_input').val() + " " + $('#zipcode_input').val() );
		}

		// blur address
		if ($('input[name=radio_addr]:radio:checked').val() == 1) {

			$('#property_b_address1').val($('#address1_input').val());
			$('#property_b_address2').val($('#address2_input').val());
			$('#property_b_city').val($('#city_input').val());
			$('#property_b_state').val($('.state_input').val());
			$('#property_b_zipcode').val($('#zipcode_input').val());

			$('#span_addr').html("the intercetion between " + $('#address1_input').val() + " and " + $('#address2_input').val() + "  in  " + $('#city_input').val() + " " + $('.state_input').val() + " " + $('#zipcode_input').val() );


		}


		/// get ip address
		$.getJSON("http://jsonip.com?callback=?", function (data) {
    		//alert("Your ip: " + data.ip);
    		$('#property_ip').val(data.ip);
    		
		});

	}	

	
	

