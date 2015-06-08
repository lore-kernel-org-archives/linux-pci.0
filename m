Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Yijing Wang <wangyijing@huawei.com>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Lv Zheng <lv.zheng@intel.com>,
	"lenb @ kernel . org" <lenb@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, "x86 @ kernel . org" <x86@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [Patch v5 0/6] Consolidate ACPI PCI root common code into ACPI core
Date: Tue,  9 Jun 2015 00:20:42 +0800
Message-Id: <1433780448-18636-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch set consolidates common code to support ACPI PCI root on x86
and IA64 platforms into ACPI core, to reproduce duplicated code and
simplify maintenance. And a patch set based on previous version to support
ACPI based PCIe host bridge on ARM64 has been posted at:
https://lkml.org/lkml/2015/5/26/207

It's based on latest mainstream kernel. It passes Fengguang's 0day test
suite and has been tested on two IA64 platforms and one x86 platform.

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

Jiang Liu (6):
  ACPI/PCI: Enhance ACPI core to support sparse IO space
  ia64/PCI/ACPI: Use common ACPI resource parsing interface for host
    bridge
  ia64/PCI: Use common struct resource_entry to replace struct
    iospace_resource
  PCI/ACPI: Consolidate common PCI host bridge code into ACPI core
  x86/PCI/ACPI: Use common interface to support PCI host bridge
  ia64/PCI/ACPI: Use common interface to support PCI host bridge

 arch/ia64/include/asm/pci.h |    5 -
 arch/ia64/pci/pci.c         |  366 ++++++++++++-------------------------------
 arch/x86/pci/acpi.c         |  294 ++++++++++------------------------
 drivers/acpi/pci_root.c     |  198 +++++++++++++++++++++++
 drivers/acpi/resource.c     |    9 +-
 include/linux/ioport.h      |    1 +
 include/linux/pci-acpi.h    |   23 +++
 7 files changed, 415 insertions(+), 481 deletions(-)

-- 
1.7.10.4

