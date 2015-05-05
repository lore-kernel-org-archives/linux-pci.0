Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Yijing Wang <wangyijing@huawei.com>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Lv Zheng <lv.zheng@intel.com>,
	"lenb @ kernel . org" <lenb@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, "x86 @ kernel . org" <x86@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [RFC v2 0/7] Consolidate ACPI PCI root common code into ACPI core
Date: Tue,  5 May 2015 10:46:03 +0800
Message-Id: <1430793970-11159-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch set consolidates common code to support ACPI PCI root on x86
and IA64 platforms into ACPI core, to reproduce duplicated code and
simplify maintenance. The common code should also used to support PCI
host bridge on ARM64 too, but I'm lacking of knowledge about PCIe host
bridge implementation details on ARM64, so please help to review whether
this is suitable for ARM64 too.

It's based on latest mainstream kernel plus the patch to fix a regression
at: http://lkml.org/lkml/2015/4/30/13

It passes Fengguang's 0day test suite and has been tested on two IA64
platforms and one x86 platform.

The patch set is available at:
https://github.com/jiangliu/linux.git acpi_pci_root_v2

Thanks!
Gerry

Jiang Liu (7):
  ACPI/PCI: Enhance ACPI core to support sparse IO space
  ia64/PCI/ACPI: Use common ACPI resource parsing interface for host
    bridge
  ia64/PCI: Use common struct resource_entry to replace struct
    iospace_resource
  x86/PCI: Rename struct pci_sysdata as struct pci_controller
  PCI/ACPI: Consolidate common PCI host bridge code into ACPI core
  x86/PCI/ACPI: Use common interface to support PCI host bridge
  ia64/PCI/ACPI: Use common interface to support PCI host bridge

 arch/ia64/include/asm/pci.h   |    5 -
 arch/ia64/pci/pci.c           |  373 +++++++++++------------------------------
 arch/x86/include/asm/pci.h    |   13 +-
 arch/x86/include/asm/pci_64.h |    4 +-
 arch/x86/pci/acpi.c           |  281 +++++++++----------------------
 arch/x86/pci/common.c         |    2 +-
 drivers/acpi/pci_root.c       |  214 +++++++++++++++++++++++
 drivers/acpi/resource.c       |    9 +-
 include/linux/ioport.h        |    1 +
 include/linux/pci-acpi.h      |   24 +++
 10 files changed, 431 insertions(+), 495 deletions(-)

-- 
1.7.10.4

