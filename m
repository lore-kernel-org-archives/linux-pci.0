Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D44C282CE
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 00:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D3542070D
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 00:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n9Y0RN4P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfDOArb (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 14 Apr 2019 20:47:31 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40504 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbfDOAra (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 14 Apr 2019 20:47:30 -0400
Received: by mail-pg1-f195.google.com with SMTP id d31so7714620pgl.7;
        Sun, 14 Apr 2019 17:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZAdm/vG86hflxhCcEg67tfgVoXjeF3f0FU+ijE2iqzc=;
        b=n9Y0RN4PNgdPwN6k9dTLOVyPbtIQID6vLeQ7waedD1PkU2iBk/RWWcQ6/HA0ra/2de
         tNSlt/OTfCJsuleI/4oRgv/WC9hT9MGOPj8i2UFDKaKeDeWkXMHX7wip8Z9tiyPna9Sa
         ir0ORdUV8xWu2oo3e3oMdSGRflm59HxZZADajkM9v/KcUT6ij6nowO8hUrNXmF+DUjtn
         I3lBVo+2DQv2YY/xu3Fhr5ADFTLRqnxeat+9ej0xdwqnF1P1cvMfB73l5Ndme4mrk50N
         scd0COfvlaIdusz/MgAX0VIL4JnxMlOb/nJ03kQGzVDugDHGpCppUfdja+95Hw8uLyL0
         gojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZAdm/vG86hflxhCcEg67tfgVoXjeF3f0FU+ijE2iqzc=;
        b=JI4PxBx4F34atCEFbCCDmc+L+P/ZjyTCI0iLBck0DbHKtl9nj/u8bXaqVwOECcHJH2
         Zpo5x41IyrWYRqmD5hqG1edxpEWUZ3NfY+jcbNfA5NBU4ZUsLFfuzYzzG9xRorNAe1hg
         nV4evxDCw7llZSNiRhen84Cl7fhERcaGI8LONwsLtbcMHlpIJ8qGAEYxAGXjhRu9S+kZ
         x9Y/d+IbYNmQLaJHhqWJ/DuaI4D8VcTmpRA6vBsy7gFRvLQssM03QWp7ykWHq4HKKx7p
         EiD3OLF/dSBb0CyrSwYqb+f136UbyMFNyM0uVluAA49p3lxyaxnzPe5AkfDVYFUnToEb
         fq6w==
X-Gm-Message-State: APjAAAX5WGYqCkcf2ieZdMC0cPY0js3vvjugecOG7jU7eUlRu1ADpZes
        mFgvGbDcEFqn7OcGcM2tub/tn1Td
X-Google-Smtp-Source: APXvYqzu8CXJA8mDHVcGjK1dWj9/Er/DOXiIXfFhmRes9GcM+ZkEDh9IhgPgUrePDbv52YCYPmhDVw==
X-Received: by 2002:a63:29c8:: with SMTP id p191mr67531444pgp.197.1555289249472;
        Sun, 14 Apr 2019 17:47:29 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id u17sm66111981pfn.19.2019.04.14.17.47.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Apr 2019 17:47:28 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 02/11] PCI: imx6: Drop imx6_pcie_wait_for_link()
Date:   Sun, 14 Apr 2019 17:46:23 -0700
Message-Id: <20190415004632.5907-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190415004632.5907-1-andrew.smirnov@gmail.com>
References: <20190415004632.5907-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

All calls to imx6_pcie_wait_for_link() share the same error path and
the state of PHY debug registers will already be printed there, so
there's no real reason we can't just use dw_pcie_wait_for_link(). Drop
imx6_pcie_wait_for_link() and replace it with dw_pcie_wait_for_link().

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Suggested-by: Lucas Stach <l.stach@pengutronix.de>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/controller/dwc/pci-imx6.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index ea2617712a3b..bb3dcfdbf697 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -723,21 +723,6 @@ static int imx6_setup_phy_mpll(struct imx6_pcie *imx6_pcie)
 	return 0;
 }
 
-static int imx6_pcie_wait_for_link(struct imx6_pcie *imx6_pcie)
-{
-	struct dw_pcie *pci = imx6_pcie->pci;
-	struct device *dev = pci->dev;
-
-	/* check if the link is up or not */
-	if (!dw_pcie_wait_for_link(pci))
-		return 0;
-
-	dev_dbg(dev, "DEBUG_R0: 0x%08x, DEBUG_R1: 0x%08x\n",
-		dw_pcie_readl_dbi(pci, PCIE_PHY_DEBUG_R0),
-		dw_pcie_readl_dbi(pci, PCIE_PHY_DEBUG_R1));
-	return -ETIMEDOUT;
-}
-
 static int imx6_pcie_wait_for_speed_change(struct imx6_pcie *imx6_pcie)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
@@ -796,7 +781,7 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
 	/* Start LTSSM. */
 	imx6_pcie_ltssm_enable(dev);
 
-	ret = imx6_pcie_wait_for_link(imx6_pcie);
+	ret = dw_pcie_wait_for_link(pci);
 	if (ret)
 		goto err_reset_phy;
 
@@ -834,7 +819,7 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
 		}
 
 		/* Make sure link training is finished as well! */
-		ret = imx6_pcie_wait_for_link(imx6_pcie);
+		ret = dw_pcie_wait_for_link(pci);
 		if (ret) {
 			dev_err(dev, "Failed to bring link up!\n");
 			goto err_reset_phy;
-- 
2.20.1

