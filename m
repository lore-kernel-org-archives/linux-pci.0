Return-Path: <SRS0=9smm=S2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04784C10F11
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 19:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7343218B0
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 19:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUzhCOH2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbfDXTSV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 24 Apr 2019 15:18:21 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39216 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbfDXTRx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Apr 2019 15:17:53 -0400
Received: by mail-wm1-f67.google.com with SMTP id n25so6647378wmk.4;
        Wed, 24 Apr 2019 12:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IeRjLmIo3+zL+ngn2z6PfEn9LxaA8z9ME0E/GMbJl4A=;
        b=TUzhCOH2F7RvxialpvgaUFfNbsBpgDv13m50OH+yCHXNzbKgkQ3+3J9fmVotTjHhZ+
         nT72Tzc880/U6F/39r2rOLBXumQ/j5RU5NezTirLrIrK8HKif6onpzxPkeL9+3b1vQq2
         1DjaR7ZH62jNLmGYqQQPFRrk8RastcZUjByEctXZYR9dDWVH50TBAdTissGRPJJFAaku
         yTmszbRe7C6g/MQlgrFC4qFKTUqOyA0NfxLlCq1xXJvcaq0cajMvWvopZxIRGurM8C5w
         Ky8/X9fshxb+9fnIfYrOG+f4N+cBIWfqByuQioMYFAZ1K6Xx48p3R+XHvkUnajpJttNi
         B/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IeRjLmIo3+zL+ngn2z6PfEn9LxaA8z9ME0E/GMbJl4A=;
        b=gBYh9EKknFeDZ6vp7h5UEhlflKVpCvgQvVX4iKsPWfvndOlLQd348fhy2z3KpJYAU2
         Ah58yrVJCtspu92pIUhzmuJQri6cgp7oFw85sg7D8PlvqJ6W3zJO3vLkyORIo38+wnh5
         Rc/ph9wAB87ydOw+YtzSuo5n+2AiDLw111Z0ubvu4DAOSea4xsO/Tfl/tYrU40rYcO3W
         GhHGuuRBEAYKX3fCrPKGf6TERadRhrJLqrGXBq1sELuOjbwhU8TdIrvgya02mIZXeWuN
         2WJZcN+3PPhln+inFvDEBRRk9p9lXXP3HKPCJh37C0pGs3wa7m4NTEAXC8xypSRrNws/
         dx/Q==
X-Gm-Message-State: APjAAAUgGxP/DcyzzPy0GoGmSCiZzeLoemI2cLTO80xULyOJekOMME/7
        7JiHKHxlqVidk4cGBZUhC7cHzXpMYHNKMA==
X-Google-Smtp-Source: APXvYqwLwnDZWORI7BhpqSdPQhydSnH4TJiDh5p2OFwPcJ1S0/zRXEp6j1rg2GAjg1ue7Rb470bFqw==
X-Received: by 2002:a1c:4c1a:: with SMTP id z26mr474306wmf.73.1556133471446;
        Wed, 24 Apr 2019 12:17:51 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:5700:c498:ee8f:ff0a:13e5? (p200300EA8BD45700C498EE8FFF0A13E5.dip0.t-ipconnect.de. [2003:ea:8bd4:5700:c498:ee8f:ff0a:13e5])
        by smtp.googlemail.com with ESMTPSA id a11sm16605685wrx.5.2019.04.24.12.17.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 12:17:50 -0700 (PDT)
Subject: [PATCH v2 6/9] iommu/amd: use helper pci_dev_id
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
Message-ID: <f673e8ac-cc9a-75a6-09b8-35b94bfc868b@gmail.com>
Date:   Wed, 24 Apr 2019 21:15:25 +0200
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
 drivers/iommu/amd_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index f467cc4b4..5cb201422 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -165,7 +165,7 @@ static inline u16 get_pci_device_id(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 
-	return PCI_DEVID(pdev->bus->number, pdev->devfn);
+	return pci_dev_id(pdev);
 }
 
 static inline int get_acpihid_device_id(struct device *dev,
-- 
2.21.0


