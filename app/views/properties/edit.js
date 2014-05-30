
alert('s');
  
$(document).ready(function () {  

   			// exactly address radio
   			$( ".radio_addr_1" ).on( "click", function() {

				  $('.group1').removeAttr("disabled"); 
			    $('.group2').attr("disabled","disabled");
			    $( '.radio_s_2' ).addClass( "text-muted");  
			    $( '.radio_s_1' ).removeClass( "text-muted");

		     });

		    //blur address radio
		    $( ".radio_addr_2" ).on( "click", function() {
				
				  $('.group2').removeAttr("disabled"); 
			    $('.group1').attr("disabled","disabled");  
				  $( '.radio_s_1' ).addClass( "text-muted");  
			    $( '.radio_s_2' ).removeClass( "text-muted");
		    });


			  $('#datepicker').datepicker();

		
  			
				/*
				var start_date;
				var end_date;			

				$('#exception_dates').focus(function(){
					start_date = $('#start_date').val();
					end_date = $('#end_date').val();
					
					//alert(start_date);	
				});
			*/
				//alert(end_date);
		    $('#exception_dates').datepicker({
			
			    multidate:true,
          multidateSeparator:',',
      		//startDate:start_date,
      		//endDate:end_date

      		//startDate: "03/19/2014",
      		//endDate:"04/16/2014"
      	});  	


				// if select the sublease option then shows datepicker

				$( "select" ).change(function() {
					var str = "Sublease";
					$( "select option:selected" ).each(function() {
  						if (str == $( this ).text()){
  							$("#sublease_section").removeClass('sublease');
  						} else {
  							$("#sublease_section").addClass('sublease');	
  						}     					
					});
				
				});



        //default set rent checkbox checked
	      $("#rent_checkbox").prop("checked", "checked");

        // set rent_checkbox always on
        $('#rent_checkbox').change(function() {
          $("#rent_checkbox").prop("checked", "checked"); 
        }); 

        
        //broker fee
        $('#property_hasBrokerFee').change(function() {
          if ($('#property_hasBrokerFee').is (':checked')){
            $('#property_broker_fee').removeAttr("disabled");   

          } else {
            $('#property_broker_fee').val('');
            $('#property_broker_fee').attr("disabled","disabled"); 
               
          }
        }); 

         //deposit
        $('#property_hasDeposit').change(function() {
          if ($('#property_hasDeposit').is (':checked')){
            $('#property_deposit').removeAttr("disabled");   

          } else {
            $('#property_deposit').val('');
            $('#property_deposit').attr("disabled","disabled"); 
               
          }
        });   

    });// document ready function




$( "#trigger_select_btn" ).on( "click", function() { 
            
            $("#upload_file").click();       // trigger to select file
            
            $(":file").change(function(){    // after file selected
              $("#trigger_select_btn").hide();                 // hide select button
              $("#trigger_upload_btn").show();                 // show  upload button and text  
             
              //truncate the file name
              var file_name = $(":file").val();

              var shortText = jQuery.trim(file_name).substring(0, 20);

              $( "#upload_text" ).text( shortText );
               
              
            });
            return false;
          });


          $( "#trigger_upload_btn" ).on( "click", function() {
            $("#upload_btn").click();          //trigger to upload file

            return false;
          });

          /*
          $( "#image_1" ).on( "click", function() {
            $( ".image_1" ).remove();  
          });
          */
        
          //photo upload
          $(document).on("click", "#upload_btn", function(){  
                    
            var form_data = new FormData();
            form_data.append('image', $('#upload_file').prop('files')[0]);
            
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

                $("#trigger_upload_btn").hide();                 // hide upload button
                $("#trigger_select_btn").show();                 // show  select button and text  
                $( "#upload_text" ).text(" ");
                 //var json = $.parseJSON(data);
                var json = data;
                  
                var btn_name = "image_" + json.id;   
                  //$('#show_thumb').append('Id: ' + json.id + " "    );
                /*
                $('#show_picture').append("<div class='col-xs-12 col-md-12 form-group'><img src=" + json.image_url_medium + "class='img-rounded' alt='Rounded Image'></div>"   );
                */
                
                
                $('#show_picture').append(" <div class='col-xs-12 col-md-12 col-lg-12 " + btn_name + "' ><div class='col-xs-10 col-md-10 col-lg-10 col_image' ><img src='" + json.image_url_medium + "'><input id='photo_image_id' name='photo[]' type='hidden' value='" + json.id + "'/></div><div class='col-xs-2 col-md-2 col-lg-2 col_image' ><button type='button' class='btn btn-warning' id='" + btn_name + "' ><span class='glyphicon glyphicon-remove'></span></button></div></div><script>$( '#" + btn_name + "' ).on( 'click', function() { $( '." + btn_name + "' ).remove();});</" + "script>" );


              }, 
              error: function(){
                alert('failure');
                $("#trigger_upload_btn").hide();                 // hide upload button
                $("#trigger_select_btn").show();                 // show  select button and text  
                $( "#upload_text" ).text(" ");

              }


            })

            return false;

          })