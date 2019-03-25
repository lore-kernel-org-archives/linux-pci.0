Return-Path: <SRS0=Cb4Y=R4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72F2C4360F
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 11:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2EB52085A
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 11:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDaV34AO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730730AbfCYLlU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 07:41:20 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37028 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730642AbfCYLlT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Mar 2019 07:41:19 -0400
Received: by mail-wr1-f67.google.com with SMTP id w10so9734380wrm.4;
        Mon, 25 Mar 2019 04:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jrsZfqcuFEIrJ4PDQ+vRhsUOUsRk2lnr6xeyB9N9o58=;
        b=dDaV34AO2yWVaLNu5EStEpnpkFiyqyBQOsfBGkJNklX2MGh4krafX58/RBm8talsQ9
         mihDqEmG3ANJmFqOALSqONPeLIT5I+8KEFQi0Dgx8hl+pPAhIYAXZu7Q434yVth9sH+d
         0AcN6bFy6aPqnCQ20qNW7Q+FXjD5ZzMRAxStIE1NTprMo5JpkB/8m3v0GZdl48qp6C8x
         hflrdlgBfk4k9lAw87ZMMC8VhwNa6dipYP6ygbgScbkbD7VPpaMpYUwMvmaMdo7lEa7u
         Gmok/R9XBj820QJzjRxMRfuGhtxFNBnR6yeZPGpLyQ+457w0eTV9W3wgALa32+rK7/HX
         7ttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jrsZfqcuFEIrJ4PDQ+vRhsUOUsRk2lnr6xeyB9N9o58=;
        b=FINZUugvFUisaUvDJiE6Nw3t/K5lYNbuGr4pmKgccnPS9p+gpr6fGqjBu9O7zUFCBc
         qFwZEK5j4DetdbQUhQ1tbeLqMOdPpeU+qCeTL2o5RZa5u2m+X2k7kYaj88Ru/1q6bOSx
         1gbEi/04srs+dHsxOBEWxGfVm5E+71s7V5Fy2jGS8W9CTheSVHRYROaS0EABdSli8DHQ
         cpFJCrGNDSEt6jUKzB9RWdrt1DEKXAUxS+cf/N1q9Xyr+2bsxl5HNfxtdOeR4jWQma/n
         4TZStl5tUbo0UlICkMki2NEOoSsdTek7zPNI0zLxalfmhjVu0sI79GzX+dilTD6qiSc5
         lwhQ==
X-Gm-Message-State: APjAAAUv+i+y1YB1bytcDfWZbvA93y0IWNJRBFU4org72F9U2h4I3Fbf
        5Q54Y3acPWezTgT1FJz65RzRBO4K
X-Google-Smtp-Source: APXvYqwVW+rP9dCMTK4hSYl51+TLfUahaLuf/AeS8f0sw21wvUUWxN+vfIvp+YfHDEknllamZjGEQQ==
X-Received: by 2002:a05:6000:1286:: with SMTP id f6mr15271820wrx.93.1553514077692;
        Mon, 25 Mar 2019 04:41:17 -0700 (PDT)
Received: from kurokawa.lan (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id f1sm3905730wrt.87.2019.03.25.04.41.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 04:41:16 -0700 (PDT)
From:   marek.vasut@gmail.com
To:     linux-pci@vger.kernel.org
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH V4 3/6] PCI: rcar: Replace various variable types with unsigned ones for register values
Date:   Mon, 25 Mar 2019 12:40:58 +0100
Message-Id: <20190325114101.10198-3-marek.vasut@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190325114101.10198-1-marek.vasut@gmail.com>
References: <20190325114101.10198-1-marek.vasut@gmail.com>
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
---
 drivers/pci/controller/pcie-rcar.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
index 3db693b4410e..6699211fdc9a 100644
--- a/drivers/pci/controller/pcie-rcar.c
+++ b/drivers/pci/controller/pcie-rcar.c
@@ -170,7 +170,7 @@ enum {
 
 static void rcar_rmw32(struct rcar_pcie *pcie, int where, u32 mask, u32 data)
 {
-	int shift = 8 * (where & 3);
+	unsigned int shift = 8 * (where & 3);
 	u32 val = rcar_pci_read_reg(pcie, where & ~3);
 
 	val &= ~(mask << shift);
@@ -180,7 +180,7 @@ static void rcar_rmw32(struct rcar_pcie *pcie, int where, u32 mask, u32 data)
 
 static u32 rcar_read_conf(struct rcar_pcie *pcie, int where)
 {
-	int shift = 8 * (where & 3);
+	unsigned int shift = 8 * (where & 3);
 	u32 val = rcar_pci_read_reg(pcie, where & ~3);
 
 	return val >> shift;
@@ -191,7 +191,7 @@ static int rcar_pcie_config_access(struct rcar_pcie *pcie,
 		unsigned char access_type, struct pci_bus *bus,
 		unsigned int devfn, int where, u32 *data)
 {
-	int dev, func, reg, index;
+	unsigned int dev, func, reg, index;
 
 	dev = PCI_SLOT(devfn);
 	func = PCI_FUNC(devfn);
@@ -295,8 +295,9 @@ static int rcar_pcie_write_conf(struct pci_bus *bus, unsigned int devfn,
 				int where, int size, u32 val)
 {
 	struct rcar_pcie *pcie = bus->sysdata;
-	int shift, ret;
+	unsigned int shift;
 	u32 data;
+	int ret;
 
 	ret = rcar_pcie_config_access(pcie, RCAR_PCI_ACCESS_READ,
 				      bus, devfn, where, &data);
@@ -506,10 +507,10 @@ static int phy_wait_for_ack(struct rcar_pcie *pcie)
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
@@ -1117,7 +1118,7 @@ static int rcar_pcie_probe(struct platform_device *pdev)
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

