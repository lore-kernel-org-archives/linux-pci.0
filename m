Return-Path: <SRS0=9smm=S2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC986C282CE
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 19:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B78E21900
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 19:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9/VNW2z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389482AbfDXTR6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 24 Apr 2019 15:17:58 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54074 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389451AbfDXTR4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Apr 2019 15:17:56 -0400
Received: by mail-wm1-f66.google.com with SMTP id 26so212779wmj.3;
        Wed, 24 Apr 2019 12:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L7OMDqn053nsdqraX4ZA3guqlyVTDUsFXQaouF1/Gos=;
        b=f9/VNW2zxOMYFkwIrmd9gbXTTDyAPJldpW0jlqhc9ddqz/XExcnPvUBW2cuC7iHYM3
         X8sWEHPyq9nl5S69NEsfykmeiFCZbevHNdIJJgmHPsizhhWl3oiNih/U1mpX9mO9RGFS
         KM259Aqjr8WT/9cB8GP0T95XxV9rqSCvyVkiuYo4c3RfkmvfNBiLbt/GpLG7igafuNss
         0UqWwQWIKRUnf6Oj2yQ1TbESq80ZDjagj7yMKikfjntdayHK1k3hrrzsjj3j3M7dIK3l
         pEEm3SCuep4hIm6x/NT02bJpFetnVPIX1ICUNx0+JawhL4nuIXclauj3K/iR0qSrEfle
         NQMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L7OMDqn053nsdqraX4ZA3guqlyVTDUsFXQaouF1/Gos=;
        b=RQczgV6Nd6x42hBFixazgdrWdHK4lZwLIl8dnFY1T/U16IeojnyCNIChDoR81KS2aI
         WRic1PvMUJeGJZieAD/QZksqAHkBCKY8MMDxwIgg23eMy6YqOSB2UJpr5BrBak7P0ydr
         TYsYjutZd4/X6TKy3fY0ZyP7sJpTvsv1G8ZgzWqQyBQ0DMYx+6J/dy2Gt4EXJ0w858bG
         5AcnjkD8LS2gcl0aWsVJJLOfHgLSrM17JVPN1WeIenZV7aHrJaaApRjEWhgUvWSfkpaV
         XTP6o4Xi0CSCVye83V7jA0lqmpmlENf36dHzHARU1H6ut72uPwzAYTGs+SxidU5cpe9V
         Ds9w==
X-Gm-Message-State: APjAAAV/Zt3wBw7jDMdQtvqD3ICto6iWZq1HMotXzosFpnaZCzaJmrTp
        auNXAHR5pnhLo7u4A5miV1pCRPFezcc=
X-Google-Smtp-Source: APXvYqwx9IkvpF+W2lsA3mJH7M+n+CqCAXpBhPx/pthS51v7A1zJHA2H9Ks26cyCm8y+AFp3wsoEFA==
X-Received: by 2002:a7b:c446:: with SMTP id l6mr489308wmi.80.1556133473878;
        Wed, 24 Apr 2019 12:17:53 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:5700:c498:ee8f:ff0a:13e5? (p200300EA8BD45700C498EE8FFF0A13E5.dip0.t-ipconnect.de. [2003:ea:8bd4:5700:c498:ee8f:ff0a:13e5])
        by smtp.googlemail.com with ESMTPSA id u17sm37513417wmu.36.2019.04.24.12.17.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 12:17:53 -0700 (PDT)
Subject: [PATCH v2 7/9] iommu/vt-d: use helper pci_dev_id
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
Message-ID: <0889204c-18aa-8a5f-1781-aaf32ee5beba@gmail.com>
Date:   Wed, 24 Apr 2019 21:16:10 +0200
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
 drivers/iommu/intel-iommu.c         | 2 +-
 drivers/iommu/intel_irq_remapping.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index d93c4bd7d..3f475a23a 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1391,7 +1391,7 @@ static void iommu_enable_dev_iotlb(struct device_domain_info *info)
 
 		/* pdev will be returned if device is not a vf */
 		pf_pdev = pci_physfn(pdev);
-		info->pfsid = PCI_DEVID(pf_pdev->bus->number, pf_pdev->devfn);
+		info->pfsid = pci_dev_id(pf_pdev);
 	}
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index 634d8f059..4160aa9f3 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -424,7 +424,7 @@ static int set_msi_sid(struct irte *irte, struct pci_dev *dev)
 		set_irte_sid(irte, SVT_VERIFY_SID_SQ, SQ_ALL_16, data.alias);
 	else
 		set_irte_sid(irte, SVT_VERIFY_SID_SQ, SQ_ALL_16,
-			     PCI_DEVID(dev->bus->number, dev->devfn));
+			     pci_dev_id(dev));
 
 	return 0;
 }
-- 
2.21.0


