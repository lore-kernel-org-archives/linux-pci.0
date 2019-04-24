Return-Path: <SRS0=9smm=S2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB91EC282CE
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 19:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AD222183E
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 19:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KK4njm5c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388127AbfDXTRr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 24 Apr 2019 15:17:47 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43555 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732310AbfDXTRq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Apr 2019 15:17:46 -0400
Received: by mail-wr1-f68.google.com with SMTP id a12so3432422wrq.10;
        Wed, 24 Apr 2019 12:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+k7fklQVC1wXNkIsXxuBFFgxierE2Y58VYjajnqTX8M=;
        b=KK4njm5c66wApJlm8WGtcK3eINA7bZzqf9jpF/xDcoCSdcuGWR7ygTnW7CxGOT7Zpb
         ClJa1zpkc0LnLQ3Y9FSdXrMwgQvpBYbm2h61pKGsBRYXBFkHEnXr7h2wDgkaAsAj6P04
         n+Zhe79BzllwSlP7qQcQ1oNHfpi5n4yGvzSir6Qil6I+8IfT0AGlMW1C3bfb7hbIOrnv
         /TQKg5FQRX19gB+eGsG3WBIFJCSsQmuhe604FqNiT/pZUC4DClEWV5U3gwAbTgI70ma+
         +jCLa9iSGj52KBjpTWMg0o/2CwQGRZzVKsI7N71kUDVC8rL8yE29inQ1qfO+L+vf3GA3
         Zx2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+k7fklQVC1wXNkIsXxuBFFgxierE2Y58VYjajnqTX8M=;
        b=Q18H1v0Ex2k8R0yyIHpu9qv+ACIRRSDaxOHPlm2jkA3Nbk+QdULOcFHr1SXD5qhvRf
         K9nnbaNPuyYDFyXBRkbqGLXE9H54VGUKqzgYwtGNMRMnU2haZun7OjZpm+MNAu38AEQT
         X4OzBVbR0Eq7kAuJCkGGHCVA1OtKqDOsTW69I9HGwQ8beTtcD8gRWPy2nvDxi9/MnJCm
         an0JE+g2S2JVC2qMYb6RQTXT3JyATEOUfrsI+cRmZHxVQuV52k9MZom2PeTPLHMR7rjj
         WgsSOxLFKekyDgUHiCaMKZ9OhZm0Th4qEV2tS/nmYe85opoixPjm4s1iDTpREV0t4Iyy
         VIKw==
X-Gm-Message-State: APjAAAXP6lGYk9kRhiUfnxDJb58I2UAcCre2RG9clZ4QISyAPIJrLS7L
        yUtmRTYNb9XsDdQ5qMhf2QyLxHSyPMAhyQ==
X-Google-Smtp-Source: APXvYqwDmKBVeUMPZVGyJTnitTfK6cM0z/PsKemtuUUK1m2YTTQaoqWzBVErwIt/ROAiTYboFRIU3w==
X-Received: by 2002:a5d:5485:: with SMTP id h5mr377002wrv.315.1556133463901;
        Wed, 24 Apr 2019 12:17:43 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:5700:c498:ee8f:ff0a:13e5? (p200300EA8BD45700C498EE8FFF0A13E5.dip0.t-ipconnect.de. [2003:ea:8bd4:5700:c498:ee8f:ff0a:13e5])
        by smtp.googlemail.com with ESMTPSA id u1sm2183653wrp.69.2019.04.24.12.17.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 12:17:43 -0700 (PDT)
Subject: [PATCH v2 3/9] r8169: use new helper pci_dev_id
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Realtek linux nic maintainers <nic_swsd@realtek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        "open list:AMD KFD" <dri-devel@lists.freedesktop.org>,
        "open list:RADEON and AMDGPU DRM DRIVERS" 
        <amd-gfx@lists.freedesktop.org>,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        "open list:8169 10/100/1000 GIGABIT ETHERNET DRIVER" 
        <netdev@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>
References: <2e1f9a57-6d08-d017-24da-3e6b97fa2449@gmail.com>
Message-ID: <fec3960e-5e65-3f62-0922-736f26db095f@gmail.com>
Date:   Wed, 24 Apr 2019 21:13:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <2e1f9a57-6d08-d017-24da-3e6b97fa2449@gmail.com>
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




