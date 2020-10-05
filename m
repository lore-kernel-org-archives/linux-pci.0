Return-Path: <SRS0=jvhy=DM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395DEC4363A
	for <linux-pci@archiver.kernel.org>; Mon,  5 Oct 2020 11:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F162F207F7
	for <linux-pci@archiver.kernel.org>; Mon,  5 Oct 2020 11:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbgJELXX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 5 Oct 2020 07:23:23 -0400
Received: from foss.arm.com ([217.140.110.172]:44582 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbgJELXX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 5 Oct 2020 07:23:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64547106F;
        Mon,  5 Oct 2020 04:23:22 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A8D53F66B;
        Mon,  5 Oct 2020 04:23:21 -0700 (PDT)
Date:   Mon, 5 Oct 2020 12:23:15 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     linux-pci@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        You-Sheng Yang <vicamo.yang@canonical.com>
Subject: Re: [PATCH v3] PCI: vmd: Offset Client VMD MSI-X vectors
Message-ID: <20201005112315.GA12904@e121166-lin.cambridge.arm.com>
References: <20200914190128.5114-1-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914190128.5114-1-jonathan.derrick@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 14, 2020 at 03:01:28PM -0400, Jon Derrick wrote:
> Client VMD platforms have a software-triggered MSI-X vector 0 that will
> not forward hardware-remapped MSI from the sub-device domain. This
> causes an issue with VMD platforms that use AHCI behind VMD and have a
> single MSI-X vector remapped to VMD vector 0. Add a VMD MSI-X vector
> offset for these platforms.
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> ---
> v3: Commit MSI-X cleanup
>     vmd_next_irq check fix per Keith
> 
>  drivers/pci/controller/vmd.c | 37 +++++++++++++++++++++++++-----------
>  1 file changed, 26 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index f69ef8c89f72..10c0d20190e0 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -53,6 +53,12 @@ enum vmd_features {
>  	 * vendor-specific capability space
>  	 */
>  	VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP	= (1 << 2),
> +
> +	/*
> +	 * Device may use MSI-X vector 0 for software triggering and will not
> +	 * be used for MSI remapping
> +	 */
> +	VMD_FEAT_OFFSET_FIRST_VECTOR		= (1 << 3),
>  };
>  
>  /*
> @@ -104,6 +110,7 @@ struct vmd_dev {
>  	struct irq_domain	*irq_domain;
>  	struct pci_bus		*bus;
>  	u8			busn_start;
> +	u8			first_vec;
>  };
>  
>  static inline struct vmd_dev *vmd_from_bus(struct pci_bus *bus)
> @@ -199,25 +206,26 @@ static irq_hw_number_t vmd_get_hwirq(struct msi_domain_info *info,
>   */
>  static struct vmd_irq_list *vmd_next_irq(struct vmd_dev *vmd, struct msi_desc *desc)
>  {
> -	int i, best = 1;
>  	unsigned long flags;
> +	int i, best;
>  
> -	if (vmd->msix_count == 1)
> -		return &vmd->irqs[0];
> +	if (vmd->msix_count == 1 + vmd->first_vec)
> +		return &vmd->irqs[vmd->first_vec];
>  
>  	/*
> -	 * White list for fast-interrupt handlers. All others will share the
> +	 * Allow list for fast-interrupt handlers. All others will share the

Is this comment change related to this patch logical change ?

Other than that ready to merge it, please let me know.

Thanks,
Lorenzo

>  	 * "slow" interrupt vector.
>  	 */
>  	switch (msi_desc_to_pci_dev(desc)->class) {
>  	case PCI_CLASS_STORAGE_EXPRESS:
>  		break;
>  	default:
> -		return &vmd->irqs[0];
> +		return &vmd->irqs[vmd->first_vec];
>  	}
>  
>  	raw_spin_lock_irqsave(&list_lock, flags);
> -	for (i = 1; i < vmd->msix_count; i++)
> +	best = vmd->first_vec + 1;
> +	for (i = best; i < vmd->msix_count; i++)
>  		if (vmd->irqs[i].count < vmd->irqs[best].count)
>  			best = i;
>  	vmd->irqs[best].count++;
> @@ -629,6 +637,7 @@ static irqreturn_t vmd_irq(int irq, void *data)
>  
>  static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  {
> +	unsigned long features = (unsigned long) id->driver_data;
>  	struct vmd_dev *vmd;
>  	int i, err;
>  
> @@ -653,12 +662,15 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  	    dma_set_mask_and_coherent(&dev->dev, DMA_BIT_MASK(32)))
>  		return -ENODEV;
>  
> +	if (features & VMD_FEAT_OFFSET_FIRST_VECTOR)
> +		vmd->first_vec = 1;
> +
>  	vmd->msix_count = pci_msix_vec_count(dev);
>  	if (vmd->msix_count < 0)
>  		return -ENODEV;
>  
> -	vmd->msix_count = pci_alloc_irq_vectors(dev, 1, vmd->msix_count,
> -					PCI_IRQ_MSIX);
> +	vmd->msix_count = pci_alloc_irq_vectors(dev, vmd->first_vec + 1,
> +						vmd->msix_count, PCI_IRQ_MSIX);
>  	if (vmd->msix_count < 0)
>  		return vmd->msix_count;
>  
> @@ -755,13 +767,16 @@ static const struct pci_device_id vmd_ids[] = {
>  				VMD_FEAT_HAS_BUS_RESTRICTIONS,},
>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x467f),
>  		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
> -				VMD_FEAT_HAS_BUS_RESTRICTIONS,},
> +				VMD_FEAT_HAS_BUS_RESTRICTIONS |
> +				VMD_FEAT_OFFSET_FIRST_VECTOR,},
>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x4c3d),
>  		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
> -				VMD_FEAT_HAS_BUS_RESTRICTIONS,},
> +				VMD_FEAT_HAS_BUS_RESTRICTIONS |
> +				VMD_FEAT_OFFSET_FIRST_VECTOR,},
>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
>  		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
> -				VMD_FEAT_HAS_BUS_RESTRICTIONS,},
> +				VMD_FEAT_HAS_BUS_RESTRICTIONS |
> +				VMD_FEAT_OFFSET_FIRST_VECTOR,},
>  	{0,}
>  };
>  MODULE_DEVICE_TABLE(pci, vmd_ids);
> -- 
> 2.18.1
> 
