Return-Path: <SRS0=piPB=QZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8DAC43381
	for <linux-pci@archiver.kernel.org>; Mon, 18 Feb 2019 09:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0990F218D3
	for <linux-pci@archiver.kernel.org>; Mon, 18 Feb 2019 09:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbfBRJw7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 18 Feb 2019 04:52:59 -0500
Received: from inva020.nxp.com ([92.121.34.13]:55664 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730068AbfBRJw6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Feb 2019 04:52:58 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id EA0411A006C;
        Mon, 18 Feb 2019 10:52:55 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8C0B31A0094;
        Mon, 18 Feb 2019 10:52:48 +0100 (CET)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 4C536402CA;
        Mon, 18 Feb 2019 17:52:39 +0800 (SGT)
From:   Xiaowei Bao <xiaowei.bao@nxp.com>
To:     bhelgaas@google.com, Zhiqiang.Hou@nxp.com, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, leoyang.li@nxp.com,
        kishon@ti.com, lorenzo.pieralisi@arm.com,
        gregkh@linuxfoundation.org, l.subrahmanya@mobiveil.co.in,
        arnd@arndb.de, Minghuan.Lian@nxp.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: [PATCH 4/6] PCI: mobiveil: Add workaround for unsupported request error
Date:   Mon, 18 Feb 2019 17:46:41 +0800
Message-Id: <20190218094643.2692-4-xiaowei.bao@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20190218094643.2692-1-xiaowei.bao@nxp.com>
References: <20190218094643.2692-1-xiaowei.bao@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Errata: unsupported request error on inbound posted write
transaction, PCIe controller reports advisory error instead
of uncorrectable error message to RC.

Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
---
depends on: http://patchwork.ozlabs.org/project/linux-pci/list/?series=88754

 .../controller/mobiveil/pci-layerscape-gen4-ep.c   |   14 +++++++++++++-
 drivers/pci/controller/mobiveil/pcie-mobiveil.h    |    4 ++++
 2 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/controller/mobiveil/pci-layerscape-gen4-ep.c b/drivers/pci/controller/mobiveil/pci-layerscape-gen4-ep.c
index dc3589d..3d980f5 100644
--- a/drivers/pci/controller/mobiveil/pci-layerscape-gen4-ep.c
+++ b/drivers/pci/controller/mobiveil/pci-layerscape-gen4-ep.c
@@ -51,7 +51,19 @@ static void ls_pcie_g4_ep_init(struct mobiveil_pcie_ep *ep)
 	struct mobiveil_pcie *mv_pci = to_mobiveil_pcie_from_ep(ep);
 	struct pci_epc *epc = ep->epc;
 	enum pci_barno bar;
-	int win_idx;
+	int win_idx, val;
+
+	/*
+	 * Errata: unsupported request error on inbound posted write
+	 * transaction, PCIe controller reports advisory error instead
+	 * of uncorrectable error message to RC.
+	 * workaround: set the bit20(unsupported_request_Error_severity) with
+	 * value 1 in uncorrectable_Error_Severity_Register, make the
+	 * unsupported request error generate the fatal error.
+	 */
+	val =  csr_readl(mv_pci, CFG_UNCORRECTABLE_ERROR_SEVERITY);
+	val |= 1 << UNSUPPORTED_REQUEST_ERROR_SHIFT;
+	csr_writel(mv_pci, val, CFG_UNCORRECTABLE_ERROR_SEVERITY);
 
 	ls_pcie_g4_get_bar_num(ep);
 
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.h b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
index 275c68f..7dc2a12 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil.h
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
@@ -120,6 +120,10 @@
 #define GPEX_BAR_SIZE_UDW                       0x4DC
 #define GPEX_BAR_SELECT                         0x4E0
 
+#define CFG_UNCORRECTABLE_ERROR_SEVERITY	0x10c
+#define UNSUPPORTED_REQUEST_ERROR_SHIFT		20
+#define CFG_UNCORRECTABLE_ERROR_MASK		0x108
+
 /* starting offset of INTX bits in status register */
 #define PAB_INTX_START			5
 
-- 
1.7.1

