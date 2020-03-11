Return-Path: <SRS0=NyCf=44=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45363C0044D
	for <linux-pci@archiver.kernel.org>; Wed, 11 Mar 2020 19:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C7B220691
	for <linux-pci@archiver.kernel.org>; Wed, 11 Mar 2020 19:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZXdYYUO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731147AbgCKTTh (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 11 Mar 2020 15:19:37 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:33087 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730807AbgCKTTh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Mar 2020 15:19:37 -0400
Received: by mail-pj1-f68.google.com with SMTP id o21so1853951pjs.0;
        Wed, 11 Mar 2020 12:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pOjQrnVayTgdrET4gCgzOMQ7+VznZ1NPyMucBXzQRTg=;
        b=eZXdYYUO9MJk8vDBz2ohUHhTlFQ6OUvKe5NJC3wwMup1+78yjzPuD0a1yqr7kKDAzn
         R6bakE9D6+2lnyfG457Nwws4+THsXyHBMV88kQa77cHLpoisL/FI1o5FbYjjD+Cho972
         a/pSRcvr7B/YCgFV1J8wk+jRpXIpqHPrPXkUbPz86UioJj5qwacgDmZn15UmH5MpjSIm
         NvmTKUXeA4shooBgG2EMsAcLL3Sm7nQ72CXnpIBnlTEibmiT3TrxdnaIeopIbHLfMDA9
         iCdUKJsTETkc/0yFfjDjJIJEzpVlInD/58X/THAjQ3ciF01RAOk751kpX86fuzJRi0o3
         d2OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pOjQrnVayTgdrET4gCgzOMQ7+VznZ1NPyMucBXzQRTg=;
        b=im5W9ds9G2tb1LIffJBVdjo6FKRMvXedDkQlplIvxaUJ4esXnjBBf5oX7ZwxCXFoVE
         HzYmeT4pzr23bXWFfiYSRKJLei+rZjPdG+9jlvSDk5xapH+5sWKkXC24OE83RWmLCYKz
         M8hyXx8pqaUsRdtjxRRGZurqiaJHB48v7Ge7quu+TTl2nZbcR0GdrrEFGYZDMnBXv5vs
         i9X17IAo9c3KxZmSuLABW59LRr+89QVL61Z9bKR/thNa7gIxKgiAQaCa15A/e6iMUGWv
         Nl2tLD9oXzGBpvpe0e9F/I0ORBL50IqXbfDhVl3Ng0rsXiehH/LBpZd5heuAVJvkdCSq
         5JCA==
X-Gm-Message-State: ANhLgQ1iaI6LB/7y8JS7HGrBD/rzJyzkhjJazNgNf6wi6R4WFqatEqc/
        1SwLRxxgs+L827Of+zo0UIU=
X-Google-Smtp-Source: ADFU+vsSzPj8KundN3q85Ksdo5biFKHHfX+UdUbQyTZOldP1FMJEG8vyFDHt7yRgWjL+jYyHW5T0Zg==
X-Received: by 2002:a17:90b:1a8b:: with SMTP id ng11mr201893pjb.173.1583954376003;
        Wed, 11 Mar 2020 12:19:36 -0700 (PDT)
Received: from localhost.localdomain ([103.46.201.94])
        by smtp.gmail.com with ESMTPSA id z17sm3792673pff.12.2020.03.11.12.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 12:19:35 -0700 (PDT)
From:   Aman Sharma <amanharitsh123@gmail.com>
Cc:     amanharitsh123@gmail.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH 4/5] pci: handled return value of platform_get_irq correctly
Date:   Thu, 12 Mar 2020 00:49:05 +0530
Message-Id: <b773b3b1ed25a0e6d5d826b6c43293473cbd24e7.1583952276.git.amanharitsh123@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1583952275.git.amanharitsh123@gmail.com>
References: <cover.1583952275.git.amanharitsh123@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Signed-off-by: Aman Sharma <amanharitsh123@gmail.com>
---
 drivers/pci/controller/pcie-tango.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-tango.c b/drivers/pci/controller/pcie-tango.c
index 21a208da3f59..18c2c4313eb5 100644
--- a/drivers/pci/controller/pcie-tango.c
+++ b/drivers/pci/controller/pcie-tango.c
@@ -273,9 +273,9 @@ static int tango_pcie_probe(struct platform_device *pdev)
 		writel_relaxed(0, pcie->base + SMP8759_ENABLE + offset);
 
 	virq = platform_get_irq(pdev, 1);
-	if (virq <= 0) {
+	if (virq < 0) {
 		dev_err(dev, "Failed to map IRQ\n");
-		return -ENXIO;
+		return virq;
 	}
 
 	irq_dom = irq_domain_create_linear(fwnode, MSI_MAX, &dom_ops, pcie);
-- 
2.20.1

