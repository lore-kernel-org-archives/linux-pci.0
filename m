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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C8DC43381
	for <linux-pci@archiver.kernel.org>; Mon,  1 Apr 2019 04:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D0820870
	for <linux-pci@archiver.kernel.org>; Mon,  1 Apr 2019 04:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rtN8s57W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfDAE0D (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Apr 2019 00:26:03 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39604 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbfDAE0D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Apr 2019 00:26:03 -0400
Received: by mail-pl1-f193.google.com with SMTP id b65so3816223plb.6;
        Sun, 31 Mar 2019 21:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F8oXQCp56ZlNvc+eSoHWKahah7TDd6mimNeNhGWIK+s=;
        b=rtN8s57WRffcMH2IkFTtr1Iyk6C/knJjziPcbblRi7bEaR8VImlr9xv+6B7m8lirKO
         0E6M/XRUApMMrh5uFLpCnBY77gNftJI9LjuZWKMIMHOaI5O6MaV/z2EPQfbRrTyxN9Vp
         9Ncxm5qRGhZWyYPHq3VurGOlbpWWjhHWxxr9W6RDzv/7hnv/ZMKJyiGF1fOKvotv9dN5
         jLqo3HymvrGMTsEeQvA0+CBQN617c1Ps9cTfzXDWMdVLNNrwUdpk/ddkD7JwE9Kp3mfI
         y3BgoOqpdkpLbTq+zIkZ7FK58QvC2iXJp10siqkwGayR/jKuObnSJxPRf5vhopch4jeb
         Cqvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F8oXQCp56ZlNvc+eSoHWKahah7TDd6mimNeNhGWIK+s=;
        b=kgRMZnPlEQeRqbqFM9SB23pRdNAdnby1g4dOGQSbeGzO3eGpv8skMakgbcLTORx/gL
         xCdE8GQGrn06P/H/1XZeyNWgnlH3Tg2fvkrCdNBxWSQIZPk8zbA8c9V+G2R2Ci09f8a2
         xJhNNHI/BVD2ApmdqTceDv8RjjjmCAtvulUtC12pc2IUoQjpdrV86e4hetKnt6ZH6EqB
         fV68dVVcubrC8/XyyEHdFdRaIThMMa5Ga4O5rjuIpd0ziH0tS2ZInfUHYnQXbsfx1ZPI
         r69LZOEeOCA4OWW0/0F1zfbQu6FCvx9gyHsEnO3vxd8RHaJRVgegwrYs/xYYDURAiz3J
         ZrFA==
X-Gm-Message-State: APjAAAV40+jdujT2XIihzKCAv7hxu2YqZahEqV9Rory4hIyZJI5tKR7S
        CkM6exwUnfzp26+G6eHAL9kKjrTn
X-Google-Smtp-Source: APXvYqxsOciJD3nXK9tfj+BsoGE2REapwqP7u/Wjlo23MzmgnpD2lRXHzbHjJ+F3JxqG9Hv28f/NGQ==
X-Received: by 2002:a17:902:8349:: with SMTP id z9mr41663324pln.144.1554092762162;
        Sun, 31 Mar 2019 21:26:02 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id t22sm10996829pgu.45.2019.03.31.21.26.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 31 Mar 2019 21:26:01 -0700 (PDT)
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
Subject: [PATCH v3 02/11] PCI: imx6: Remove redundant debug tracing
Date:   Sun, 31 Mar 2019 21:25:38 -0700
Message-Id: <20190401042547.14067-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190401042547.14067-1-andrew.smirnov@gmail.com>
References: <20190401042547.14067-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

All calls to imx6_pcie_wait_for_link() share the same error path and
the state of PHY debug registers will already be printed there.

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
 drivers/pci/controller/dwc/pci-imx6.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index fb0b29e5b1f0..7582d0b2fbe7 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -726,16 +726,9 @@ static int imx6_setup_phy_mpll(struct imx6_pcie *imx6_pcie)
 static int imx6_pcie_wait_for_link(struct imx6_pcie *imx6_pcie)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
-	struct device *dev = pci->dev;
 
 	/* check if the link is up or not */
-	if (!dw_pcie_wait_for_link(pci))
-		return 0;
-
-	dev_dbg(dev, "DEBUG_R0: 0x%08x, DEBUG_R1: 0x%08x\n",
-		dw_pcie_readl_dbi(pci, PCIE_PHY_DEBUG_R0),
-		dw_pcie_readl_dbi(pci, PCIE_PHY_DEBUG_R1));
-	return -ETIMEDOUT;
+	return dw_pcie_wait_for_link(pci);
 }
 
 static int imx6_pcie_wait_for_speed_change(struct imx6_pcie *imx6_pcie)
-- 
2.20.1

