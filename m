Return-Path: <SRS0=sVnv=Q2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07355C43381
	for <linux-pci@archiver.kernel.org>; Tue, 19 Feb 2019 20:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B621F21738
	for <linux-pci@archiver.kernel.org>; Tue, 19 Feb 2019 20:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLn8k50K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729816AbfBSUEV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 19 Feb 2019 15:04:21 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42431 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729759AbfBSUEU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Feb 2019 15:04:20 -0500
Received: by mail-pg1-f193.google.com with SMTP id b2so4894478pgl.9;
        Tue, 19 Feb 2019 12:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BZi2w8f57gOm3gFQ8UGMMY60waRhbgxhlftcvIngYdk=;
        b=DLn8k50K04WUEg8VKTvya93AQofVWYeFWRQz7bWvjzLLN0Wd8V8DxubI+t+I1QVspL
         UioKOnR03EfgqqlIWdFmCv2+l2xLBpwABpTcHSNUrlGVJBfVzEbV1dV44IStOjfG+36G
         GVLYkbRlBsJjXSA/IsokZBdbqtUqbvf6KGLLcpMiM3o8USZ3CrZdeFPyjOaAXL/vlsZR
         1WIipNvw2ieVcyKUottu7TeHg84Ucvlp0UZSXRtMo3+3NuUghzdaWdJtqE6W7nzFpmjy
         uF+esZmk12ri7Ewl6tfaQu/omAIabWWEl+prmDRokPYZPmmt67EkV/nyvKk0ViVgCJWt
         j31Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BZi2w8f57gOm3gFQ8UGMMY60waRhbgxhlftcvIngYdk=;
        b=U1IhawAvZyQ7ezszeA3AVYUTHRFmOpB3WRO6EG/OXYBqlFjX9vriPAIfWruFGyleKI
         lYuhI+NMeeFx4T2osokYFPn61x9kXgrhrpyZUvWhHdL2i+gJxjCIcJVAPlHkaQX4ciVL
         SULDbEDOmLfDoOBtdxl0jd9Uyu5mHJrHPo2giG1EuJz9JyveRl0LmOpEu8zBN1LdFZi9
         0nioUEkaRXw8ayfPHlLQIj0WOv/pus8mmRstYdEFhEVCQ5D88I8lR8DrIcRtwHYpyZa6
         D5b7gvUgjchDLwOTC9wUweGWKAX9J/5IHD01Dj2JU9nGjI6NaWvkV+Aa9ufnqLALFyj+
         pVVA==
X-Gm-Message-State: AHQUAuZ/OedQkoMUrKFrR7yu7hGvJPp0lu3N4Urz143vtasGbO/Qtn0E
        i17A88zUm6ikNHLESiVG7/s=
X-Google-Smtp-Source: AHgI3IZInibU5Q4FBmodj59vvkLZQJoScZEM++EElmkNviJN23OVcpFqfexe7ksD15S1jtW4MRHw7g==
X-Received: by 2002:a63:4e05:: with SMTP id c5mr25940085pgb.393.1550606659627;
        Tue, 19 Feb 2019 12:04:19 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id e63sm31519622pfc.47.2019.02.19.12.04.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 12:04:18 -0800 (PST)
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
Subject: [PATCH 4/5] PCI: dwc: Make use of GENMASK/FIELD_PREP
Date:   Tue, 19 Feb 2019 12:02:41 -0800
Message-Id: <20190219200242.17243-5-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190219200242.17243-1-andrew.smirnov@gmail.com>
References: <20190219200242.17243-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Convert various multi-bit fields to be defined using
GENMASK/FIELD_PREP. This way bit field boundaries are defined in a
single place only, as well as defined in a way that makes it easier to
verify them against reference manual. No functional change intended.

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
 drivers/pci/controller/dwc/pcie-designware.h | 29 +++++++++++---------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 070382869685..8ebfb06584d9 100644
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
@@ -42,11 +44,12 @@
 
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
@@ -72,9 +75,9 @@
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
2.20.1

