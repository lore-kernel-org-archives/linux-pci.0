Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A78C18DF5
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 13:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F156A206BB
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 13:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="0GHyHRpN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F156A206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbeKTX4T (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 18:56:19 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:47292 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727536AbeKTX4T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Nov 2018 18:56:19 -0500
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id A83235C2673;
        Tue, 20 Nov 2018 14:27:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1542720429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K7rDdsRBxzLSxyHmL1i9ojUubg1idCe5WOAmjcZYgLw=;
        b=0GHyHRpNCj1WLOCzvICmmsO3eKN9j6BssqU6E8uomUgJKVqi3yMu8+UngiAFGqNIYj1yDg
        kmeMEkRzP/kHCZRZ72THjfFb3gS4w+tMmg67cOFQMFI52KZw6pFrGjI5SVulTZhULr5gVy
        1Mj6G8NrqJnj6dlUrXoPilouz9CricU=
From:   Stefan Agner <stefan@agner.ch>
To:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        l.stach@pengutronix.de, tpiepho@impinj.com
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
Subject: [PATCH v2 3/3] PCI: imx6: limit DBI register length
Date:   Tue, 20 Nov 2018 14:27:05 +0100
Message-Id: <20181120132705.6917-3-stefan@agner.ch>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181120132705.6917-1-stefan@agner.ch>
References: <20181120132705.6917-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Define the length of the DBI registers. This makes sure that
the kernel does not access registers beyond that point, avoiding
the following abort on a i.MX 6Quad:
  # cat /sys/devices/soc0/soc/1ffc000.pcie/pci0000\:00/0000\:00\:00.0/config
  [  100.021433] Unhandled fault: imprecise external abort (0x1406) at 0xb6ea7000
  ...
  [  100.056423] PC is at dw_pcie_read+0x50/0x84
  [  100.060790] LR is at dw_pcie_rd_own_conf+0x44/0x48
  ...

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/pci/controller/dwc/pci-imx6.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 7ac1a639fe91..41d6127b40ad 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -41,6 +41,7 @@ enum imx6_pcie_variants {
 
 struct imx6_pcie_drvdata {
 	enum imx6_pcie_variants variant;
+	int			dbi_length;
 };
 
 struct imx6_pcie {
@@ -779,6 +780,8 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 		break;
 	}
 
+	pci->dbi_length = imx6_pcie->drvdata->dbi_length;
+
 	/* Grab GPR config register range */
 	imx6_pcie->iomuxc_gpr =
 		 syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
@@ -839,7 +842,7 @@ static void imx6_pcie_shutdown(struct platform_device *pdev)
 }
 
 static const struct imx6_pcie_drvdata drvdata[] = {
-	[IMX6Q] = { .variant = IMX6Q },
+	[IMX6Q] = { .variant = IMX6Q, .dbi_length = 0x15c },
 	[IMX6SX] = { .variant = IMX6SX },
 	[IMX6QP] = { .variant = IMX6QP },
 	[IMX7D] = { .variant = IMX7D },
-- 
2.19.1

