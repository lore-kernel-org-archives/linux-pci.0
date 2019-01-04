Return-Path: <SRS0=mKou=PM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2EDDC43387
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 17:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5BA721872
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 17:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cl1DLcwR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbfADRuA (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 4 Jan 2019 12:50:00 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:32790 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728465AbfADRt7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Jan 2019 12:49:59 -0500
Received: by mail-pl1-f195.google.com with SMTP id z23so17737613plo.0;
        Fri, 04 Jan 2019 09:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=shK5Doptk0Qhk1JfbtIOZ/odHZxsAlF8OFxlwBmTSmo=;
        b=cl1DLcwRE/0QWpXSbhSh5i0/TvsBDRwsOkAAPfQn0820+d/QVQbClX49IoSnREMRBL
         zxnfMG4pWoNcC8D0cP6VPi2bj6s10QjS2/WG1XgllsKJPtdSAMIrQm20reIhnEw6z9HX
         +BLrO1ogIB0/6RxoBfW+KluWbWMcl+Q5Jqq66h0OXhirOVEKyLYFZKyQ/NCM0GCeWaLA
         IE6sgPXDOv9RtA56sojeXdqs/ewJ58mXxoaP7WeXq4VU54Zxk5GwgtBibUyYZTZcTqAa
         iSVVH/4dWXNs7hVbX17zPNm0jN+VsFQRG+iwmunKx71ox3qmkzuzdUUf8/iIlym9kc9r
         3j+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=shK5Doptk0Qhk1JfbtIOZ/odHZxsAlF8OFxlwBmTSmo=;
        b=cO0p1mhrsPB9aj10LDZ+aP+QimxQ4OcFGLB46sVo6Lpc0bvYskoGBI4cOjCmDoMdwi
         /0LzeKn4GwJl+7YRk66zRU4YsYworRrvos30210rvRGX4FD3vN32IDifYwt1k5qP4x8R
         ZTv+FzFwuSzmtxa06PZM+YktNz0ghwtMBBuWm/yfkAUJJZ+FMN3wT6htT+shc9Nd30N/
         FVNQ39kKJGoHmXZpHpIdv2cVeYjnOlg/zDEzlnMbU89YgwVmdL866QXikVSS9/sjJZY6
         XF8+xHV/Le7qAqARZOMz3zOHaYMODWsmbZoHBWg8+JyEye211Bx1M2135Lqc1q1e9Zpq
         O/Lg==
X-Gm-Message-State: AJcUuketT8q8opUjLTYWaWlTnkUDswT6Wk5TFzozZ3qJHFJaGy1v5izx
        ogy2xgkfgEKKhoUxO96PpgyuA0QQyO8=
X-Google-Smtp-Source: ALg8bN7xL2Wj0D3OvOejOoR/ru4ykY6LA92CJfEgjRNXWosVQ6tj6c/GwLJV5CaMLFa9MqTdBrCMeA==
X-Received: by 2002:a17:902:5982:: with SMTP id p2mr51337128pli.39.1546624197107;
        Fri, 04 Jan 2019 09:49:57 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id i193sm100699632pgc.22.2019.01.04.09.49.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 09:49:56 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/20] PCI: dwc: imx6: Share PHY debug register definitions
Date:   Fri,  4 Jan 2019 09:49:14 -0800
Message-Id: <20190104174925.17153-10-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190104174925.17153-1-andrew.smirnov@gmail.com>
References: <20190104174925.17153-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Both pcie-designware.c and pci-imx6.c contain custom definitions for
PHY debug registers R0/R1 and on top of that there's already a
definition for R0 in pcie-designware.h. Move all of the definitions to
pcie-designware.h. No functional change intended.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-imx@nxp.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/pci/controller/dwc/pci-imx6.c        |  6 ++----
 drivers/pci/controller/dwc/pcie-designware.c | 12 +++---------
 drivers/pci/controller/dwc/pcie-designware.h |  3 +++
 3 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 282b09076fea..5e7fab089bde 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -99,8 +99,6 @@ struct imx6_pcie {
 
 /* PCIe Port Logic registers (memory-mapped) */
 #define PL_OFFSET 0x700
-#define PCIE_PHY_DEBUG_R0 (PL_OFFSET + 0x28)
-#define PCIE_PHY_DEBUG_R1 (PL_OFFSET + 0x2c)
 
 #define PCIE_PHY_CTRL (PL_OFFSET + 0x114)
 #define PCIE_PHY_CTRL_DATA_LOC 0
@@ -784,8 +782,8 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
 
 err_reset_phy:
 	dev_dbg(dev, "PHY DEBUG_R0=0x%08x DEBUG_R1=0x%08x\n",
-		dw_pcie_readl_dbi(pci, PCIE_PHY_DEBUG_R0),
-		dw_pcie_readl_dbi(pci, PCIE_PHY_DEBUG_R1));
+		dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG0),
+		dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG1));
 	imx6_pcie_reset_phy(imx6_pcie);
 	return ret;
 }
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 67236379c61a..d123ac290b9e 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -14,12 +14,6 @@
 
 #include "pcie-designware.h"
 
-/* PCIe Port Logic registers */
-#define PLR_OFFSET			0x700
-#define PCIE_PHY_DEBUG_R1		(PLR_OFFSET + 0x2c)
-#define PCIE_PHY_DEBUG_R1_LINK_UP	(0x1 << 4)
-#define PCIE_PHY_DEBUG_R1_LINK_IN_TRAINING	(0x1 << 29)
-
 int dw_pcie_read(void __iomem *addr, int size, u32 *val)
 {
 	if (!IS_ALIGNED((uintptr_t)addr, size)) {
@@ -334,9 +328,9 @@ int dw_pcie_link_up(struct dw_pcie *pci)
 	if (pci->ops->link_up)
 		return pci->ops->link_up(pci);
 
-	val = readl(pci->dbi_base + PCIE_PHY_DEBUG_R1);
-	return ((val & PCIE_PHY_DEBUG_R1_LINK_UP) &&
-		(!(val & PCIE_PHY_DEBUG_R1_LINK_IN_TRAINING)));
+	val = readl(pci->dbi_base + PCIE_PORT_DEBUG1);
+	return ((val & PCIE_PORT_DEBUG1_LINK_UP) &&
+		(!(val & PCIE_PORT_DEBUG1_LINK_IN_TRAINING)));
 }
 
 void dw_pcie_setup(struct dw_pcie *pci)
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 9943d8c68335..58735fd01668 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -39,6 +39,9 @@
 #define PCIE_PORT_DEBUG0		0x728
 #define PORT_LOGIC_LTSSM_STATE_MASK	0x1f
 #define PORT_LOGIC_LTSSM_STATE_L0	0x11
+#define PCIE_PORT_DEBUG1		0x72C
+#define PCIE_PORT_DEBUG1_LINK_UP		(0x1 << 4)
+#define PCIE_PORT_DEBUG1_LINK_IN_TRAINING	(0x1 << 29)
 
 #define PCIE_LINK_WIDTH_SPEED_CONTROL	0x80C
 #define PORT_LOGIC_SPEED_CHANGE		(0x1 << 17)
-- 
2.20.1

