
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <!-- Page title -->
    <title>Users</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/datatables.net-bs/css/dataTables.bootstrap.min.css" />
 
    
   

</head>
<body class="fixed-navbar sidebar-scroll">
       <jsp:include page="menu.jsp"/>
       
<div id="wrapper">

<div class="small-header">
    <div class="hpanel">
        <div class="panel-body">
            <div id="hbreadcrumb" class="pull-right">
                <ol class="hbreadcrumb breadcrumb">
                    <li><a href="#">Dashboard</a></li>
                    
                    <li class="active">
                        <span>User Details</span>
                    </li>
                </ol>
            </div>
            <h2 class="font-light m-b-xs">
                Users
            </h2>
            <small>Manage Users</small>
        </div>
    </div>
</div>

<div class="content">
<div>

<div class="row">
    
    <!--tab component -->
    <div class="col-lg-12">
        <div class="hpanel">
            <div class="nav nav-tabs">
           
                <ul class="nav nav-tabs">
                    <li class="active"><a data-toggle="tab" href="#tab-8">Users</a></li>
                    
                </ul>
                
                <div class="tab-content ">
                    <div id="tab-8" class="tab-pane active">
                        <div class="panel-body">
                            
                        <div class="row " style="padding-bottom:20px;">
                            <div class="col-md-12 text-right">
                                <button class="btn btn-primary " id="CreateUser" type="button"><i class="fa fa-plus"></i> New</button>
                            </div>
                        </div>
                          
                    <table id="tblSystemUsers" class="table table-striped table-bordered table-hover" width="100%">
                        <thead>
                        <tr>
                            <th>Name</th>
                            <th>Email</th>
                            <th width="15%">User Type</th>
                            <th width="15%">Actions</th>
                            
                        </tr>
                        </thead>
                        <tbody>
                        
                        <c:forEach items="${systemUsers}" var="user">
                                    <tr>
                                        <td>${user.getUsername()}</td>
                                        <td>${user.getEmail()}</td>
                                        <td><c:out value="${user.getUserType()}" /></td>
                                        <td>
                                            <button class="btn btn-primary btn-circle EditUser" type="button" data-user='${user.getJson()}'><i class="fa fa-edit"></i></button>
                                            <button class="btn btn-danger btn-circle DeleteUser" type="button" id="" data-user='${user.getJson()}'><i class="fa fa-times"  ></i></button>
                                            <button class="btn btn-primary btn-circle ViewUser" type="button" id="" data-user='${user.getJson()}'><i class="fa fa-list"  ></i></button>
                                            
                                        </td>
                                    </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                     
                        </div>
                    </div>
                               
                    
                </div>

            </div>
        </div>
    </div>
    
   <!--End of tab component -->
    </div>
    
   <!--Create Model Component -->
   <div class="modal fade" id="myModalCreate" tabindex="-1" role="dialog" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="color-line"></div>
                                <div class="modal-header text-center">
                                    <h4 class="modal-title">Create System User</h4>
                                    <small class="font-bold">Could create Product under this Type Later!</small>
                                </div>
                                <div class="modal-body">
                                    
                                        
                                     <!--     -->
                                       <form role="form" id="form_createuser" class="form-horizontal" method="POST" action="${pageContext.request.contextPath}/UserServlet">
                                           <input type="text" value="CreateUser" name="action"  hidden >
                                           
                                           <div class="form-group"><label class="col-sm-2 control-label">User Type<span style="color: red;">*</span></label>

                                                <div class="col-sm-10"><select class="form-control m-b" name="type">
                                                    <option></option>
                                                    <option>Administrator</option>
                                                    <option>Sales</option>
                                                    
                                                </select>
                                                </div>
                                            </div>
                                            <div class="form-group"><label class="col-sm-2 control-label" >User Name<span style="color: red;">*</span></label>
                                            <div class="col-sm-10"><input type="text" placeholder="User Name" name="username" class="form-control" required></div>
                                            </div>
                                            
                                            <div class="form-group"><label class="col-sm-2 control-label" >Email<span style="color: red;">*</span></label>
                                                <div class="col-sm-10"><input type="email" placeholder="Email" name="email" class="form-control" required></div>
                                            </div>
                                            
                                            <div class="form-group">
                                                <div class="col-sm-8 col-sm-offset-2">
                                                    <button class="btn btn-default" type="button" data-dismiss="modal">Cancel</button>
                                                    <button class="btn btn-primary" type="submit">Save</button>
                                                </div>
                                            </div>
                                        </form>
                                    
                                </div>
                                
                            </div>
                        </div>
                    </div>
   <!-- End of model -->

   <!--Edit Model Component -->
   <div class="modal fade" id="myModalEdit" tabindex="-1" role="dialog" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="color-line"></div>
                                <div class="modal-header text-center">
                                    <h4 class="modal-title">Edit User Details</h4>
                                    <small class="font-bold">Manage user details!</small>
                                </div>
                                <div class="modal-body">
                                     <form role="form" id="form_edituser" class="form-horizontal" method="POST" action="${pageContext.request.contextPath}/UserServlet">
                                           <input type="text" value="EditUser" name="action"  hidden >
                                           <input type="text" id="eid" name="id"  hidden >
                                           
                                           
                                           <div class="form-group"><label class="col-sm-2 control-label">User Type<span style="color: red;">*</span></label>

                                                <div class="col-sm-10"><select class="form-control m-b" id="etype" name="type">
                                                    <option>Administrator</option>
                                                    <option>Sales</option>
                                                    
                                                </select>
                                                </div>
                                            </div>
                                            <div class="form-group"><label class="col-sm-2 control-label" >User Name<span style="color: red;">*</span></label>
                                                <div class="col-sm-10"><input type="text" placeholder="User Name" id="eusername" name="username" class="form-control" required></div>
                                            </div>
                                            <div class="form-group"><label class="col-sm-2 control-label" >Email<span style="color: red;">*</span></label>
                                                <div class="col-sm-10"><input type="email" placeholder="Email" id="eemail" name="email" class="form-control" required></div>
                                            </div>
                                           
                                            <div class="form-group">
                                                <div class="col-sm-8 col-sm-offset-2">
                                                    <button class="btn btn-default" type="button" data-dismiss="modal">Cancel</button>
                                                    <button class="btn btn-primary" type="submit">Save</button>
                                                </div>
                                            </div>
                                        </form>
                                </div>
                                
                            </div>
                        </div>
                    </div>
   <!-- End of model -->
    
   <!--View Model Component -->
   <div class="modal fade" id="myModalView" tabindex="-1" role="dialog" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="color-line"></div>
                                <div class="modal-header text-center">
                                    <h4 class="modal-title">View System User</h4>
                                    <small class="font-bold">View System User Details!</small>
                                </div>
                                <div class="modal-body">
                                    <form role="form" id="form_createtype" class="form-horizontal">
                                            
                                           <div class="form-group"><label class="col-sm-2 control-label">User Type</label>

                                               <div class="col-sm-10"><select class="form-control m-b" id="vtype" name="type" disabled="">
                                                    <option>Administrator</option>
                                                    <option>Sales</option>
                                                    
                                                </select>
                                                </div>
                                            </div>
                                            <div class="form-group"><label class="col-sm-2 control-label" >User Name</label>
                                            <div class="col-sm-10"><input type="text" placeholder="User Name" id="vusername" name="username" class="form-control" disabled="" required></div>
                                            </div>
                      
                                            <div class="form-group"><label class="col-sm-2 control-label" >Email</label>
                                                <div class="col-sm-10"><input type="email" placeholder="Email" id="vemail" name="email" class="form-control" disabled="" required></div>
                                            </div>
                                          
                                            <div class="form-group">
                                                <div class="col-sm-8 col-sm-offset-2">
                                                    <button class="btn btn-default" type="button" data-dismiss="modal">Cancel</button>
                                                    
                                                </div>
                                            </div>
                                        </form>
                                </div>
                                
                            </div>
                        </div>
                    </div>
   <!-- End of model -->

    
</div>
</div>
</div> 
       
<script src="${pageContext.request.contextPath}/css/jquery-validation/jquery.validate.min.js"></script> 
 <!-- DataTables -->
<script src="${pageContext.request.contextPath}/css/datatables/media/js/jquery.dataTables.min.js"></script>
<script src="${pageContext.request.contextPath}/css/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
<!-- DataTables buttons scripts -->
<script src="${pageContext.request.contextPath}/css/pdfmake/build/pdfmake.min.js"></script>
<script src="${pageContext.request.contextPath}/css/pdfmake/build/vfs_fonts.js"></script>
<script src="${pageContext.request.contextPath}/css/datatables.net-buttons/js/buttons.html5.min.js"></script>
<script src="${pageContext.request.contextPath}/css/datatables.net-buttons/js/buttons.print.min.js"></script>
<script src="${pageContext.request.contextPath}/css/datatables.net-buttons/js/dataTables.buttons.min.js"></script>
<script src="${pageContext.request.contextPath}/css/datatables.net-buttons-bs/js/buttons.bootstrap.min.js"></script>
 

 <script>

    $(document).ready(function () {
        //$('#myModal').modal('show');
         var ORID= 0;
        
        $(document).on("submit", "#form_createuser", function(event) {
                var $form = $(this);

                $.post($form.attr("action"), $form.serialize(), function(response) {
                    $('#myModalCreate').modal('hide');
                    
                    if(response.IsSuccess)
                    {
                                          
                      swal({title: "Registered!",
                      text: "User details has been created!.",
                      type: "success"}, function() {
                            window.location.href = window.location.href
                     });
           
                    }
                    else
                    {
                       swal("Cancelled", "Something Went Wrong", "error"); 
                    }
                });

                event.preventDefault(); // Important! Prevents submitting the form.
        });
        
        
        $(document).on("submit", "#form_edituser", function(event) {
                var $form = $(this);

                $.post($form.attr("action"), $form.serialize(), function(response) {
                    $('#myModalEdit').modal('hide');
                    
                    if(response.IsSuccess)
                    {                    
                      swal({title: "Updated!",
                      text: "User details has been updated!.",
                      type: "success"}, function() {
                            window.location.href = window.location.href
                     });
                    }
                    else
                    {
                       swal("Cancelled", "Something Went Wrong", "error"); 
                    }
                });

                event.preventDefault(); // Important! Prevents submitting the form.
        });
        
        
        $("#form_createuser").validate({
            rules: {
                type: {
                    required: true,                   
                },             
                username: {
                    required: true,                   
                },
                email: {
                    required: true, 
                    email: true
                }
                
            }
        });
        
        $("#form_edituser").validate({
            rules: {
                type: {
                    required: true,                   
                },      
                username: {
                    required: true,                   
                },             
                email: {
                    required: true, 
                    email: true
                }
                
            }
        });
        
      
        
        
        $('.DeleteUser').click(function () {
            var imageObj = $(this).data('user');
            swal({
                        title: "Are you sure?",
                        text: "Your will not be able to recover this User profile!",
                        type: "warning",
                        showCancelButton: true,
                        confirmButtonColor: "#DD6B55",
                        confirmButtonText: "Yes, delete it!",
                        cancelButtonText: "No, cancel plx!",
                        closeOnConfirm: false,
                        closeOnCancel: false },
                    function (isConfirm) {
                       if (isConfirm) {
                            
                            
                            var form = $(this).closest('form');
                            form = form.serializeArray();
                            form = form.concat([
                                {name: "id", value:imageObj.Id } ,
                                {name: "action", value:"DeleteUser" }

                            ]);
                            $.post('${pageContext.request.contextPath}/UserServlet', form, function(d) {
                                
                                if (d.IsSuccess) {
                                   
                                     swal({title: "Deleted!",
                                        text: "Selected User profile has been deleted.",
                                        type: "success"}, function() {
                                              window.location.href = window.location.href
                                       });
                                } else {
                                    swal("Cancelled", "Something Went Wrong!", "error");
                                }
                             });
                            
                        } else 
                        {
                            swal("Cancelled", "User Profile Saved!", "error");
                        }
                    });
        });
        
        
       
        
        
        $(".ViewUser").click(function(){
             var imageObj = $(this).data('user');
             // set modal values
             //currentBranch = imageObj.Id;
             $("#vusername").val(imageObj.Username);
             $("#vemail").val(imageObj.Email);         
             $("#vtype").val(imageObj.UserType);        
             $("#vid").val(imageObj.Id);
             
             $('#myModalView').modal('show');
        });
        
        
        $("#CreateUser").click(function(){
 
             $('#myModalCreate').modal('show');
        });
        
        $(".EditUser").click(function(){
             
             var imageObj = $(this).data('user');
             
             $("#eusername").val(imageObj.Username);
             $("#eemail").val(imageObj.Email);          
             $("#etype").val(imageObj.UserType);          
             $("#eid").val(imageObj.Id);
             
             
             $('#myModalEdit').modal('show');
        });
        
        $(function () {
        // Initialize Example 1
        $('#tblSystemUsers').dataTable( {
         //   "ajax": '${pageContext.request.contextPath}/api/datatables.json',
            
            dom: "<'row'<'col-sm-4'l><'col-sm-4 text-center'B><'col-sm-4'f>>tp",
            "lengthMenu": [ [10, 25, 50, -1], [10, 25, 50, "All"] ],
            buttons: [
                {extend: 'copy',className: 'btn-sm'},
                {extend: 'csv',title: 'ExampleFile', className: 'btn-sm'},
                {extend: 'pdf', title: 'ExampleFile', className: 'btn-sm'},
                {extend: 'print',className: 'btn-sm'}
            ]
           
        });
    });
    
        
    });
    


</script>     
       
</body>
</html>
