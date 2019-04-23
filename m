Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC955C10F14
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 04:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DD2E20B1F
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 04:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="mpOLzOc7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbfDWEt2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 00:49:28 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:12361 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbfDWEt1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 00:49:27 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cbe995d0000>; Mon, 22 Apr 2019 21:49:33 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 22 Apr 2019 21:49:27 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 22 Apr 2019 21:49:27 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 23 Apr
 2019 04:49:27 +0000
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 23 Apr
 2019 04:49:26 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 23 Apr 2019 04:49:26 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cbe99530000>; Mon, 22 Apr 2019 21:49:26 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <Jisheng.Zhang@synaptics.com>, <thierry.reding@gmail.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>,
        <sagar.tv@gmail.com>, <vidyas@nvidia.com>
Subject: [PATCH V3 1/2] PCI: dwc: Add API support to de-initialize host
Date:   Tue, 23 Apr 2019 10:19:19 +0530
Message-ID: <20190423044920.19663-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555994973; bh=b/ovF9X/ed9vvfIpBkzI7xPKA8NQj7NJGZajPZ5fBxE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=mpOLzOc7OGv4qAz+kvvRFzjG1AUwiWTtUqqK4OktmJe+/elWAG5pRy2JKr8qPjof5
         2AsN5WPqdufFqHg1zHUUGRmKx9yXpCithYh3dZsPQEU506h/Xg0SZIgZg/cQbqVviN
         8W1BNL5hifFNQosfRVC1hOhACTY7pYCpGuAsfxBEjst1hXP7Rp4dX6KqkRIeyrM3VF
         dEFDArK65Wtk2B1LJPb7JfkkKya/F840IHSIu4E1g4r/UGUF+rbz/pi6TFQHe5uJol
         Zxyp0keB8ajNimhozlRJzeh7YqQc4R9/M98wtBVjvwmFX8Dcq7wS4pTuoqlWA7JBoC
         SST3TQ2DDAATA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add an API to group all the tasks to be done to de-initialize host which
can then be called by any DesignWare core based driver implementations
while adding .remove() support in their respective drivers.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
v3:
* Rebased on top of linux-next top of the tree branch

v2:
* s/Designware/DesignWare

 drivers/pci/controller/dwc/pcie-designware-host.c | 7 +++++++
 drivers/pci/controller/dwc/pcie-designware.h      | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 77db32529319..f87c9542eb09 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -496,6 +496,13 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	return ret;
 }
 
+void dw_pcie_host_deinit(struct pcie_port *pp)
+{
+	pci_stop_root_bus(pp->root_bus);
+	pci_remove_root_bus(pp->root_bus);
+	dw_pcie_free_msi(pp);
+}
+
 static int dw_pcie_access_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 				     u32 devfn, int where, int size, u32 *val,
 				     bool write)
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index deab426affd3..4f48ec78c7b9 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -348,6 +348,7 @@ void dw_pcie_msi_init(struct pcie_port *pp);
 void dw_pcie_free_msi(struct pcie_port *pp);
 void dw_pcie_setup_rc(struct pcie_port *pp);
 int dw_pcie_host_init(struct pcie_port *pp);
+void dw_pcie_host_deinit(struct pcie_port *pp);
 int dw_pcie_allocate_domains(struct pcie_port *pp);
 #else
 static inline irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
@@ -372,6 +373,10 @@ static inline int dw_pcie_host_init(struct pcie_port *pp)
 	return 0;
 }
 
+static inline void dw_pcie_host_deinit(struct pcie_port *pp)
+{
+}
+
 static inline int dw_pcie_allocate_domains(struct pcie_port *pp)
 {
 	return 0;
-- 
2.17.1

