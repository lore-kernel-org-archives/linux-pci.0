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
	Suravee.Suthikulpanit@amd.com,
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
	Tomasz Nowicki <tn@semihalf.com>
Subject: [RFC PATCH 0/3] ECAM quirks handling for ARM64 platforms
Date: Thu,  2 Jun 2016 10:41:00 +0200
Message-Id: <1464856864-18049-1-git-send-email-tn@semihalf.com>
List-ID: <linux-pci.vger.kernel.org>

This series bases on pending ACPI PCI support for ARM64:
https://lkml.org/lkml/2016/5/30/468

Quirk handling relies on an idea of matching MCFG OEM ID and OEM revision
(the ones from standard header of MCFG table). Linker section is used
so that quirks can be registered using special macro (see patches) and
kept self contained.

As an example, last patch presents above mechanism usage for ThunderX PEM driver.

Tomasz Nowicki (3):
  pci, acpi: Match PCI config space accessors against platfrom specific
    ECAM quirks.
  arm64, pci: Start using quirks handling for ACPI based PCI host
    controller.
  pci, pci-thunder-pem: Add ACPI support for ThunderX PEM.

 arch/arm64/kernel/pci.c            |   7 +-
 drivers/acpi/pci_mcfg.c            |  32 +++++++++
 drivers/pci/host/pci-thunder-pem.c | 132 +++++++++++++++++++++++++++++++++----
 include/asm-generic/vmlinux.lds.h  |   7 ++
 include/linux/pci-acpi.h           |  19 ++++++
 5 files changed, 181 insertions(+), 16 deletions(-)

-- 
1.9.1
