Return-Path: <SRS0=Lify=RU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D78C10F03
	for <linux-pci@archiver.kernel.org>; Sun, 17 Mar 2019 00:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3952218E0
	for <linux-pci@archiver.kernel.org>; Sun, 17 Mar 2019 00:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUAzU+S/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfCQAGZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 16 Mar 2019 20:06:25 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38487 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfCQAGZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Mar 2019 20:06:25 -0400
Received: by mail-wr1-f67.google.com with SMTP id g12so13199741wrm.5;
        Sat, 16 Mar 2019 17:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UzQAOaNFJl4O9dGDd5nLwwB9pTU2KwSKAP9fzeea2dg=;
        b=lUAzU+S/K+fXxz9SYbMFmpddHWyGf2a23IzexYfBWDkeFW6aOIqSledY9N4c1AMNGC
         j0Oa3Rd4vjSuNYvCkQWYFUEORz/ABYlfyrXQ6f5LmMaB6yAO5QbmzfBpPJaHC9gNoX2J
         JzhTAnjM+JtLMkB/MQ2ju50mXExrjNLOOPtm+/Fe8OQHkh7CqtrXslZwYJ5vD8jBfnIX
         /NABwOLu5YNctmVRhLW5e9UHVlmZStesqsOMTan66W2Yr59eGUSSai8meIW0c70Cn0Pw
         ahLM2PHZQpDWoUHPEAyC88hxJ4nFAkRDhfzdgo4xiQXHICwmgExf05iUiy1biERG22Dp
         0oZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UzQAOaNFJl4O9dGDd5nLwwB9pTU2KwSKAP9fzeea2dg=;
        b=RPf64ssE6abyoC/NADO/GCAmNqGEoR+mXves3zj/C5WipELik5mvKYv/yXcij0WQxU
         Yl7ww9zREGXuz0/nXgD6vrmBWTLTmz1y9DTuUnNglmMKSgLhZkg5l+0ts6NzrlkKmeYZ
         CmyJm0/lpmZYJSo4yheJPHjcJ4va4ekahKPPqT6LDkn4ygPl1IfFeULEelkadgfoRTMc
         LmTOSYNCOvPwCXWeiVTNUXfYZ8PgDtVQmZtnfmioi38VikIk5+2GPVtnE8B1p78NU19F
         U2WLxXNwOp4OBsFi8kbqHmKrxIlW46u+VanEqsG5+0rTfHCNhIB55IBvzTswIJcVt3WC
         Olbw==
X-Gm-Message-State: APjAAAV/+X+y+0aoHIp7fZcDlzK3F4WshP7bLY0LHlWLtJgjhq/FLC5W
        FpM+5n1pEnjZgRs/i0JcwBPzputV
X-Google-Smtp-Source: APXvYqxfNcCo+Lsepr3q0rBg/OzVqXyCsgbUV0vvc5ayQhxT8j/TSKvh6O7evCi+mNZW7F04/b8cxw==
X-Received: by 2002:a5d:4a4d:: with SMTP id v13mr6837365wrs.169.1552781182649;
        Sat, 16 Mar 2019 17:06:22 -0700 (PDT)
Received: from kurokawa.lan (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id b3sm6759016wrx.57.2019.03.16.17.06.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Mar 2019 17:06:21 -0700 (PDT)
From:   marek.vasut@gmail.com
To:     linux-pci@vger.kernel.org
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH 2/3] PCI: rcar: Allow 64bit MSI addresses
Date:   Sun, 17 Mar 2019 01:06:07 +0100
Message-Id: <20190317000608.24881-2-marek.vasut@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190317000608.24881-1-marek.vasut@gmail.com>
References: <20190317000608.24881-1-marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Marek Vasut <marek.vasut+renesas@gmail.com>

The MSI address can be 64bit. Switch the data type used to hold the
result of virt_to_phys() to phys_addr_t to reflect it's properties
correctly and program the top 32bits of PA into PCIEMSIAUR.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc@vger.kernel.org
To: linux-pci@vger.kernel.org
---
 drivers/pci/controller/pcie-rcar.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
index 857d88fd03d5..801925a136ae 100644
--- a/drivers/pci/controller/pcie-rcar.c
+++ b/drivers/pci/controller/pcie-rcar.c
@@ -888,7 +888,7 @@ static int rcar_pcie_enable_msi(struct rcar_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
 	struct rcar_msi *msi = &pcie->msi;
-	unsigned long base;
+	phys_addr_t base;
 	int err, i;
 
 	mutex_init(&msi->lock);
@@ -930,7 +930,7 @@ static int rcar_pcie_enable_msi(struct rcar_pcie *pcie)
 	base = virt_to_phys((void *)msi->pages);
 
 	rcar_pci_write_reg(pcie, base | MSIFE, PCIEMSIALR);
-	rcar_pci_write_reg(pcie, 0, PCIEMSIAUR);
+	rcar_pci_write_reg(pcie, base >> 32, PCIEMSIAUR);
 
 	/* enable all MSI interrupts */
 	rcar_pci_write_reg(pcie, 0xffffffff, PCIEMSIIER);
-- 
2.20.1

