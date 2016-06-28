Return-Path: <tn@semihalf.com>
Return-Path: <tn@semihalf.com>
From: Tomasz Nowicki <tn@semihalf.com>
To: helgaas@kernel.org,
	arnd@arndb.de,
	will.deacon@arm.com,
	catalin.marinas@arm.com,
	rafael@kernel.org,
	hanjun.guo@linaro.org,
	Lorenzo.Pieralisi@arm.com,
	okaya@codeaurora.org,
	jchandra@broadcom.com
Cc: robert.richter@caviumnetworks.com,
	mw@semihalf.com,
	Liviu.Dudau@arm.com,
	ddaney@caviumnetworks.com,
	wangyijing@huawei.com,
	msalter@redhat.com,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linaro-acpi@lists.linaro.org,
	jcm@redhat.com,
	andrea.gallo@linaro.org,
	dhdang@apm.com,
	jeremy.linton@arm.com,
	liudongdong3@huawei.com,
	cov@codeaurora.org,
	gabriele.paoloni@huawei.com,
	jhugo@codeaurora.org,
	Tomasz Nowicki <tn@semihalf.com>
Subject: [RFC PATCH v4 0/5] ECAM quirks handling for ARM64 platforms
Date: Tue, 28 Jun 2016 09:53:57 +0200
Message-Id: <1467100442-28078-1-git-send-email-tn@semihalf.com>
List-ID: <linux-pci.vger.kernel.org>

Quirk handling relies on an idea of matching MCFG OEM ID, TABLE ID and
revision (the ones from standard header of MCFG table).

Static array is used to keep quirk entries. Each entry consist of
metioned MCFG IDs along with custom pci_ops structure and initialization call.

As an example, last patch presents quirk handling mechanism usage for
ThunderX PEM driver.

Tomasz Nowicki (5):
  PCI: Embed pci_ecam_ops in pci_config_window structure
  PCI/ACPI: Move ACPI ECAM mapping to generic MCFG driver
  PCI: Check platform specific ECAM quirks
  ARM64/PCI: Start using quirks handling for ACPI based PCI host
    controller
  PCI: thunder: Add ThunderX PEM MCFG quirk to the list

 arch/arm64/kernel/pci.c            | 42 +----------------
 drivers/acpi/pci_mcfg.c            | 40 ++++++++++++++++
 drivers/pci/ecam.c                 |  6 +--
 drivers/pci/host/Makefile          |  1 +
 drivers/pci/host/mcfg-quirks.c     | 95 +++++++++++++++++++++++++++++++++++++
 drivers/pci/host/mcfg-quirks.h     | 24 ++++++++++
 drivers/pci/host/pci-thunder-pem.c | 96 ++++++++++++++++++++++++++++++++------
 include/linux/pci-acpi.h           |  5 ++
 include/linux/pci-ecam.h           |  2 +-
 9 files changed, 254 insertions(+), 57 deletions(-)
 create mode 100644 drivers/pci/host/mcfg-quirks.c
 create mode 100644 drivers/pci/host/mcfg-quirks.h

-- 
1.9.1
