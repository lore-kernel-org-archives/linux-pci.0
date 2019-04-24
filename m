Return-Path: <SRS0=9smm=S2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD97C282CE
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 19:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D05D8205ED
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 19:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWGOnKfd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389533AbfDXTSC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 24 Apr 2019 15:18:02 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39229 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389451AbfDXTSB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Apr 2019 15:18:01 -0400
Received: by mail-wm1-f67.google.com with SMTP id n25so6647929wmk.4;
        Wed, 24 Apr 2019 12:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HyUIjv1ZcTz3BJRhp2dFVjFVc8FZkCvFMerRUJk35rs=;
        b=mWGOnKfdu64PXdK4VkEsSESr1A3fAGLATh3SgnROHhCWvMZgDNu3SbfVQoPybvG9pK
         eigLrw6HkNx5eSa60OFNw6I6AzBlh0qp0v52mQi8APrNqu/ZnNdmaA+iKPOVsqt2sCoO
         UOUnXM4kOp9PKJ9lKXwfABww/PaNtFz+94XxKPe2LJODsi37G30Gy73vot5PxxNWqeiU
         hxNThydhzbWKbCUtL5M5CZw60KzQgBVKTQSh5IWajOiiGVoJwP0oDJwDu0qP8ZACVfS0
         vA0rmAJ6uWd6gloEFSDqu1PVRiB4HPHDDZoCDdJeh3wY72Eu3UBBlWTKHV+DIA2o1TxV
         vjqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HyUIjv1ZcTz3BJRhp2dFVjFVc8FZkCvFMerRUJk35rs=;
        b=hVlyt6uN5BHkc3rEd9vxUFsgBManGqjIwPTxo9vzIT6quJrgDk3AvwcVtBAVDespnY
         oTks6jiyODo4xLdiFgd8j/6OUXV3e1TtWXyyq2pJsnOezyTaPYvKyreuDlySNaZKyWXz
         glRJ8Vn4gQ0pAp3FofVKaGAAu5MSV8Wl97ZJ2TcrmweXncV1Ks/ewtnh1WTdCAFQmVT/
         v1vCPdS21SI0DoixXLaXxEUjsiGUPxc+6CJzPDzTxkbbNTBeJJiov0rhnKLypnFsB+Nt
         rn46awZAmo1JsJg0e65KxoNsM9agrGgGy0+ULTPJW5BjNTWGlLX9hlwcmAM2w+F1IbPS
         V7JA==
X-Gm-Message-State: APjAAAXOahAPzrFw3MKpZCtI58yvx/J90G3Xe6kfaWF/tgCZkBSh9Mek
        8sf9//q+/FJYsYs7Hjprt7KI2t2oWN4=
X-Google-Smtp-Source: APXvYqwh3CNfCKJTs9MOTu4bXqWdzGeM/Qp5h/VOnaJHwwOVsZkGf5/cSOBP+OP8er+qIAMJlFmteg==
X-Received: by 2002:a1c:9c03:: with SMTP id f3mr478703wme.67.1556133478847;
        Wed, 24 Apr 2019 12:17:58 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:5700:c498:ee8f:ff0a:13e5? (p200300EA8BD45700C498EE8FFF0A13E5.dip0.t-ipconnect.de. [2003:ea:8bd4:5700:c498:ee8f:ff0a:13e5])
        by smtp.googlemail.com with ESMTPSA id t17sm17033907wrr.26.2019.04.24.12.17.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 12:17:58 -0700 (PDT)
Subject: [PATCH v2 9/9] platform/chrome: chromeos_laptop: use helper
 pci_dev_id
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
Message-ID: <e882f58b-0808-952e-d293-5e8cc3f04c97@gmail.com>
Date:   Wed, 24 Apr 2019 21:17:19 +0200
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
 drivers/platform/chrome/chromeos_laptop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/chromeos_laptop.c b/drivers/platform/chrome/chromeos_laptop.c
index 24326eecd..7abbb6167 100644
--- a/drivers/platform/chrome/chromeos_laptop.c
+++ b/drivers/platform/chrome/chromeos_laptop.c
@@ -125,7 +125,7 @@ static bool chromeos_laptop_match_adapter_devid(struct device *dev, u32 devid)
 		return false;
 
 	pdev = to_pci_dev(dev);
-	return devid == PCI_DEVID(pdev->bus->number, pdev->devfn);
+	return devid == pci_dev_id(pdev);
 }
 
 static void chromeos_laptop_check_adapter(struct i2c_adapter *adapter)
-- 
2.21.0


