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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5094DC43381
	for <linux-pci@archiver.kernel.org>; Mon,  1 Apr 2019 04:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E8A020879
	for <linux-pci@archiver.kernel.org>; Mon,  1 Apr 2019 04:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqcaChFB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731623AbfDAE0l (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Apr 2019 00:26:41 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40449 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731160AbfDAE0J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Apr 2019 00:26:09 -0400
Received: by mail-pf1-f193.google.com with SMTP id c207so3879463pfc.7;
        Sun, 31 Mar 2019 21:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CGjdSjCoRVjM4VFnkLgtsjJRQadXXrAea1wagTahPCc=;
        b=UqcaChFBSFJ0SPaeuxtJBB1cSPnCZ2sEe3S1PPXX5rBeNvR8PwTB1ZsKtyObu88+QO
         vvsRpyRFEB55r9hgoiffK/cF1vhWwSUYQ333HgUFhpNf1/qkdNoJx71EUQsRASAFjX4m
         zjuuOy81iBVV5jPfQ5rFqaqMdjE+LvK9357jyb0I5ARhUhveiGfQjcEfzDLedUzhpjlj
         p3To993VV/FtD5C+k9ig3o1UNZzHHMakfLpgyeDuhpmYDLfC37kCJEznCPFOPjeNUGpT
         CejT0ehhqF3DIt3teTeBM7Kvg102eSmqMMAlhGzFNM7umWpm7t9UypSzg9JO9RlFUJCj
         kdog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CGjdSjCoRVjM4VFnkLgtsjJRQadXXrAea1wagTahPCc=;
        b=StoZ6WClIXMdvf6Rxmw01MpyUrRYhB/GqNmwF5AqgcLwNLSy7w0xE8QX0WpkFBF7Yc
         5GZNEld/EE4uiK5BHEE1BZhXJZBFt+H2oKLgq9lf95s78r/9s2qMjcx5kiqP4IdcGuEM
         rXGgxtjfMko2kYI6giT2EYkJzFzxrzpguFM6xQLUSb9i1c6kO9yqsyOTXoBhiHE4hn38
         GwtYbya8s0yYWpKDBZ6pAHiz8w5dRiwjL6U8rCfIsEAspNlPrZISqjcNQjRf6iUiTfBs
         F6ciMlAYEfsJwMY/x2OtMZBlKttJYRlDbFlbRFjWiK12kSo4RpWEkSPcKqj8D+/j6gMb
         j87g==
X-Gm-Message-State: APjAAAWjbDjX+d7TAzmlCq4wrqjFYPE1ByaP91xK+ezDt6bDfDpY5O1f
        /iuRGKqJ9RMDRGVzv3rPy+lklC4Y
X-Google-Smtp-Source: APXvYqzJ1deNkqroSYDhGhDcfZIBagXvLbOQeCE2B1UedaPnBWHx5yIpvdvCf3VWGPMNBiv/Qf9tkQ==
X-Received: by 2002:a65:6150:: with SMTP id o16mr28828934pgv.285.1554092768571;
        Sun, 31 Mar 2019 21:26:08 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id t22sm10996829pgu.45.2019.03.31.21.26.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 31 Mar 2019 21:26:07 -0700 (PDT)
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
Subject: [PATCH v3 06/11] PCI: imx6: Make use of BIT() in constant definitions
Date:   Sun, 31 Mar 2019 21:25:42 -0700
Message-Id: <20190401042547.14067-7-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190401042547.14067-1-andrew.smirnov@gmail.com>
References: <20190401042547.14067-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Avoid using explicit left shifts and convert various definitions to
use BIT() instead. No functional change intended.

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
 drivers/pci/controller/dwc/pci-imx6.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index bb95a3273ca2..b1f30b94fb30 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -118,14 +118,14 @@ struct imx6_pcie {
 
 /* PHY registers (not memory-mapped) */
 #define PCIE_PHY_ATEOVRD			0x10
-#define  PCIE_PHY_ATEOVRD_EN			(0x1 << 2)
+#define  PCIE_PHY_ATEOVRD_EN			BIT(2)
 #define  PCIE_PHY_ATEOVRD_REF_CLKDIV_SHIFT	0
 #define  PCIE_PHY_ATEOVRD_REF_CLKDIV_MASK	0x1
 
 #define PCIE_PHY_MPLL_OVRD_IN_LO		0x11
 #define  PCIE_PHY_MPLL_MULTIPLIER_SHIFT		2
 #define  PCIE_PHY_MPLL_MULTIPLIER_MASK		0x7f
-#define  PCIE_PHY_MPLL_MULTIPLIER_OVRD		(0x1 << 9)
+#define  PCIE_PHY_MPLL_MULTIPLIER_OVRD		BIT(9)
 
 #define PCIE_PHY_RX_ASIC_OUT 0x100D
 #define PCIE_PHY_RX_ASIC_OUT_VALID	(1 << 0)
@@ -148,8 +148,8 @@ struct imx6_pcie {
 #define PCIE_PHY_CMN_REG26_ATT_MODE	0xBC
 
 #define PHY_RX_OVRD_IN_LO 0x1005
-#define PHY_RX_OVRD_IN_LO_RX_DATA_EN (1 << 5)
-#define PHY_RX_OVRD_IN_LO_RX_PLL_EN (1 << 3)
+#define PHY_RX_OVRD_IN_LO_RX_DATA_EN		BIT(5)
+#define PHY_RX_OVRD_IN_LO_RX_PLL_EN		BIT(3)
 
 static int pcie_phy_poll_ack(struct imx6_pcie *imx6_pcie, int exp_val)
 {
-- 
2.20.1

