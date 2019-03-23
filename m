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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D3DC43381
	for <linux-pci@archiver.kernel.org>; Sat, 23 Mar 2019 01:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 127CF20883
	for <linux-pci@archiver.kernel.org>; Sat, 23 Mar 2019 01:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAc9PHec"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbfCWByS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 22 Mar 2019 21:54:18 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38231 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728208AbfCWByR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Mar 2019 21:54:17 -0400
Received: by mail-wr1-f67.google.com with SMTP id g12so4205834wrm.5;
        Fri, 22 Mar 2019 18:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hHRXoXedoFz32Oq9DJvcczdt4Z6N3+3d7M9GXrlyl8Y=;
        b=MAc9PHecybfIfu+F2guxsZemYhXIfaDQ3l/E/5IaeACvqQbxP+meJlsZwSq18mG9an
         sQw0mY1i40fDyO1Hv2e5488/s3mSnTezG4fKjMlPxYBzqOgAYg7PlZoUUlUH5REZMb8N
         CgxAG9dleiPZItyFLIDJ5JtlUMaSmMCpLLS0ZxCxU/yQqOo7Ry/QoCWb0wxK+WtOnEye
         6QtYi+t8xKEC/BaVtUc6FxCn3wNbKn2tIWG5rfvgsMbgLjE9LOVPZcp+JK7Scl13am2g
         00cRlolV1UAthkOZybym/j25CsHLv1+HAYOEGHFHJyxsz6gkkPx7vCii5pUGaLt/4kwk
         h0YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hHRXoXedoFz32Oq9DJvcczdt4Z6N3+3d7M9GXrlyl8Y=;
        b=XQm5lIK047mNqFqTT/rGVrsZPN8xoiL0I7XG5qLOPPFjLes9h24edrjkTseKuvjsJc
         Fm7TH1lqQd8sDRerjWUWkI10WBTQusJwYfWMAI9lMo6gLhvCrFJ3VKLdxZ/HEhj/EU8S
         Fm/u9MyQKynTYP0CF+tZBnKw4Wyt/TwKOTg+YJcEASHystbZ1vM5rUzN2ciZqaTmvJHk
         IST4brioZWxg/IHKtaIR5uWIejnYTOefb8/XRvfrZgf/7L62KgO/95I/nnRM1RPkJOgr
         Ld/KqcbAK9Ap/ZrpxVYX+kyN46ZQb4UyqydtOf45zyWgzoh+N0GMJlExvvuW6f15OCA/
         DEjw==
X-Gm-Message-State: APjAAAWkG8qUkSlFVGC9yMkUPulK0pQOi8XPUjNttZMYG8jAOM+kO+Ah
        wPTgi7yxzHB1G1afADqsOCFyg+wi
X-Google-Smtp-Source: APXvYqwZrYb+gU+aKbINElN/4hRcNKDcVEKjHPHSe6FGdCdzCtu0PM05rniKxw+kc0qauMEmsrlEYQ==
X-Received: by 2002:a5d:4a87:: with SMTP id o7mr3826776wrq.306.1553306055524;
        Fri, 22 Mar 2019 18:54:15 -0700 (PDT)
Received: from kurokawa.lan (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id y192sm25433050wmc.6.2019.03.22.18.54.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 18:54:14 -0700 (PDT)
From:   marek.vasut@gmail.com
To:     linux-pci@vger.kernel.org
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH V3 4/6] PCI: rcar: Replace (8 * n) with (n << 3)
Date:   Sat, 23 Mar 2019 02:53:57 +0100
Message-Id: <20190323015359.7231-4-marek.vasut@gmail.com>
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

Replace (8 * n) with (n << 3) to make bit shift operations consistent.
No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc@vger.kernel.org
To: linux-pci@vger.kernel.org
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
V2: Bundle this patch with other cleanups before resending
V3: Add Wolfram's R-B
---
 drivers/pci/controller/pcie-rcar.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
index a2d3855b15ea..f835e4341590 100644
--- a/drivers/pci/controller/pcie-rcar.c
+++ b/drivers/pci/controller/pcie-rcar.c
@@ -169,7 +169,7 @@ enum {
 
 static void rcar_rmw32(struct rcar_pcie *pcie, int where, u32 mask, u32 data)
 {
-	unsigned int shift = 8 * (where & 3);
+	unsigned int shift = (where & 3) << 3;
 	u32 val = rcar_pci_read_reg(pcie, where & ~3);
 
 	val &= ~(mask << shift);
@@ -179,7 +179,7 @@ static void rcar_rmw32(struct rcar_pcie *pcie, int where, u32 mask, u32 data)
 
 static u32 rcar_read_conf(struct rcar_pcie *pcie, int where)
 {
-	unsigned int shift = 8 * (where & 3);
+	unsigned int shift = (where & 3) << 3;
 	u32 val = rcar_pci_read_reg(pcie, where & ~3);
 
 	return val >> shift;
@@ -280,9 +280,9 @@ static int rcar_pcie_read_conf(struct pci_bus *bus, unsigned int devfn,
 	}
 
 	if (size == 1)
-		*val = (*val >> (8 * (where & 3))) & 0xff;
+		*val = (*val >> ((where & 3) << 3)) & 0xff;
 	else if (size == 2)
-		*val = (*val >> (8 * (where & 2))) & 0xffff;
+		*val = (*val >> ((where & 2) << 3)) & 0xffff;
 
 	dev_dbg(&bus->dev, "pcie-config-read: bus=%3d devfn=0x%04x where=0x%04x size=%d val=0x%08lx\n",
 		bus->number, devfn, where, size, (unsigned long)*val);
@@ -308,11 +308,11 @@ static int rcar_pcie_write_conf(struct pci_bus *bus, unsigned int devfn,
 		bus->number, devfn, where, size, (unsigned long)val);
 
 	if (size == 1) {
-		shift = 8 * (where & 3);
+		shift = (where & 3) << 3;
 		data &= ~(0xff << shift);
 		data |= ((val & 0xff) << shift);
 	} else if (size == 2) {
-		shift = 8 * (where & 2);
+		shift = (where & 2) << 3;
 		data &= ~(0xffff << shift);
 		data |= ((val & 0xffff) << shift);
 	} else
-- 
2.20.1

