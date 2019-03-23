Return-Path: <SRS0=AkHN=R2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB35C10F03
	for <linux-pci@archiver.kernel.org>; Sat, 23 Mar 2019 01:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B91321873
	for <linux-pci@archiver.kernel.org>; Sat, 23 Mar 2019 01:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gp7d98lZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbfCWByQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 22 Mar 2019 21:54:16 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38522 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728136AbfCWByQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Mar 2019 21:54:16 -0400
Received: by mail-wm1-f65.google.com with SMTP id a188so3787573wmf.3;
        Fri, 22 Mar 2019 18:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UsipTrZgTM1L+6C3Gfamb8/OgpqPLp9z3b+nG60Gxxc=;
        b=Gp7d98lZRO2i90z8s1xUmNjlyLRCMu7knySJ0MbMyew7MboX0Drc7uuL1QsEeCIXih
         PxktEiEzt3AGcIvuR2ylYRuGVne8LIFIw+uC8mEvX7P07SYleSNiebus2zhWYylriLxv
         VNwkIIX9Tsz+tZQ9prkRH5lOo1vN6t4J5100qEgX0ybW4ECJPjnX33l3o1Mylq1iBb2A
         LP7pJnWfl/PX2wfWGfNZOhhWerFbKkbBqgf7vZC/mvrFYLYe5Wge9c0m1OX2VQr1kd/x
         Ot9y0UD+hg0PKDku4j+b91Ypc52gETRFj2FLGDDU9+KJ/VcWSkjLtqu7j3FpMAIkyU1X
         q0Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UsipTrZgTM1L+6C3Gfamb8/OgpqPLp9z3b+nG60Gxxc=;
        b=i5lUXeObmFGrDU8A+FbnObkexZH+6kK4NKp5Zgt0EHJfvGVzh6W8Rpn0HXL5uleZaM
         4KG6RgFniJmpASEFBysCPBSMxmiOeV6diImJqrz3erflhH6hJGLEwkgQ7nSWGcDXdLIM
         ZvhEwGHwOQ2w9hJzV5wfr2ICT+G72qFvPp6szSudGx+OeN1NI70vrkrrG78Tbviwrj2Q
         70zl6gLANnSG9ToqpqzkEbUXouwdnZ2ZK2Ag23heapQhSywTSc6suKhIKW4V5LNIY6pv
         FGx1ZQ3dmJ8vVBcyiiT8Q5RL0XXaJBiJWQ8/OvhqWL8DwGP8Uem8/CcQqoe7tPbb56kj
         dn/w==
X-Gm-Message-State: APjAAAXyN+UmNAZ/ROZEhlxjqOHIEpG6W+qXGR219xUzdvga7NhM4NWC
        CbiqWPNCvr+4Qw79b6knaGpqlBHX
X-Google-Smtp-Source: APXvYqzkrCU11kdrweRz871xGRzGH062sL+QY9xTteUQr5rPyABPp0p1auRu2/GfuYsoA/K8ujRrMg==
X-Received: by 2002:a1c:6c17:: with SMTP id h23mr4643207wmc.122.1553306054121;
        Fri, 22 Mar 2019 18:54:14 -0700 (PDT)
Received: from kurokawa.lan (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id y192sm25433050wmc.6.2019.03.22.18.54.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 18:54:13 -0700 (PDT)
From:   marek.vasut@gmail.com
To:     linux-pci@vger.kernel.org
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH V3 3/6] PCI: rcar: Replace various variable types with unsigned ones for register values
Date:   Sat, 23 Mar 2019 02:53:56 +0100
Message-Id: <20190323015359.7231-3-marek.vasut@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190323015359.7231-1-marek.vasut@gmail.com>
References: <20190323015359.7231-1-marek.vasut@gmail.com>
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
V3: - Change shift from u32 to unsigned int
    - Change addr and data in phy_write_reg() from unsigned int to u32
---
 drivers/pci/controller/pcie-rcar.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
index 1408c8aa758b..a2d3855b15ea 100644
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
@@ -294,8 +295,9 @@ static int rcar_pcie_write_conf(struct pci_bus *bus, unsigned int devfn,
 				int where, int size, u32 val)
 {
 	struct rcar_pcie *pcie = bus->sysdata;
-	int shift, ret;
+	unsigned int shift;
 	u32 data;
+	int ret;
 
 	ret = rcar_pcie_config_access(pcie, RCAR_PCI_ACCESS_READ,
 				      bus, devfn, where, &data);
@@ -505,10 +507,10 @@ static int phy_wait_for_ack(struct rcar_pcie *pcie)
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
@@ -1116,7 +1118,7 @@ static int rcar_pcie_probe(struct platform_device *pdev)
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

