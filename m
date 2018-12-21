Return-Path: <SRS0=Xdj1=O6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D97DC43387
	for <linux-pci@archiver.kernel.org>; Fri, 21 Dec 2018 07:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4B1921906
	for <linux-pci@archiver.kernel.org>; Fri, 21 Dec 2018 07:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fuJydmjO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387743AbeLUH2A (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Dec 2018 02:28:00 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42066 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387860AbeLUH16 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Dec 2018 02:27:58 -0500
Received: by mail-pl1-f196.google.com with SMTP id y1so2097821plp.9;
        Thu, 20 Dec 2018 23:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rMjeSwqTVYgU8Pkh3tt+I27KOANJIXmBbqHJEBxidRc=;
        b=fuJydmjOCe/aNVUWccFNTUhSXJgPFuBevZ0KZvetPIaHuw3xlUcl1eRP/w46kKKE8H
         yP7FYF5virlsp+ZnSFEKDQ1atdLjHEi+O3vIDrOEFdN2QYO6mklcZhp/ex5ph7RE01pL
         0Gwg1LqSMmTRXF904GVVqjBxsUL1Xt6hDuuGqCUL+txnGNrUGkSmjeK+BJcTl2+PbTxY
         8LGsxFT3yTx9d7RMDAfPC6cKVhI34UwfG7WPgF7tzIyelnarJzSMRPkfhod74r7LT7qz
         8JieMinuEVFwP/GO7Y+hVCWAusX1EJ/qrKjlPEBhQdnPRrQPEZzJdRNr3jgHXHUoyKOj
         bREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rMjeSwqTVYgU8Pkh3tt+I27KOANJIXmBbqHJEBxidRc=;
        b=WPpN1J9qfDSAuoYn9SsS34KjcaV6/v4tOLfj/xXCBtW1+ZGigNS30//5mQxZfsEW5V
         V4f29n2dUso3PLsFGXvRy8CiSIjeK2iF76yOUwqiR0MPJbD/TCt7l4yXPDjJ+QBI2Obn
         MQEKqC6Th8wIsshZ1xVVDM13gNOjUV1PfFh/lpVu5WHO35p9T9qtQvcTJe82QQ1WML/0
         i02lgGsdmmH+TNT7WdBTVjvwhiDPC10G9lmtGfZRH5IN/oBxJAIHilTUjhMCdEt2/TOU
         VLFNvB1+rkQpOB62vMX5HqXT1egSWxjgU2rdAJXtjVzMoMnHbMbhEzYY4uVg0xE0KwQn
         1FxQ==
X-Gm-Message-State: AJcUukcP2y6tsxW0tiWlLI59+DO9UWKcSotWme2tzqWdAwgBikja6fPi
        LWYhgNFKS8LCUiy/1PmpLpEHT+iS
X-Google-Smtp-Source: ALg8bN6q73Q1NnW5DO0vkV8WUnO939ff0oDQK8QdIco6O92Xhm1cJd9Vi5e7YSWBjPhBUsepla/bug==
X-Received: by 2002:a17:902:d01:: with SMTP id 1mr1435404plu.127.1545377277849;
        Thu, 20 Dec 2018 23:27:57 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id t90sm44971921pfj.23.2018.12.20.23.27.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 23:27:57 -0800 (PST)
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
Subject: [PATCH 10/21] PCI: designware: imx6: Share PHY debug register definitions
Date:   Thu, 20 Dec 2018 23:27:05 -0800
Message-Id: <20181221072716.29017-11-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181221072716.29017-1-andrew.smirnov@gmail.com>
References: <20181221072716.29017-1-andrew.smirnov@gmail.com>
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
index 74faca11eeae..c0b073cf20c0 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -82,8 +82,6 @@ struct imx6_pcie {
 
 /* PCIe Port Logic registers (memory-mapped) */
 #define PL_OFFSET 0x700
-#define PCIE_PHY_DEBUG_R0 (PL_OFFSET + 0x28)
-#define PCIE_PHY_DEBUG_R1 (PL_OFFSET + 0x2c)
 
 #define PCIE_PHY_CTRL (PL_OFFSET + 0x114)
 #define PCIE_PHY_CTRL_DATA_LOC 0
@@ -706,8 +704,8 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
 
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
2.19.1

