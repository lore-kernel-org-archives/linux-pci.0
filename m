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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EEB7C10F05
	for <linux-pci@archiver.kernel.org>; Tue,  2 Apr 2019 01:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF3B320857
	for <linux-pci@archiver.kernel.org>; Tue,  2 Apr 2019 01:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qAvcuVjb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbfDBBde (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Apr 2019 21:33:34 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42732 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbfDBBde (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Apr 2019 21:33:34 -0400
Received: by mail-pf1-f193.google.com with SMTP id r15so5462357pfn.9;
        Mon, 01 Apr 2019 18:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4tGhphRrWWaHKd9rE7vscoLmSMMnrsZuw+RjG6zFgas=;
        b=qAvcuVjbHQHqlqr1Ro54+mh4m789guhafFF8myuSnta93A6u0cv2B+zC/YjnKunnh6
         kF7IuAiNN8k/P7v6eC9cEmz4Q2eYH5/YrIbBA6M9q21H3sEnXLgyQ2BUIHXjk923bgNK
         wh1l1qAKQu6BoFEI3Fo1y+wOKRG5hR2SKEF5nLC1CwBhzj5K21X0yxCnV+gEiVf7E85t
         +am8yz+FlFCwmRAV4x62hvOKCoka9T37qTdnZw/DwKzIMtKWA+cu3VRywMVfyRUSwDs9
         6Snr/tDEKubkNG03Y69L7sWhN8Ag3yRwi8y92LpkwPvrGjzqstPlMDStb7G7NYbmjGc6
         wO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4tGhphRrWWaHKd9rE7vscoLmSMMnrsZuw+RjG6zFgas=;
        b=DZfaLl1pzrRVHm5hqpg4y4DprRxhovsVBVd+VCw1sSgMNFvHHhwoogSbnGwTSG/rnw
         jafsYUZPRSwdSl3zdDvChw59R5qF3xv9a5izdclNx3gu7HdTy4vNkqfPMyPWHNUAVEDu
         OM49e6/oyo9nsznpw2FbHeJ2Nskfg9m6BJcaJcXUTejhIDn4vbc1JArSRAT7wuuBt7H4
         K7wperqNKfPFq52oUDHzGIViiEYqg3ZMiIIebivX98wbWPYGBppj2QuRkY4374ew+nIW
         LxGu47A035JFIMXGrbW+hppQYibQeJ07gWooJ/SbCreks+++8TztCTICqW2alo2fRjlS
         A3Xw==
X-Gm-Message-State: APjAAAWoVHVTLDxAyGZHe03Fhstx9sF1xLccE5OF+At0Pi9s0DNoYBIf
        IZEdmiu9rr1eTB1j2v9j83gCcMsd
X-Google-Smtp-Source: APXvYqzI1vXeMYfKTPaXMHy/OzhbiwiegW/sjtIqgQ8PhpumHZKw4V7hXIJQVPdHBlx0MiNkuE/lmg==
X-Received: by 2002:a63:36ce:: with SMTP id d197mr14686088pga.180.1554168812765;
        Mon, 01 Apr 2019 18:33:32 -0700 (PDT)
Received: from localhost.localdomain ([1.1.125.76])
        by smtp.gmail.com with ESMTPSA id q86sm27912247pfi.171.2019.04.01.18.33.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 18:33:32 -0700 (PDT)
From:   marek.vasut@gmail.com
To:     linux-pci@vger.kernel.org
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH V5 4/6] PCI: rcar: Replace (8 * n) with (BITS_PER_BYTE * n)
Date:   Tue,  2 Apr 2019 03:33:05 +0200
Message-Id: <20190402013307.20912-4-marek.vasut@gmail.com>
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

Replace (8 * n) with (BITS_PER_BYTE * n) to make bit shift operations
consistent. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc@vger.kernel.org
To: linux-pci@vger.kernel.org
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
V2: Bundle this patch with other cleanups before resending
V3: Add Wolfram's R-B
V4: Change the patch from n << 3 to BITS_PER_BYTE * n
V5: Rebase on next/master 20190401
---
 drivers/pci/controller/pcie-rcar.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
index 9d0e63945842..d9b8c7cd9fba 100644
--- a/drivers/pci/controller/pcie-rcar.c
+++ b/drivers/pci/controller/pcie-rcar.c
@@ -172,7 +172,7 @@ enum {
 
 static void rcar_rmw32(struct rcar_pcie *pcie, int where, u32 mask, u32 data)
 {
-	unsigned int shift = 8 * (where & 3);
+	unsigned int shift = BITS_PER_BYTE * (where & 3);
 	u32 val = rcar_pci_read_reg(pcie, where & ~3);
 
 	val &= ~(mask << shift);
@@ -182,7 +182,7 @@ static void rcar_rmw32(struct rcar_pcie *pcie, int where, u32 mask, u32 data)
 
 static u32 rcar_read_conf(struct rcar_pcie *pcie, int where)
 {
-	unsigned int shift = 8 * (where & 3);
+	unsigned int shift = BITS_PER_BYTE * (where & 3);
 	u32 val = rcar_pci_read_reg(pcie, where & ~3);
 
 	return val >> shift;
@@ -282,9 +282,9 @@ static int rcar_pcie_read_conf(struct pci_bus *bus, unsigned int devfn,
 	}
 
 	if (size == 1)
-		*val = (*val >> (8 * (where & 3))) & 0xff;
+		*val = (*val >> (BITS_PER_BYTE * (where & 3))) & 0xff;
 	else if (size == 2)
-		*val = (*val >> (8 * (where & 2))) & 0xffff;
+		*val = (*val >> (BITS_PER_BYTE * (where & 2))) & 0xffff;
 
 	dev_dbg(&bus->dev, "pcie-config-read: bus=%3d devfn=0x%04x where=0x%04x size=%d val=0x%08lx\n",
 		bus->number, devfn, where, size, (unsigned long)*val);
@@ -310,11 +310,11 @@ static int rcar_pcie_write_conf(struct pci_bus *bus, unsigned int devfn,
 		bus->number, devfn, where, size, (unsigned long)val);
 
 	if (size == 1) {
-		shift = 8 * (where & 3);
+		shift = BITS_PER_BYTE * (where & 3);
 		data &= ~(0xff << shift);
 		data |= ((val & 0xff) << shift);
 	} else if (size == 2) {
-		shift = 8 * (where & 2);
+		shift = BITS_PER_BYTE * (where & 2);
 		data &= ~(0xffff << shift);
 		data |= ((val & 0xffff) << shift);
 	} else
-- 
2.20.1

