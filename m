Return-Path: <SRS0=Vy8e=QE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDF8C282C8
	for <linux-pci@archiver.kernel.org>; Mon, 28 Jan 2019 17:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8E452177B
	for <linux-pci@archiver.kernel.org>; Mon, 28 Jan 2019 17:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="Do2gJelx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbfA1RLM (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:11:12 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:44316 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732124AbfA1QJw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Jan 2019 11:09:52 -0500
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 98B735C12C0;
        Mon, 28 Jan 2019 17:09:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1548691790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=JkdRioVK6OjF6/3Sswhw2GXRL+dykv2ZJpvFouV70bE=;
        b=Do2gJelxiiat7+dtdOZlSkEU3Sbrg8m6aRU3t+oNaBrZSO/zw1+xeYTUUBj5l2z+0NOkdZ
        fgejWP+aO++/1y6m2Gziwk5a1Flfpwlai2DIkjeJKv7da6Sf9SKQhqhYBneWf9lpmwtnU4
        q27NkCZgwgQbt3OIiif4AzY2kUIxtqc=
From:   Stefan Agner <stefan@agner.ch>
To:     lorenzo.pieralisi@arm.com
Cc:     l.stach@pengutronix.de, fabio.estevam@nxp.com, linux-imx@nxp.com,
        kernel@pengutronix.de, shawnguo@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH 3/3] PCI: controller: dwc: allow to select i.MX driver for i.MX 7D
Date:   Mon, 28 Jan 2019 17:09:49 +0100
Message-Id: <20190128160949.24731-1-stefan@agner.ch>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The i.MX 6 PCI driver supports the i.MX 7D SoC too. Allow to select
the i.MX PCI driver even if only the i.MX 7D SoC has been selected.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/pci/controller/dwc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 91b0194240a5..aacf3297c197 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -90,7 +90,7 @@ config PCI_EXYNOS
 
 config PCI_IMX6
 	bool "Freescale i.MX6 PCIe controller"
-	depends on SOC_IMX6Q || (ARM && COMPILE_TEST)
+	depends on SOC_IMX6Q || SOC_IMX7D || (ARM && COMPILE_TEST)
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
 
-- 
2.20.1

