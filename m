Return-Path: <SRS0=Cb4Y=R4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202A5C43381
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 08:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAE312133F
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 08:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dRMx/GDi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730053AbfCYIh3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 04:37:29 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:34024 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730339AbfCYIh2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Mar 2019 04:37:28 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2P8bF24031066;
        Mon, 25 Mar 2019 03:37:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553503035;
        bh=FQifuCUrENL8NGdaDyObLGabN5HL+zMUVCN85TUbVgM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=dRMx/GDiA9rKvNYZYFZjWHS5a9DhHERda7h0wJYPZn0r47pNqLVOy1e0XsQ33P0rJ
         HCCc6tG61ay4nem8l7yCgqz9wVky3/keBkouXk9Iz+uyA36s8H8a/3igsLJE6TyKd2
         Q/d5E6SH8Zsz+sXgHGeF3oSMsG6XvJRi50tGB0Q0=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2P8bFcx017630
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Mar 2019 03:37:15 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 25
 Mar 2019 03:37:15 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Mon, 25 Mar 2019 03:37:14 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2P8ZsG0006534;
        Mon, 25 Mar 2019 03:37:11 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Murali Karicheri <m-karicheri2@ti.com>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-arm-kernel@axis.com>
Subject: [PATCH v2 18/26] PCI: endpoint: Add support to allocate aligned buffers to be mapped in BARs
Date:   Mon, 25 Mar 2019 14:04:53 +0530
Message-ID: <20190325083501.8088-19-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190325083501.8088-1-kishon@ti.com>
References: <20190325083501.8088-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Modify pci_epf_alloc_space API to take alignment size as argument in
order to argument in order to allocate aligned buffers to be mapped to
BARs.

Add 'align' parameter to epc_features which can be used by platform
drivers to specifiy the BAR allocation alignment requirements and use
this while invoking pci_epf_alloc_space.

This is mainly required for Synopsys Designware PCIe core which masks
the lower bits based on the BAR size (See "I/O and MEM Match Modes"
section in DesignWare Cores PCI Express Controller Databook version
4.90a).

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c |  5 +++--
 drivers/pci/endpoint/pci-epf-core.c           | 10 ++++++++--
 include/linux/pci-epc.h                       |  2 ++
 include/linux/pci-epf.h                       |  3 ++-
 4 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index d0b91da49bf4..c0786ca74312 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -438,7 +438,7 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 	epc_features = epf_test->epc_features;
 
 	base = pci_epf_alloc_space(epf, sizeof(struct pci_epf_test_reg),
-				   test_reg_bar);
+				   test_reg_bar, epc_features->align);
 	if (!base) {
 		dev_err(dev, "Failed to allocated register space\n");
 		return -ENOMEM;
@@ -453,7 +453,8 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 		if (!!(epc_features->reserved_bar & (1 << bar)))
 			continue;
 
-		base = pci_epf_alloc_space(epf, bar_size[bar], bar);
+		base = pci_epf_alloc_space(epf, bar_size[bar], bar,
+					   epc_features->align);
 		if (!base)
 			dev_err(dev, "Failed to allocate space for BAR%d\n",
 				bar);
diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 8bfdcd291196..fb1306de8f40 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -109,10 +109,12 @@ EXPORT_SYMBOL_GPL(pci_epf_free_space);
  * pci_epf_alloc_space() - allocate memory for the PCI EPF register space
  * @size: the size of the memory that has to be allocated
  * @bar: the BAR number corresponding to the allocated register space
+ * @align: alignment size for the allocation region
  *
  * Invoke to allocate memory for the PCI EPF register space.
  */
-void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar)
+void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
+			  size_t align)
 {
 	void *space;
 	struct device *dev = epf->epc->dev.parent;
@@ -120,7 +122,11 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar)
 
 	if (size < 128)
 		size = 128;
-	size = roundup_pow_of_two(size);
+
+	if (align)
+		size = ALIGN(size, align);
+	else
+		size = roundup_pow_of_two(size);
 
 	space = dma_alloc_coherent(dev, size, &phys_addr, GFP_KERNEL);
 	if (!space) {
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index c3ffa3917f88..f641badc2c61 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -109,6 +109,7 @@ struct pci_epc {
  * @reserved_bar: bitmap to indicate reserved BAR unavailable to function driver
  * @bar_fixed_64bit: bitmap to indicate fixed 64bit BARs
  * @bar_fixed_size: Array specifying the size supported by each BAR
+ * @align: alignment size required for BAR buffer allocation
  */
 struct pci_epc_features {
 	unsigned int	linkup_notifier : 1;
@@ -117,6 +118,7 @@ struct pci_epc_features {
 	u8	reserved_bar;
 	u8	bar_fixed_64bit;
 	u64	bar_fixed_size[BAR_5 + 1];
+	size_t	align;
 };
 
 #define to_pci_epc(device) container_of((device), struct pci_epc, dev)
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index ec02f58758c8..2d6f07556682 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -149,7 +149,8 @@ void pci_epf_destroy(struct pci_epf *epf);
 int __pci_epf_register_driver(struct pci_epf_driver *driver,
 			      struct module *owner);
 void pci_epf_unregister_driver(struct pci_epf_driver *driver);
-void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar);
+void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
+			  size_t align);
 void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar);
 int pci_epf_bind(struct pci_epf *epf);
 void pci_epf_unbind(struct pci_epf *epf);
-- 
2.17.1

