Return-Path: <SRS0=/yaj=M3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F188C71132
	for <linux-pci@archiver.kernel.org>; Mon, 15 Oct 2018 13:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EDED20892
	for <linux-pci@archiver.kernel.org>; Mon, 15 Oct 2018 13:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gLTV3u5u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EDED20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbeJOUxo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Oct 2018 16:53:44 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:56444 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbeJOUxo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Oct 2018 16:53:44 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9FD8G58085920;
        Mon, 15 Oct 2018 08:08:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539608896;
        bh=NL93FqjXfL5GmS7Q7CEcO9WJ0fDK7IYqMoegnb1ILGg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=gLTV3u5uN8lkXG0w06Dtnl0qVXQP7u1WhscTReLWNkFlXqp/NRw6zeWdRYdQwgCu/
         7zyb5EowfqgM2dEJ3N5xbwgoMAkvjAMXnq1a/vViluyAB4HURbnXmffyb7Jux+APfs
         GDFP59n40pqX+/FS3rIW2ljqLtSrr9hGnIyFLKmI=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9FD8Gw1032707;
        Mon, 15 Oct 2018 08:08:16 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 15
 Oct 2018 08:08:16 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 15 Oct 2018 08:08:16 -0500
Received: from a0393678ub.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9FD7tL8009433;
        Mon, 15 Oct 2018 08:08:12 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC:     Rob Herring <robh+dt@kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 05/19] PCI: keystone: Remove unused argument from ks_dw_pcie_host_init()
Date:   Mon, 15 Oct 2018 18:37:07 +0530
Message-ID: <20181015130721.5535-6-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181015130721.5535-1-kishon@ti.com>
References: <20181015130721.5535-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

No functional change. Remove unused "msi_intc_np" argument from
ks_dw_pcie_host_init().

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone-dw.c | 3 +--
 drivers/pci/controller/dwc/pci-keystone.c    | 2 +-
 drivers/pci/controller/dwc/pci-keystone.h    | 3 +--
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone-dw.c b/drivers/pci/controller/dwc/pci-keystone-dw.c
index 0682213328e9..4bd6c6e2b177 100644
--- a/drivers/pci/controller/dwc/pci-keystone-dw.c
+++ b/drivers/pci/controller/dwc/pci-keystone-dw.c
@@ -439,8 +439,7 @@ void ks_dw_pcie_initiate_link_train(struct keystone_pcie *ks_pcie)
  * and call dw_pcie_v3_65_host_init() API to initialize the Keystone
  * PCI host controller.
  */
-int __init ks_dw_pcie_host_init(struct keystone_pcie *ks_pcie,
-				struct device_node *msi_intc_np)
+int __init ks_dw_pcie_host_init(struct keystone_pcie *ks_pcie)
 {
 	struct dw_pcie *pci = ks_pcie->pci;
 	struct pcie_port *pp = &pci->pp;
diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index aa7e706fc37d..f87ade2de711 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -341,7 +341,7 @@ static int __init ks_add_pcie_port(struct keystone_pcie *ks_pcie,
 	}
 
 	pp->ops = &keystone_pcie_host_ops;
-	ret = ks_dw_pcie_host_init(ks_pcie, ks_pcie->msi_intc_np);
+	ret = ks_dw_pcie_host_init(ks_pcie);
 	if (ret) {
 		dev_err(dev, "failed to initialize host\n");
 		return ret;
diff --git a/drivers/pci/controller/dwc/pci-keystone.h b/drivers/pci/controller/dwc/pci-keystone.h
index 8a13da391543..4eacc263f157 100644
--- a/drivers/pci/controller/dwc/pci-keystone.h
+++ b/drivers/pci/controller/dwc/pci-keystone.h
@@ -41,8 +41,7 @@ void ks_dw_pcie_enable_legacy_irqs(struct keystone_pcie *ks_pcie);
 void ks_dw_pcie_handle_legacy_irq(struct keystone_pcie *ks_pcie, int offset);
 void ks_dw_pcie_enable_error_irq(struct keystone_pcie *ks_pcie);
 irqreturn_t ks_dw_pcie_handle_error_irq(struct keystone_pcie *ks_pcie);
-int  ks_dw_pcie_host_init(struct keystone_pcie *ks_pcie,
-			struct device_node *msi_intc_np);
+int  ks_dw_pcie_host_init(struct keystone_pcie *ks_pcie);
 int ks_dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 		unsigned int devfn, int where, int size, u32 val);
 int ks_dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
-- 
2.17.1

