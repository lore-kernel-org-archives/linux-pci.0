Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50910 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751532AbdFHOO2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Jun 2017 10:14:28 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
        Matthew Minter <matt@masarand.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Mingkai Hu <mingkai.hu@freescale.com>,
        Tanmay Inamdar <tinamdar@apm.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Minghuan Lian <minghuan.Lian@freescale.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Roy Zang <tie-fei.zang@freescale.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [RFT PATCH v2 24/42] PCI: Build setup-irq.o on all arches
Date: Thu,  8 Jun 2017 15:13:24 +0100
Message-Id: <20170608141342.2018-25-lorenzo.pieralisi@arm.com>
In-Reply-To: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
References: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Matthew Minter <matt@masarand.com>

The functions included in setup-irq.o currently apply only to a selection
of architectures which share common IRQ assignment code. However this
code needs to be generalised for all arches to allow deferred IRQ
assignment. So the first step is to build it on all architectures.

Signed-off-by: Matthew Minter <matt@masarand.com>
---
 drivers/pci/Makefile | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 462c1f5..66a21ac 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -4,7 +4,8 @@
 
 obj-y		+= access.o bus.o probe.o host-bridge.o remove.o pci.o \
 			pci-driver.o search.o pci-sysfs.o rom.o setup-res.o \
-			irq.o vpd.o setup-bus.o vc.o mmap.o
+			irq.o vpd.o setup-bus.o vc.o mmap.o setup-irq.o
+
 obj-$(CONFIG_PROC_FS) += proc.o
 obj-$(CONFIG_SYSFS) += slot.o
 
@@ -29,20 +30,6 @@ obj-$(CONFIG_PCI_ATS) += ats.o
 obj-$(CONFIG_PCI_IOV) += iov.o
 
 #
-# Some architectures use the generic PCI setup functions
-#
-obj-$(CONFIG_ALPHA) += setup-irq.o
-obj-$(CONFIG_ARC) += setup-irq.o
-obj-$(CONFIG_ARM) += setup-irq.o
-obj-$(CONFIG_ARM64) += setup-irq.o
-obj-$(CONFIG_UNICORE32) += setup-irq.o
-obj-$(CONFIG_SUPERH) += setup-irq.o
-obj-$(CONFIG_MIPS) += setup-irq.o
-obj-$(CONFIG_TILE) += setup-irq.o
-obj-$(CONFIG_SPARC_LEON) += setup-irq.o
-obj-$(CONFIG_M68K) += setup-irq.o
-
-#
 # ACPI Related PCI FW Functions
 # ACPI _DSM provided firmware instance and string name
 #
-- 
2.10.0
