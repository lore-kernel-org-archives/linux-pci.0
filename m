Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>
Cc: Liu Jiang <jiang.liu@linux.intel.com>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: [Patch v7 0/7] Consolidate ACPI PCI root common code into ACPI core
Date: Wed, 14 Oct 2015 14:29:35 +0800
Message-Id: <1444804182-6596-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Liu Jiang <jiang.liu@linux.intel.com>

This patch set consolidates common code to support ACPI PCI root on x86
and IA64 platforms into ACPI core, to reproduce duplicated code and
simplify maintenance. And a patch set based on previous version to support
ACPI based PCIe host bridge on ARM64 has been posted at:
https://lkml.org/lkml/2015/5/26/207

It's based on latest mainstream kernel. It passes Fengguang's 0day test
suite and has been tested on two IA64 platforms and one x86 platform.

V6->V7:
1) Improve commit message according to Bjorn's suggestion.
2) Move arch specific logic(code) from ACPI core into arch code
   according to Bjorn's review comments.

V5->V6:
1) Patch 5 to reset domain number to 0 when pci_ignore_seg is set
2) Remove parameter segment and node from function acpi_pci_root_create(),
   as suggested by Lorenzo and Bjorn.
V4-V5:
1) As suggested by Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, do not
   introduce "struct pci_controller" into generic drivers/acpi/pci_root.c,
   so ARM64 doesn't need to define a useless structure. And it simplifies
   code a little too.

V3->V4:
1) Add patch[05/08] support solve building issue on ARM64
2) Solve an implicitly pointer cast issue.
3) Rebase to latest mainstream kernel

V2->V3:
1. Move memory allocation/free from ACPI core into arch
2. Kill the field 'segment' in struct pci_root_info on x86

Thanks!
Gerry

Jiang Liu (7):
  ACPI/PCI: Enhance ACPI core to support sparse IO space
  ia64/PCI/ACPI: Use common ACPI resource parsing interface for host
    bridge
  ia64/PCI: Use common struct resource_entry to replace struct
    iospace_resource
  PCI/ACPI: Add interface acpi_pci_root_create()
  ACPI, PCI: Reset acpi_root_dev->domain to 0 when pci_ignore_seg is
    set
  x86/PCI/ACPI: Use common interface to support PCI host bridge
  ia64/PCI/ACPI: Use common interface to support PCI host bridge

 arch/ia64/include/asm/pci.h |    5 -
 arch/ia64/pci/pci.c         |  368 ++++++++++++-------------------------------
 arch/x86/pci/acpi.c         |  296 +++++++++++-----------------------
 drivers/acpi/pci_root.c     |  204 ++++++++++++++++++++++++
 drivers/acpi/resource.c     |    9 +-
 include/linux/ioport.h      |    1 +
 include/linux/pci-acpi.h    |   24 +++
 7 files changed, 423 insertions(+), 484 deletions(-)

-- 
1.7.10.4

