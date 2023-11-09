all: run

dependencies:
	@python -m venv .venv
	@source .venv/bin/activate && pip install -r requirements.txt
	@source .venv/bin/activate && ansible-galaxy collection install ansible.windows
	@source .venv/bin/activate && ansible-galaxy collection install community.windows

provisioner: dependencies
	@cd provisioner/ && vagrant up

run: provisioner
	@source .venv/bin/activate && ansible-playbook -i inventory.ini playbook.yml

destroy:
	@cd provisioner/ && vagrant destroy

.PHONY: run