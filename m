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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1305C10F10
	for <linux-pci@archiver.kernel.org>; Sat, 23 Mar 2019 01:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DC2620883
	for <linux-pci@archiver.kernel.org>; Sat, 23 Mar 2019 01:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZRox8/O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbfCWByO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 22 Mar 2019 21:54:14 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41525 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728136AbfCWByO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Mar 2019 21:54:14 -0400
Received: by mail-wr1-f67.google.com with SMTP id p1so4186364wrs.8;
        Fri, 22 Mar 2019 18:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jSrlccwhQwc3GzuUl1Q5/05D6DwWtcM1QO2IngsuJg8=;
        b=mZRox8/OZ6wbRPY56UM4jXNmNS2UXR9GcczYNxXFSTZgTtP7oFoahqV4xbiYMClZou
         hKucxOaV2m8XXlU/UsHXawNn+htyPRIaluxfSwoDfzrcNDzO8j+T/cvuYZ+OHt+2wzvU
         aWcMVNlqeGUACaatXCDK95q1eIMiy8mCorkTC9N3G/laysvSErtsey5dLNP24lVwMLzM
         3eTiekhF6uukENghKxzlHi+h5hLDOAtdkjLzbqgvippmliM/j/MFcw4ThGTt60CU+vuq
         Ufqy0oMvd8Nu6KbgAGBBSqZC8/Ei4P56ZL5+3IheYhKv7lhBhOiJ/HKdAHxakye1iFwv
         mdJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jSrlccwhQwc3GzuUl1Q5/05D6DwWtcM1QO2IngsuJg8=;
        b=iE6Uys4s5GaYu6yCHsRPcP8VCX2WOfw2lsGdZC8f8VW3tm0QPoPujAZc2Cu30hH1Ct
         LywJdSR6y+adOFkbRF8tkHzE8CinTadOQwkYEPymkKdi01e/To9n4wKtpBs0yjVPBANd
         5DWql6RKNsxBfxG5OMCDVdg/riqyYoMO+iIOANzNtI9fXShud3b5k3DBOT9xKLRR8D/+
         UC5RzTaMVI8V4bIAND46Zb1GLT/0eoe0lp7KYfS92QWWfPzDp0UaaeF2AExHe7vFFWqw
         jU+bNR6v5f9e9okWIIXRmGhi+wsAuontdKLAntuevq7ivNyUimYHQSNBwNthCHDwWS37
         eRYA==
X-Gm-Message-State: APjAAAVdw5kB4zv2MJTD87Tnnm13VB7E3qsoSPqCNsUl15/BLjuTWO/M
        Pr4uB9IZrCAqkFZr+2ebRkcXJ+x6
X-Google-Smtp-Source: APXvYqzUKJyqPc6ZyxLqylideCsJwCILEjY4iN2ZG6KopPLcTfPk74ywB7QSAhuXNbIxSRquOWkztA==
X-Received: by 2002:adf:db10:: with SMTP id s16mr224429wri.181.1553306052507;
        Fri, 22 Mar 2019 18:54:12 -0700 (PDT)
Received: from kurokawa.lan (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id y192sm25433050wmc.6.2019.03.22.18.54.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 18:54:11 -0700 (PDT)
From:   marek.vasut@gmail.com
To:     linux-pci@vger.kernel.org
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH V3 2/6] PCI: rcar: Replace unsigned long with u32 in register accessors
Date:   Sat, 23 Mar 2019 02:53:55 +0100
Message-Id: <20190323015359.7231-2-marek.vasut@gmail.com>
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

Replace unsigned long with u32 in register accessor functions,
since they access 32bit registers.

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

