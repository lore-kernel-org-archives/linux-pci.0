Return-Path: <SRS0=cvZd=QJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B73C282D8
	for <linux-pci@archiver.kernel.org>; Sat,  2 Feb 2019 00:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38EE121872
	for <linux-pci@archiver.kernel.org>; Sat,  2 Feb 2019 00:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgeDSQ4r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbfBBAP4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 1 Feb 2019 19:15:56 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44081 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbfBBAPj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Feb 2019 19:15:39 -0500
Received: by mail-pg1-f195.google.com with SMTP id t13so3672261pgr.11;
        Fri, 01 Feb 2019 16:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vv1JQ0JPb3zW29ME2GUJIKxPfKCAiMhdwxKiy7ndpT8=;
        b=dgeDSQ4rWvfeG7g3fUWqqHd6u5Yej8odwIm8hCWQ8GpG/g3pb6MJoDugAmCrpg2XKC
         dMOn6z1EGoaoxJJWYyeyHoulgjI5ws1Jx6Ol2jFn/V5m3PirBP7AGuPrvZ13NrdmTzsq
         VRS9lkF0wXJoPejN+SyR8GxNwrECdfNMLu20A19BySdmruSSViNzKM7KggpUxO33+FjA
         9+ptU2wkSmfw4kEbcYnRfRbUhhBXiQaO3wW2zZMioZlcKZ6N+F16TmUWYWroncV32Tcj
         GOSkKpkCW+G5p/+7tSdSITF0d3FoiFyFDZXPnO2vKZe6ZCO6FuG7SXjW5KcYoLqzICR2
         /Thw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vv1JQ0JPb3zW29ME2GUJIKxPfKCAiMhdwxKiy7ndpT8=;
        b=Dn+YHI5drTNGkdjsdQyqxy2uelnKs8J7gORCoKemwb5hBwHLey8DcnPFSqTVVvvNum
         7J+R1KhscuAV63IiSZL8I5WTJkOaXpSEqG5fqolcudPsQjm/upevAoKZ2KN1er74of7u
         Ltwfl8n3fPO+KiI0ZAAOL4WINzWaY3f6Utd8Ecqhdu7wArKbl4hL5XYaEMNeGMk1DPJp
         44g1j/nJkVsPPlHP8+C+ZDD2X473ZB7ISx3y7ywAy8/YjwwPW99QZHJj3BNHB4XN/WTO
         uGoXKq+BwuJF49g3X/Fd7VDWRp0OmTIIILrvS1nP2rQd/u0WHZ2xNnptnYZWN3ttnAPl
         rmZg==
X-Gm-Message-State: AHQUAubBv183k4OnYCLyGLgw0D/en6XpJ37Hy7jXyJVu9Aa/Mfw5BNqN
        o/u7ei8uhwDa9QNBmdbe3pc=
X-Google-Smtp-Source: AHgI3IbueUOqL5nL2fNRvAN23j3r+E7P753d0IpuIiubkVzEhycMzHGXfKU7QVaUV4v2VqrRfHm+dw==
X-Received: by 2002:a63:68c4:: with SMTP id d187mr1533670pgc.11.1549066538053;
        Fri, 01 Feb 2019 16:15:38 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id w6sm28374545pga.72.2019.02.01.16.15.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 16:15:37 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Trent Piepho <tpiepho@impinj.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v7 2/4] PCI: imx6: Mark PHY functions as i.MX6 specific
Date:   Fri,  1 Feb 2019 16:15:21 -0800
Message-Id: <20190202001523.12517-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190202001523.12517-1-andrew.smirnov@gmail.com>
References: <20190202001523.12517-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCIe PHY IP block on i.MX7D differs from the one used on i.MX6 family,
so none of the code in current implementation of imx6_setup_phy_mpll()
or imx6_pcie_reset_phy() is applicable. Introduce
IMX6_PCIE_FLAG_IMX6_PHY and checks for it to aforementioned functions
to make sure they are only executed on apporpriate PCIe IP variants.

Tested-by: Trent Piepho <tpiepho@impinj.com>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
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
 drivers/pci/controller/dwc/pci-imx6.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 1e940ba7e4c4..26e1e974b0dd 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -41,8 +41,11 @@ enum imx6_pcie_variants {
 	IMX7D,
 };
 
+#define IMX6_PCIE_FLAG_IMX6_PHY			BIT(0)
+
 struct imx6_pcie_drvdata {
 	enum imx6_pcie_variants variant;
+	u32 flags;
 };
 
 struct imx6_pcie {
@@ -255,6 +258,9 @@ static void imx6_pcie_reset_phy(struct imx6_pcie *imx6_pcie)
 {
 	u32 tmp;
 
+	if (!(imx6_pcie->drvdata->flags & IMX6_PCIE_FLAG_IMX6_PHY))
+		return;
+
 	pcie_phy_read(imx6_pcie, PHY_RX_OVRD_IN_LO, &tmp);
 	tmp |= (PHY_RX_OVRD_IN_LO_RX_DATA_EN |
 		PHY_RX_OVRD_IN_LO_RX_PLL_EN);
@@ -572,6 +578,9 @@ static int imx6_setup_phy_mpll(struct imx6_pcie *imx6_pcie)
 	int mult, div;
 	u32 val;
 
+	if (!(imx6_pcie->drvdata->flags & IMX6_PCIE_FLAG_IMX6_PHY))
+		return 0;
+
 	switch (phy_rate) {
 	case 125000000:
 		/*
@@ -1090,12 +1099,15 @@ static void imx6_pcie_shutdown(struct platform_device *pdev)
 static const struct imx6_pcie_drvdata drvdata[] = {
 	[IMX6Q] = {
 		.variant = IMX6Q,
+		.flags = IMX6_PCIE_FLAG_IMX6_PHY,
 	},
 	[IMX6SX] = {
 		.variant = IMX6SX,
+		.flags = IMX6_PCIE_FLAG_IMX6_PHY,
 	},
 	[IMX6QP] = {
 		.variant = IMX6QP,
+		.flags = IMX6_PCIE_FLAG_IMX6_PHY,
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
-- 
2.20.1

