Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89108C10F13
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 00:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 563C620870
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 00:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rZDowLZq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfDOArd (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 14 Apr 2019 20:47:33 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36331 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbfDOArd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 14 Apr 2019 20:47:33 -0400
Received: by mail-pf1-f195.google.com with SMTP id z5so7716326pfn.3;
        Sun, 14 Apr 2019 17:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9beIuYqBF6SILMxXaavWO/q8AQSlMA1a2HjBO8p38og=;
        b=rZDowLZqJw3bbECWetTAiWiAIYWB/pbTb6fjFNQC/bCujN2AJJ0K/7GGmGKJiFASau
         pC8q56ANjK1KplTa6QSiN6LSNglmqhd3IqiKMc3HhVoSJLOoWKEzrC3X4k8j27QgxAFu
         l9Tc1aiSFc9yO3rxLjHl4oFHPhzuY7acsh6SgiZi+it1FwvEd6ksXF9ML8NS0xdXXejs
         lB4LHAnLjyTBob8mkR05GYwKvMqPwP2wRxvKbZQJLQjQXyPMBklEauf7vOE5lS/rECGE
         YXxJ9mBn7H9EZZvv/5DX+EfNiwDMnpRApe3r5+zAxNnyz3iipBT+/I9iBlxJ5z6vez22
         68JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9beIuYqBF6SILMxXaavWO/q8AQSlMA1a2HjBO8p38og=;
        b=E8paFmJ2sCai8BVh1ZpHmhxB/YbrECMH1uvnc63+/RYSSRSPPkcLHExChEZR/6M6Xr
         naevgLRwU0K/CJlO6gwzZAmu8wG5q531KjY/LRu1d5Ze/39HUzZt6kdFOUNV/OMvk3J1
         BgbOMFfoGqnBhkvn3vE6HgkW5GkmMtHLsQRXNgUvtFriuWJEk/Cdn21ZYGzr+fFas4c4
         AknD4XAWwHc2i5CNL0tJE6cYBvTB7wpQWYPfymehJ3nrbIwJulxTSkNmiWwb4v1SVdO7
         yok0HmWuIgxYUQDrJmoT3GWjI6nCnFhGnhGDQ7RJWuPtk4a9h/edjLx7mvnAG45ddnwm
         Gzfw==
X-Gm-Message-State: APjAAAVvBYVRTQc0UgxYUQuxBysJGgmfzVG50evSDDY4BRtgFUcp+4gB
        z7JeJYczmdIyBeO5Gq0BvPZoWnEw
X-Google-Smtp-Source: APXvYqz0bqwjhWJfMUBVTSpq/0QGtNPgOBbelODk1fB1QPQAlQFtiF8DbRCfFyKiEO4dMKeFiqEWxA==
X-Received: by 2002:a63:31ce:: with SMTP id x197mr65850514pgx.69.1555289252010;
        Sun, 14 Apr 2019 17:47:32 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id u17sm66111981pfn.19.2019.04.14.17.47.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Apr 2019 17:47:31 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 04/11] PCI: imx6: Remove PCIE_PL_PFLR_* constants
Date:   Sun, 14 Apr 2019 17:46:25 -0700
Message-Id: <20190415004632.5907-5-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190415004632.5907-1-andrew.smirnov@gmail.com>
References: <20190415004632.5907-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Code using these constants was removed in commit a71280722eeb ("PCI:
imx6: Remove LTSSM disable workaround"). No functional change
intended.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/controller/dwc/pci-imx6.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 021ef121a058..c0867df090f5 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -103,9 +103,6 @@ struct imx6_pcie {
 
 /* PCIe Port Logic registers (memory-mapped) */
 #define PL_OFFSET 0x700
-#define PCIE_PL_PFLR (PL_OFFSET + 0x08)
-#define PCIE_PL_PFLR_LINK_STATE_MASK		(0x3f << 16)
-#define PCIE_PL_PFLR_FORCE_LINK			(1 << 15)
 #define PCIE_PHY_DEBUG_R0 (PL_OFFSET + 0x28)
 #define PCIE_PHY_DEBUG_R1 (PL_OFFSET + 0x2c)
 
-- 
2.20.1

