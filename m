Return-Path: <SRS0=aMvC=SS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1769DC10F13
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 14:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7010223FD
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 14:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="fg1RGE9x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729432AbfDPOPo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 16 Apr 2019 10:15:44 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:13474 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbfDPOPo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Apr 2019 10:15:44 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cb5e3940000>; Tue, 16 Apr 2019 07:15:48 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 16 Apr 2019 07:15:43 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 16 Apr 2019 07:15:43 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 16 Apr
 2019 14:15:43 +0000
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 16 Apr
 2019 14:15:42 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 16 Apr 2019 14:15:42 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cb5e38b0003>; Tue, 16 Apr 2019 07:15:42 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <Jisheng.Zhang@synaptics.com>, <thierry.reding@gmail.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>,
        <sagar.tv@gmail.com>, <vidyas@nvidia.com>
Subject: [PATCH V2 1/2] PCI: dwc: Add API support to de-initialize host
Date:   Tue, 16 Apr 2019 19:45:15 +0530
Message-ID: <20190416141516.23908-2-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190416141516.23908-1-vidyas@nvidia.com>
References: <20190416141516.23908-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555424148; bh=pUiFP+Z9LUBBzgUJW1rnX/SXb+8V4muvYp1eB4jsEtg=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=fg1RGE9xoQ2oe4tMXsgFMnsgzyPXVR5wLv+Am8ACyHGg5oHawHPGuvSdwBCdJlcwS
         R/vEU7L+GDw3iuGN9JFr2OuTGOJCojuErdElzXuUieoECL3NsBTbg52WY2z4tjk/Jv
         2KNBzSNtkFSbyRwViKk89RTFk36Fbn2uqDc0h/jF6UfnN/nWZHQQqr0SfwlfOmFKNt
         jeA7t677o04utHVXdx0v5/ZddJWSdAw7LBOp6e7y/CfOu4wzr2i+ItnX9uUZytdNlW
         9itqJQ1U49yb79hClgI3tpQflopKrCSoJXautbi62JUSQLbz/Q4rdOyz4vA4uEwKjq
         WBLiTd7BmNRtg==
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
v2:
* s/Designware/DesignWare

 drivers/pci/controller/dwc/pcie-designware-host.c | 7 +++++++
 drivers/pci/controller/dwc/pcie-designware.h      | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 3e4169e738a5..d7881490282d 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -516,6 +516,13 @@ int dw_pcie_host_init(struct pcie_port *pp)
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
index adff0c713665..ea8d1caf11c5 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -343,6 +343,7 @@ void dw_pcie_msi_init(struct pcie_port *pp);
 void dw_pcie_free_msi(struct pcie_port *pp);
 void dw_pcie_setup_rc(struct pcie_port *pp);
 int dw_pcie_host_init(struct pcie_port *pp);
+void dw_pcie_host_deinit(struct pcie_port *pp);
 int dw_pcie_allocate_domains(struct pcie_port *pp);
 #else
 static inline irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
@@ -367,6 +368,10 @@ static inline int dw_pcie_host_init(struct pcie_port *pp)
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

