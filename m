Return-Path: <SRS0=ROz5=S4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B01C43218
	for <linux-pci@archiver.kernel.org>; Fri, 26 Apr 2019 13:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F0D82089E
	for <linux-pci@archiver.kernel.org>; Fri, 26 Apr 2019 13:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbfDZNrb (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 26 Apr 2019 09:47:31 -0400
Received: from 8bytes.org ([81.169.241.247]:37696 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbfDZNra (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 26 Apr 2019 09:47:30 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 590925F7; Fri, 26 Apr 2019 15:47:29 +0200 (CEST)
Date:   Fri, 26 Apr 2019 15:47:28 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
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
        Paul Mackerras <paulus@samba.org>,
        open list <linux-kernel@vger.kernel.org>,
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
Subject: Re: [PATCH v2 7/9] iommu/vt-d: use helper pci_dev_id
Message-ID: <20190426134727.GE24576@8bytes.org>
References: <2e1f9a57-6d08-d017-24da-3e6b97fa2449@gmail.com>
 <0889204c-18aa-8a5f-1781-aaf32ee5beba@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0889204c-18aa-8a5f-1781-aaf32ee5beba@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 24, 2019 at 09:16:10PM +0200, Heiner Kallweit wrote:
> Use new helper pci_dev_id() to simplify the code.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Joerg Roedel <jroedel@suse.de>

> ---
>  drivers/iommu/intel-iommu.c         | 2 +-
>  drivers/iommu/intel_irq_remapping.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index d93c4bd7d..3f475a23a 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -1391,7 +1391,7 @@ static void iommu_enable_dev_iotlb(struct device_domain_info *info)
>  
>  		/* pdev will be returned if device is not a vf */
>  		pf_pdev = pci_physfn(pdev);
> -		info->pfsid = PCI_DEVID(pf_pdev->bus->number, pf_pdev->devfn);
> +		info->pfsid = pci_dev_id(pf_pdev);
>  	}
>  
>  #ifdef CONFIG_INTEL_IOMMU_SVM
> diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
> index 634d8f059..4160aa9f3 100644
> --- a/drivers/iommu/intel_irq_remapping.c
> +++ b/drivers/iommu/intel_irq_remapping.c
> @@ -424,7 +424,7 @@ static int set_msi_sid(struct irte *irte, struct pci_dev *dev)
>  		set_irte_sid(irte, SVT_VERIFY_SID_SQ, SQ_ALL_16, data.alias);
>  	else
>  		set_irte_sid(irte, SVT_VERIFY_SID_SQ, SQ_ALL_16,
> -			     PCI_DEVID(dev->bus->number, dev->devfn));
> +			     pci_dev_id(dev));
>  
>  	return 0;
>  }
> -- 
> 2.21.0
> 
