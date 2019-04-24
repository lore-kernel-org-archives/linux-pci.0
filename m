Return-Path: <SRS0=9smm=S2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7E6C282E1
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 19:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6701C2183E
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 19:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTBInYBe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732395AbfDXTRp (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 24 Apr 2019 15:17:45 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51536 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbfDXTRo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Apr 2019 15:17:44 -0400
Received: by mail-wm1-f66.google.com with SMTP id 4so6035691wmf.1;
        Wed, 24 Apr 2019 12:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kB/xsYXQ3pDchMWCMlizuJaQAcde2gxIfDs80kGqcvg=;
        b=CTBInYBeuOjwDz9xKf2KWhzfLNI5mxAnUPPI4BWhAfkSOE+IcGDVUG/LTdlVKn0Ey3
         kXb11SNQiqB+f2tzvApgE3K75ekW4vp4F4rKo2tfq2976kcwUhHVdM3czRnkLPBeL6j5
         fdW4sKALm8HMDXeA4HSw9r/5mjk7UzIUoGIP/nv52R1glLBQr7mNguwP52EfgA+EyV2y
         UwEmJLPtOAif4lWOA8h/nDGbj6w+XyJdLKMvrB4c3zYVVXyhWbkJC4hJRXUZS/KfsJKR
         V6GztvWZ9hBzwOPVfQYlkGM8eQYmznplt3VVqTmyEvx37Zhusc47WL3zc9FIPbwplUOL
         lGcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kB/xsYXQ3pDchMWCMlizuJaQAcde2gxIfDs80kGqcvg=;
        b=mPMvEe1RPpdvI10lVXGGChKzE9uz/wwMshyKA3OTItk+CQwrJIlXzfsxk1DWK62IHo
         ujMU2kFhMhozFDP3ECLB3McXpfVR8lhI7iGbecI9VCw/ASJbnawmGQftEq0KU1cPfoFS
         WyLxSVCrHu9FoMkuMGg9J8ImFeL69+x2qra9P4LtCFvVIGzuFcFfniQWrEM5/5krXp6r
         xybAnSZFHwTuy5ai4VBVPsQaplqRst7iuTkDYClWpljNu7AKRko6ulm9MQJlhSPZ6uhs
         UzYzpzxW5+FDQRhVEL5Kd/ZObHW3HZoaG76Nls+2Hl4N10IxKakDdO9NpMvI0Toz54IB
         mgOw==
X-Gm-Message-State: APjAAAUacWiwai63TNH9NH198QDqo4tO+Y0GB5KmGTxxCMlr9NpcwrZg
        ozmJmqsito5xqXTy8QPJBa3YZ7c9IF1qKw==
X-Google-Smtp-Source: APXvYqwLnC7/zIBsNJ0PEohfeeMVDSaWpOxoU/IBtJ5vk+4XlNCYrRJFKHauDYKLq545t4gZsrwWgA==
X-Received: by 2002:a1c:2087:: with SMTP id g129mr517222wmg.114.1556133461454;
        Wed, 24 Apr 2019 12:17:41 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:5700:c498:ee8f:ff0a:13e5? (p200300EA8BD45700C498EE8FFF0A13E5.dip0.t-ipconnect.de. [2003:ea:8bd4:5700:c498:ee8f:ff0a:13e5])
        by smtp.googlemail.com with ESMTPSA id x192sm30686484wmf.48.2019.04.24.12.17.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 12:17:40 -0700 (PDT)
Subject: [PATCH v2 2/9] PCI: use helper pci_dev_id
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
Message-ID: <9cc03738-f664-3896-d8eb-48146772a655@gmail.com>
Date:   Wed, 24 Apr 2019 21:12:45 +0200
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
 drivers/pci/msi.c    |  6 +++---
 drivers/pci/search.c | 10 +++-------
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 73986825d..e039b740f 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1338,7 +1338,7 @@ irq_hw_number_t pci_msi_domain_calc_hwirq(struct pci_dev *dev,
 					  struct msi_desc *desc)
 {
 	return (irq_hw_number_t)desc->msi_attrib.entry_nr |
-		PCI_DEVID(dev->bus->number, dev->devfn) << 11 |
+		pci_dev_id(dev) << 11 |
 		(pci_domain_nr(dev->bus) & 0xFFFFFFFF) << 27;
 }
 
@@ -1508,7 +1508,7 @@ static int get_msi_id_cb(struct pci_dev *pdev, u16 alias, void *data)
 u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev)
 {
 	struct device_node *of_node;
-	u32 rid = PCI_DEVID(pdev->bus->number, pdev->devfn);
+	u32 rid = pci_dev_id(pdev);
 
 	pci_for_each_dma_alias(pdev, get_msi_id_cb, &rid);
 
@@ -1531,7 +1531,7 @@ u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev)
 struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev)
 {
 	struct irq_domain *dom;
-	u32 rid = PCI_DEVID(pdev->bus->number, pdev->devfn);
+	u32 rid = pci_dev_id(pdev);
 
 	pci_for_each_dma_alias(pdev, get_msi_id_cb, &rid);
 	dom = of_msi_map_get_device_domain(&pdev->dev, rid);
diff --git a/drivers/pci/search.c b/drivers/pci/search.c
index 2b5f72086..5c7922612 100644
--- a/drivers/pci/search.c
+++ b/drivers/pci/search.c
@@ -33,7 +33,7 @@ int pci_for_each_dma_alias(struct pci_dev *pdev,
 	struct pci_bus *bus;
 	int ret;
 
-	ret = fn(pdev, PCI_DEVID(pdev->bus->number, pdev->devfn), data);
+	ret = fn(pdev, pci_dev_id(pdev), data);
 	if (ret)
 		return ret;
 
@@ -88,9 +88,7 @@ int pci_for_each_dma_alias(struct pci_dev *pdev,
 					return ret;
 				continue;
 			case PCI_EXP_TYPE_PCIE_BRIDGE:
-				ret = fn(tmp,
-					 PCI_DEVID(tmp->bus->number,
-						   tmp->devfn), data);
+				ret = fn(tmp, pci_dev_id(tmp), data);
 				if (ret)
 					return ret;
 				continue;
@@ -101,9 +99,7 @@ int pci_for_each_dma_alias(struct pci_dev *pdev,
 					 PCI_DEVID(tmp->subordinate->number,
 						   PCI_DEVFN(0, 0)), data);
 			else
-				ret = fn(tmp,
-					 PCI_DEVID(tmp->bus->number,
-						   tmp->devfn), data);
+				ret = fn(tmp, pci_dev_id(tmp), data);
 			if (ret)
 				return ret;
 		}
-- 
2.21.0




