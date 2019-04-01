Return-Path: <SRS0=cJ9t=SD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F07AC43381
	for <linux-pci@archiver.kernel.org>; Mon,  1 Apr 2019 04:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 713FA20870
	for <linux-pci@archiver.kernel.org>; Mon,  1 Apr 2019 04:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="It3my+tk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731111AbfDAE0I (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Apr 2019 00:26:08 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38732 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbfDAE0H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Apr 2019 00:26:07 -0400
Received: by mail-pf1-f195.google.com with SMTP id 10so3882042pfo.5;
        Sun, 31 Mar 2019 21:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xPS6eriV1RNG7+i63e9okUWFl9H6ovMd2i7tJGd9Na4=;
        b=It3my+tkm2rh7qzaj/fwyBLYrbSqe48T9Vw3hzIRFfZc773481pr2ncPrOATkFlkPK
         vo4QBeUJHihvMlYFjW0tbuWh41jlbk5u1SOAuGwv0p5PKFhYtthLdWutJEOLAe6QZKuc
         VpOrkyeQFlCm/x3M0Q9ri9yvMTwQ9dVKcZ2BJDfW0wjalzquVlGY7JoN0Iw0iEjiQv66
         frEEus3FQb/amVjKofKQBdAmybwLT4kjTAJH9CAeSPq0LqggaAwovOJzmo7vz4HCy7zn
         vZr1RRDyPLyhuwbbztEFCLKcjjdr1egOgxDAoy65CeMArejMPoBlGAEu1ffkYY4pphsp
         ZG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xPS6eriV1RNG7+i63e9okUWFl9H6ovMd2i7tJGd9Na4=;
        b=RLRQmZhQeMro9w+HupVPMw30SLA9JUb6Z/DoM2sf1Yzda0mfVyaXwdx4Hv7BnfV/op
         NQE1vrCAY9ZA0YQD7Wk5tLpHOQQ2LMWHd98NPY6IkPezfw2Ki6r1dKMtnZnuqU862KtC
         bQfIMCXC02hbPHp+k4Pbj0igfSFZ+34MIUDssOoNhrubb+JrrCF8/+maE1avdjPgfRqE
         rlSo0SajPUpulPxqhsozJ6TcZVMIZYu2XWTq7SMmgLVUhh9Y1decV7VE7wIaka6taXUx
         ic8tAT6J1/jjQMCJBtg2jo09hAKvcerIyp3qj4i1x4JNdB5IRhsGjoNXmtRJGcSZNcc1
         8agQ==
X-Gm-Message-State: APjAAAUm7xc6KoxB9kPYOEKATrf7MdFTPWmeypurn4tk/jWE1v/vZqWN
        7E2yMZGKatb92RM6GN9r/lNxayer
X-Google-Smtp-Source: APXvYqyicxturgChify1dQhXwW+Mi6Yxk6kl0UDNKC5iRrwsnBkTMDrHa3stZlY2uOb3PHG92oC5GA==
X-Received: by 2002:a63:2106:: with SMTP id h6mr58279524pgh.441.1554092765627;
        Sun, 31 Mar 2019 21:26:05 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id t22sm10996829pgu.45.2019.03.31.21.26.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 31 Mar 2019 21:26:04 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/11] PCI: imx6: Remove PCIE_PL_PFLR_* constants
Date:   Sun, 31 Mar 2019 21:25:40 -0700
Message-Id: <20190401042547.14067-5-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190401042547.14067-1-andrew.smirnov@gmail.com>
References: <20190401042547.14067-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Code using these constants was removed in commit a71280722eeb ("PCI:
imx6: Remove LTSSM disable workaround"). No functional change
intended.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-imx@nxp.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 3f4707072942..92c40c250a34 100644
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

