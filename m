Return-Path: <tn@semihalf.com>
Return-Path: <tn@semihalf.com>
From: Tomasz Nowicki <tn@semihalf.com>
To: helgaas@kernel.org,
	will.deacon@arm.com,
	catalin.marinas@arm.com,
	rafael@kernel.org,
	Lorenzo.Pieralisi@arm.com
Cc: arnd@arndb.de,
	jchandra@broadcom.com,
	ard.biesheuvel@linaro.org,
	robert.richter@caviumnetworks.com,
	mw@semihalf.com,
	ddaney@caviumnetworks.com,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linaro-acpi@lists.linaro.org,
	andrea.gallo@linaro.org,
	jeremy.linton@arm.com,
	liudongdong3@huawei.com,
	gabriele.paoloni@huawei.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jcm@redhat.com,
	msalter@redhat.com,
	Tomasz Nowicki <tn@semihalf.com>
Subject: [PATCH V1 0/2] Add support for ThunderX SoCs ACPI Host Controllers
Date: Tue, 15 Nov 2016 10:14:56 +0100
Message-Id: <1479201298-25494-1-git-send-email-tn@semihalf.com>
List-ID: <linux-pci.vger.kernel.org>

These patches were part of https://lkml.org/lkml/2016/9/9/666 series,
however, only core part (first two patches) was approved. ThunderX quirk
example had some comments which are address in this series (resetting version
numbering).

Add ACPI PCI host controler support for ThunderX SoCs pass1.x & pass2.x using
ACPI quirk mechanism [1]. Patches rework ThunderX ECAM and PEM driver to work
with ACPI & DT boot method.

Patch set can be found here:
git@github.com:semihalf-nowicki-tomasz/linux.git (pci-quirks-thunderx-v1)
It is based on branch pci/ecam-v6 which can be found here:
[1] https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git (pci/ecam-v6)

Tomasz Nowicki (2):
  PCI: thunder: Enable ACPI PCI controller for ThunderX pass2.x silicon
    version
  PCI: thunder: Enable ACPI PCI controller for ThunderX pass1.x silicon
    version

 drivers/acpi/pci_mcfg.c             |  35 ++++++++++++
 drivers/pci/host/pci-thunder-ecam.c |   2 +-
 drivers/pci/host/pci-thunder-pem.c  | 107 +++++++++++++++++++++++++++++++-----
 include/linux/pci-ecam.h            |   7 +++
 4 files changed, 136 insertions(+), 15 deletions(-)

-- 
2.7.4
