Return-Path: <SRS0=PPlZ=SV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05ED5C282DF
	for <linux-pci@archiver.kernel.org>; Fri, 19 Apr 2019 18:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B932D20449
	for <linux-pci@archiver.kernel.org>; Fri, 19 Apr 2019 18:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VEheSSdV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbfDSSaS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:30:18 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34901 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbfDSSaS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Apr 2019 14:30:18 -0400
Received: by mail-wr1-f66.google.com with SMTP id o12so4539542wrn.2;
        Fri, 19 Apr 2019 11:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=+k7fklQVC1wXNkIsXxuBFFgxierE2Y58VYjajnqTX8M=;
        b=VEheSSdVL8xcEk5WIbzmxNBN0LRVx0rC1MT6Cy75WEkcRSKh9T+2UtQEiNBnrMOC5l
         ONnPX6dSUbLO8IUUFWErCJi72VsQ7zzatlQ5Yg7j2LtMzK/F2lxVEShnCCAVmtvb4aBG
         MiBIV1DALHVbvSfQn+iyeSeGEf++ts7tNQiOQOdP01aJM4oBLrUhrklg0RTvJiw5X+rE
         DPmtz0dqF/plKZpdwdTT1Pc5U00fRN0yj9k3CI721jVs/p2q232PT4Vv2Ng/mDgqIkpT
         JWnNX2Bh6vAB/7G5PKNxzuzw1jTbV8zDSTaLokugyIZCSn2qMW2n7dQxX8MC44In4kvu
         egHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+k7fklQVC1wXNkIsXxuBFFgxierE2Y58VYjajnqTX8M=;
        b=mGOkn9C+YHLrd0XX32OTFQ38ApJ0J/IGgOMmB/2t4EBJsyiHjl07fRZBl1D8M3I5KQ
         SSRT2XPkFpF8FZTVwmZWqFZzgMbjCn0WfAu3Ke8iJR/xH9E1LVHyVM5vvLod8WtoDT3h
         XcGOH22LLl9sDJjXFiIenkwG/GIAaJwO/1pX/D6F7gVAIQAv0z7SB8Ug9lj4/bK9WfyK
         wxilrSIXI4b9qM3is58MqkTYivUlPZz05/Mpa6FeH/ReRZUb3srpAWlKF2NXgurku21S
         lkge8JANOb3SYQQkFzFQColPRYj+I3nt6aWsBQdBQEDXvUqZ6CQ8TE9dtL4DEu5zcnsS
         6WYA==
X-Gm-Message-State: APjAAAXyGJ0lmVBkLoBH1LX0E/Ijg6q1Ilc9SdkPHyNmOOmZ81eApXhA
        iI7fyL3mD0zpwarDF3GPxFPRQLom
X-Google-Smtp-Source: APXvYqxAS0VW7ubMQH9lHmT8YRuJHNgWO9dAC7OqIXv8qbIN1Ytqsp30R6rUcimb5ORYq3FV65+ekg==
X-Received: by 2002:adf:dc4a:: with SMTP id m10mr2538448wrj.0.1555672234349;
        Fri, 19 Apr 2019 04:10:34 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:5700:584:3262:bfe6:7518? (p200300EA8BD4570005843262BFE67518.dip0.t-ipconnect.de. [2003:ea:8bd4:5700:584:3262:bfe6:7518])
        by smtp.googlemail.com with ESMTPSA id x12sm2878752wrl.34.2019.04.19.04.10.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 04:10:33 -0700 (PDT)
Subject: [PATCH 3/3] r8169: use new helper pci_dev_id
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <b352964f-a9a4-c8eb-520c-19b4dca4fba1@gmail.com>
Message-ID: <061caba3-7648-4b20-14a6-b26c7f29d194@gmail.com>
Date:   Fri, 19 Apr 2019 13:10:13 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <b352964f-a9a4-c8eb-520c-19b4dca4fba1@gmail.com>
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


