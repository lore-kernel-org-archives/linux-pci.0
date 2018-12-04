Return-Path: <SRS0=uO3t=ON=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F3DC04EB8
	for <linux-pci@archiver.kernel.org>; Tue,  4 Dec 2018 16:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB0BE20659
	for <linux-pci@archiver.kernel.org>; Tue,  4 Dec 2018 16:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="FhzzqNir"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB0BE20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbeLDQzh (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:55:37 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:36344 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726570AbeLDQzg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Dec 2018 11:55:36 -0500
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 665FF5C1222;
        Tue,  4 Dec 2018 17:55:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1543942534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LhdC4oPsx0c5SbbzIOCXLSzbgGLPbjjL7+nHoArKlYE=;
        b=FhzzqNiru/acAGmljYsC0iWPgAKaSd/UUourb7eS/J4EUjeASLfi+Nvk4F0DZ2UbEXIUxo
        CrJLQ6N76qqjkq9vGbckbDgDd36SeDpu1EBtir/1iEXJv7sQsaZmRxxilzWCup3QJKton8
        fGno7LbDjtLL2patP2MAkXO9hnjag68=
From:   Stefan Agner <stefan@agner.ch>
To:     lorenzo.pieralisi@arm.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, l.stach@pengutronix.de,
        tpiepho@impinj.com
Cc:     leonard.crestez@nxp.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH v4 3/3] PCI: imx6: limit DBI register length
Date:   Tue,  4 Dec 2018 17:55:28 +0100
Message-Id: <20181204165528.15534-3-stefan@agner.ch>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181204165528.15534-1-stefan@agner.ch>
References: <20181204165528.15534-1-stefan@agner.ch>
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
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
---
Changes in v3:
- Rebase on pci/dwc
Changes in v4:
- Rebase on pci/dwc

 drivers/pci/controller/dwc/pci-imx6.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 45cbdf2ccf80..a69eb625ed18 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -43,6 +43,7 @@ enum imx6_pcie_variants {
 
 struct imx6_pcie_drvdata {
 	enum imx6_pcie_variants variant;
+	int			dbi_length;
 };
 
 struct imx6_pcie {
@@ -1015,6 +1016,8 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 		break;
 	}
 
+	pci->dbi_length = imx6_pcie->drvdata->dbi_length;
+
 	/* Grab turnoff reset */
 	imx6_pcie->turnoff_reset = devm_reset_control_get_optional_exclusive(dev, "turnoff");
 	if (IS_ERR(imx6_pcie->turnoff_reset)) {
@@ -1086,7 +1089,7 @@ static void imx6_pcie_shutdown(struct platform_device *pdev)
 }
 
 static const struct imx6_pcie_drvdata drvdata[] = {
-	[IMX6Q] = { .variant = IMX6Q },
+	[IMX6Q] = { .variant = IMX6Q, .dbi_length = 0x15c },
 	[IMX6SX] = { .variant = IMX6SX },
 	[IMX6QP] = { .variant = IMX6QP },
 	[IMX7D] = { .variant = IMX7D },
-- 
2.19.1

