Return-Path: <SRS0=cJ9t=SD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE67C4360F
	for <linux-pci@archiver.kernel.org>; Mon,  1 Apr 2019 04:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BC2A20870
	for <linux-pci@archiver.kernel.org>; Mon,  1 Apr 2019 04:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vLKrtTIX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731364AbfDAE0J (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Apr 2019 00:26:09 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39805 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfDAE0I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Apr 2019 00:26:08 -0400
Received: by mail-pg1-f196.google.com with SMTP id k3so4068582pga.6;
        Sun, 31 Mar 2019 21:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8whUmPYH8KsqvkwsmrRZwN7fZI8OQ9E54/C8jqSTYVM=;
        b=vLKrtTIXy4SD7SlQWtGDn/Rm38iDuIjIeGocg0oZARQHvW0QgDXqxpGBaC/CIBXIaa
         tlug3ab3KQuyxMKo5ALEcNQEbFmlkV7L8LxOVpkzWotBEPydQ5ux9nm38/xk+lzeft4q
         VFmeJX8EW/Dk8hI6Oex4a0wnZxY2ES3brJT5OVhz0Nd59Jp+WlviyRxWCYJ2DdeXALSD
         0eQFYNM36x/bApzkmP3NAPd5t8WQh58vSBhGyaDe4ujIbjuOzhkku9ACLXBmU9Rke9ob
         7fLWHk/JiElZpT5pw/MTxL1oXe/R92NYcFfB21qr6CpfVVq7LRjr6gxvvUM/dg0ihPSr
         5Csw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8whUmPYH8KsqvkwsmrRZwN7fZI8OQ9E54/C8jqSTYVM=;
        b=VkF5B7Gs+sP0slQfSTdST0+oM9R/4Go9CYrDLLXboe5ysjgtoGWwmFFJj7kYjQ5+CG
         OC58NDMMsMTd9SyXv/d1Fw0GL1dF4XikJHgg0fJ4EkPGfKGQdHLU+kk8A3YsVeE+Vq+5
         qsNWElBxdeJPN3SSWmAiTkuzTfepJt02AqRAaT08eOwazDrEGyQTieu4YKR3VJxM/6FB
         FVqvfHd+rHfAEH/6TrBpCCkuqGSEn9/5PIQb/xLWamrjXh2QaA4Qm6zKS9+TznoafYPa
         UHQjw+WEARbygUyqNGrpiOyVQtwg6BVrPraB0+plLfZ9VvxXZRGGbPBahpuI3c4/KoJe
         EgNA==
X-Gm-Message-State: APjAAAVXiH9hirvP02mUJxTqYQSyChC0RRN8woqF9a43toX7PMQ2er36
        PYw+Vvcx6nwb2smimGj+uT3T4vrZ
X-Google-Smtp-Source: APXvYqyglTsuRlhl/0izWWPDsxD4hoX3JRd6WuETqcXR6P2heRnmooiXnKqhRPv23Ruocf8sZyxL/w==
X-Received: by 2002:a63:fa54:: with SMTP id g20mr4043801pgk.242.1554092767129;
        Sun, 31 Mar 2019 21:26:07 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id t22sm10996829pgu.45.2019.03.31.21.26.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 31 Mar 2019 21:26:06 -0700 (PDT)
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
Subject: [PATCH v3 05/11] PCI: dwc: imx6: Share PHY debug register definitions
Date:   Sun, 31 Mar 2019 21:25:41 -0700
Message-Id: <20190401042547.14067-6-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190401042547.14067-1-andrew.smirnov@gmail.com>
References: <20190401042547.14067-1-andrew.smirnov@gmail.com>
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
index 92c40c250a34..bb95a3273ca2 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -103,8 +103,6 @@ struct imx6_pcie {
 
 /* PCIe Port Logic registers (memory-mapped) */
 #define PL_OFFSET 0x700
-#define PCIE_PHY_DEBUG_R0 (PL_OFFSET + 0x28)
-#define PCIE_PHY_DEBUG_R1 (PL_OFFSET + 0x2c)
 
 #define PCIE_PHY_CTRL (PL_OFFSET + 0x114)
 #define PCIE_PHY_CTRL_DATA_LOC 0
@@ -839,8 +837,8 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
 
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
index 31f6331ca46f..086e87a40316 100644
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
index 377f4c0b52da..662bb9082c76 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -41,6 +41,9 @@
 #define PCIE_PORT_DEBUG0		0x728
 #define PORT_LOGIC_LTSSM_STATE_MASK	0x1f
 #define PORT_LOGIC_LTSSM_STATE_L0	0x11
+#define PCIE_PORT_DEBUG1		0x72C
+#define PCIE_PORT_DEBUG1_LINK_UP		(0x1 << 4)
+#define PCIE_PORT_DEBUG1_LINK_IN_TRAINING	(0x1 << 29)
 
 #define PCIE_LINK_WIDTH_SPEED_CONTROL	0x80C
 #define PORT_LOGIC_SPEED_CHANGE		BIT(17)
-- 
2.20.1

