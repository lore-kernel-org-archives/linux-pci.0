Return-Path: <SRS0=Cb4Y=R4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B14FC10F03
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 09:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64FF32087F
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 09:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XocAwBs/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730701AbfCYJnj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 05:43:39 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:37620 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730377AbfCYJni (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Mar 2019 05:43:38 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2P9hJiE013307;
        Mon, 25 Mar 2019 04:43:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553506999;
        bh=chMDM1S73N5348Ke4wiey3wF6sgdC3UveRlW6BwAUuY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=XocAwBs/92tYgDwGP41RltrF4uz0r5BUbqpDCAG58QkcqXggkGCKzL82SH9nYC73A
         Lm4dQP2MnHhaFAI5buWz/mMs4xXjXTkn3JFzwcnmxSEztoL58AnXevIN2J6bFZ0y5W
         eyGqvnHdLmiD3W3nd+U0xQiqifw72L6AGmRRNgn8=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2P9hJLt015902
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Mar 2019 04:43:19 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 25
 Mar 2019 04:43:19 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Mon, 25 Mar 2019 04:43:19 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2P9feaW028077;
        Mon, 25 Mar 2019 04:43:14 -0500
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
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-kernel@axis.com>, Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>
Subject: [PATCH v3 17/26] PCI: keystone: Add support to set the max link speed from DT
Date:   Mon, 25 Mar 2019 15:09:38 +0530
Message-ID: <20190325093947.32633-18-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190325093947.32633-1-kishon@ti.com>
References: <20190325093947.32633-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCIe in TI's AM654 devices is by default configured to work in GEN3 mode.
However PCIe doesn't work reliably in GEN3 mode because of SERDES
configuration.

Add support to set the link speed to GEN1, GEN2 or GEN3 based on
"max-link-speed" dt property with GEN2 as the default speed if
"max-link-speed" is absent.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 35 +++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index e4a816f53b8e..312fd0c49bbb 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -28,6 +28,7 @@
 #include <linux/resource.h>
 #include <linux/signal.h>
 
+#include "../../pci.h"
 #include "pcie-designware.h"
 
 #define PCIE_VENDORID_MASK	0xffff
@@ -89,6 +90,8 @@
 #define LEG_EP				0x1
 #define RC				0x2
 
+#define EXP_CAP_ID_OFFSET		0x70
+
 #define KS_PCIE_SYSCLOCKOUTEN		BIT(0)
 
 #define AM654_PCIE_DEV_TYPE_MASK	0x3
@@ -971,6 +974,31 @@ static int ks_pcie_am654_set_mode(struct device *dev)
 	return 0;
 }
 
+static void ks_pcie_set_link_speed(struct dw_pcie *pci, int link_speed)
+{
+	u32 val;
+
+	dw_pcie_dbi_ro_wr_en(pci);
+
+	val = dw_pcie_readl_dbi(pci, EXP_CAP_ID_OFFSET + PCI_EXP_LNKCAP);
+	if ((val & PCI_EXP_LNKCAP_SLS) != link_speed) {
+		val &= ~((u32)PCI_EXP_LNKCAP_SLS);
+		val |= link_speed;
+		dw_pcie_writel_dbi(pci, EXP_CAP_ID_OFFSET + PCI_EXP_LNKCAP,
+				   val);
+	}
+
+	val = dw_pcie_readl_dbi(pci, EXP_CAP_ID_OFFSET + PCI_EXP_LNKCTL2);
+	if ((val & PCI_EXP_LNKCAP_SLS) != link_speed) {
+		val &= ~((u32)PCI_EXP_LNKCAP_SLS);
+		val |= link_speed;
+		dw_pcie_writel_dbi(pci, EXP_CAP_ID_OFFSET + PCI_EXP_LNKCTL2,
+				   val);
+	}
+
+	dw_pcie_dbi_ro_wr_dis(pci);
+}
+
 static const struct ks_pcie_of_data ks_pcie_rc_of_data = {
 	.host_ops = &ks_pcie_host_ops,
 	.version = 0x365A,
@@ -1011,6 +1039,7 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	void __iomem *base;
 	u32 num_viewport;
 	struct phy **phy;
+	int link_speed;
 	u32 num_lanes;
 	char name[10];
 	int ret;
@@ -1165,6 +1194,12 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 		gpiod_set_value_cansleep(gpiod, 1);
 	}
 
+	link_speed = of_pci_get_max_link_speed(np);
+	if (link_speed < 0)
+		link_speed = 2;
+
+	ks_pcie_set_link_speed(pci, link_speed);
+
 	pci->pp.ops = host_ops;
 	ret = ks_pcie_add_pcie_port(ks_pcie, pdev);
 	if (ret < 0)
-- 
2.17.1

