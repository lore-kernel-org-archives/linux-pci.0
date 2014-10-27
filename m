Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Xinwei Hu <huxinwei@huawei.com>, Wuyun <wuyun.wu@huawei.com>,
	<linux-arm-kernel@lists.infradead.org>,
	Russell King <linux@arm.linux.org.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Thierry Reding" <thierry.reding@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH 00/10] Save MSI chip in pci_sys_data
Date: Mon, 27 Oct 2014 15:48:37 +0800
Message-ID: <1414396127-30023-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now PCI host bridge drivers in arm associate MSI chip and
PCI bus by adding .add_bus(), and assign MSI chip pointer
to every PCI bus. Associating MSI chip and every PCI bus
is not necessary. All PCI busses under same PCI host brdige
share the same MSI chip. So saving MSI chip in pci_sys_data
is a better solution, it make PCI host bridge drivers clean.
Because we still need to provide arch spec pcibios_msi_controller()
to extract MSI controller pointer, a better solution is to
refactor PCI host bridge, make a generic pci_host_bridge, and
save common info like PCI domain number, MSI chip, resources
in it. We will do that work in another series as soon.

To Bjorn: Because struct msi_chip defined in struct hw_pci and pci_sys_data
is under the #ifdef CONFIG_PCI_MSI, if we use if(IS_ENABLED(CONFIG_PCI_MSI))
in PCI host bridge drivers, it will cause build errors when the CONFIG_PCI_MSI
is off. So I keep #ifdef CONFIG_PCI_MSI in this series.

Yijing Wang (10):
  MSI: Rename msi_chip to msi_controller for better readability
  PCI/MSI: Introduce weak pcibios_msi_controller()
  arm/MSI: Save MSI controller in pci_sys_data
  PCI: tegra: Save MSI controller in pci_sys_data
  PCI: designware: Save MSI controller in pci_sys_data
  PCI: rcar: Save MSI controller in pci_sys_data
  PCI: mvebu: Save MSI controller in pci_sys_data
  PCI: xilinx: Save MSI controller in pci_sys_data
  arm/PCI: Clean unused pcibios_add_bus() and pcibios_remove_bus()
  PCI/MSI: Remove useless bus->msi assignment

 arch/arm/include/asm/mach/pci.h     |   10 +++++---
 arch/arm/kernel/bios32.c            |   28 ++++++++++--------------
 drivers/irqchip/irq-armada-370-xp.c |   22 +++++++++---------
 drivers/of/of_pci.c                 |   40 +++++++++++++++++-----------------
 drivers/pci/host/pci-keystone-dw.c  |    4 +-
 drivers/pci/host/pci-keystone.h     |    2 +-
 drivers/pci/host/pci-mvebu.c        |   14 ++++-------
 drivers/pci/host/pci-tegra.c        |   37 +++++++++++++-------------------
 drivers/pci/host/pcie-designware.c  |   25 +++++++--------------
 drivers/pci/host/pcie-designware.h  |    2 +-
 drivers/pci/host/pcie-rcar.c        |   37 +++++++++++++-------------------
 drivers/pci/host/pcie-xilinx.c      |   27 +++++++----------------
 drivers/pci/msi.c                   |   22 ++++++++++++++-----
 drivers/pci/probe.c                 |    1 -
 include/linux/msi.h                 |    6 ++--
 include/linux/of_pci.h              |   14 ++++++------
 include/linux/pci.h                 |    2 +-
 17 files changed, 132 insertions(+), 161 deletions(-)

