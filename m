Return-Path: <SRS0=9smm=S2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB660C10F11
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 19:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A143205ED
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 19:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIXRJwuB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389612AbfDXTSJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 24 Apr 2019 15:18:09 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36051 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388804AbfDXTR7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Apr 2019 15:17:59 -0400
Received: by mail-wm1-f65.google.com with SMTP id h18so6654785wml.1;
        Wed, 24 Apr 2019 12:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SAbbSQG37YeApBp0oyHaMCbtBHNMxP+2zNJpk+CsD/M=;
        b=AIXRJwuB+H8CUQQMeS5qlpm0mA9MRtCpnvd55esAPnP4ZWf8RvpdvE922lJmqnVIpB
         3WTSTa1p1xLB/UPdSXHtSdMm3TwK0Ijnw5bZfpyK0oWvEVW3C09vKa1Q2aYpH2hWevRC
         LzFsybDvUKqNfYk+TG/LaBrmNyzjfxLPOoWGgrjG+moMF94/PiKjNMdt7AGAj8dA59K4
         1/Eg3DgVYvKL5GLVCx68IVgAiK56Pb2bmSAxMnuMtfO32YoCnamKsq6gqu71j44UcOgv
         4GZRg98MJRc10wCTTm84P0cCLZbrQhwuPU/OgImeBXnr5lQkDyGgHFjzV90i9GpJdHs7
         kLQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SAbbSQG37YeApBp0oyHaMCbtBHNMxP+2zNJpk+CsD/M=;
        b=DDTZKeDF/eTYhcOoYP/VjKb02JZ9ltmbd3Nyz5Oy9csIuO2NTDKajR8Ua3CwQ1pefd
         T5mEcH63MjRlShUjwgtDJPHMs3/+z8XGb4FP3SBNrwKtloOsJpIJEF2Z8lGVDMyQh1kO
         SuaPMfivj3SXLIK9PyDZ0FJdBiUfEzDF/bFpoxCw9xcv/2b+6F4ZeZLwK9MGnCzMeZJL
         Pdvt4h8M8uA/1pnSCHy48cfNTmw2n244z2jsJSE0bSoVG7PKsYuQXgmNQZj+QnBJ6cB/
         Rrp87Zcu8mu3P1JMX49I/DiwDq6yxr3/jR5OsO/bL+kiBUngHNdkHTiP6SAapobsH6Bg
         27DQ==
X-Gm-Message-State: APjAAAXv+IRqaFMpGzbEN1CyLTe0b1fBNBoCsQ1koP3HwHyGVFXGYpNe
        hQm8jH5LYttibDYjkLwXoTOkSdg2+vg=
X-Google-Smtp-Source: APXvYqz1FxREHsjxcSzzKYBRZR1hyc+jklGgIQJ7OMGK1qrzBngr1H8WAm880vG55Y8yYFtfRLfERA==
X-Received: by 2002:a1c:f50a:: with SMTP id t10mr473319wmh.86.1556133476436;
        Wed, 24 Apr 2019 12:17:56 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:5700:c498:ee8f:ff0a:13e5? (p200300EA8BD45700C498EE8FFF0A13E5.dip0.t-ipconnect.de. [2003:ea:8bd4:5700:c498:ee8f:ff0a:13e5])
        by smtp.googlemail.com with ESMTPSA id q202sm4917605wme.9.2019.04.24.12.17.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 12:17:55 -0700 (PDT)
Subject: [PATCH v2 8/9] stmmac: pci: use helper pci_dev_id
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
Message-ID: <82febf42-5f1e-a5d1-5c38-40dcaefdf700@gmail.com>
Date:   Wed, 24 Apr 2019 21:16:41 +0200
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
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
index cc1e887e4..0e87a9596 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
@@ -208,7 +208,7 @@ static int quark_default_data(struct pci_dev *pdev,
 		ret = 1;
 	}
 
-	plat->bus_id = PCI_DEVID(pdev->bus->number, pdev->devfn);
+	plat->bus_id = pci_dev_id(pdev);
 	plat->phy_addr = ret;
 	plat->interface = PHY_INTERFACE_MODE_RMII;
 
-- 
2.21.0


