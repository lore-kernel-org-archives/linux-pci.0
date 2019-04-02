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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B577CC10F05
	for <linux-pci@archiver.kernel.org>; Tue,  2 Apr 2019 01:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 806BD20857
	for <linux-pci@archiver.kernel.org>; Tue,  2 Apr 2019 01:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmxO6cAE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbfDBBd0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Apr 2019 21:33:26 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42726 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbfDBBdZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Apr 2019 21:33:25 -0400
Received: by mail-pf1-f193.google.com with SMTP id r15so5462213pfn.9;
        Mon, 01 Apr 2019 18:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=217mzBCBjhWvy1vQNChNd0vWeqQUpouuzIzh0WcsAXg=;
        b=GmxO6cAEY2REwB8GpSN3QRdGX5ve9f5ZLbH6tCZmlL7iWrUWHO/dd20dL60p6jKdy5
         OTMQ1FwVRB/53+B4JU91+PuT+iSsIDGXyh4nCo4r2oRtcj6QSJdZSmzdMYRRiVZiGrok
         fe2R5nAdNSR/oMCEyYQtfmt/h2JFUWCc9zK8vVb3mOhyEICG4wXpI3NDtWDNTv2/Dd2l
         mYTjwH3fRJ4DcvlcV4ZlTDaS8C+SI/rNI0BMURZ8ZiOZWGxK3yemWPZet8MOCDdL41Do
         2A2/qPVNmUqT2TLkwWzL2y6K8ApIcFifo7MW51Yhu9pPVf5K+gzeLuI5ymeezBEu5g9b
         DIxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=217mzBCBjhWvy1vQNChNd0vWeqQUpouuzIzh0WcsAXg=;
        b=k40opZks762paNsqBx+dg3xlhUHSJPI5tntFuC0aodto60Yy9ssl6Kr1k/XIk6BngG
         HINTthVO4OUlUUbpyeRhrgduRvJNo/MJ5XBbj448uT9W8mpOTpFUdp+AmtklaljOeXCJ
         w/elIdZEVMmacSX2lts5xNtvRAsuq0FHYnOmS/v7ChoB9kRwbG6GqvvZ55hvOPDmn8u/
         LCyDTQVWUIiUliPCFZTlZel/RtASyKenRop/bMrW6/7V2DM2EcUO9KH5bgEeGg/qwpW+
         T4TA6wBocz4cR5q7qIvwP7FhWj/y6r19xtVwtVW59nGVYXl5vtt7TWTyYYOtPoyPb2ge
         kw6w==
X-Gm-Message-State: APjAAAXfYHcACR510AOItxOfBgpMdgt+QCE/FYcMjKGd3zfdlUJV3Hzk
        dsMTnhsM41nSgy8zjmzKd5Ej0RAT
X-Google-Smtp-Source: APXvYqwhLvqUwkgWFGU5xzmDkSDmzFkaSHW5tdSDGLSwabEgR5lX0A1BzsznGfw4uL+Upqx2I0gMYw==
X-Received: by 2002:a62:4e86:: with SMTP id c128mr42499851pfb.39.1554168804695;
        Mon, 01 Apr 2019 18:33:24 -0700 (PDT)
Received: from localhost.localdomain ([1.1.125.76])
        by smtp.gmail.com with ESMTPSA id q86sm27912247pfi.171.2019.04.01.18.33.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 18:33:23 -0700 (PDT)
From:   marek.vasut@gmail.com
To:     linux-pci@vger.kernel.org
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH V5 2/6] PCI: rcar: Replace unsigned long with u32/unsigned int in register accessors
Date:   Tue,  2 Apr 2019 03:33:03 +0200
Message-Id: <20190402013307.20912-2-marek.vasut@gmail.com>
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

Replace unsigned long with u32 and unsigned int in register accessor
functions, since they access 32bit registers.

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
V4: Change reg to unsigned int
V5: Rebase on next/master 20190401
---
 drivers/pci/controller/pcie-rcar.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
index 542b5bbf4bf1..317f688b1fd2 100644
--- a/drivers/pci/controller/pcie-rcar.c
+++ b/drivers/pci/controller/pcie-rcar.c
@@ -154,14 +154,13 @@ struct rcar_pcie {
 	struct			rcar_msi msi;
 };
 
-static void rcar_pci_write_reg(struct rcar_pcie *pcie, unsigned long val,
-			       unsigned long reg)
+static void rcar_pci_write_reg(struct rcar_pcie *pcie, u32 val,
+			       unsigned int reg)
 {
 	writel(val, pcie->base + reg);
 }
 
-static unsigned long rcar_pci_read_reg(struct rcar_pcie *pcie,
-				       unsigned long reg)
+static u32 rcar_pci_read_reg(struct rcar_pcie *pcie, unsigned int reg)
 {
 	return readl(pcie->base + reg);
 }
-- 
2.20.1

