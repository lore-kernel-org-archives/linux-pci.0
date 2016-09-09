Return-Path: <tn@semihalf.com>
Return-Path: <tn@semihalf.com>
From: Tomasz Nowicki <tn@semihalf.com>
To: helgaas@kernel.org,
	will.deacon@arm.com,
	catalin.marinas@arm.com,
	rafael@kernel.org,
	Lorenzo.Pieralisi@arm.com
Cc: arnd@arndb.de,
	hanjun.guo@linaro.org,
	okaya@codeaurora.org,
	jchandra@broadcom.com,
	cov@codeaurora.org,
	dhdang@apm.com,
	ard.biesheuvel@linaro.org,
	robert.richter@caviumnetworks.com,
	mw@semihalf.com,
	Liviu.Dudau@arm.com,
	ddaney@caviumnetworks.com,
	wangyijing@huawei.com,
	msalter@redhat.com,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linaro-acpi@lists.linaro.org,
	jcm@redhat.com,
	andrea.gallo@linaro.org,
	jeremy.linton@arm.com,
	liudongdong3@huawei.com,
	gabriele.paoloni@huawei.com,
	jhugo@codeaurora.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tomasz Nowicki <tn@semihalf.com>
Subject: [PATCH V6 0/5] ECAM quirks handling for ARM64 platforms
Date: Fri,  9 Sep 2016 21:24:02 +0200
Message-Id: <1473449047-10499-1-git-send-email-tn@semihalf.com>
List-ID: <linux-pci.vger.kernel.org>

Quirk handling relies on an idea of simple static array which contains
quirk enties. Each entry consists of identification information (IDs from
standard header of MCFG table) along with custom pci_ecam_ops structure and 
configuration space resource structure. This way it is possible find
corresponding quirk entries and override pci_ecam_ops and PCI configuration
space regions.

As an example, the last 3 patches present quirk handling mechanism usage for
ThunderX.

v5 -> v6
- rebase against v4.8-rc5
- drop patch 1 form previous series
- keep pci_acpi_setup_ecam_mapping() in ARM64 arch directory
- move quirk code to pci_mcfg.c
- restrict quirk to override pci_ecam_ops and CFG resource structure
  only, no init call any more
- split ThunderX quirks into the smaller chunks
- add ThunderX pass1.x silicon revision support

v4 -> v5
- rebase against v4.8-rc1
- rework to exact MCFG OEM ID, TABLE ID, rev match
  - use memcmp instead of strncmp
  - no substring match
- fix typos and dmesg message

Tomasz Nowicki (5):
  PCI/ACPI: Extend pci_mcfg_lookup() responsibilities
  PCI/ACPI: Check platform specific ECAM quirks
  PCI: thunder-pem: Allow to probe PEM-specific register range for ACPI
    case
  PCI: thunder: Enable ACPI PCI controller for ThunderX pass2.x silicon
    version
  PCI: thunder: Enable ACPI PCI controller for ThunderX pass1.x silicon
    version

 arch/arm64/kernel/pci.c             |  17 ++--
 drivers/acpi/pci_mcfg.c             | 168 +++++++++++++++++++++++++++++++++++-
 drivers/pci/host/pci-thunder-ecam.c |   2 +-
 drivers/pci/host/pci-thunder-pem.c  |  63 +++++++++++---
 include/linux/pci-acpi.h            |   4 +-
 include/linux/pci-ecam.h            |   7 ++
 6 files changed, 230 insertions(+), 31 deletions(-)

-- 
1.9.1
