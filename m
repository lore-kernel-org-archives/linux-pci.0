Return-Path: <SRS0=Lify=RU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BCEC10F03
	for <linux-pci@archiver.kernel.org>; Sun, 17 Mar 2019 00:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0BD1218E0
	for <linux-pci@archiver.kernel.org>; Sun, 17 Mar 2019 00:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfTBJJuz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfCQAGW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 16 Mar 2019 20:06:22 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45863 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfCQAGW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Mar 2019 20:06:22 -0400
Received: by mail-wr1-f65.google.com with SMTP id h99so13165994wrh.12;
        Sat, 16 Mar 2019 17:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RE33TNUWm4/0ZBXVkUx6gT3N2Blrm0ry0PL8IYLdT2g=;
        b=JfTBJJuzZROtqv1HYX9v13eyL0LpbL7gV/RD1BvKP0Ua78LCwdD+xJOeghUUsHPrrK
         fq/umzZVw9aCjM3QO8H0CEdAI047kco/LBjToPhwwWGUlUWBojUb0UuzCXEiOcfg3DNL
         yB34FvbTmbZgR/ciAVrY98abWvPQ0pxcnOZadS4tI91+LbdmSPGr+BIc2z5A/1V8tl7a
         qj3itkIrtiJTxfZ9sVvd1haR2NWAj4XGHvc9r/VU++wP++rfRbTcl0HcqMFZewRgVIQ3
         9xa8ckhOdogAAbf8WSOLOc1QtqFEWO70bto7DLNyX8I4OPa/n3WKQF4OFbWJhjiK/ivg
         bTTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RE33TNUWm4/0ZBXVkUx6gT3N2Blrm0ry0PL8IYLdT2g=;
        b=Uu3EphO/jrXgyjCaz5ty1DC1zhTFmK+CHQlZUaM/QAOezUaMb4Y2g8a8/R2lfg6XiG
         hgoKLjtBB2jXas/hB/U2m1STd3vMOf8vVw6T2H6uJlxtFgm4BIGw22JkmsAp/GTa8IOV
         qCcV1okrXYDsc7Jw73IWwxUcocbsvTnxpQC1E214PcUkTEJk1lxl5mVbH1G3mkYKPmMo
         s7yM1pVh6HOrlNyUS/qruKKqMXo0/jUvMxt41AuTjBokLY1CPpXQFbjiQzjQekVK7RRn
         I/IIkEFfvD/SCIxzozsyuJTEi5fSYooSF9b3quutAlQkXPFn6FaDAaD6bstqc+6viFw+
         oDxw==
X-Gm-Message-State: APjAAAUxvLSlgGt2H24lbitOeQy8kDl1zh0TDO+GCHqFC0j+bgkjb5A2
        pXBQG+wzgRFVOtoRcR4HDKWokIW2
X-Google-Smtp-Source: APXvYqxFhzpLvx35aaQN+CoZbEK/jyPeQqS/A+6d8b1tNTPFYy3J3u8BHZdIFBDAoXHeBWv/r8HFqQ==
X-Received: by 2002:a5d:4e46:: with SMTP id r6mr6840110wrt.210.1552781180729;
        Sat, 16 Mar 2019 17:06:20 -0700 (PDT)
Received: from kurokawa.lan (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id b3sm6759016wrx.57.2019.03.16.17.06.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Mar 2019 17:06:19 -0700 (PDT)
From:   marek.vasut@gmail.com
To:     linux-pci@vger.kernel.org
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH 1/3] PCI: rcar: Replace unsigned long with u32 for register values
Date:   Sun, 17 Mar 2019 01:06:06 +0100
Message-Id: <20190317000608.24881-1-marek.vasut@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Marek Vasut <marek.vasut+renesas@gmail.com>

Replace unsigned long with u32 type for variables holding
register values, since the registers are 32bit. Note that
rcar_pcie_msi_irq() still uses unsigned long because both
find_first_bit() and __fls() require unsigned long as an
argument.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc@vger.kernel.org
To: linux-pci@vger.kernel.org
---
 drivers/pci/controller/pcie-rcar.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
index 1408c8aa758b..857d88fd03d5 100644
--- a/drivers/pci/controller/pcie-rcar.c
+++ b/drivers/pci/controller/pcie-rcar.c
@@ -169,7 +169,7 @@ enum {
 
 static void rcar_rmw32(struct rcar_pcie *pcie, int where, u32 mask, u32 data)
 {
-	int shift = 8 * (where & 3);
+	u32 shift = 8 * (where & 3);
 	u32 val = rcar_pci_read_reg(pcie, where & ~3);
 
 	val &= ~(mask << shift);
@@ -179,7 +179,7 @@ static void rcar_rmw32(struct rcar_pcie *pcie, int where, u32 mask, u32 data)
 
 static u32 rcar_read_conf(struct rcar_pcie *pcie, int where)
 {
-	int shift = 8 * (where & 3);
+	u32 shift = 8 * (where & 3);
 	u32 val = rcar_pci_read_reg(pcie, where & ~3);
 
 	return val >> shift;
@@ -190,7 +190,7 @@ static int rcar_pcie_config_access(struct rcar_pcie *pcie,
 		unsigned char access_type, struct pci_bus *bus,
 		unsigned int devfn, int where, u32 *data)
 {
-	int dev, func, reg, index;
+	u32 dev, func, reg, index;
 
 	dev = PCI_SLOT(devfn);
 	func = PCI_FUNC(devfn);
@@ -508,7 +508,7 @@ static void phy_write_reg(struct rcar_pcie *pcie,
 				 unsigned int rate, unsigned int addr,
 				 unsigned int lane, unsigned int data)
 {
-	unsigned long phyaddr;
+	u32 phyaddr;
 
 	phyaddr = WRITE_CMD |
 		((rate & 1) << RATE_POS) |
@@ -1116,7 +1116,7 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct rcar_pcie *pcie;
-	unsigned int data;
+	u32 data;
 	int err;
 	int (*phy_init_fn)(struct rcar_pcie *);
 	struct pci_host_bridge *bridge;
-- 
2.20.1

