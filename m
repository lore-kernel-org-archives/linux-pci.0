Return-Path: <SRS0=ngrz=OZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219EAC43387
	for <linux-pci@archiver.kernel.org>; Sun, 16 Dec 2018 23:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D3B2084A
	for <linux-pci@archiver.kernel.org>; Sun, 16 Dec 2018 23:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X672KZFE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731079AbeLPXJn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 16 Dec 2018 18:09:43 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44430 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731020AbeLPXJm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 16 Dec 2018 18:09:42 -0500
Received: by mail-pg1-f195.google.com with SMTP id t13so5163595pgr.11;
        Sun, 16 Dec 2018 15:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=630bTHnJjqwfGqvwds3Arb51H+EGehA9C94eFD613KI=;
        b=X672KZFE92BRla2JFSoPoNeUns+n7a5/84TFppsKFpoG4xa0SgdhWK8AWWfkhMkHUf
         Tj/yPBcGWr89ZoyZLwasu/T1alnt2F4nZCa34sH+suoZOLMbE4oLShOBIRE0MZd7SmoI
         d3IIbxbkRPGH0lEYUtGHcIXPu6Ay95GVWqTaPOdrPA0cF6MpUYNaTNxBNqxOAlUr0Ito
         SkTjXzuzycZI000LslYUSOnZCVjzODqSgL4tuyftG6HyktxtdJlPvqgYTckQeJ4ehaV2
         YgigRSDiq9dzgoKSnZgUP4CM4mBZHoW0K5/f0ZU+NgOm/GiqQP/U9HGZGgyQqJH/HnMS
         kufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=630bTHnJjqwfGqvwds3Arb51H+EGehA9C94eFD613KI=;
        b=aMVbxOskXoNAEN2o9wNYLuzu/NP+WKxiGkZODb6o/4OyLi/AORlq76d3WyFCTtHkpu
         /KWWU9A/znfwpq3jxbuOcBAi06aTj7EXxvoj7er/dJF/Lhdh5Zv558xLPQmza9PpClGj
         a/Jipw5Jzfl8261OyXcgMUtUuYa2OzS6f3ewJQSKDeojVTpzEb+8hpb2ZPfGbSrq+NQ0
         oWSdUZcM43ohm06dZlp7RZA7nfQzBi4rpP6EstCs9sgViTmSEmrVQ7tsCTvCSgsSe04w
         n5rqy36kuizU8AiWUz4ktwyrlfvfCe2MtR8aI3Us73lbS99c79krqS1fpbDz5qil1Uid
         fu7Q==
X-Gm-Message-State: AA+aEWaJ0jdWRki4ggUzj8I8ZEP/AsE5erVOFmn6t66AwhnJBcXvSUs2
        7Vs3pYFZy+ENPpqutHY2YUA=
X-Google-Smtp-Source: AFSGD/UyHsKL9Qn3NP34DOD/KjQSdkrY6aB0QcpgakfwuqCeosmY57w6BcYvSr8IX1U0njnVsENeWw==
X-Received: by 2002:a63:a112:: with SMTP id b18mr10246376pgf.440.1545001781772;
        Sun, 16 Dec 2018 15:09:41 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id d18sm13837878pfj.47.2018.12.16.15.09.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 16 Dec 2018 15:09:40 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH 2/3] PCI: imx6: Invert checks in imx6_pcie_reset_phy() and imx6_setup_phy_mpll()
Date:   Sun, 16 Dec 2018 15:09:15 -0800
Message-Id: <20181216230916.22982-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181216230916.22982-1-andrew.smirnov@gmail.com>
References: <20181216230916.22982-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In order to avoid having potentially ever growing list of variants
that don't support methods implemented in imx6_pcie_reset_phy() and
imx6_setup_phy_mpll(), change logical checks in the to check for SoC's
that _do_ support what they implement. While at it, share the code via
a small helper function.

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
Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 4b7f638b8aff..59658577e81d 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -256,12 +256,18 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
 	return 0;
 }
 
+static bool imx6_pcie_has_imx6_phy(struct imx6_pcie *imx6_pcie)
+{
+	return imx6_pcie->variant == IMX6Q ||
+	       imx6_pcie->variant == IMX6SX ||
+	       imx6_pcie->variant == IMX6QP;
+}
+
 static void imx6_pcie_reset_phy(struct imx6_pcie *imx6_pcie)
 {
 	u32 tmp;
 
-	if (imx6_pcie->variant == IMX7D ||
-	    imx6_pcie->variant == IMX8MQ)
+	if (!imx6_pcie_has_imx6_phy(imx6_pcie))
 		return;
 
 	pcie_phy_read(imx6_pcie, PHY_RX_OVRD_IN_LO, &tmp);
@@ -637,8 +643,7 @@ static int imx6_setup_phy_mpll(struct imx6_pcie *imx6_pcie)
 	int mult, div;
 	u32 val;
 
-	if (imx6_pcie->variant == IMX7D ||
-	    imx6_pcie->variant == IMX8MQ)
+	if (!imx6_pcie_has_imx6_phy(imx6_pcie))
 		return 0;
 
 	switch (phy_rate) {
-- 
2.19.1

