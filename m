Return-Path: <SRS0=Xdj1=O6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A85C43387
	for <linux-pci@archiver.kernel.org>; Fri, 21 Dec 2018 07:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B3E621903
	for <linux-pci@archiver.kernel.org>; Fri, 21 Dec 2018 07:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZmGDu3T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387897AbeLUH2B (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Dec 2018 02:28:01 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34609 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387869AbeLUH2A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Dec 2018 02:28:00 -0500
Received: by mail-pl1-f193.google.com with SMTP id w4so2118558plz.1;
        Thu, 20 Dec 2018 23:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m7MEN22xZYILSeqqlIU1BMlYkd4ApqQIfal0i82aqSc=;
        b=ZZmGDu3T8HXjZFjkvSVQYq7jVhGdL3AOkVax6x+BkXgM7pqjSvQXUwGuM1jjj1Cka9
         iVg1ODnpiLTcgoKDJO0JSB63ZejLwNhWWekLZ+GjwC4htx3yUrUp5cGoNuWhKI3ZtoZY
         hH7z2gMXQ2a2QVlCrB39PECb+EhTxs2IHDts+7RXDqW7jygOhRbLpkyyRmV0GyzKypxu
         zhs9/dE+2ZvXKbo22+c6Kr62Og2tybOwpVBKzVjd/rOgGXgr7JeVdpPkVdwyZMuvmL05
         lPJ7vPv2xIpZ1aGiPQZcbDV510X42FNJfUkHYG7Z17u1Amz58+63ZJvW9EfWTRRMQqHL
         Pl+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m7MEN22xZYILSeqqlIU1BMlYkd4ApqQIfal0i82aqSc=;
        b=fCXXZhAhzLruhw3TObXimR1rH6IVzpeo8iHqeLUa9PPGYCxHOuK3e/haB5yVkmFGSV
         6B7XkmY0EU24VAK3vbIMt+W5FiWWtzZzrYjShSxkcJ4ZmlNIBFGVhZuJI/bFtFHRBG2b
         8XPIHLfZa0YXvz0bXVqz8hPMmndP/4yhnorqP1eiR9+pkXUT6ywFfy4tSzP2ZVfgqOFS
         Ox2jjFPjZI0GprPL/ygniu0rRLvHgIvq9lus5qiApyrwdQxX9KYNXq95YKbDOxY1yxYW
         GGnk4jpzv8Vr9ERIWUMsVduvympkQ8cBV6Z9ew574/Dmrd3SHQiDrJ3ieCYmtIFKXDE8
         yvHw==
X-Gm-Message-State: AJcUukcJuoshSYXotredwf5aesLFqvNOowl2lQ7h01yRGWFf4MV11N5Y
        V9LKEY1j1E9ctAZ703mfIB02pJZB
X-Google-Smtp-Source: ALg8bN6ThoRT6OXXj55K3ngrcTHhbGq34vHZw6EHKrvfvxBcvviztT6l0Lj/cOoLrG1/tx5VZ/ocdA==
X-Received: by 2002:a17:902:5ac2:: with SMTP id g2mr1398311plm.313.1545377279885;
        Thu, 20 Dec 2018 23:27:59 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id t90sm44971921pfj.23.2018.12.20.23.27.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 23:27:58 -0800 (PST)
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
Subject: [PATCH 11/21] PCI: designware: Make use of BIT() in constant definitions
Date:   Thu, 20 Dec 2018 23:27:06 -0800
Message-Id: <20181221072716.29017-12-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181221072716.29017-1-andrew.smirnov@gmail.com>
References: <20181221072716.29017-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Avoid using explicit left shifts and convert various definitions to
use BIT() instead. No functional change intended.

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
 drivers/pci/controller/dwc/pcie-designware.c |  2 +-
 drivers/pci/controller/dwc/pcie-designware.h | 18 +++++++++---------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index d123ac290b9e..086e87a40316 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -300,7 +300,7 @@ void dw_pcie_disable_atu(struct dw_pcie *pci, int index,
 	}
 
 	dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT, region | index);
-	dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, ~PCIE_ATU_ENABLE);
+	dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, (u32)~PCIE_ATU_ENABLE);
 }
 
 int dw_pcie_wait_for_link(struct dw_pcie *pci)
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 58735fd01668..348e91b6daa2 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -40,11 +40,11 @@
 #define PORT_LOGIC_LTSSM_STATE_MASK	0x1f
 #define PORT_LOGIC_LTSSM_STATE_L0	0x11
 #define PCIE_PORT_DEBUG1		0x72C
-#define PCIE_PORT_DEBUG1_LINK_UP		(0x1 << 4)
-#define PCIE_PORT_DEBUG1_LINK_IN_TRAINING	(0x1 << 29)
+#define PCIE_PORT_DEBUG1_LINK_UP		BIT(4)
+#define PCIE_PORT_DEBUG1_LINK_IN_TRAINING	BIT(29)
 
 #define PCIE_LINK_WIDTH_SPEED_CONTROL	0x80C
-#define PORT_LOGIC_SPEED_CHANGE		(0x1 << 17)
+#define PORT_LOGIC_SPEED_CHANGE		BIT(17)
 #define PORT_LOGIC_LINK_WIDTH_MASK	(0x1f << 8)
 #define PORT_LOGIC_LINK_WIDTH_1_LANES	(0x1 << 8)
 #define PORT_LOGIC_LINK_WIDTH_2_LANES	(0x2 << 8)
@@ -58,8 +58,8 @@
 #define PCIE_MSI_INTR0_STATUS		0x830
 
 #define PCIE_ATU_VIEWPORT		0x900
-#define PCIE_ATU_REGION_INBOUND		(0x1 << 31)
-#define PCIE_ATU_REGION_OUTBOUND	(0x0 << 31)
+#define PCIE_ATU_REGION_INBOUND		BIT(31)
+#define PCIE_ATU_REGION_OUTBOUND	0
 #define PCIE_ATU_REGION_INDEX2		(0x2 << 0)
 #define PCIE_ATU_REGION_INDEX1		(0x1 << 0)
 #define PCIE_ATU_REGION_INDEX0		(0x0 << 0)
@@ -69,8 +69,8 @@
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
@@ -81,7 +81,7 @@
 #define PCIE_ATU_UPPER_TARGET		0x91C
 
 #define PCIE_MISC_CONTROL_1_OFF		0x8BC
-#define PCIE_DBI_RO_WR_EN		(0x1 << 0)
+#define PCIE_DBI_RO_WR_EN		BIT(0)
 
 /*
  * iATU Unroll-specific register definitions
@@ -108,7 +108,7 @@
 		((region) << 9)
 
 #define PCIE_GET_ATU_INB_UNR_REG_OFFSET(region) \
-		(((region) << 9) | (0x1 << 8))
+		(((region) << 9) | BIT(8))
 
 #define MAX_MSI_IRQS			256
 #define MAX_MSI_IRQS_PER_CTRL		32
-- 
2.19.1

