Return-Path: <SRS0=okY7=QN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A1BDC169C4
	for <linux-pci@archiver.kernel.org>; Wed,  6 Feb 2019 09:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CBAE218A3
	for <linux-pci@archiver.kernel.org>; Wed,  6 Feb 2019 09:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="FPZQ8ykA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbfBFJ4F (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 6 Feb 2019 04:56:05 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:40732 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbfBFJ4E (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Feb 2019 04:56:04 -0500
Received: from zyt.lan (unknown [IPv6:2a02:169:34b6::564])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id B1C485C145A;
        Wed,  6 Feb 2019 10:56:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1549446962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N9XWwfEulsFK9VHuxbs2IvRFKykUhnv9rn+Qndj3W+U=;
        b=FPZQ8ykAscZ1Md/ysJFslnfmnphUv+0B8YQJ1mgnoOgFV3w30i4L8gtefE6fOKYPdKTeqB
        fLndSNXMBLxi22G9zqZTzJbNpygGyLMXpdVKBEomsKChPI6+rvMFOlPkS5ULI6AS4UU1LS
        X1TSdZit6bnGv5d5zasFdK32+ufJXmU=
From:   Stefan Agner <stefan@agner.ch>
To:     lorenzo.pieralisi@arm.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, l.stach@pengutronix.de,
        tpiepho@impinj.com
Cc:     leonard.crestez@nxp.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        stefan@agner.ch
Subject: [PATCH 2/2] PCI: imx6: limit DBI register length
Date:   Wed,  6 Feb 2019 10:57:32 +0100
Message-Id: <119211b4f2e9ada55b86041d009656e49c2b5281.1549446867.git.stefan@agner.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <14fafdf52d19feb9c926c312f4e3ba7ff8a4bad9.1549446867.git.stefan@agner.ch>
References: <14fafdf52d19feb9c926c312f4e3ba7ff8a4bad9.1549446867.git.stefan@agner.ch>
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
Changes in v5:
- Rebased ontop of pci/dwc
- Use DBI length of 0x200

 drivers/pci/controller/dwc/pci-imx6.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index c1d434ba3642..1ef7be1232f3 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -55,6 +55,7 @@ enum imx6_pcie_variants {
 struct imx6_pcie_drvdata {
 	enum imx6_pcie_variants variant;
 	u32 flags;
+	int dbi_length;
 };
 
 struct imx6_pcie {
@@ -1087,6 +1088,8 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 		break;
 	}
 
+	pci->dbi_length = imx6_pcie->drvdata->dbi_length;
+
 	/* Grab turnoff reset */
 	imx6_pcie->turnoff_reset = devm_reset_control_get_optional_exclusive(dev, "turnoff");
 	if (IS_ERR(imx6_pcie->turnoff_reset)) {
@@ -1170,6 +1173,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.variant = IMX6Q,
 		.flags = IMX6_PCIE_FLAG_IMX6_PHY |
 			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE,
+		.dbi_length = 0x200,
 	},
 	[IMX6SX] = {
 		.variant = IMX6SX,
-- 
2.20.1

