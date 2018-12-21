Return-Path: <SRS0=Xdj1=O6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA52C43387
	for <linux-pci@archiver.kernel.org>; Fri, 21 Dec 2018 07:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FD5621903
	for <linux-pci@archiver.kernel.org>; Fri, 21 Dec 2018 07:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLiKURRB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729744AbeLUH22 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Dec 2018 02:28:28 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36754 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388661AbeLUH2T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Dec 2018 02:28:19 -0500
Received: by mail-pf1-f195.google.com with SMTP id b85so2188412pfc.3;
        Thu, 20 Dec 2018 23:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ceA3OOHkrp0/rBgfzfMs4oo9EwOqW1+SB1EA7e79xlA=;
        b=TLiKURRBbXaznllUhiqXzwJmMzNw9zNpxqRqosDaxG7rXC5+tiqPlP5vHq/TDxHkEg
         pivODxC1imDMsSrrqPKMbzS25+VaONbZAm834Vt+t/7BONwc++ZWNO1HVALX+Lseh3gf
         RUX95M11hEaQ+QrCxmaJ+pwo2VgmV2oPxHMhKcmnkkRq7Ry/1roNPNKdKif5NZO0XfRk
         xWbRoeFMmOltYYW0BV/y0jri+x2f01mptdX6QMsJ5tqWAQqgMQWl6BGaePye33jHOyoZ
         S1P8Cj2+BuNOwzltRmfkJTTq6DwqwFyAIt1AV/OJOECI0EopA5qGxpV+2/74tMSoSBZi
         jVxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ceA3OOHkrp0/rBgfzfMs4oo9EwOqW1+SB1EA7e79xlA=;
        b=E9M4WYGp121P37HElRvHqN7885mcBz+0Na9pnhqtr7eyEaZHztQuO67D64/m6RiNYk
         FMP1d2ASdAglhs3rT+0vOb1jxo1wUA0Z1g9PK6p0H2RIKwHcSHNzZ7AKKcn5HypLKPUl
         jnU4KELNXHFOVIpHY+xDPrZOVPLTKgZ10Jlr3qn9uyeKAbxyIOrQp+btY1gCA0EHKam+
         myQ03Dk2L4tePnNTfnqZWXNFZuWOtUbq8Ctn5JkPbfPeegxdbe39VyahC1a+lfuJD5z/
         pWwZnaqXDBzqlGByCAzPLWscxBAKbVAaHgSpF032ERa3f7MbjszB4rgh2wlxoqr/7rMf
         Nkhg==
X-Gm-Message-State: AJcUukcLciaZZjUbBpY9iYmtGSM6yPb/ULw/m2QjYu9rMWQS8yOq1giE
        DCdBt1g6IA57t1pkNYZXBNmWHZDM
X-Google-Smtp-Source: ALg8bN5zSz1wxg+PBVvIZ84CcYmXtIjNqUGxU8XxDrd1F6hHjuSlR1HFpP0O4hXHsxF4/BZSSjKQxg==
X-Received: by 2002:a63:a611:: with SMTP id t17mr1326464pge.338.1545377296834;
        Thu, 20 Dec 2018 23:28:16 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id t90sm44971921pfj.23.2018.12.20.23.28.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 23:28:16 -0800 (PST)
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
Subject: [PATCH 20/21] PCI: designware: Make use of GENMASK/FIELD_PREP
Date:   Thu, 20 Dec 2018 23:27:15 -0800
Message-Id: <20181221072716.29017-21-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181221072716.29017-1-andrew.smirnov@gmail.com>
References: <20181221072716.29017-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Convert various mult-bit fields to be defined using
GENMASK/FIELD_PREP. This way bit field boundaries are defined in a
single place only as well as defined in a way that makes it easier to
verify them against reference manual. No functional change intended.

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
 drivers/pci/controller/dwc/pcie-designware.h | 29 +++++++++++---------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 348e91b6daa2..0de653284fca 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -11,6 +11,7 @@
 #ifndef _PCIE_DESIGNWARE_H
 #define _PCIE_DESIGNWARE_H
 
+#include <linux/bitfield.h>
 #include <linux/dma-mapping.h>
 #include <linux/irq.h>
 #include <linux/msi.h>
@@ -30,11 +31,12 @@
 
 /* Synopsys-specific PCIe configuration registers */
 #define PCIE_PORT_LINK_CONTROL		0x710
-#define PORT_LINK_MODE_MASK		(0x3f << 16)
-#define PORT_LINK_MODE_1_LANES		(0x1 << 16)
-#define PORT_LINK_MODE_2_LANES		(0x3 << 16)
-#define PORT_LINK_MODE_4_LANES		(0x7 << 16)
-#define PORT_LINK_MODE_8_LANES		(0xf << 16)
+#define PORT_LINK_MODE_MASK		GENMASK(21, 16)
+#define PORT_LINK_MODE(n)		FIELD_PREP(PORT_LINK_MODE_MASK, n)
+#define PORT_LINK_MODE_1_LANES		PORT_LINK_MODE(0x1)
+#define PORT_LINK_MODE_2_LANES		PORT_LINK_MODE(0x3)
+#define PORT_LINK_MODE_4_LANES		PORT_LINK_MODE(0x7)
+#define PORT_LINK_MODE_8_LANES		PORT_LINK_MODE(0xf)
 
 #define PCIE_PORT_DEBUG0		0x728
 #define PORT_LOGIC_LTSSM_STATE_MASK	0x1f
@@ -45,11 +47,12 @@
 
 #define PCIE_LINK_WIDTH_SPEED_CONTROL	0x80C
 #define PORT_LOGIC_SPEED_CHANGE		BIT(17)
-#define PORT_LOGIC_LINK_WIDTH_MASK	(0x1f << 8)
-#define PORT_LOGIC_LINK_WIDTH_1_LANES	(0x1 << 8)
-#define PORT_LOGIC_LINK_WIDTH_2_LANES	(0x2 << 8)
-#define PORT_LOGIC_LINK_WIDTH_4_LANES	(0x4 << 8)
-#define PORT_LOGIC_LINK_WIDTH_8_LANES	(0x8 << 8)
+#define PORT_LOGIC_LINK_WIDTH_MASK	GENMASK(12, 8)
+#define PORT_LOGIC_LINK_WIDTH(n)	FIELD_PREP(PORT_LOGIC_LINK_WIDTH_MASK, n)
+#define PORT_LOGIC_LINK_WIDTH_1_LANES	PORT_LOGIC_LINK_WIDTH(0x1)
+#define PORT_LOGIC_LINK_WIDTH_2_LANES	PORT_LOGIC_LINK_WIDTH(0x2)
+#define PORT_LOGIC_LINK_WIDTH_4_LANES	PORT_LOGIC_LINK_WIDTH(0x4)
+#define PORT_LOGIC_LINK_WIDTH_8_LANES	PORT_LOGIC_LINK_WIDTH(0x8)
 
 #define PCIE_MSI_ADDR_LO		0x820
 #define PCIE_MSI_ADDR_HI		0x824
@@ -75,9 +78,9 @@
 #define PCIE_ATU_UPPER_BASE		0x910
 #define PCIE_ATU_LIMIT			0x914
 #define PCIE_ATU_LOWER_TARGET		0x918
-#define PCIE_ATU_BUS(x)			(((x) & 0xff) << 24)
-#define PCIE_ATU_DEV(x)			(((x) & 0x1f) << 19)
-#define PCIE_ATU_FUNC(x)		(((x) & 0x7) << 16)
+#define PCIE_ATU_BUS(x)			FIELD_PREP(GENMASK(31, 24), x)
+#define PCIE_ATU_DEV(x)			FIELD_PREP(GENMASK(23, 19), x)
+#define PCIE_ATU_FUNC(x)		FIELD_PREP(GENMASK(18, 16), x)
 #define PCIE_ATU_UPPER_TARGET		0x91C
 
 #define PCIE_MISC_CONTROL_1_OFF		0x8BC
-- 
2.19.1

