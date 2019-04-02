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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9879CC10F05
	for <linux-pci@archiver.kernel.org>; Tue,  2 Apr 2019 01:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6660520857
	for <linux-pci@archiver.kernel.org>; Tue,  2 Apr 2019 01:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3GSkY0d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbfDBBdm (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Apr 2019 21:33:42 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36633 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbfDBBdm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Apr 2019 21:33:42 -0400
Received: by mail-pl1-f194.google.com with SMTP id ck15so4182048plb.3;
        Mon, 01 Apr 2019 18:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JY5xYvCLwwUJvsda8ccnmMiMiuKZ9i5E/Z+FL52T01g=;
        b=m3GSkY0d973a0yQqcjly2/+V1nBDvENMqqsV83T8La7gAdrMSjvIgStoZJsx7obkkR
         9uz6Z2UMZ3fFtCtVlL/xZ05+YzPFMm+CQhvkvkvgkAzTYoCVj05K+LKCUJSvPVojFDKQ
         8A7LIYbaDeE9b6UQTJJ9KOZbitJV4lKOaIUagGjS1RGL5clmxFk87JmXnVM7Yh+G/pKq
         GT9D5T1OP5WZIqw+G+n6XMhWoROAsWfJ0e9VE+85ODg+XRUDkyXbeS3C9+rQYdIEtf/2
         eqkkRP0Wzg1qYUhIbZmdZg1XHobe721lsFkx3W66+Idc1ypcZGec+5o/oXyv/elu3rwZ
         DC4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JY5xYvCLwwUJvsda8ccnmMiMiuKZ9i5E/Z+FL52T01g=;
        b=JLfR/896f2Dp0cNJy0NAs5oEWQxBxhIOm/q5oiyK6XTM1qZKMKZ8WqYy2OGC0e1zVB
         P0CdrN5DKcNJcd5QDlUEgPXr3ubOMx/6QxlhRMEMmaqI4rnN/Q6hiiao01kentktZGUY
         71ts65DdbD8g/A3hCCsq8cobSiI2mL98xZzbUzkIHqlBLpu10D0JAZvuMtLGwrC5ASQz
         xXAm5nTwwSHZwXChlIIjGbTZruLYTtpejCXwZZF+mZcSBoWMux09OwNL/KkXH1svOeMn
         9KABqttRfOv8fGXoJuULLezrX+7mZch0CDPuoyRm1kfBQwG5sQ+CvR5Ef7V2q7zliBlv
         5TeQ==
X-Gm-Message-State: APjAAAVXl0Xpoz4WrKmqXl5EAmH6HmlFOLlwKlIXMssEXl8bbORdbfV0
        Ny1z3LdChzJfZme8/lkea8zIIrEt
X-Google-Smtp-Source: APXvYqx01p8g/bATZsjXE77HrNQKOlVkb4aXFdJM5jTjGEEy5ZNP6Kw3+EKdaheo3QfvFkoLmKnDDg==
X-Received: by 2002:a17:902:e091:: with SMTP id cb17mr43867136plb.222.1554168821697;
        Mon, 01 Apr 2019 18:33:41 -0700 (PDT)
Received: from localhost.localdomain ([1.1.125.76])
        by smtp.gmail.com with ESMTPSA id q86sm27912247pfi.171.2019.04.01.18.33.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 18:33:40 -0700 (PDT)
From:   marek.vasut@gmail.com
To:     linux-pci@vger.kernel.org
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH V5 6/6] PCI: rcar: Fix 64bit MSI message address handling
Date:   Tue,  2 Apr 2019 03:33:07 +0200
Message-Id: <20190402013307.20912-6-marek.vasut@gmail.com>
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
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
V2: - s/it's/its/ in commit message
    - Add R-B from Geert
V3: - Reworded commit message and thus dropped Geerts R-B
V4: - Add Geert's R-B again
V5: - Rebase on next/master 20190401
    - Use {lower,upper}_32_bits() instead of >> 32
---
 drivers/pci/controller/pcie-rcar.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
index 168bc6b9bb93..5e0102796345 100644
--- a/drivers/pci/controller/pcie-rcar.c
+++ b/drivers/pci/controller/pcie-rcar.c
@@ -892,7 +892,7 @@ static int rcar_pcie_enable_msi(struct rcar_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
 	struct rcar_msi *msi = &pcie->msi;
-	unsigned long base;
+	phys_addr_t base;
 	int err, i;
 
 	mutex_init(&msi->lock);
@@ -933,8 +933,8 @@ static int rcar_pcie_enable_msi(struct rcar_pcie *pcie)
 	msi->pages = __get_free_pages(GFP_KERNEL, 0);
 	base = virt_to_phys((void *)msi->pages);
 
-	rcar_pci_write_reg(pcie, base | MSIFE, PCIEMSIALR);
-	rcar_pci_write_reg(pcie, 0, PCIEMSIAUR);
+	rcar_pci_write_reg(pcie, lower_32_bits(base) | MSIFE, PCIEMSIALR);
+	rcar_pci_write_reg(pcie, upper_32_bits(base), PCIEMSIAUR);
 
 	/* enable all MSI interrupts */
 	rcar_pci_write_reg(pcie, 0xffffffff, PCIEMSIIER);
-- 
2.20.1

