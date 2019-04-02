Return-Path: <SRS0=JkSV=SE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD01C10F05
	for <linux-pci@archiver.kernel.org>; Tue,  2 Apr 2019 01:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B8AA20857
	for <linux-pci@archiver.kernel.org>; Tue,  2 Apr 2019 01:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VypiD682"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfDBBda (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Apr 2019 21:33:30 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41213 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbfDBBd3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Apr 2019 21:33:29 -0400
Received: by mail-pf1-f195.google.com with SMTP id 188so5476355pfd.8;
        Mon, 01 Apr 2019 18:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/b2GPQ7mSz/AeuVi1zGDYx0uWgKKdLfbpSpkOtBQSvI=;
        b=VypiD682Q4gH9uuJuJRNXVhsy8wT6HlUqZ4UY+L2xKFnU4DElwUwoQPuyJFaw+w3Ps
         H9M5bzp8spqlrcLNOz7SXwRixmpfAUwDhc+dbpc9fdgF79RRWJRZ6CT9dRIlTewQUzUz
         g48d83DJgdtXerrPB/x9aEgcV4zD5efaja8X01UY+t838vGzyVjc/T8UJNwogm3WSbmf
         IFK0Iez+zWS+RbnnOGddFZu/MqOnaXmzB5lZeuaJboDQOd4Mzz1nvk2T9Fp8SeYhFJ6K
         mB3gi9w6aWGv5qUeUDSc5yLTZz6dYoGUy08odbLrwcEsjwKAFPaDqcHR6aOlzSvZp7xy
         M2ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/b2GPQ7mSz/AeuVi1zGDYx0uWgKKdLfbpSpkOtBQSvI=;
        b=ulofFya2yorBvofEEvI23S5hVMJTQqbp4Rz9Pt+NOTDBmdyDl/KwzXopEzk7qaVgoi
         teqvPSKuJ9KCJ2RklKOSKEio7PcdBU36ISQABAf6RwNP8NpMd1ULTWFxewxXdAcoLZ9T
         LfXbi+b/BtjGSIRmxrQchJgRTe6iZVVkfus1X56GnEXeH9dwAU4bVnhK6UYnQnt6/Rc+
         Qye7V+QUVaRo5I44wL774kD3m0IiIekqjgUtNgGgu7NzOmMnFv8G36NrR/z2rZJ4jTrg
         4GYBONcHvSbveWMlTIIcFJgV2lOwGcc1r1UpTV5yl2tt+UrbaXg7qYCeIt0bdSDvYI4f
         kNaQ==
X-Gm-Message-State: APjAAAVM1OcO7pr0S0I9hJe1dwBV+IBBRSMULJ2gdEuVKyI2wwQdDY8u
        iYLas+JClYlw9Ayj/amfqC7DWdDR
X-Google-Smtp-Source: APXvYqxUPAiNaJY6inNrH1zirrFtEU6lRCM0gj43pRU4UlRpPfsoZvu/0e1PKp/84Z7h8VXW5WhTgg==
X-Received: by 2002:a63:2045:: with SMTP id r5mr63014457pgm.394.1554168808913;
        Mon, 01 Apr 2019 18:33:28 -0700 (PDT)
Received: from localhost.localdomain ([1.1.125.76])
        by smtp.gmail.com with ESMTPSA id q86sm27912247pfi.171.2019.04.01.18.33.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 18:33:28 -0700 (PDT)
From:   marek.vasut@gmail.com
To:     linux-pci@vger.kernel.org
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH V5 3/6] PCI: rcar: Replace various variable types with unsigned ones for register values
Date:   Tue,  2 Apr 2019 03:33:04 +0200
Message-Id: <20190402013307.20912-3-marek.vasut@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190402013307.20912-1-marek.vasut@gmail.com>
References: <20190402013307.20912-1-marek.vasut@gmail.com>
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
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
V2: - s@unsigned long@various variable types@ in the commit message
    - Replace int with unsigned int for the $shift variable
    - Replace int with unsigned int / u32 in rcar_pcie_config_access()
V3: - Change shift from u32 to unsigned int
    - Change addr and data in phy_write_reg() from unsigned int to u32
V4: - Change reg to unsigned int in rcar_pcie_config_access()
V5: Rebase on next/master 20190401
---
 drivers/pci/controller/pcie-rcar.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
index 317f688b1fd2..9d0e63945842 100644
--- a/drivers/pci/controller/pcie-rcar.c
+++ b/drivers/pci/controller/pcie-rcar.c
@@ -172,7 +172,7 @@ enum {
 
 static void rcar_rmw32(struct rcar_pcie *pcie, int where, u32 mask, u32 data)
 {
-	int shift = 8 * (where & 3);
+	unsigned int shift = 8 * (where & 3);
 	u32 val = rcar_pci_read_reg(pcie, where & ~3);
 
 	val &= ~(mask << shift);
@@ -182,7 +182,7 @@ static void rcar_rmw32(struct rcar_pcie *pcie, int where, u32 mask, u32 data)
 
 static u32 rcar_read_conf(struct rcar_pcie *pcie, int where)
 {
-	int shift = 8 * (where & 3);
+	unsigned int shift = 8 * (where & 3);
 	u32 val = rcar_pci_read_reg(pcie, where & ~3);
 
 	return val >> shift;
@@ -193,7 +193,7 @@ static int rcar_pcie_config_access(struct rcar_pcie *pcie,
 		unsigned char access_type, struct pci_bus *bus,
 		unsigned int devfn, int where, u32 *data)
 {
-	int dev, func, reg, index;
+	unsigned int dev, func, reg, index;
 
 	dev = PCI_SLOT(devfn);
 	func = PCI_FUNC(devfn);
@@ -297,8 +297,9 @@ static int rcar_pcie_write_conf(struct pci_bus *bus, unsigned int devfn,
 				int where, int size, u32 val)
 {
 	struct rcar_pcie *pcie = bus->sysdata;
-	int shift, ret;
+	unsigned int shift;
 	u32 data;
+	int ret;
 
 	ret = rcar_pcie_config_access(pcie, RCAR_PCI_ACCESS_READ,
 				      bus, devfn, where, &data);
@@ -508,10 +509,10 @@ static int phy_wait_for_ack(struct rcar_pcie *pcie)
 }
 
 static void phy_write_reg(struct rcar_pcie *pcie,
-				 unsigned int rate, unsigned int addr,
-				 unsigned int lane, unsigned int data)
+			  unsigned int rate, u32 addr,
+			  unsigned int lane, u32 data)
 {
-	unsigned long phyaddr;
+	u32 phyaddr;
 
 	phyaddr = WRITE_CMD |
 		((rate & 1) << RATE_POS) |
@@ -1119,7 +1120,7 @@ static int rcar_pcie_probe(struct platform_device *pdev)
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

