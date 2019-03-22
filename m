Return-Path: <SRS0=nTPQ=RZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E944FC10F00
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 02:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B04BA218FC
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 02:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hor5+wYb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfCVCiz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 21 Mar 2019 22:38:55 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35662 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfCVCiz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Mar 2019 22:38:55 -0400
Received: by mail-wr1-f67.google.com with SMTP id w1so697618wrp.2;
        Thu, 21 Mar 2019 19:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/C2GUyzjoOE8MS8c7hA4ndqPfrFVkibkq7593zNFkt0=;
        b=hor5+wYbMKsE7L7RMxr65ry/JCPCYce3tQRhhb5WeXG4o2JGjHcfLz6+kUzZDxdDi9
         jQdGqzQr6436cMDYav3EnGQEYPC/4QH1lPGOv+XMYkmlSR2XejP/lHNRYKiz+YX++LFK
         J0/h2ghpxEyNZSafYno7Tfz2kFFbg7GngW5hGSO52gN1PhQB4sOZzuoM/4TMv0EFYJ0M
         mYDYOJjM8pvZwGRzkQ0c2FEWhuzSyz8pDJbjaSDN3WzioOwciCvONlk4Pee+/y6tEtuc
         DB2dxjX2ILTttJyWDZHhHpGuGnuqkD9ZWPRO/RRThl/r2krGUm349ovYZKeUPbrmR5T8
         6o4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/C2GUyzjoOE8MS8c7hA4ndqPfrFVkibkq7593zNFkt0=;
        b=DMvNqrYsBS+F8lUZdmK7jt6ZrHfbhciReasvJs9Fm8UzuvcT7eTQTfhrAcc+XitYFx
         +y+SBCU6WBEva0ecMnnjYboxyXMddML0Wwf4LvmpOIeDQjNZpLAqyPJhtZl1wXxLm/iM
         8/yDynMIQ+QbC1rYlT2lbCGZsX9b65gbdx7Hx3m1hafyHix776O1M5rt3CMohWHmNQ10
         DCXColNQWMlEg5Re8og0s7I+ZVPyYperZDKUndNA2ruwQf3xFhhyJjwcyyXAX17VDa4A
         S0MgFTbxlY3BL2gyFEuunWqB7EscPnwG9IIsu/EEx5tDml7E5qhasEQtRZqNo68dr3uU
         SQdw==
X-Gm-Message-State: APjAAAUJ4I+SlILDl2PYZMe5BzZeh34XmMvlYZzHPjo+Q5ghiIGIJVbI
        HI/6ugr7SfcewWyS+vf0fxoXDL7p
X-Google-Smtp-Source: APXvYqy28wYvlIqKujm8R9bm4z9xKHxdKTVqtbi9Yusc5ofBofJ3DAA6uO5xipCKDq9sTUB4+jL0jA==
X-Received: by 2002:adf:fc0b:: with SMTP id i11mr4706574wrr.145.1553222332770;
        Thu, 21 Mar 2019 19:38:52 -0700 (PDT)
Received: from kurokawa.lan (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id w18sm10432692wru.24.2019.03.21.19.38.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 19:38:51 -0700 (PDT)
From:   marek.vasut@gmail.com
To:     linux-pci@vger.kernel.org
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH V2 3/6] PCI: rcar: Replace various variable types with unsigned ones for register values
Date:   Fri, 22 Mar 2019 03:38:41 +0100
Message-Id: <20190322023844.18574-3-marek.vasut@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190322023844.18574-1-marek.vasut@gmail.com>
References: <20190322023844.18574-1-marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Marek Vasut <marek.vasut+renesas@gmail.com>

Replace various variable types with u32 or unsigned int type for
variables holding register values, since the registers are 32bit.
Note that rcar_pcie_msi_irq() still uses various variable types
because both find_first_bit() and __fls() require various variable
types as an argument.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc@vger.kernel.org
To: linux-pci@vger.kernel.org
---
V2: - s@unsigned long@various variable types@ in the commit message
    - Replace int with unsigned int for the $shift variable
    - Replace int with unsigned int / u32 in rcar_pcie_config_access()
---
 drivers/pci/controller/pcie-rcar.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
index 1408c8aa758b..66599e0c4bb4 100644
--- a/drivers/pci/controller/pcie-rcar.c
+++ b/drivers/pci/controller/pcie-rcar.c
@@ -169,7 +169,7 @@ enum {
 
 static void rcar_rmw32(struct rcar_pcie *pcie, int where, u32 mask, u32 data)
 {
-	int shift = 8 * (where & 3);
+	unsigned int shift = 8 * (where & 3);
 	u32 val = rcar_pci_read_reg(pcie, where & ~3);
 
 	val &= ~(mask << shift);
@@ -179,7 +179,7 @@ static void rcar_rmw32(struct rcar_pcie *pcie, int where, u32 mask, u32 data)
 
 static u32 rcar_read_conf(struct rcar_pcie *pcie, int where)
 {
-	int shift = 8 * (where & 3);
+	unsigned int shift = 8 * (where & 3);
 	u32 val = rcar_pci_read_reg(pcie, where & ~3);
 
 	return val >> shift;
@@ -190,7 +190,8 @@ static int rcar_pcie_config_access(struct rcar_pcie *pcie,
 		unsigned char access_type, struct pci_bus *bus,
 		unsigned int devfn, int where, u32 *data)
 {
-	int dev, func, reg, index;
+	unsigned int dev, func, index;
+	u32 reg;
 
 	dev = PCI_SLOT(devfn);
 	func = PCI_FUNC(devfn);
@@ -294,8 +295,8 @@ static int rcar_pcie_write_conf(struct pci_bus *bus, unsigned int devfn,
 				int where, int size, u32 val)
 {
 	struct rcar_pcie *pcie = bus->sysdata;
-	int shift, ret;
-	u32 data;
+	int ret;
+	u32 shift, data;
 
 	ret = rcar_pcie_config_access(pcie, RCAR_PCI_ACCESS_READ,
 				      bus, devfn, where, &data);
@@ -508,7 +509,7 @@ static void phy_write_reg(struct rcar_pcie *pcie,
 				 unsigned int rate, unsigned int addr,
 				 unsigned int lane, unsigned int data)
 {
-	unsigned long phyaddr;
+	u32 phyaddr;
 
 	phyaddr = WRITE_CMD |
 		((rate & 1) << RATE_POS) |
@@ -1116,7 +1117,7 @@ static int rcar_pcie_probe(struct platform_device *pdev)
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

