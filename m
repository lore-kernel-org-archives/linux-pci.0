Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37944 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932629AbaGWSz4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 23 Jul 2014 14:55:56 -0400
From: Murali Karicheri <m-karicheri2@ti.com>
To: <linux-pci@vger.kernel.org>
CC: Murali Karicheri <m-karicheri2@ti.com>,
	Russell King <linux@arm.linux.org.uk>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mohit Kumar <mohit.kumar@st.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Pratyush Anand <pratyush.anand@st.com>,
	Richard Zhu <r65037@freescale.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Marek Vasut <marex@denx.de>, Arnd Bergmann <arnd@arndb.de>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v8 0/2] Add Keystone PCIe controller drive
Date: Wed, 23 Jul 2014 14:54:50 -0400
Message-ID: <1406141692-7249-1-git-send-email-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch series add PCIe controller driver for keystone SoCs. This is
based on v7 of the series posted to the mailing list. Keystone PCI controller
is based on version 3.65 of the DW hardware. This driver uses the DW core
functions to implement the PCI controller driver for keystone.

Testing:
=======

Testing of the driver is done on TI's K2HK EVM inserted to a Elma blu!eco
MicroTCA chassis AMC slot with JumpGen SEM-200 AMC SATA Storage and Dual
Ethernet Card Express inserted on another AMC slot. The e1000e driver available
on intel's website is patched to the kernel source tree and build. e1000e.ko
is dynamically loaded and executed ping and iperf tests to test the
functionality.

Note to PCI subsystem  maintainer
=================================
Patch 1-2 of v7 has already been merged to pci/host-designware branch
at git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git. Patch 1/2
of v8 (3/5 of v7) now applies cleanly on top of the above branch. Please apply
1 and 2 of this series on top of pci/host-designware branch as agreed on the
PCI mailing list.

See Changelog below for more details.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>

CC: Russell King <linux@arm.linux.org.uk>
CC: Grant Likely <grant.likely@linaro.org>
CC: Rob Herring <robh+dt@kernel.org>
CC: Mohit Kumar <mohit.kumar@st.com>
CC: Jingoo Han <jg1.han@samsung.com>
CC: Bjorn Helgaas <bhelgaas@google.com>
CC: Pratyush Anand <pratyush.anand@st.com>
CC: Richard Zhu <r65037@freescale.com>
CC: Kishon Vijay Abraham I <kishon@ti.com>
CC: Marek Vasut <marex@denx.de>
CC: Arnd Bergmann <arnd@arndb.de>
CC: Pawel Moll <pawel.moll@arm.com>
CC: Mark Rutland <mark.rutland@arm.com>
CC: Ian Campbell <ijc+devicetree@hellion.org.uk>
CC: Kumar Gala <galak@codeaurora.org>
CC: Randy Dunlap <rdunlap@infradead.org>
CC: Grant Likely <grant.likely@linaro.org>

Changelog:

v8
 - Rebased 3/5 of v7 to Bjorn's pci/host-designware branch per request and
   now became 1/2. This also has ack from Jingoo Han <jg1.han@samsung.com>
 - Patch 4/5 and 5/5 are combined into patch 2/2. Also addressed comments
   against v7.
v7
 - Removed ti,enable_linktrain DT property. The driver now check if
   the link is up and then retrain the link if not already up. This
   is as per comment from DT maintainer.
 - Rebased to upstream kernel v3.16-rc6

v6
 - Added Ack from Maintainer for patch 3. Patch 1-3 now have the
   Acks from maintainer and can be merged to upstream branch.
   Patch 4 is waiting ack from DT maintainer.
v5
 - Rebased to upstream kernel v3.16-rc5
 - Reworked Patch 3/6 and 4/6 into a single patch based on
   maintainer comment to use a API callback model to support
   the v3.65 h/w.
v4
 - Addressed comments against 5/5.
 - Added a patch 6/6 for Maintainer information
 - Added couple of Acked-By:
 - Rebased to latest Linux 3.16-rc4
v3
 - DW application register handling code is now part of
   Keystone PCI driver. RFC had this code part of Keystone
   PCI driver, then V1 moved this to a separate file to
   re-use on other platforms that uses this version of the
   DW h/w. Then based on comments against v2, this is moved
   back to Keystone driver.
 - Keystone SerDes phy driver is removed from this series so that
   this can be merged independent of that patch
 - added msi_set_irq()/clear_irq() API's to support Keystone

V2
 - Split the designware pcie enhancement patch to multiple
   patches based on functionality added
 - Remove the quirk code and add a patch to fix mps/mrss
   tuning for ARM. Use kernel command line parameter
   pci=pcie_bus_perf to work with Keystone PCI Controller.
   Following patch addressed this.
     [PATCH v1] ARM: pci: add call to pcie_bus_configure_settings()
 - Add documentation for device tree bindings
 - Add separate interrupt controller nodes for MSI and Legacy
   IRQs and use irq map for legacy IRQ
 - Use compatibility to identify v3.65 version of the DW hardware
   and use it to customize the designware common code.
 - Use reg property for configuration space instead of range
 - Other minor updates based on code inspection. 

V1
 - Add an interrupt controller node for Legacy irq chip and use
   interrupt map/map-mask property to map legacy IRQs A/B/C/D
 - Add a Phy driver to replace the original serdes driver
 - Move common application register handling code to a separate
   file to allow re-use across other platforms that use older
   DW PCIe h/w
 - PCI quirk for maximum read request size. Check and override only
   if the maximum is higher than what controller can handle.
 - Converted to a module platform driver.

Murali Karicheri (2):
  PCI: designware: enhance dw_pcie_host_init() to support v3.65 DW
    hardware
  PCI: add PCI controller for keystone PCIe h/w

 .../devicetree/bindings/pci/pci-keystone.txt       |   68 +++
 MAINTAINERS                                        |    7 +
 drivers/pci/host/Kconfig                           |   10 +
 drivers/pci/host/Makefile                          |    1 +
 drivers/pci/host/pci-keystone-dw.c                 |  520 ++++++++++++++++++++
 drivers/pci/host/pci-keystone.c                    |  386 +++++++++++++++
 drivers/pci/host/pci-keystone.h                    |   58 +++
 drivers/pci/host/pcie-designware.c                 |   52 +-
 drivers/pci/host/pcie-designware.h                 |    2 +
 9 files changed, 1086 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/pci-keystone.txt
 create mode 100644 drivers/pci/host/pci-keystone-dw.c
 create mode 100644 drivers/pci/host/pci-keystone.c
 create mode 100644 drivers/pci/host/pci-keystone.h

-- 
1.7.9.5

