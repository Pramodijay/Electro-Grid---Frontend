<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="UTF-8">
	<title>title</title>
	
    
    <script src="assets/js/croppie.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.0/jquery.validate.js"></script>
	
</head>
<body>
	
    <div class="container">
		
<br>
<p></p>
	                    <div>notice List</div>
	                    <div>
	                        <div id="noticesDiv">
	                    	
	            			</div>
	                    </div>
	                    
	                   
<div id="hideDiv" style="display: none">
   	                        <form id="noticeRegister">
							<input type= "hidden" id="edit_id" name="edit_id">
	                            
	                            <div>
	                                <label>Account ID</label>
	                                <div>
	                                    <input type="number" id="account_id" class="form-control" name="account_id">
	                                </div>
	                            </div>
	                            
	                            <div>
	                                <label>Bill ID</label>
	                                <div>
	                                    <input type="number" id="b_id" class="form-control" name="b_id">
	                                </div>
	                            </div>
	                            
	                            <div>
	                                <label>Bill Amount</label>
	                                <div>
	                                    <input type="number" id="b_amount" class="form-control" name="b_amount">
	                                </div>
	                            </div>
	                            
	                            <div>
	                                <label>Customer Name</label>
	                                <div>
	                                    <input type="text" id="c_name" class="form-control" name="c_name">
	                                </div>
	                            </div>
	                            
	                           
	                            
	                             <div>
	                                <label>Payment Method</label>
	                                <div>
	                                    <input type="text" id="p_method" class="form-control" name="p_method">
	                                </div>
	                            </div>
	                            
	                             <div>
	                                <label>Description</label>
	                                <div>
	                                    <input type="text" id="description" class="form-control" name="description">
	                                </div>
	                            </div>
	                           
	                            <div>
	                                <label>Date</label>
	                                <div>
	                                    <input type="date" id="date" class="form-control" name="date">
	                                </div>
	                            </div>
	                            
	                             <div>
	                                <label>Customer NIC</label>
	                                <div>
	                                    <input type="number" id="c_nic" class="form-control" name="c_nic">
	                                </div>
	                            </div>
	                            <div>
	                                <label>Type</label>
	                                <div>
	                                    <input type="text" id="type" class="form-control" name="type">
	                                </div>
	                            </div>
	                            
	                            
	                            <div>
	                                <button type="submit" class="btn btn-success">
	                                    Edit
	                                </button>
	                                
	                            </div>
	                    	</form>
</div> 
	                    
</div>
	
</body>
</html>

<script>

    function deletes(id) {
    	if (confirm("Delete ?") == true) {
        	$.ajax({
                type: "DELETE",
                url: "rest_api/notice",
                data: JSON.stringify({ 'id' : id}),
                dataType: "json",
    			contentType : 'application/json',
                success: function(data){
                	if(data['success']=="Done"){
                		alert("Delete Successfull!");
    					reload();
    				}else if(data['success']=="0"){
    					alert("Delete Unsuccessful!");
    				}
                },
                failure: function(errMsg) {
                    alert('Error');
                }
            });
    	}
    }

    $(document).ready(function () {

    	   $("#noticeRegister").validate({
    	        rules: {
    	        	//id: "required",
    	        	account_id: "required",
    	        	b_id: "required",
    	        	b_amount: "required",
    	        	c_name: "required",
    	        	p_method: "required",
    	            description: "required",
    	        	date: "required",
    	            c_nic: "required",
    	            type: "required"
    	        },
    	        messages: {
    	        	//id: "N Required!",
    	        	account_id: "F Required!",
    	        	b_id: "l Required!",
    	        	b_amount: "m Required!",
    	        	c_name: "n Required!",
    	        	p_method: "a Required!",
    	        	description: "p Required!",
    	        	date: "a Required!",
    	            c_nic: "c Required",
    	     	    type: "t Required"
    	        },
    	        submitHandler: function () {
    	        	var fromData = JSON.stringify({
    	        		"id" : $('#edit_id').val(),
    	                "account_id" : $('#account_id').val(),
    	                "b_id" : $('#b_id').val(),
    	                "b_amount" : $('#b_amount').val(),
    	                "c_name" : $('#c_name').val(),
    	                "p_method" : $('#p_method').val(),
    	                "description" : $('#description').val(),
    	                "date" : $('#date').val(),
    	                "c_nic" : $('#c_nic').val(),
    	                "type" : $('#type').val()
    	            });
            	
            	console.log(fromData);

                $.ajax({
                    type: "PUT",
                    url: 'rest_api/notice',
                    dataType : 'json',
    				contentType : 'application/json',
    				data: fromData,
                    success: function(data){
                    	if(data['success']=="Done"){
                    		alert("Edit Successfull!");
                        	document.getElementById("hideDiv").style.display = "none";
                            $("#noticeRegister")[0].reset();
    						reload();
    					}else{
    						alert("Unsuccessful!");
    					}
                    },
                    failure: function(errMsg) {
                    	alert("Connection Error!");
                    }
                });
            }
        });

        $("#noticeRegister").submit(function(e) {
            e.preventDefault();
        });

    });

    function reload(){
    	$.ajax({
            type: "GET",
            url: "rest_api/notice",
            success: function(data){
            	$("#noticesDiv").html(data);
            },
            failure: function(errMsg) {
                alert('Error');
            }
        });
    }

    reload();
    
    function edit(id) {
    	document.getElementById("hideDiv").style.display = "block";
    	$.ajax({
            type: "POST",
            url: "rest_api/notice/get",
            data: JSON.stringify({ 'id' : id}),
            dataType: "json",
			contentType : 'application/json',
            success: function(data){
            	console.log(data),
                $('#edit_id').val(data['id']),
                $('#account_id').val(data['account_id']),
                $('#b_id').val(data['b_id']),
                $('#b_amount').val(data['b_amount']),
                $('#c_name').val(data['c_name']),
                $('#p_method').val(data['p_method']),
                $('#description').val(data['description']),
                $('#date').val(data['date']),
                $('#c_nic').val(data['c_nic']),
                $('#type').val(data['type'])
            },
            failure: function(errMsg) {
                alert('Error');
            }
        });

    }
    
    
</script>