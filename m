Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A245349D0
	for <linux-pci@vger.kernel.org>; Wed, 14 Oct 2026 17:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791999070; cv=none; b=FhzczVFxyOmqNTs2YfwYvgc280HH14VZUG8i3Chbh6uYsbRnkV8qBbb3XgqZkVvwfWCXUirR4BSVetZfpazDy9Nza9SeiJdPV2HN2MHWBUizRrZ8u6y3nvSmrhe8M2cBgWZCDjq2zYOAEro/MuOUWo0drhKA1sxDEX9cZNXSNoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791999070; c=relaxed/simple;
	bh=XH5YdSaslVVo13fXg5v8Iks7PAimZ9eCsGZ5SQVB0J4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=UdEu1xkQbussQSygq0gS3Nvy+j3ubOg2g7oNjssivew3Refvy6Itx4DeLfHbIQX8acbgkMtTqpgA/8M+JsZDWtPs59mOnkuhJXFotQmbrwV4ObtVRH51z6ID7Rm8FLVkfopZtP+tw65wLFLJT7uWAdrEU1NP+84IsZbl7ttN7bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ew9E9YA6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ew9E9YA6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 748B41F000C4;
	Wed, 14 Oct 2026 17:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791999067;
	bh=RYProyi5xNxC6zBZwCH3uv9Z1jW/dCeSE4umfM39R84=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=Ew9E9YA62Gv9M0AW8R0KVP6Iv2ggUxLjrY92VDMPj8bwdHOGNAzvuC3xiynzgK3Vr
	 CDsgLHyhDz11zSR8EaG8JjGG1LsFm5htvVBi0bVYadhyPq0ppl5yljuQaF/rpt9yS/
	 iuqFs3rysJ+WbjBU1H3B3R1lxNdVSW5Eosi35f80C/avRVyoKJ7sB/BR5fdlvxD7FN
	 BEuOMX+tMn/vQdipaTpTUMyoLSpOj9GLCMqMGnVt2SXBbU8BjVSTlDDhvbPo1ZkRM6
	 bsZQkKK6dEAqmJzVLdn3F8tzpuqjVlk+feF69lTCMCP6ciiZDHzdgygaioUaqpeKxh
	 WFBfAQe810rNA==
Date: Wed, 14 Oct 2026 12:31:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, changfengnan@bytedance.com,
	linux-pci@vger.kernel.org, tglx@kernel.org,
	namjain@linux.microsoft.com, Keith Busch <kbusch@kernel.org>,
	Luigi Rizzo <lrizzo@google.com>
Subject: Re: [RFC PATCH 2/3] PCI/MSI: Implement irq_mask_nowait() for MSI-x
Message-ID: <20261014173106.GA1643226@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013223543.395054-3-kbusch@meta.com>

[+cc Luigi, cover letter at
https://lore.kernel.org/all/20261013223543.395054-1-kbusch@meta.com]

On Tue, Oct 13, 2026 at 03:35:42PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Skip the read-back that flushes the MSI-x mask write. Parent domains
> that mask on behalf of PCI/MSI continue using their own irq_mask().
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>

I assume Thomas will review/ack the pci/msi/ parts.

Cc'd Luigi since I know he's interested in interrupt moderation in
general.

> ---
>  drivers/irqchip/irq-msi-lib.c | 1 +
>  drivers/pci/msi/irqdomain.c   | 6 ++++++
>  drivers/pci/msi/msi.h         | 8 +++++++-
>  3 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-msi-lib.c b/drivers/irqchip/irq-msi-lib.c
> index 45e0ed3134ce1..bff622b4839aa 100644
> --- a/drivers/irqchip/irq-msi-lib.c
> +++ b/drivers/irqchip/irq-msi-lib.c
> @@ -126,6 +126,7 @@ bool msi_lib_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
>  	 */
>  	if (info->flags & MSI_FLAG_PCI_MSI_MASK_PARENT) {
>  		chip->irq_mask		= irq_chip_mask_parent;
> +		chip->irq_mask_nowait	= NULL;
>  		chip->irq_unmask	= irq_chip_unmask_parent;
>  	}
>  
> diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
> index 6e65f0f44112e..92a53c2772659 100644
> --- a/drivers/pci/msi/irqdomain.c
> +++ b/drivers/pci/msi/irqdomain.c
> @@ -162,6 +162,11 @@ static void pci_irq_mask_msix(struct irq_data *data)
>  	pci_msix_mask(irq_data_get_msi_desc(data));
>  }
>  
> +static void pci_irq_mask_nowait_msix(struct irq_data *data)
> +{
> +	pci_msix_mask_nowait(irq_data_get_msi_desc(data));
> +}
> +
>  static void pci_irq_unmask_msix(struct irq_data *data)
>  {
>  	pci_msix_unmask(irq_data_get_msi_desc(data));
> @@ -182,6 +187,7 @@ static const struct msi_domain_template pci_msix_template = {
>  		.irq_startup		= pci_irq_startup_msix,
>  		.irq_shutdown		= pci_irq_shutdown_msix,
>  		.irq_mask		= pci_irq_mask_msix,
> +		.irq_mask_nowait	= pci_irq_mask_nowait_msix,
>  		.irq_unmask		= pci_irq_unmask_msix,
>  		.irq_write_msi_msg	= pci_msi_domain_write_msg,
>  		.flags			= IRQCHIP_ONESHOT_SAFE,
> diff --git a/drivers/pci/msi/msi.h b/drivers/pci/msi/msi.h
> index 0b420b319f50f..337ff9d9da0ed 100644
> --- a/drivers/pci/msi/msi.h
> +++ b/drivers/pci/msi/msi.h
> @@ -40,10 +40,16 @@ static inline void pci_msix_write_vector_ctrl(struct msi_desc *desc, u32 ctrl)
>  		writel(ctrl, desc_addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
>  }
>  
> -static inline void pci_msix_mask(struct msi_desc *desc)
> +/* Posted write only: the device may still send an interrupt after return */
> +static inline void pci_msix_mask_nowait(struct msi_desc *desc)
>  {
>  	desc->pci.msix_ctrl |= PCI_MSIX_ENTRY_CTRL_MASKBIT;
>  	pci_msix_write_vector_ctrl(desc, desc->pci.msix_ctrl);
> +}
> +
> +static inline void pci_msix_mask(struct msi_desc *desc)
> +{
> +	pci_msix_mask_nowait(desc);
>  	/* Flush write to device */
>  	readl(desc->pci.mask_base);
>  }
> -- 
> 2.52.0
> 
