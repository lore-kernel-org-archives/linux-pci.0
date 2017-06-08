Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:49962 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751507AbdFHOM4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Jun 2017 10:12:56 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Jingoo Han <jingoohan1@gmail.com>,
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
        Matthew Minter <matt@masarand.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [RFT PATCH v2 05/42] PCI: Add pci_free_host_bridge interface
Date: Thu,  8 Jun 2017 15:13:05 +0100
Message-Id: <20170608141342.2018-6-lorenzo.pieralisi@arm.com>
In-Reply-To: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
References: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Commit a52d1443bba1 ("PCI: Export host bridge registration interface")
exported the pci_alloc_host_bridge() interface so that PCI host
controllers drivers can make use of it.

Introduce pci_alloc_host_bridge() kernel counterpart to free the
host bridge data structures, pci_free_host_bridge(), export it
and update kernel functions releasing host bridge objects allocated
memory to make use of it.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c | 12 +++++++++---
 include/linux/pci.h |  1 +
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 586d83d..cbf0d0c 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -517,9 +517,7 @@ static void pci_release_host_bridge_dev(struct device *dev)
 	if (bridge->release_fn)
 		bridge->release_fn(bridge);
 
-	pci_free_resource_list(&bridge->windows);
-
-	kfree(bridge);
+	pci_free_host_bridge(bridge);
 }
 
 struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
@@ -537,6 +535,14 @@ struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
 }
 EXPORT_SYMBOL(pci_alloc_host_bridge);
 
+void pci_free_host_bridge(struct pci_host_bridge *bridge)
+{
+	pci_free_resource_list(&bridge->windows);
+
+	kfree(bridge);
+}
+EXPORT_SYMBOL(pci_free_host_bridge);
+
 static const unsigned char pcix_bus_speed[] = {
 	PCI_SPEED_UNKNOWN,		/* 0 */
 	PCI_SPEED_66MHz_PCIX,		/* 1 */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8039f9f..5720635 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -463,6 +463,7 @@ static inline struct pci_host_bridge *pci_host_bridge_from_priv(void *priv)
 }
 
 struct pci_host_bridge *pci_alloc_host_bridge(size_t priv);
+void pci_free_host_bridge(struct pci_host_bridge *bridge);
 int pci_register_host_bridge(struct pci_host_bridge *bridge);
 struct pci_host_bridge *pci_find_host_bridge(struct pci_bus *bus);
 
-- 
2.10.0
