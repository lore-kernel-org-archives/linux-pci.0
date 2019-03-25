Return-Path: <SRS0=Cb4Y=R4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CB8C10F03
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 11:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50AA62085A
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 11:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sj0PLddz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730642AbfCYLlY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 07:41:24 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51787 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfCYLlY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Mar 2019 07:41:24 -0400
Received: by mail-wm1-f68.google.com with SMTP id 4so8533420wmf.1;
        Mon, 25 Mar 2019 04:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dP5qdcCTQ74ItJjVqPX6cC3bVHkZBzJFObfiXJrn84M=;
        b=sj0PLddzbyCgqzZKqN1WJM8w4RhAcXvFNH3wWwQXLsEJbIY4Xcl0GwoTOvB6NiV0i/
         mAZXL9clGT6kV7PezDhNGSfzNu9SRnhRf2SrHwie/BxfwSKAQqj0q06PsaZsoH6gyuq1
         rLvDqHWB30sunNO1m+hqyIR9f6mk1fCJNqRR0FkU6q8loYN+WF1VUKNpLz3oWX/kh6YH
         5kCone9WJ5ANnQI7g9Ykr98BQHnVpkqGdbu4SoOVZd5tC7IcG1xnDu9YXzv6lsWvezWI
         2GiMkwgGbhMrZO34GcsROa5eaSR37WY7Gqv4Uwe9izJ3eEGM5PoCucLDKa+cpxRowai9
         IB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dP5qdcCTQ74ItJjVqPX6cC3bVHkZBzJFObfiXJrn84M=;
        b=oGqV4+JlS/8V4KE/Tbb6TQkefH9kSjbl2B1lOfFhXPOKe2TNbXTi5j+IsLz7VBgC75
         mP8HgfnYKlNW5COgzy7QzU5y5iGRG4yn9+FpgKBt0bKFN4yjM2Lerl8UH8ACkYZymKFE
         1Fx7cxXfn0eQ0roKP3no3jrqRgwZ2BLnbFC44HEJTjEdQFzyuKg8kLlLS3jaEUsGsDPn
         u1v/yqe/abUK6q77CVXu6J2oZ44LQZyOHwuDYtaPur0Uh87npkIRGR21sgCHYe3NMax5
         BuaQSbkbBzitLCulYLDoFPUQUA4yysiO8WxlzK+oAafWRCzCWUxnkX76T/ENHGqTjqej
         mUUA==
X-Gm-Message-State: APjAAAU2CnAc6dlKWgTD1brtN3AHZ/kK/VhCZ/Ortux9QmPBg7WHAj7D
        H50a7WY4IBN8AJq8F77nyloU7i+J
X-Google-Smtp-Source: APXvYqzn0EYiaoaNx0gMu+MA1xxGksmka/mXWlLKfEuaHZ2exgGgf1n0IFVSG6Amq2up0ErPAlWwVA==
X-Received: by 2002:a1c:f414:: with SMTP id z20mr4970122wma.100.1553514081998;
        Mon, 25 Mar 2019 04:41:21 -0700 (PDT)
Received: from kurokawa.lan (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id f1sm3905730wrt.87.2019.03.25.04.41.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 04:41:21 -0700 (PDT)
From:   marek.vasut@gmail.com
To:     linux-pci@vger.kernel.org
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH V4 6/6] PCI: rcar: Fix 64bit MSI message address handling
Date:   Mon, 25 Mar 2019 12:41:01 +0100
Message-Id: <20190325114101.10198-6-marek.vasut@gmail.com>
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
---
 drivers/pci/controller/pcie-rcar.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
index c6013f95bdb2..62d2de9fbf1c 100644
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

