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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E789C4360F
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 02:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D855206C0
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 02:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kK4SQ0h1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfCVCjA (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 21 Mar 2019 22:39:00 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38620 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727404AbfCVCjA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Mar 2019 22:39:00 -0400
Received: by mail-wm1-f67.google.com with SMTP id a188so661609wmf.3;
        Thu, 21 Mar 2019 19:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6OuZ5lf2dx/eKeJVs4puZI0qRZx8tWmj1dHNl/FZeMg=;
        b=kK4SQ0h1nR6U2k3uqdBLmYOlfVsRmeF9kQ1h9n0vrDSUTfz4XNi0/OB3NkSpHiidTT
         YqXsZVdQaqwmDKvUL9Gf8MrJyRs+mhNtyUWOwG6LX8nMMqsO0lLGSPQObnZBwhZ6Oioq
         zA0KSUlDejLgX5vQGOfUA30HXJ4lfmv4qMnQZil/iGjOUYu7/0T3C5bZy7Xgf7L9G+Rl
         3c/JowBlDxLcAiekzCzl+fXzPOqVRns09y+1sAbSNJa4zWXDOAv4hKGXc63l/C8tQRfV
         cX0osuThL4TmQxaHUhhaMyPuQwQp3GoE9CEBHrdDOIJajivA92GB3x/QrPRuvCNjIrHj
         yg+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6OuZ5lf2dx/eKeJVs4puZI0qRZx8tWmj1dHNl/FZeMg=;
        b=ZYUnZPahdCUhymURReglI9FZTK6URSLEB3DVdhK8VJDIN55qRAOBuKoD2evBSKaFxe
         +tUZBFrwOIrSuyxqypQJf6PtRbjse6TFC6BCk49aEMty+4az0UpL/km79IV04Yt+jeGd
         V/dwMakX4BIxHf+QKa3fpofoiCjAW4jSn7V9lLA7PLVfcJ2WATN3XsmoCKsvj7OwikWy
         AkXl/7+zzf+wSB1xvQ0kLusNkwEKxGhYqrWCbrLX7XnYcKcbuRRFBKNzJOfYlkYF8NlC
         zbFoPNjbrOM53QnbQ6IInUDG96YEM0jHReqiAS3FpLsioSJPqpCB0MHwroVW3HXqcmNw
         ZTPQ==
X-Gm-Message-State: APjAAAUkHTLEjK0BVZzywJJfVNmPA5iIBsZwAU8/MA62HGR3OO5WQx4w
        KIBqAtnQlUCUR6ackU7BcvoNB9sL
X-Google-Smtp-Source: APXvYqwMMKC3QoN5klpbxAqsXYtEpSQ+Ynp/WmyOuVz18IgEMAwFJLREgCwwDZpgw0mti/P0xWVNeQ==
X-Received: by 2002:a1c:7dcc:: with SMTP id y195mr1294604wmc.13.1553222337851;
        Thu, 21 Mar 2019 19:38:57 -0700 (PDT)
Received: from kurokawa.lan (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id w18sm10432692wru.24.2019.03.21.19.38.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 19:38:56 -0700 (PDT)
From:   marek.vasut@gmail.com
To:     linux-pci@vger.kernel.org
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH V2 6/6] PCI: rcar: Allow 64bit MSI addresses
Date:   Fri, 22 Mar 2019 03:38:44 +0100
Message-Id: <20190322023844.18574-6-marek.vasut@gmail.com>
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

The MSI address can be 64bit. Switch the data type used to hold the
result of virt_to_phys() to phys_addr_t to reflect its properties
correctly and program the top 32bits of PA into PCIEMSIAUR.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc@vger.kernel.org
To: linux-pci@vger.kernel.org
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
V2: - s/it's/its/ in commit message
    - Add R-B from Geert
---
 drivers/pci/controller/pcie-rcar.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
index 989b7b73ed61..75ac83f21035 100644
--- a/drivers/pci/controller/pcie-rcar.c
+++ b/drivers/pci/controller/pcie-rcar.c
@@ -889,7 +889,7 @@ static int rcar_pcie_enable_msi(struct rcar_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
 	struct rcar_msi *msi = &pcie->msi;
-	unsigned long base;
+	phys_addr_t base;
 	int err, i;
 
 	mutex_init(&msi->lock);
@@ -931,7 +931,7 @@ static int rcar_pcie_enable_msi(struct rcar_pcie *pcie)
 	base = virt_to_phys((void *)msi->pages);
 
 	rcar_pci_write_reg(pcie, base | MSIFE, PCIEMSIALR);
-	rcar_pci_write_reg(pcie, 0, PCIEMSIAUR);
+	rcar_pci_write_reg(pcie, base >> 32, PCIEMSIAUR);
 
 	/* enable all MSI interrupts */
 	rcar_pci_write_reg(pcie, 0xffffffff, PCIEMSIIER);
-- 
2.20.1

