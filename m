Return-Path: <SRS0=Xdj1=O6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8A2C43387
	for <linux-pci@archiver.kernel.org>; Fri, 21 Dec 2018 07:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ED1C21903
	for <linux-pci@archiver.kernel.org>; Fri, 21 Dec 2018 07:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kj97J01v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732394AbeLUH2n (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Dec 2018 02:28:43 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42089 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388220AbeLUH2M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Dec 2018 02:28:12 -0500
Received: by mail-pl1-f195.google.com with SMTP id y1so2098129plp.9;
        Thu, 20 Dec 2018 23:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=os5HCIWWSeiXp86kNFBUOm5Js1nl9fgasgDsX5LPT/Y=;
        b=Kj97J01vYaRO2Tsth4vmAsL09eUm8ZfT+Y1IlvimyYHPKsSNx4cwmrtBkpYQB/pyrY
         L2QtTUlnNmLrAX6TAqZr6yne1yTCd7kLgANDnmAiDbBQ+jDHoohFzgZOxUlnDHv54PDr
         p/0c8okKY+ylW2UNiyjZoYDn0AP/jOhvFNzjPn5SlLTkBMhpXeuShdh29XLKsxy2//6M
         x2UDRXm0qvBnzH1AQz5M7CD4goUCjur5DPjsL2jX1PMz9RAxheMINSdKvTaZpiUJOT3E
         0jBzNJMp0nMuxAbU6/aBF4PL85YI9mSyYL39bKCxPVSI4Th1puQCwHYDr5+7U9jYU7CT
         KdOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=os5HCIWWSeiXp86kNFBUOm5Js1nl9fgasgDsX5LPT/Y=;
        b=NO8vcNdo64O/524uHyDp9Ve8CsLyhZedNJWsV0jRJ6g8ABW5yiyHSMbQJEhEaAjhDg
         YLJ1LchlPjNRNk/+QmiHrHRn8CHGI2vz1zgLyzWkrPFOy0rW2rfqjPfLgz2DGY1QrFzZ
         POZXtZLDyHTKeeNUWPJOne7HksuDBjWAOfRS7KtTAM3soGOBCqwPwsd7cR7KFCvceEC1
         IRKM13f427EDLVOawwKJyPwq88gjS8JTESExLhl2y1B/ZZA/lDBECWqVLiO/w+81HW9Z
         vKSv/RZuVTIbnfGsBi6yNbDZstAbAA76Qy5JITO1qnNJwY1cLPNN9vXZp8Q6TS4zWnTn
         FUGA==
X-Gm-Message-State: AJcUukfACISpaNouh3ZVdQgfbyDAG3kOSlzFTS/ltEvRekmLmZECQJel
        p2iac0jE+hUUk0ZCE/wLVtk9IErs
X-Google-Smtp-Source: ALg8bN4z4ZU5nz72DBY5q8YOvRp5wW78zQBbybW7pRGQW2hcy8aJw7wfTvss0oEMNvtfTdMs0MWtMQ==
X-Received: by 2002:a17:902:d697:: with SMTP id v23mr1388203ply.261.1545377291783;
        Thu, 20 Dec 2018 23:28:11 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id t90sm44971921pfj.23.2018.12.20.23.28.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 23:28:10 -0800 (PST)
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
Subject: [PATCH 17/21] PCI: imx6: Use common mask in imx6_pcie_reset_phy()
Date:   Thu, 20 Dec 2018 23:27:12 -0800
Message-Id: <20181221072716.29017-18-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181221072716.29017-1-andrew.smirnov@gmail.com>
References: <20181221072716.29017-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Simplify imx6_pcie_reset_phy() by using common mask. No functional
change intended.

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
 drivers/pci/controller/dwc/pci-imx6.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index bade9d608605..38c8e8baa077 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -230,18 +230,18 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, u16 data)
 
 static void imx6_pcie_reset_phy(struct imx6_pcie *imx6_pcie)
 {
+	const u16 mask = PHY_RX_OVRD_IN_LO_RX_DATA_EN |
+			 PHY_RX_OVRD_IN_LO_RX_PLL_EN;
 	u16 tmp;
 
 	pcie_phy_read(imx6_pcie, PHY_RX_OVRD_IN_LO, &tmp);
-	tmp |= (PHY_RX_OVRD_IN_LO_RX_DATA_EN |
-		PHY_RX_OVRD_IN_LO_RX_PLL_EN);
+	tmp |= mask;
 	pcie_phy_write(imx6_pcie, PHY_RX_OVRD_IN_LO, tmp);
 
 	usleep_range(2000, 3000);
 
 	pcie_phy_read(imx6_pcie, PHY_RX_OVRD_IN_LO, &tmp);
-	tmp &= ~(PHY_RX_OVRD_IN_LO_RX_DATA_EN |
-		  PHY_RX_OVRD_IN_LO_RX_PLL_EN);
+	tmp &= ~mask;
 	pcie_phy_write(imx6_pcie, PHY_RX_OVRD_IN_LO, tmp);
 }
 
-- 
2.19.1

