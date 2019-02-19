Return-Path: <SRS0=sVnv=Q2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7238CC4360F
	for <linux-pci@archiver.kernel.org>; Tue, 19 Feb 2019 20:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FB3D21738
	for <linux-pci@archiver.kernel.org>; Tue, 19 Feb 2019 20:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+dvwvSu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729839AbfBSUEX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 19 Feb 2019 15:04:23 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41089 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729690AbfBSUEW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Feb 2019 15:04:22 -0500
Received: by mail-pg1-f193.google.com with SMTP id m1so10618189pgq.8;
        Tue, 19 Feb 2019 12:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gTZS3t8Lyn570x3oRncarDhKKj8oVR/yQ7+W/riZcU8=;
        b=G+dvwvSuDU6HE9jgfFG21HfXS4BEgBfzNKskDzwX91rsuKELDHESW0fs5hqOY2/3/F
         iRQL1z7xpeKG+1zlTLP6FkpfTgZ9JRUKJCwsfFrL4RogLj+xJTd94WvBdbD/AT+WZfGf
         nudFMCdQyvSe7qYa8FSGXVaZEMfbPZkjqpcU/x3ZQnwNP82XH01iqriLzmws6F83d0tq
         MX+14L4oqAAZAPnalbRTOC+7B81+PSBHpcjJ14SC7YYNUiF6nR80CH4xVNXQsFvFqAyH
         DUa/kmQBal3LSauQW24gx9bNuMLyaEsnaEDaP6+vLreBt2AYELyp4eo15wrcjZg0fAih
         bVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gTZS3t8Lyn570x3oRncarDhKKj8oVR/yQ7+W/riZcU8=;
        b=CPOeBy4Z1/nUl6A+M3FY5c1LB6FA1PMfbiQJGdJr6DyneH9GuqmcttoliKNsHw+VKT
         hHjIdKsR0Wkci/wJAwYh+0ShZ7kMQYXhm73T/0OqAyD3F4svfauVVh7g8B0ULbXkfwnX
         taX62MIJLe+hOY9/srfXq5nQfr+2/rSvAr0VkZ1zoRJ32oeCNd8Bl0D7IytKCXmuLow9
         s5TiXw7cpr5B1anZf4YiPJ2dJUU6Y1qx4mpBowrVRQEznlVcdZquNaPwW3LH4/qYhC+k
         mu/MJDsbJxucUqfLKb7y+gDZLcX3mzmPNOr9MS3w6Eb5UmyMxWbpGHbfdEidj3g0TNRv
         jwTA==
X-Gm-Message-State: AHQUAuY0Cdw8S9mTJdpSL/H0HHUG9D7sN7tXQ3RhV0IrCJxQ3tjD9DTp
        V6qFnowWVNV+W9WLIaO9+Ks=
X-Google-Smtp-Source: AHgI3IbtUCPjKiYn8vRprZhcgLfAG7cHtYkA9MN4O7HEk3qZ8QWNEfA+R628X+qWcnqFcCpLAEyPYA==
X-Received: by 2002:a63:6881:: with SMTP id d123mr25343732pgc.10.1550606661180;
        Tue, 19 Feb 2019 12:04:21 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id e63sm31519622pfc.47.2019.02.19.12.04.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 12:04:20 -0800 (PST)
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
Subject: [PATCH 5/5] PCI: dwc: Remove superfluous shifting in definitions
Date:   Tue, 19 Feb 2019 12:02:42 -0800
Message-Id: <20190219200242.17243-6-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190219200242.17243-1-andrew.smirnov@gmail.com>
References: <20190219200242.17243-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Surrounding definitions no longer use explicit shift, so "<< 0" here
serve no purpose. Remove them. No functional change intended.

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
 drivers/pci/controller/dwc/pcie-designware.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 8ebfb06584d9..f6fb65a40f10 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -60,14 +60,14 @@
 #define PCIE_ATU_VIEWPORT		0x900
 #define PCIE_ATU_REGION_INBOUND		BIT(31)
 #define PCIE_ATU_REGION_OUTBOUND	0
-#define PCIE_ATU_REGION_INDEX2		(0x2 << 0)
-#define PCIE_ATU_REGION_INDEX1		(0x1 << 0)
-#define PCIE_ATU_REGION_INDEX0		(0x0 << 0)
+#define PCIE_ATU_REGION_INDEX2		0x2
+#define PCIE_ATU_REGION_INDEX1		0x1
+#define PCIE_ATU_REGION_INDEX0		0x0
 #define PCIE_ATU_CR1			0x904
-#define PCIE_ATU_TYPE_MEM		(0x0 << 0)
-#define PCIE_ATU_TYPE_IO		(0x2 << 0)
-#define PCIE_ATU_TYPE_CFG0		(0x4 << 0)
-#define PCIE_ATU_TYPE_CFG1		(0x5 << 0)
+#define PCIE_ATU_TYPE_MEM		0x0
+#define PCIE_ATU_TYPE_IO		0x2
+#define PCIE_ATU_TYPE_CFG0		0x4
+#define PCIE_ATU_TYPE_CFG1		0x5
 #define PCIE_ATU_CR2			0x908
 #define PCIE_ATU_ENABLE			BIT(31)
 #define PCIE_ATU_BAR_MODE_ENABLE	BIT(30)
-- 
2.20.1

