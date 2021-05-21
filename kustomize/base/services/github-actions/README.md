# How to run github actions operator and runner

## requirements

* created organization
* created by a user who has read / write + permissions for the organization
* Create a PCT (Personal client token) for users
* secrety in github at the level of the organization

## commissioning in kubernetes

* create a secret for the runner
* runner settings

## troubleshooting

* when the pod is stuck in terminating state
* if the runner does not want to synchronize with the github

.......................................................................

## Creating an organization

* It is necessary to have an organization created in guthub and all repositories to be added under the given organization. This ensures that all repositories have access to self-hosted runners

## User to work with the runner

* The user must be part of the organization and have read / write rights.

* The user must also exist in AWS (another cloud service) and have rights to push / push from ECR (or similar) and have administrator rights to work with EKC (or similar)

## Creating a personal access token (PAT)

* Follow the [official documentation] (https://docs.github.com/en/github/authenticating-to-github/creating-a-personal-access-token) and create a token.

* in a nutshell:
  * Verify your email address - if you haven't already
  * Click on the profile picture in the top right and select `Settings`
  * select `Developer settings`
  * select `Personal access tokens`
  * select `Generate new token`
  * enter name and caption
  * select rules
  * click on the `Generate token` button at the very bottom

* Save the token value somewhere - it cannot be displayed again
* Token serves as a value for the GH_TOKEN variable in [secret] (kubernetes / kustomize / base / services / Github-actions / runner / secret.enc.yaml)

### Rules for PAT

* to use the token for github acstions workflow you need to have the following checked:

* repo - everything
* workflow
* admin: org - everything
* admin: public_key - read: public_key
* admin: repo_hook - read: repo_hook
* admin: org_hook
* notifications (I don't think this may be)

## secrets in github at the level of the organization

* KUBECONFIG_${ENVIRONMENT} - insert kubeconfig for the given environment, which is encrypted using base64
* AWS_ACCESS_KEY_ID - AWS user ID for the runner
* AWS_SECRET_ACCESS_KEY - AWS SECRET ACCESS KEY user for runner
* GH_TOKEN - generated user PAT for runner

.......................................................................

## Secrets for runner

* You need to create a secret named `actions-runner` that will contain the value:

```txt
GH_TOKEN: CELÝ_PERSONAL_TOKEN_GITHUB_UŽIVATELE_PRO_RUNNER
```

* deploy this secret to the same namespace as GithubActionRunner

## Custom runner settings

* the following values ​​are adjustable:
  * minRunners (line 8) - the minimum number of pods for the runner that will always be available
  * maxRunners (line 10) - maximum number of pods for the runner
  * organization (line 12) - MUST BE ADJUSTED - the name of the organization in github
  * reconciliationPeriod (line 14) - at what intervals to look for new work
  * organization in container (line 52) - MUST BE ADJUSTED - THE VALUE MUST BE THE SAME AS IN THE ORGANIZATION

  .......................................................................

## when the pod is stuck in terminating state

* When migrating a Github action runner, it is very likely that the pods will cut in state terminating.
* it can be removed according to this [manual](https://containersolutions.github.io/runbooks/posts/kubernetes/pod-stuck-in-terminating-state/#solution-a). In short, just use this:

```text
kubectl patch pod [POD_NAME] -p '{"metadata":{"finalizers":null}}'
``` 

## If there is a problem with the runner pods

* If everything runs as it should, but there are no pods in the namespac with the github action runner, then it is necessary to look in the log of the podium of the github action operator, specifically in the container manager.
* If the log contains the following:

```log
2021-05-12T09:27:26.486Z	INFO	controllers.GithubActionRunner	Pods and runner API not in sync, returning early	{"githubactionrunner": "github-actions-runner/runner-pool"}
2021-05-12T09:28:26.505Z	INFO	controllers.GithubActionRunner	Reconciling GithubActionRunner	{"githubactionrunner": "github-actions-runner/runner-pool"}
```

* so you need to go to the github repository ORGANIZATION -> settings -> actions -> runner and if there is a delfhosted runner offline, delete it (forcnout it)
