<!-- Main jumbotron for a primary marketing message or call to action -->
<div class="jumbotron bt">
	<div class="container">
		<h1>ColdFusion API</h1>
		<p class="lead">A RESTful API running on ColdFusion</p>
	</div>
</div>

<div class="container">

	<div class="row">

		<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">

			<p class="pull-xs-right hidden-sm-up">
				<button type="button" class="btn btn-primary btn-sm" data-toggle="offcanvas">Toggle nav</button>
			</p>

			<div class="row">

				<div class="col-xs-12 col-lg-6">
					<div class="jumbotron" style="padding: 1rem">
						<h2>API Environment</h2>
						<h3>
							<cfoutput>
							<cfloop list="development,production" index="listItem">
								<span class="label <cfif prc.environment eq listItem>label-danger<cfelse>label-default</cfif>">
									#listItem#
								</span>
							</cfloop>
							</cfoutput>
						</h3>
						<br>
						<h3>
							<span class="label label-warning"><cfoutput>#prc.hostaddress#</cfoutput></span>
						</h3>
					</div>
				</div>

				<div class="col-xs-12 col-lg-6">
					<h2>Good Reading</h2>
					<ul>
						<li>
							<a href="https://coldbox.ortusbooks.com/content/full/recipes/building_rest_apis.html">Building REST APIs</a>
						</li>
						<li>
							<a href="https://coldbox.ortusbooks.com/content/full/routing/restful_action_routing.html">RESTful Action Routing</a>
						</li>
						<li>
							<a href="https://coldbox.ortusbooks.com/content/full/event_handlers/rendering_data.html">Rendering Data</a>
						</li>
						<li>
							<a href="https://coldbox.ortusbooks.com/content/full/routing/with_clousures.html">Routing with Closures</a>
						</li>
						<li>
							<a href="https://github.com/Ortus-Solutions/cbox-cbrestbasehandler">The ColdBox Rest Base Handler Module</a>
						</li>
						<li>
							<a href="https://github.com/lmajano/presso-advanced-rest-with-coldbox">Advanced REST Techniques with ColdBox</a>
						</li>
					</ul>
				</div>

			</div>

			<!---
				Display the following
				when not in PRODUCTION environments.
			--->
			<cfif prc.environment neq "production">

				<div class="row">
					<p>&nbsp;</p>
				</div>

				<div class="row">

					<div class="col-xs-12 col-lg-6">
						<h2>Documentation</h2>
						<p>
							<a href="https://github.com/ColdBox/coldbox-relax">Relax</a> is a tool used for documenting APIs.
							It automagically describes, models, documents, tests and monitors RESTful services
							on multiple environments.
						</p>
						<p><a class="btn btn-secondary" href="/relax" role="button">View Docs &raquo;</a></p>
					</div>

					<div class="col-xs-12 col-lg-6">
						<h2>Postman</h2>
						<p>
							The shared Collection below can be imported, and safely overwritten, in Postman.
							It includes sample payloads to test all endpoints.
						</p>
						<cfoutput>
							<div class="postman-run-button"
							data-postman-action="collection/import"
							data-postman-var-1="9cdc5d9c719a73f74b7b"
							data-postman-param="env%5BLucee%205%5D=W3sia2V5Ijoid2Vic2l0ZSIsInZhbHVlIjoiaHR0cDovL2xvY2FsaG9zdDo1MjUyMCIsInR5cGUiOiJ0ZXh0IiwiZW5hYmxlZCI6dHJ1ZX1d"></div>
							<script type="text/javascript">
							  (function (p,o,s,t,m,a,n) {
							    !p[s] && (p[s] = function () { (p[t] || (p[t] = [])).push(arguments); });
							    !o.getElementById(s+t) && o.getElementsByTagName("head")[0].appendChild((
							      (n = o.createElement("script")),
							      (n.id = s+t), (n.async = 1), (n.src = m), n
							    ));
							  }(window, document, "_pm", "PostmanRunObject", "https://run.pstmn.io/button.js"));
							</script>
							<div>Modified #prc.postmanFileLastModified#</div>
						</cfoutput>
					</div>

				</div>

				<div class="row">
					<p>&nbsp;</p>
				</div>

				<div class="row">

					<div class="col-xs-12 col-lg-6">
						<h2>Tests</h2>
						<p>
							<a href="https://www.gitbook.com/book/ortus/testbox-documentation/details">TestBox</a>
							is a TDD/BDD syntax CFML testing framework.
							It bundles a runner, an assertions and expectations library, and MockBox
							for mocking and stubbing.
						</p>
						<p><a class="btn btn-secondary" href="/tests/index.cfm" role="button">Run Tests &raquo;</a></p>
					</div>

					<div class="col-xs-12 col-lg-6">

					</div>

				</div>

			</cfif>

		</div>

	</div>

	<div class="row">
		&nbsp;
	</div>

	<hr>

	<footer>
		<p>&copy; Evagoras Charalambous <cfoutput>#year( now() )#</cfoutput></p>
	</footer>

</div><!--/.container-->