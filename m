Return-Path: <SRS0=sVnv=Q2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9540EC43381
	for <linux-pci@archiver.kernel.org>; Tue, 19 Feb 2019 20:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5661121773
	for <linux-pci@archiver.kernel.org>; Tue, 19 Feb 2019 20:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7EeaW7x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729698AbfBSUET (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 19 Feb 2019 15:04:19 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37446 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729690AbfBSUET (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Feb 2019 15:04:19 -0500
Received: by mail-pg1-f196.google.com with SMTP id q206so10635991pgq.4;
        Tue, 19 Feb 2019 12:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jp5F1KPWJWW598c9kjTLRM3hJfIiNreNpkLqMBLWLxc=;
        b=j7EeaW7xx5pdrl8h3qI/gaSy9x13j2SUiv58eh+Lzn7mlEzP+JjRgZEe3Y2gQiBKtZ
         EqQWvD/mCqfo9Bw8gENUWyEurkocFtx1oOfhg0hqJ+Ha0ppP4F7VkR0fkLa6Md5iZ9gy
         xvdW/FRtssuFz8hkCE2ey2Td2u4KwOcIH+9ERLIXm6XZMWI8MumsDQUXnhHGTzMsESPO
         I3aW6tY6PtsQWXb5RMz/KOskKtoCDatfTfy2SKJDinMCgeLnZi3S7CCqsDahyBmN68A3
         f5LfnDRQpJH+dC7PEv1pk8qzW5pWtFQeZj9HtYkFjBBHN+OSueBS7Er1/69aX8+LIsYY
         YWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jp5F1KPWJWW598c9kjTLRM3hJfIiNreNpkLqMBLWLxc=;
        b=j3KYmmSi1sQTOwhmXRZiXusFabBft6Pl7lYfad+L156DIWAgjKiTK2ELgx1DupQ3nI
         FqXhqtCsmiSSH69OlxYIDWlhdY29zn31jfbozx0Zh5Sa8xM31lpcBD67KOwCKsY0+1cF
         eb2+F3oHfd0rFjtYE6Y1fwfemre5RB5hVjgWuzTv7kePi6vLXhQvg1qU26zwWQ1aMtzE
         dNYDOmFgOxsEAgSEGNi40WhQXBiQ9K3Ps+IH7x/n7vi5I18izIdBwdxLDbz5CvBiMd1Q
         VrKRZ04FYFvmJ37Uzyx22vV6uyiuoWKlIrYzuHleMUW3cuua0TNYokz2XBsfi4vOtY30
         9Zow==
X-Gm-Message-State: AHQUAub+8BqbsRWCJBOjE6//jSH0j160U8GE94DsUv2oKLGQBtqVK51V
        Rvvc3bcCrzPdmTCID+dliro=
X-Google-Smtp-Source: AHgI3IYggCXb4ggn0uNchQ1s7xq2ZhI++jGaZDTAUqENU/DRFsKCpY7ZpdJ52mJt9s8XPDcEWcITKw==
X-Received: by 2002:a62:6e07:: with SMTP id j7mr31841489pfc.135.1550606658265;
        Tue, 19 Feb 2019 12:04:18 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id e63sm31519622pfc.47.2019.02.19.12.04.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 12:04:17 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH 3/5] PCI: dwc: Make use of BIT() in constant definitions
Date:   Tue, 19 Feb 2019 12:02:40 -0800
Message-Id: <20190219200242.17243-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190219200242.17243-1-andrew.smirnov@gmail.com>
References: <20190219200242.17243-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Avoid using explicit left shifts and convert various definitions to
use BIT() instead. No functional change intended.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
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
---
 drivers/pci/controller/dwc/pcie-designware.c |  2 +-
 drivers/pci/controller/dwc/pcie-designware.h | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 67236379c61a..31f6331ca46f 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -306,7 +306,7 @@ void dw_pcie_disable_atu(struct dw_pcie *pci, int index,
 	}
 
 	dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT, region | index);
-	dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, ~PCIE_ATU_ENABLE);
+	dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, (u32)~PCIE_ATU_ENABLE);
 }
 
 int dw_pcie_wait_for_link(struct dw_pcie *pci)
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 279000255ad1..070382869685 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -41,7 +41,7 @@
 #define PORT_LOGIC_LTSSM_STATE_L0	0x11
 
 #define PCIE_LINK_WIDTH_SPEED_CONTROL	0x80C
-#define PORT_LOGIC_SPEED_CHANGE		(0x1 << 17)
+#define PORT_LOGIC_SPEED_CHANGE		BIT(17)
 #define PORT_LOGIC_LINK_WIDTH_MASK	(0x1f << 8)
 #define PORT_LOGIC_LINK_WIDTH_1_LANES	(0x1 << 8)
 #define PORT_LOGIC_LINK_WIDTH_2_LANES	(0x2 << 8)
@@ -55,8 +55,8 @@
 #define PCIE_MSI_INTR0_STATUS		0x830
 
 #define PCIE_ATU_VIEWPORT		0x900
-#define PCIE_ATU_REGION_INBOUND		(0x1 << 31)
-#define PCIE_ATU_REGION_OUTBOUND	(0x0 << 31)
+#define PCIE_ATU_REGION_INBOUND		BIT(31)
+#define PCIE_ATU_REGION_OUTBOUND	0
 #define PCIE_ATU_REGION_INDEX2		(0x2 << 0)
 #define PCIE_ATU_REGION_INDEX1		(0x1 << 0)
 #define PCIE_ATU_REGION_INDEX0		(0x0 << 0)
@@ -66,8 +66,8 @@
 #define PCIE_ATU_TYPE_CFG0		(0x4 << 0)
 #define PCIE_ATU_TYPE_CFG1		(0x5 << 0)
 #define PCIE_ATU_CR2			0x908
-#define PCIE_ATU_ENABLE			(0x1 << 31)
-#define PCIE_ATU_BAR_MODE_ENABLE	(0x1 << 30)
+#define PCIE_ATU_ENABLE			BIT(31)
+#define PCIE_ATU_BAR_MODE_ENABLE	BIT(30)
 #define PCIE_ATU_LOWER_BASE		0x90C
 #define PCIE_ATU_UPPER_BASE		0x910
 #define PCIE_ATU_LIMIT			0x914
@@ -78,7 +78,7 @@
 #define PCIE_ATU_UPPER_TARGET		0x91C
 
 #define PCIE_MISC_CONTROL_1_OFF		0x8BC
-#define PCIE_DBI_RO_WR_EN		(0x1 << 0)
+#define PCIE_DBI_RO_WR_EN		BIT(0)
 
 /*
  * iATU Unroll-specific register definitions
@@ -105,7 +105,7 @@
 		((region) << 9)
 
 #define PCIE_GET_ATU_INB_UNR_REG_OFFSET(region) \
-		(((region) << 9) | (0x1 << 8))
+		(((region) << 9) | BIT(8))
 
 #define MAX_MSI_IRQS			256
 #define MAX_MSI_IRQS_PER_CTRL		32
-- 
2.20.1

