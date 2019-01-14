Return-Path: <SRS0=hqs4=PW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53224C43387
	for <linux-pci@archiver.kernel.org>; Mon, 14 Jan 2019 11:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1696F2086D
	for <linux-pci@archiver.kernel.org>; Mon, 14 Jan 2019 11:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="i9hTjCS/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfANLQI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 14 Jan 2019 06:16:08 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:45282 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbfANLQI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Jan 2019 06:16:08 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0EBFmA1112623;
        Mon, 14 Jan 2019 05:15:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547464548;
        bh=7zfWfnCQeG4SmqHvA26Y+pmRNPO6bCuT02zsP3l4mz4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=i9hTjCS/NUPQO4ZstIx+7yGt3pVQWFkwD3rmw6yWgqWtxRt6ME/fkhZINKNuh51l9
         fBbq9DuhWKCMeg9BOIUBfukGT3OWaEkauKys5wSvN+mMme1DQMdtZy5lAzXDFVfV0c
         5xuszTFS43yYbeyMUGY+1yP42P1ghep3Mg5HEJmw=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0EBFmRZ107813
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Jan 2019 05:15:48 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 14
 Jan 2019 05:15:47 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 14 Jan 2019 05:15:47 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0EBFd1T011560;
        Mon, 14 Jan 2019 05:15:44 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Alan Douglas <adouglas@cadence.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 01/15] PCI: endpoint: Add new pci_epc_ops to get EPC features
Date:   Mon, 14 Jan 2019 16:44:59 +0530
Message-ID: <20190114111513.21618-2-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190114111513.21618-1-kishon@ti.com>
References: <20190114111513.21618-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a new pci_epc_ops ->get_features() to get the features
supported by EPC. Since EPC can provide different features to
different functions, the ->get_features() ops takes _func_no_ as
an argument.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/endpoint/pci-epc-core.c | 30 +++++++++++++++++++++++++++++
 include/linux/pci-epc.h             | 22 +++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 094dcc3203b8..5a099479d9ab 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -83,6 +83,36 @@ struct pci_epc *pci_epc_get(const char *epc_name)
 }
 EXPORT_SYMBOL_GPL(pci_epc_get);
 
+/**
+ * pci_epc_get_features() - get the features supported by EPC
+ * @epc: the features supported by *this* EPC device will be returned
+ * @func_no: the features supported by the EPC device specific to the
+ *	     endpoint function with func_no will be returned
+ *
+ * Invoke to get the features provided by the EPC which may be
+ * specific to an endpoint function. Returns pci_epc_features on success
+ * and NULL for any failures.
+ */
+const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
+						    u8 func_no)
+{
+	const struct pci_epc_features *epc_features;
+	unsigned long flags;
+
+	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
+		return NULL;
+
+	if (!epc->ops->get_features)
+		return NULL;
+
+	spin_lock_irqsave(&epc->lock, flags);
+	epc_features = epc->ops->get_features(epc, func_no);
+	spin_unlock_irqrestore(&epc->lock, flags);
+
+	return epc_features;
+}
+EXPORT_SYMBOL_GPL(pci_epc_get_features);
+
 /**
  * pci_epc_stop() - stop the PCI link
  * @epc: the link of the EPC device that has to be stopped
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 37dab8116901..79fbcf94e14d 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -59,6 +59,8 @@ struct pci_epc_ops {
 			     enum pci_epc_irq_type type, u16 interrupt_num);
 	int	(*start)(struct pci_epc *epc);
 	void	(*stop)(struct pci_epc *epc);
+	const struct pci_epc_features* (*get_features)(struct pci_epc *epc,
+						       u8 func_no);
 	struct module *owner;
 };
 
@@ -100,6 +102,24 @@ struct pci_epc {
 	unsigned int			features;
 };
 
+/**
+ * struct pci_epc_features - features supported by a EPC device per function
+ * @linkup_notifier: indicate if the EPC device can notify EPF driver on link up
+ * @msi_capable: indicate if the endpoint function has MSI capability
+ * @msix_capable: indicate if the endpoint function has MSI-X capability
+ * @reserved_bar: bitmap to indicate reserved BAR unavailable to function driver
+ * @bar_fixed_64bit: bitmap to indicate fixed 64bit BARs
+ * @bar_fixed_size: Array specifying the size supported by each BAR
+ */
+struct pci_epc_features {
+	unsigned int	linkup_notifier : 1;
+	unsigned int	msi_capable : 1;
+	unsigned int	msix_capable : 1;
+	u8	reserved_bar;
+	u8	bar_fixed_64bit;
+	u64	bar_fixed_size[BAR_5 + 1];
+};
+
 #define EPC_FEATURE_NO_LINKUP_NOTIFIER		BIT(0)
 #define EPC_FEATURE_BAR_MASK			(BIT(1) | BIT(2) | BIT(3))
 #define EPC_FEATURE_MSIX_AVAILABLE		BIT(4)
@@ -158,6 +178,8 @@ int pci_epc_raise_irq(struct pci_epc *epc, u8 func_no,
 		      enum pci_epc_irq_type type, u16 interrupt_num);
 int pci_epc_start(struct pci_epc *epc);
 void pci_epc_stop(struct pci_epc *epc);
+const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
+						    u8 func_no);
 struct pci_epc *pci_epc_get(const char *epc_name);
 void pci_epc_put(struct pci_epc *epc);
 
-- 
2.17.1

