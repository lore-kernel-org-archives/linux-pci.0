Return-Path: <SRS0=rJvA=RM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37BCC10F0C
	for <linux-pci@archiver.kernel.org>; Sat,  9 Mar 2019 00:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3DA320866
	for <linux-pci@archiver.kernel.org>; Sat,  9 Mar 2019 00:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXXcGLZj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfCIA4X (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 8 Mar 2019 19:56:23 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44253 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfCIA4X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Mar 2019 19:56:23 -0500
Received: by mail-wr1-f66.google.com with SMTP id w2so23159244wrt.11;
        Fri, 08 Mar 2019 16:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hNFudz8xVpYznoAjgANt/2D9z5OUCW1uMT/VgT+hL5c=;
        b=DXXcGLZjHqnzaqivhbIAutnsTXvlLDT3J0l/gHEZbXoccicKlyNMjTHqLDY5FdRwwb
         ZLXXHSxLuMYs0LCr3TyG+uKUylB6VHmUoDG3lKyYvYcnG4tIT2hJn/xGgo3d9D7BTld3
         oeNyd+M45fMT86Sr1l7YHKcixBADS9NNOla4vrSbzKPUATUAPOFchmQi7HpFoOkZh02F
         4qC7y6zxvVyMDTv4BQiZ5KbeSnvb8qneiixJHLUihc2vxgAJz3iuTik9qZee4EuptZMM
         gSv0k/v4Y7eb8AE4LGriegYrsDO5jN7M+c8aObuGucDRw6kn52QRHFt8JtldtdNkMbWA
         HYkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hNFudz8xVpYznoAjgANt/2D9z5OUCW1uMT/VgT+hL5c=;
        b=g6lqnwl0epeBWJQ2AgHb+Kn8SmNePpFCKNs7uW1EM7fW//EKa2N/XgK+myYvNV0o5M
         cE1+O6GKZ97Lki2cy7//FaUzpfWuywGVaKf1qU1ZGAz/n4P+qJT+gAOxlvp9vxFp3g6I
         4nlfWKx575HbTANvrxIsEKOPCSStOxeTVwEJ+efXwCFpTD79zuOSH1BjiQkMw4z8hygf
         mVa8eEMTDxsDbmmWdAOnVCs15rSW5KMC5jBtJv/CEr0Y/V+s3xPhAU5gQkMVvHGW6qdQ
         EP7bYU+uPeLw0TNNG3qkpbwpPphwYE9DM7gtPfVOL9PldD+XeJcR6Z3g6a0zqmabh93n
         0BUw==
X-Gm-Message-State: APjAAAV6HX+1zbN5YPNh2ElKBDml6CkaPzxgBf2rvvNg6KCzpwVI1rOV
        QzZi08KHo1ANpv3hQCyTfokdmjTL
X-Google-Smtp-Source: APXvYqzCEMFu5BHsWr2yMkI8wAD/xk4Hd4SLCdwTU8zBePBGfQZDpzz3mccng8c/mg3j+cepDKrPiw==
X-Received: by 2002:adf:e3cb:: with SMTP id k11mr13114361wrm.263.1552092980512;
        Fri, 08 Mar 2019 16:56:20 -0800 (PST)
Received: from kurokawa.lan (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id e23sm8340623wme.15.2019.03.08.16.56.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 16:56:19 -0800 (PST)
From:   marek.vasut@gmail.com
To:     linux-pci@vger.kernel.org
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH 2/2] PCI: rcar: Replace unsigned long with u32 in register accessors
Date:   Sat,  9 Mar 2019 01:56:13 +0100
Message-Id: <20190309005613.1493-2-marek.vasut@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190309005613.1493-1-marek.vasut@gmail.com>
References: <20190309005613.1493-1-marek.vasut@gmail.com>
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

