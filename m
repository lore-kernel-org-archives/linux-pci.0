Return-Path: <SRS0=Cb4Y=R4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96265C10F03
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 11:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 669A92085A
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 11:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nuW7E2Lf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730749AbfCYLlV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 07:41:21 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43253 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfCYLlV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Mar 2019 07:41:21 -0400
Received: by mail-wr1-f68.google.com with SMTP id k17so1766993wrx.10;
        Mon, 25 Mar 2019 04:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cgr+QFoF4osyfmKyRWjolF8arxagaIcsd3D6Oah1mFM=;
        b=nuW7E2LfesyQnXrfug+FBSfHNcL/90eo+vbEI73BVQ/Ozuaez1FtvD8mozLyfdYNuM
         dBk94l1IE0+jUGLiCaZcq5NykbXMlTrRu48RGZ9lZchv9bRJ3g3MHBzOs0fJfYJrygQ7
         Np5omYno4kAPMF8gqne1Cou9IdS1acxjST0mwZvpWqYUtOnw+6cxnv+PQQMnOXd1sm+L
         qqiCZys1FJDGHeYkii1RUPYfu20EC00tywL1NeMomrdAKaYGRP45JS5BknlYKBUoDT5v
         rV5uaObV8uCTvnPShE6xxmUwXIGgYw8PdnUc2GQrg2bq7tf95tmR8BS299flZELjFpXh
         dt3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cgr+QFoF4osyfmKyRWjolF8arxagaIcsd3D6Oah1mFM=;
        b=SPHP1+SR+G3uPLTBmgM3q1D8Okb5BWekT9OZlPbWaO92ba5SXFDCr9dIvON6X8r3Eu
         C2PdrzOGUSfjdz+UB+ADXdTySS+e+OnMkpXukVNV4AT8ITP/FeA0PQ/sL8xMlfoq87sJ
         5IRvKV0JOnYBMAwR20w7r4SelBgEp0UapbiHbz4pD0gTvtaWRWAJRnV/+F65Nv7GVyfy
         FIqM/jWv4Xaa7x1gQQBdtMVXq/XrhYHKP+daQ8iDPo+5lij9dUbi1Q5q7fVo2WEjp90m
         QxySvAuFvlQ5B57lm5JOeFGyHaN8omvbIiSZTbbRRPJE9AVHjavCvGcdVT1lV5wzRdp1
         azgg==
X-Gm-Message-State: APjAAAWXpu+EyA1k7T7+bNWdgGlwH44P9JThlTa0rmY9uhCcSY/gmjHm
        O0vmKr51155g1iBbrxHCfK+PAlgT
X-Google-Smtp-Source: APXvYqyLV2DYx47Y6xT3kUt03JhcSqQa30oJ3v67sumUcrYZHRvouPA9dY5PJoNd7sWTbCHOAj0ERA==
X-Received: by 2002:adf:ed90:: with SMTP id c16mr14751145wro.74.1553514079067;
        Mon, 25 Mar 2019 04:41:19 -0700 (PDT)
Received: from kurokawa.lan (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id f1sm3905730wrt.87.2019.03.25.04.41.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 04:41:18 -0700 (PDT)
From:   marek.vasut@gmail.com
To:     linux-pci@vger.kernel.org
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH V4 4/6] PCI: rcar: Replace (8 * n) with (BITS_PER_BYTE * n)
Date:   Mon, 25 Mar 2019 12:40:59 +0100
Message-Id: <20190325114101.10198-4-marek.vasut@gmail.com>
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
---
V2: Bundle this patch with other cleanups before resending
V3: Add Wolfram's R-B
V4: Change the patch from n << 3 to BITS_PER_BYTE * n
---
 drivers/pci/controller/pcie-rcar.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
index 6699211fdc9a..96210768e774 100644
--- a/drivers/pci/controller/pcie-rcar.c
+++ b/drivers/pci/controller/pcie-rcar.c
@@ -170,7 +170,7 @@ enum {
 
 static void rcar_rmw32(struct rcar_pcie *pcie, int where, u32 mask, u32 data)
 {
-	unsigned int shift = 8 * (where & 3);
+	unsigned int shift = BITS_PER_BYTE * (where & 3);
 	u32 val = rcar_pci_read_reg(pcie, where & ~3);
 
 	val &= ~(mask << shift);
@@ -180,7 +180,7 @@ static void rcar_rmw32(struct rcar_pcie *pcie, int where, u32 mask, u32 data)
 
 static u32 rcar_read_conf(struct rcar_pcie *pcie, int where)
 {
-	unsigned int shift = 8 * (where & 3);
+	unsigned int shift = BITS_PER_BYTE * (where & 3);
 	u32 val = rcar_pci_read_reg(pcie, where & ~3);
 
 	return val >> shift;
@@ -280,9 +280,9 @@ static int rcar_pcie_read_conf(struct pci_bus *bus, unsigned int devfn,
 	}
 
 	if (size == 1)
-		*val = (*val >> (8 * (where & 3))) & 0xff;
+		*val = (*val >> (BITS_PER_BYTE * (where & 3))) & 0xff;
 	else if (size == 2)
-		*val = (*val >> (8 * (where & 2))) & 0xffff;
+		*val = (*val >> (BITS_PER_BYTE * (where & 2))) & 0xffff;
 
 	dev_dbg(&bus->dev, "pcie-config-read: bus=%3d devfn=0x%04x where=0x%04x size=%d val=0x%08lx\n",
 		bus->number, devfn, where, size, (unsigned long)*val);
@@ -308,11 +308,11 @@ static int rcar_pcie_write_conf(struct pci_bus *bus, unsigned int devfn,
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

