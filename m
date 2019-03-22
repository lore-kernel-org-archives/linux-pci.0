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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52942C10F0E
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 02:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ECC921902
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 02:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NIwMRkQa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfCVCix (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 21 Mar 2019 22:38:53 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37200 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfCVCix (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Mar 2019 22:38:53 -0400
Received: by mail-wr1-f67.google.com with SMTP id w10so687856wrm.4;
        Thu, 21 Mar 2019 19:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8rxuw1WuD4xW/29oYPvpa4K4LxHE/AFWLTJgSSwQb6E=;
        b=NIwMRkQalycE1EsWydgzo+Ly106QEXmDuq4A5NBV6cC+5atD/advTNgavtPgf9bOVF
         DcByeUk5U2bTuAr+6IJE387/IGqeGFY1xWRPqAWadgI5JiXIpx7zkJmvffY6T6Hav3pz
         cnVcZKhymkUl1xgtG69jmlHIEotE9i4lSJAifwEonzUt7aiPN654d8VPVMp4lntnqHOq
         zU8YvGgqlXpeMbszNPhnA9JVMCzuT0qtSgFHA3kqiAZBWPiK/kagT4GTbi1ZlOPLyu0Y
         /F82EfIGCUxwGehD652B1hLMWmMJIO0Zcf7x/DIfhEsrkqNYbbl30iRi381c+8gueyiT
         MOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8rxuw1WuD4xW/29oYPvpa4K4LxHE/AFWLTJgSSwQb6E=;
        b=t0yJtAWeqsNLazM7bZbu8GkSI/oGeW613A7Q0d8ALR7ZXN0eK6d+gtIkNdW2hCyE36
         oQe/JnxWw2Tmt8YfU9QyyUHSsJ4RcnuuVJXmti/avdUfdtz2dM4DZOxgcYZwx7dGwrju
         ENLYQOjHme1lKtg4Oo/kd/M7PU+LVyPbehUOoUHhWemxvU9A2+YFry4V7Nkt6BUoQfNJ
         xo5PbJKBwJ+CI5YbQ9uq5BTh4DtRy5DNnRsH/4M2AS6xop3IzfFZH7IfrEGulvhLViZK
         jZtxpt8uJ4WDki7QS9Rn+ZdKzYLrJ2QMfJUTtz8vRfU3S0/Bk4Pl1Wo5Xs0jyZWdt2ze
         eQAA==
X-Gm-Message-State: APjAAAV2amlh8z920YC/dmeg4gcP7pom/U3nHws4Tlez6wAWIQx+4Gbz
        1zaeYU258/uGLsmnFoRYnCteO/R8
X-Google-Smtp-Source: APXvYqwK5J/QMHbiELmmSAHu4+uCpb08W/HexcaTTIXOgxrCaCvtF+fXFNWxpAceU5dpQYiii+p+hw==
X-Received: by 2002:adf:9c8f:: with SMTP id d15mr4468988wre.309.1553222331203;
        Thu, 21 Mar 2019 19:38:51 -0700 (PDT)
Received: from kurokawa.lan (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id w18sm10432692wru.24.2019.03.21.19.38.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 19:38:50 -0700 (PDT)
From:   marek.vasut@gmail.com
To:     linux-pci@vger.kernel.org
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH V2 2/6] PCI: rcar: Replace unsigned long with u32 in register accessors
Date:   Fri, 22 Mar 2019 03:38:40 +0100
Message-Id: <20190322023844.18574-2-marek.vasut@gmail.com>
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

Replace unsigned long with u32 in register accessor functions,
since they access 32bit registers.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc@vger.kernel.org
To: linux-pci@vger.kernel.org
---
V2: Bundle this patch with other cleanups before resending
---
 drivers/pci/controller/pcie-rcar.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
index 5b8736f0cd6b..1408c8aa758b 100644
--- a/drivers/pci/controller/pcie-rcar.c
+++ b/drivers/pci/controller/pcie-rcar.c
@@ -152,14 +152,12 @@ struct rcar_pcie {
 	struct			rcar_msi msi;
 };
 
-static void rcar_pci_write_reg(struct rcar_pcie *pcie, unsigned long val,
-			       unsigned long reg)
+static void rcar_pci_write_reg(struct rcar_pcie *pcie, u32 val, u32 reg)
 {
 	writel(val, pcie->base + reg);
 }
 
-static unsigned long rcar_pci_read_reg(struct rcar_pcie *pcie,
-				       unsigned long reg)
+static u32 rcar_pci_read_reg(struct rcar_pcie *pcie, u32 reg)
 {
 	return readl(pcie->base + reg);
 }
-- 
2.20.1

