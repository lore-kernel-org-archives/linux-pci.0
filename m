Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDF6C48BE5
	for <linux-pci@archiver.kernel.org>; Tue, 15 Jun 2021 19:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A74696128B
	for <linux-pci@archiver.kernel.org>; Tue, 15 Jun 2021 19:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbhFOTQd (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 15 Jun 2021 15:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbhFOTQc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Jun 2021 15:16:32 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A69C061574;
        Tue, 15 Jun 2021 12:14:26 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id x21-20020a17090aa395b029016e25313bfcso272092pjp.2;
        Tue, 15 Jun 2021 12:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K96NEhRwOfOsQAPRB6OZS+5qrNhl6I/oCeCqkJvi258=;
        b=qqZc2Uh2ZSIzSDA25Ys4zEG506SaSOwt57+BYQxVx/T6xa/17qGN5X4LRAR++F1oEo
         mhKz0nqRJrVl4OLbSn2pQI3Tq9Hx5Q+uzsXKjny4hbYpttchuB/iQBbJT98LRGoyvOCy
         XQuzNbLm16MVFZkxuHdKFD5p3V7SP4SPFIHvgqNhJBUfokWXFPKk5jcvC86GnBvNh62h
         Yt00xKCIGpDKTZ3ro1VpQM9resKlcM2hjAIB4Mo9fh24aglQGiUHkeY6HxbX0LoCJzGV
         cQlzanM1Lp4xDaA/m8SZN41i3FjJ2jGjMonXq9ZWwCYyWfiI3DWXLnRusY20j/nxW+Pe
         9BEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K96NEhRwOfOsQAPRB6OZS+5qrNhl6I/oCeCqkJvi258=;
        b=pNGbf8o3uLRC30rV5p/SCeDpbkWv6kGgtvoB6a8BWPYgrPt4+YXliAG0eIOmkEsPAo
         F/SL/Z2BSC0ZPnhaYYer4sO6uDuk3AnS8Y+eY4idbU0LiLAD2YCR/CPeMvrRwex+e30w
         lze/OLD5NH/XSV/ZwVBBPY+f9k28JXwE005KPbEPb4Mqsn0/GMztaw7XYFbw6zc129V0
         AcyoAPLTvJZOhzuBKLuNVCUbszIvIXUF5qPrMkCD0ObHX2NwDuk8ebAxutUAMQvX4rEP
         KTLy/KTJADcKcdzhFbeKUnHVvb4v/Gs+/TdE70ED2oUTEEj8kILeyctQHnc6K0Xy0Qtf
         cJCg==
X-Gm-Message-State: AOAM5335ewLJjedjpuvoIqhH8aM9kiS3f9cR77arJ2TWX0wZ0twGSj4X
        cK2/rwa6iYdn7neXNdq/3n21PvFTgZno3Q==
X-Google-Smtp-Source: ABdhPJzBXgY2YbgSAgc0sRNfpuHgDCWRry9ogh+YjFBZ+/hwygS7W27RAZZaG8TlduIafjPsxMKlZg==
X-Received: by 2002:a17:90a:5401:: with SMTP id z1mr740025pjh.7.1623784465930;
        Tue, 15 Jun 2021 12:14:25 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id j4sm3165008pjv.7.2021.06.15.12.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 12:14:25 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jim Quinlan <jquinlan@broadcom.com>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/3] PCI: brcmstb: Check return value of clk_prepare_enable()
Date:   Tue, 15 Jun 2021 15:14:02 -0400
Message-Id: <20210615191405.21878-2-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210615191405.21878-1-jim2101024@gmail.com>
References: <20210615191405.21878-1-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Check for failure of clk_prepare_enable() on device resume.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Fixes: 8195b7417018 ("PCI: brcmstb: Add suspend and resume pm_ops")
---
 drivers/pci/controller/pcie-brcmstb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 08bc788d9422..abc62a86d94e 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1162,7 +1162,9 @@ static int brcm_pcie_resume(struct device *dev)
 	int ret;
 
 	base = pcie->base;
-	clk_prepare_enable(pcie->clk);
+	ret = clk_prepare_enable(pcie->clk);
+	if (ret)
+		return ret;
 
 	ret = reset_control_reset(pcie->rescal);
 	if (ret)
-- 
2.17.1

