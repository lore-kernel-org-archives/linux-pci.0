Return-Path: <SRS0=GqAx=SG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA74C4360F
	for <linux-pci@archiver.kernel.org>; Thu,  4 Apr 2019 12:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A433B2147C
	for <linux-pci@archiver.kernel.org>; Thu,  4 Apr 2019 12:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="U6Qf7rYu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbfDDMUo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 4 Apr 2019 08:20:44 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:3803 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbfDDMUo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Apr 2019 08:20:44 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ca5f69f0000>; Thu, 04 Apr 2019 05:20:47 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 04 Apr 2019 05:20:43 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 04 Apr 2019 05:20:43 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 4 Apr
 2019 12:20:43 +0000
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 4 Apr
 2019 12:20:42 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 4 Apr 2019 12:20:42 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ca5f6970001>; Thu, 04 Apr 2019 05:20:42 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <Jisheng.Zhang@synaptics.com>, <thierry.reding@gmail.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>,
        <sagar.tv@gmail.com>, <vidyas@nvidia.com>
Subject: [PATCH 2/2] PCI: dwc: Export APIs to support .remove() implementation
Date:   Thu, 4 Apr 2019 17:50:24 +0530
Message-ID: <1554380425-29215-3-git-send-email-vidyas@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554380425-29215-1-git-send-email-vidyas@nvidia.com>
References: <1554380425-29215-1-git-send-email-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1554380447; bh=nrCtE07bZ8Lw5rvbZO6zOxGLTD60K3VS7HCwtL7J/TI=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=U6Qf7rYubJ/II2lg47WVfk7+zxD5EDHHjESjBf3kPHm5wwAK+eyPEPiM67hJQYQri
         j00DcOwvmfZJrhjOFI+qM1PzLFGtp38zsj8sDvOQ6IZuD7uGnqkWsYyTfdHeawPNPF
         R1ml2MPBX4zCSMYj85ondcLaPjJeFgSLC7U+iTrshXY/bSSYavgQ2Xh3upu1QqCal8
         sPBY8XEbXXFurwH7+YcZ5ucjCLPAdDvFLbHNmkCCH1WvGvW/JT2X8JGfhNmvN/NBwn
         hmAgqDnVeCZyNdGu3RSK52KptpR3s4sIzrARBeYu689xZ4GtalaPx6Bp07uPihIKea
         fj2HDUXqXfEKg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Export all configuration space access APIs and also other APIs to
support host controller drivers of Designware core based
implementations while adding support for .remove() hook to build their
respective drivers as modules

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c |  4 +++
 drivers/pci/controller/dwc/pcie-designware.c      | 38 +++++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h      | 35 ++++-----------------
 3 files changed, 48 insertions(+), 29 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index d7881490282d..2a5332e5ccfa 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -333,6 +333,7 @@ void dw_pcie_msi_init(struct pcie_port *pp)
 	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_HI, 4,
 			    upper_32_bits(msi_target));
 }
+EXPORT_SYMBOL_GPL(dw_pcie_msi_init);
 
 int dw_pcie_host_init(struct pcie_port *pp)
 {
@@ -515,6 +516,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		dw_pcie_free_msi(pp);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(dw_pcie_host_init);
 
 void dw_pcie_host_deinit(struct pcie_port *pp)
 {
@@ -522,6 +524,7 @@ void dw_pcie_host_deinit(struct pcie_port *pp)
 	pci_remove_root_bus(pp->root_bus);
 	dw_pcie_free_msi(pp);
 }
+EXPORT_SYMBOL_GPL(dw_pcie_host_deinit);
 
 static int dw_pcie_access_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 				     u32 devfn, int where, int size, u32 *val,
@@ -731,3 +734,4 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 	val |= PORT_LOGIC_SPEED_CHANGE;
 	dw_pcie_wr_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, val);
 }
+EXPORT_SYMBOL_GPL(dw_pcie_setup_rc);
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 31f6331ca46f..f98e2f284ae1 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -40,6 +40,7 @@ int dw_pcie_read(void __iomem *addr, int size, u32 *val)
 
 	return PCIBIOS_SUCCESSFUL;
 }
+EXPORT_SYMBOL_GPL(dw_pcie_read);
 
 int dw_pcie_write(void __iomem *addr, int size, u32 val)
 {
@@ -57,6 +58,7 @@ int dw_pcie_write(void __iomem *addr, int size, u32 val)
 
 	return PCIBIOS_SUCCESSFUL;
 }
+EXPORT_SYMBOL_GPL(dw_pcie_write);
 
 u32 __dw_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
 		       size_t size)
@@ -89,6 +91,42 @@ void __dw_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
 		dev_err(pci->dev, "Write DBI address failed\n");
 }
 
+void dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 val)
+{
+	__dw_pcie_write_dbi(pci, pci->dbi_base, reg, 0x4, val);
+}
+EXPORT_SYMBOL_GPL(dw_pcie_writel_dbi);
+
+u32 dw_pcie_readl_dbi(struct dw_pcie *pci, u32 reg)
+{
+	return __dw_pcie_read_dbi(pci, pci->dbi_base, reg, 0x4);
+}
+EXPORT_SYMBOL_GPL(dw_pcie_readl_dbi);
+
+void dw_pcie_writew_dbi(struct dw_pcie *pci, u32 reg, u16 val)
+{
+	__dw_pcie_write_dbi(pci, pci->dbi_base, reg, 0x2, val);
+}
+EXPORT_SYMBOL_GPL(dw_pcie_writew_dbi);
+
+u16 dw_pcie_readw_dbi(struct dw_pcie *pci, u32 reg)
+{
+	return __dw_pcie_read_dbi(pci, pci->dbi_base, reg, 0x2);
+}
+EXPORT_SYMBOL_GPL(dw_pcie_readw_dbi);
+
+void dw_pcie_writeb_dbi(struct dw_pcie *pci, u32 reg, u8 val)
+{
+	__dw_pcie_write_dbi(pci, pci->dbi_base, reg, 0x1, val);
+}
+EXPORT_SYMBOL_GPL(dw_pcie_writeb_dbi);
+
+u8 dw_pcie_readb_dbi(struct dw_pcie *pci, u32 reg)
+{
+	return __dw_pcie_read_dbi(pci, pci->dbi_base, reg, 0x1);
+}
+EXPORT_SYMBOL_GPL(dw_pcie_readb_dbi);
+
 static u32 dw_pcie_readl_ob_unroll(struct dw_pcie *pci, u32 index, u32 reg)
 {
 	u32 offset = PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(index);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index ea8d1caf11c5..86df36701a37 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -265,35 +265,12 @@ void dw_pcie_disable_atu(struct dw_pcie *pci, int index,
 			 enum dw_pcie_region_type type);
 void dw_pcie_setup(struct dw_pcie *pci);
 
-static inline void dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 val)
-{
-	__dw_pcie_write_dbi(pci, pci->dbi_base, reg, 0x4, val);
-}
-
-static inline u32 dw_pcie_readl_dbi(struct dw_pcie *pci, u32 reg)
-{
-	return __dw_pcie_read_dbi(pci, pci->dbi_base, reg, 0x4);
-}
-
-static inline void dw_pcie_writew_dbi(struct dw_pcie *pci, u32 reg, u16 val)
-{
-	__dw_pcie_write_dbi(pci, pci->dbi_base, reg, 0x2, val);
-}
-
-static inline u16 dw_pcie_readw_dbi(struct dw_pcie *pci, u32 reg)
-{
-	return __dw_pcie_read_dbi(pci, pci->dbi_base, reg, 0x2);
-}
-
-static inline void dw_pcie_writeb_dbi(struct dw_pcie *pci, u32 reg, u8 val)
-{
-	__dw_pcie_write_dbi(pci, pci->dbi_base, reg, 0x1, val);
-}
-
-static inline u8 dw_pcie_readb_dbi(struct dw_pcie *pci, u32 reg)
-{
-	return __dw_pcie_read_dbi(pci, pci->dbi_base, reg, 0x1);
-}
+void dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 val);
+u32 dw_pcie_readl_dbi(struct dw_pcie *pci, u32 reg);
+void dw_pcie_writew_dbi(struct dw_pcie *pci, u32 reg, u16 val);
+u16 dw_pcie_readw_dbi(struct dw_pcie *pci, u32 reg);
+void dw_pcie_writeb_dbi(struct dw_pcie *pci, u32 reg, u8 val);
+u8 dw_pcie_readb_dbi(struct dw_pcie *pci, u32 reg);
 
 static inline void dw_pcie_writel_dbi2(struct dw_pcie *pci, u32 reg, u32 val)
 {
-- 
2.7.4

