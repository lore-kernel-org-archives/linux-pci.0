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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34140C10F03
	for <linux-pci@archiver.kernel.org>; Sat, 23 Mar 2019 01:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03B1D2087F
	for <linux-pci@archiver.kernel.org>; Sat, 23 Mar 2019 01:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFooEtuT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbfCWByV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 22 Mar 2019 21:54:21 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53904 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728136AbfCWByU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Mar 2019 21:54:20 -0400
Received: by mail-wm1-f66.google.com with SMTP id q16so3785232wmj.3;
        Fri, 22 Mar 2019 18:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M/bqmq1neQ8ZCG+i4HaquxamvGRxXKBsVpujyAjKLpw=;
        b=aFooEtuTjS3Z09mYGyWOCZuV2CBhfaez6yc/EBpodh3QZz0aeJWHPVxvZr3C9h1SKM
         8I6vck3hU+KNpxZoObLe+2klmtHiVGrjxAHAFuV82v2g5fFCZZe/jBlhXTo018LE1sXq
         1P/60hTqEAmx0iyd1YxwCoZ+evOKKMjjhEvORiKK5tZ+bUcqUfD2dxDzL8/otG3whXo4
         BIMNV/xdsA4BG9bRJJaPMiVbegZgiqcleDAGe9aLZDYQhtBLOo/0DAzAh4AQHOiSg77n
         FmgzMe1n4OCMvXeRbJnX3LVbu44jYXhpcGioX9OPIzpv4DgVF6dDiRPRKlUZsyn0pku/
         cA0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M/bqmq1neQ8ZCG+i4HaquxamvGRxXKBsVpujyAjKLpw=;
        b=DJS9nkuTVHM3kcKNFWdOWl9zdnRq0XW4QjoJXggZOEwm0iHioiC9Xt8Btuq+uweKfk
         IfNcbPHAChJC/kdV9T1noU9zf9KaUWHclYBRhnkf3AhRibo7KwrYDiHTDzVprfaM0uQE
         +JxQD6FzcGX2vcA2DunxWjSekp8cAPaD8DsPaUfel3WCoeNdx1rHEWB2A7RIbfq9waOs
         RWhpqgFvbLf+x82uwXjzpxbFTYuI78nlvrVOccY4kY4uRO3T2WB7a56ovTlvW/qmzEEc
         BnIbPqZnXrcetlfHqKzNTI7HqFk6O0htZVFE/KMEZXjQCmQSfjSt/fcplU3O6lTGvJNU
         hP4g==
X-Gm-Message-State: APjAAAXmBtqZm4T3BbbqvHc6qYudSHA7R/4R7oxzFD3Fgbta+1l/zgl0
        DjxcSCTobDkX7OJn0mVNBl7cV5ZO
X-Google-Smtp-Source: APXvYqx6loSxMLcgbNzr/8clkj6pW6s86PyyWHotgUmoMKolAyR63m3ZIQqtKBp/oCSLhbC67s9nnQ==
X-Received: by 2002:a1c:2394:: with SMTP id j142mr4632751wmj.111.1553306058446;
        Fri, 22 Mar 2019 18:54:18 -0700 (PDT)
Received: from kurokawa.lan (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id y192sm25433050wmc.6.2019.03.22.18.54.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 18:54:17 -0700 (PDT)
From:   marek.vasut@gmail.com
To:     linux-pci@vger.kernel.org
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH V3 6/6] PCI: rcar: Fix 64bit MSI message address handling
Date:   Sat, 23 Mar 2019 02:53:59 +0100
Message-Id: <20190323015359.7231-6-marek.vasut@gmail.com>
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

The MSI message address in the RC address space can be 64 bit. The
R-Car PCIe RC supports such a 64bit MSI message address as well.
The code currently uses virt_to_phys(__get_free_pages()) to obtain
a reserved page for the MSI message address, and the return value
of which can be a 64 bit physical address on 64 bit system.

However, the driver only programs PCIEMSIALR register with the bottom
32 bits of the virt_to_phys(__get_free_pages()) return value and does
not program the top 32 bits into PCIEMSIAUR, but rather programs the
PCIEMSIAUR register with 0x0. This worked fine on older 32 bit R-Car
SoCs, however may fail on new 64 bit R-Car SoCs.

Since from a PCIe controller perspective, an inbound MSI is a memory
write to a special address (in case of this controller, defined by
the value in PCIEMSIAUR:PCIEMSIALR), which triggers an interrupt, but
never hits the DRAM _and_ because allocation of an MSI by a PCIe card
driver obtains the MSI message address by reading PCIEMSIAUR:PCIEMSIALR
in rcar_msi_setup_irqs(), incorrectly programmed PCIEMSIAUR cannot
cause memory corruption or other issues.

There is however the possibility that if virt_to_phys(__get_free_pages())
returned address above the 32bit boundary _and_ PCIEMSIAUR was programmed
to 0x0 _and_ if the system had physical RAM at the address matching the
value of PCIEMSIALR, a PCIe card driver could allocate a buffer with a
physical address matching the value of PCIEMSIALR and a remote write to
such a buffer by a PCIe card would trigger a spurious MSI.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc@vger.kernel.org
To: linux-pci@vger.kernel.org
---
V2: - s/it's/its/ in commit message
    - Add R-B from Geert
V3: - Reworded commit message and thus dropped Geerts R-B
---
 drivers/pci/controller/pcie-rcar.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
index 4d9e68ddcdd9..6bedd2167f3c 100644
--- a/drivers/pci/controller/pcie-rcar.c
+++ b/drivers/pci/controller/pcie-rcar.c
@@ -890,7 +890,7 @@ static int rcar_pcie_enable_msi(struct rcar_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
 	struct rcar_msi *msi = &pcie->msi;
-	unsigned long base;
+	phys_addr_t base;
 	int err, i;
 
 	mutex_init(&msi->lock);
@@ -932,7 +932,7 @@ static int rcar_pcie_enable_msi(struct rcar_pcie *pcie)
 	base = virt_to_phys((void *)msi->pages);
 
 	rcar_pci_write_reg(pcie, base | MSIFE, PCIEMSIALR);
-	rcar_pci_write_reg(pcie, 0, PCIEMSIAUR);
+	rcar_pci_write_reg(pcie, base >> 32, PCIEMSIAUR);
 
 	/* enable all MSI interrupts */
 	rcar_pci_write_reg(pcie, 0xffffffff, PCIEMSIIER);
-- 
2.20.1

