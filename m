Return-Path: <SRS0=PPlZ=SV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C8EC282DF
	for <linux-pci@archiver.kernel.org>; Fri, 19 Apr 2019 18:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55CFD20449
	for <linux-pci@archiver.kernel.org>; Fri, 19 Apr 2019 18:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnSrzDVQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbfDSSaA (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:30:00 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37721 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbfDSS37 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Apr 2019 14:29:59 -0400
Received: by mail-wm1-f68.google.com with SMTP id v14so7215768wmf.2;
        Fri, 19 Apr 2019 11:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+k7fklQVC1wXNkIsXxuBFFgxierE2Y58VYjajnqTX8M=;
        b=KnSrzDVQ439anku7anz/nTTVQk1O9lOrSy852kzvujzWkgbzZW9IuHBCsuMx6+0SEq
         SPVD7Dst1hh3MopFdfaLd9BZAv9y7Ut738zVGT9fAhS5EYf5xBj7ak1QJ+nQCeOkQ3AW
         ZT53cJ4o/V3IS7Vwi9TvK6YZBhcMujiodaoFueRbIj5oRBopQWN+66GqANd72ChOlCgJ
         30h8s+p7Xx7TXBaw/s+K//BhSF/AEHo89Xi4jfAWObO/Rx77jTkkIaY2L335D92BCOMm
         h3sHsRnJ9qXvuOkzKydHKj7EEw07dLsUye1M/gIY6fobdD6ClMuyJ5/rDA0XyavZc45M
         Kc6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+k7fklQVC1wXNkIsXxuBFFgxierE2Y58VYjajnqTX8M=;
        b=Uyqp6dRaVrfDRy7ehZ9F5CZtw5IYs/LUIT533xdISxk3EewbTHF+8W0nYteDVJktXE
         j6PuIXRL463UMElYEhFBi4QAae94VIYY39mMegudtvA0STOjisuK//USEqE4r8MeW/xs
         wX4vceEH0pd/FM1HPGPYqSoU6VubvXq9Hand2z398XrTT5jlVP8Uo3+9ud9+EDmaPAlj
         bKWLm8Xr4MUPWxb2SsJx1TK3rttskn9f2lPm/cNoKr8Aku1Bz/UOFB/CgueNroNK4l8e
         js4Ju23PHgopCktE02X3d2HzWdnmgIsegaA0akLuqf80E9ZR6YqDy5u1oA+7y01n7wrn
         NrGg==
X-Gm-Message-State: APjAAAX7k/Bo45JRGpI8l6DMGXi78EN2I6D2VkKpi7hMxCJZtjYaYU85
        Vwa5678mY7e29Nh1fYfYMQT1F+Iq
X-Google-Smtp-Source: APXvYqyGlr5B0JZef0WFZBRi3W65lcfH8G0CXJGEAYBnosLFYx4rw9SYFnVIkHOSSRXKZGogNDIhgw==
X-Received: by 2002:a05:600c:219:: with SMTP id 25mr3460440wmi.7.1555698597817;
        Fri, 19 Apr 2019 11:29:57 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:5700:584:3262:bfe6:7518? (p200300EA8BD4570005843262BFE67518.dip0.t-ipconnect.de. [2003:ea:8bd4:5700:584:3262:bfe6:7518])
        by smtp.googlemail.com with ESMTPSA id i18sm4315465wrm.7.2019.04.19.11.29.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 11:29:57 -0700 (PDT)
Subject: [PATCH 3/3] r8169: use new helper pci_dev_id
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <b193514c-23d1-e090-7ddb-40371595f3a7@gmail.com>
Message-ID: <ddcac887-95f5-c6b7-c27b-33920edd9ca1@gmail.com>
Date:   Fri, 19 Apr 2019 20:29:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <b193514c-23d1-e090-7ddb-40371595f3a7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use new helper pci_dev_id() to simplify the code.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
index efaea1a0a..ae476fe8d 100644
--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -7020,8 +7020,7 @@ static int r8169_mdio_register(struct rtl8169_private *tp)
 	new_bus->priv = tp;
 	new_bus->parent = &pdev->dev;
 	new_bus->irq[0] = PHY_IGNORE_INTERRUPT;
-	snprintf(new_bus->id, MII_BUS_ID_SIZE, "r8169-%x",
-		 PCI_DEVID(pdev->bus->number, pdev->devfn));
+	snprintf(new_bus->id, MII_BUS_ID_SIZE, "r8169-%x", pci_dev_id(pdev));
 
 	new_bus->read = r8169_mdio_read_reg;
 	new_bus->write = r8169_mdio_write_reg;
-- 
2.21.0



