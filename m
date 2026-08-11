Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F2B388E69;
	Tue, 11 Aug 2026 21:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786482697; cv=none; b=cchWeK4Kd2WsAW4BiBBQ845WWK6BCJcNDNnMpjF/c53nuYM7GQSn+Tf/shblIYIvMo0n5q4X4wxpepMvh9wbMjwM3elVcSFPEFK74KUFGdz64/398EeAzM/YAE7+M0jwGixWJ9psAeJITJm0B0jS5Nb5icPbTePos0kfN5BCFBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786482697; c=relaxed/simple;
	bh=726ER7+Rkh0JZGmxUeVNdHZr78o6KgDj3SrToq7xTXA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OfZao2lckIND0oz7I9//3yVExICewAYLbTXdJV+PvbHcKCVM/FNUipH1bztXF5CsmIu4GmHp/rI1BN3cSubBlG+mXmpfr28lu+rzojU5riyX8HFcT+oFIdcDtgWz9AEUv5OvEYGtyJ8yKQIX0wisMILAvZsR+esAneUgl97t8QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QfUz9R4O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QfUz9R4O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531041F000E9;
	Tue, 11 Aug 2026 21:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786482695;
	bh=ILHdH4cXPBLxh6nT49wDappOv61AuAEjgVWm00tLVfU=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=QfUz9R4OiStbSCsEWR+GbTH/C+WSY/eyjF+98JE0AfmbQtgLP4sijxWm3jsSFksuU
	 1X1tpASEr0+RciwCt7XEHtZxfN0I4XEfi188aY46wrzit4wPixGDZwST0bDBJ8n7Sp
	 E4/Tzdi5cYLl7TSIMvkkzHvx+r2V25+coW7XG0UdWVNCxJrdP79YtoKR0CLf2ZXbK1
	 uLvCsUG5XfI/f6AAO58IGlLZPcKtOE1RhQmIqn3z6SNbA5NoKXM4EjdBKAo+oGQyJ8
	 j9TFkOVr1+wWFiU5MwIZ2BFRzgY8JC3JBh0SJJciMsw/+UZRDvL67d1iSFG9yBMgqs
	 v0037z5NTLzrA==
Date: Tue, 11 Aug 2026 16:11:34 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: bhelgaas@google.com, kwilczynski@kernel.org, aliceryhl@google.com,
	daniel.almeida@collabora.com, ojeda@kernel.org, boqun@kernel.org,
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
	a.hindborg@kernel.org, tmgross@umich.edu, tamird@kernel.org,
	acourbot@nvidia.com, work@onurozkan.dev, jhubbard@nvidia.com,
	ttabi@nvidia.com, apopple@nvidia.com, ecourtney@nvidia.com,
	shashanks@nvidia.com, zhiw@nvidia.com, driver-core@lists.linux.dev,
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] PCI: add pci_irq_type() to query the allocated
 interrupt type
Message-ID: <20260811211134.GA678959@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810224800.2314458-5-dakr@kernel.org>

On Tue, Aug 11, 2026 at 12:47:43AM +0200, Danilo Krummrich wrote:
> Add a helper that returns PCI_IRQ_MSIX, PCI_IRQ_MSI, or PCI_IRQ_INTX
> based on the interrupt type the PCI core selected after
> pci_alloc_irq_vectors().
> 
> Several drivers already open-code this check against pdev->msix_enabled
> and pdev->msi_enabled, or even open code this helper [1].
> 
> A common helper avoids the duplication and keeps drivers from accessing
> the bitfield directly (see also [2]).
> 
> Link: https://elixir.bootlin.com/linux/v7.1/source/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c#L196 [1]
> Inspired-by: John Hubbard <jhubbard@nvidia.com>
> Link: https://lore.kernel.org/all/DKKG2QM3YJYB.Z2H2B2UXJ75N@kernel.org/ [2]
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

In the subject line, to match drivers/pci/ history,

  PCI: Add pci_irq_type() ...

> ---
>  include/linux/pci.h | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 64b308b6e61c..80b8561b5be0 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1783,6 +1783,26 @@ void pci_free_irq_vectors(struct pci_dev *dev);
>  int pci_irq_vector(struct pci_dev *dev, unsigned int nr);
>  const struct cpumask *pci_irq_get_affinity(struct pci_dev *pdev, int vec);
>  
> +/**
> + * pci_irq_type - Get the interrupt type of a PCI device
> + * @pdev: the PCI device to operate on
> + *
> + * Discriminate the interrupt type the PCI core selected for this device
> + * after a successful pci_alloc_irq_vectors() call.
> + *
> + * Return: %PCI_IRQ_MSIX, %PCI_IRQ_MSI, or %PCI_IRQ_INTX.
> + */
> +static inline unsigned int pci_irq_type(struct pci_dev *pdev)
> +{
> +	if (pdev->msix_enabled)
> +		return PCI_IRQ_MSIX;
> +
> +	if (pdev->msi_enabled)
> +		return PCI_IRQ_MSI;
> +
> +	return PCI_IRQ_INTX;
> +}
> +
>  #else
>  static inline int pci_msi_vec_count(struct pci_dev *dev) { return -ENOSYS; }
>  static inline void pci_disable_msi(struct pci_dev *dev) { }
> @@ -1845,6 +1865,11 @@ static inline const struct cpumask *pci_irq_get_affinity(struct pci_dev *pdev,
>  {
>  	return cpu_possible_mask;
>  }
> +
> +static inline unsigned int pci_irq_type(struct pci_dev *pdev)
> +{
> +	return PCI_IRQ_INTX;
> +}
>  #endif
>  
>  /**
> -- 
> 2.55.0
> 
