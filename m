Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792780957;
	b=vXxbYYraeeZEoSYXrvUaEALgWzBt7M8voB8U9Ig4ecX+c9oeD6OS7ga9Ujj843UUbSdp
	 sLbIpO3b5MUJg6KU5tA5YZNJiCQ+MKKeOVI4tIFncZyEKMWJ1evSedeZVCmhBrKz+T7YU
	 7Rv4/Sm8an5it9a2D6aUOIQ5KhYZBpaluTiRlHRXCKDojezzHlImd7SBmNOGCAv6NXUbz
	 Dn8K9XvFjGNizaLlhmMmPZ6BSAPO5thE5A04tUFF92pu73KNR15Truj6qhgJHY/pPnYYe
	 jVaT6hzn73s4pj8e/K7/Wv3r2GfM0FXh1WQM7Jz/Kzr8Bh8a7q6AU6AuGOGXmMp91MQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792780957;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=NNM5yQ01YePyoWldFqWq1JW4Jzta8vvLgFBnOX/HqDU=;
	b=KkjQVsFGCdxi+2buN0W/BJz0t0IpEhFLi7k+YpRNr7oXAAaDcFjzJksbVFYVdjo+8hwg
	 J8hqjR1WRk/tgw9w8H68qfOAqdr48SlFw00uBH0sqd+Wu1VdeTCviYXepB6y4AAAwyCEp
	 ArJMX40I24SPwiMWbN6zkdV0porQt13avdyEl/sQuGMK3kR4gmWrWs22BG3+ZvY8ReLrC
	 CIwRmrwErcWn8C4EruLV/uCBEBWbITQ9o716qEB5/Sx6Wzh0zFwdql2QpvI+ZM9jZ4rcH
	 i7aptnz/JyMTKqFLgvyfoqBIMSU34beu6c466R1hBS4oVITKl1EhhRftsEGBp0bj3Cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="QOm50d/S";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C480606A31A;
	Fri, 23 Oct 2026 18:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QOm50d/S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FDD41F01825;
	Fri, 23 Oct 2026 18:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792780956;
	bh=NNM5yQ01YePyoWldFqWq1JW4Jzta8vvLgFBnOX/HqDU=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=QOm50d/SekKZDk9PZzzdmMiGdo9+EvMc1kTKhKGCpVimfDSJqEY36jZdKP7id95/U
	 jScPyyUqy/i3WUy2mMzcp4Cs0wRL4Px/qmnP8M5HeRjYAe6/J9105zSLiX366sNvK1
	 wSOLNqN87VANC5ZQPzL3JNPB6S6JSE7wQAurc41tc1bD9IGvXkCcxcHqN4NjKjRPtb
	 i7L+H/9mrrBVKyqrYqAd69xyKBev591tphdWoQ+LDvnL+g10dhLRLLONLxNzWFUkr6
	 ZwQjLLPQk+aTNVkNJiMwm282NxbUJeMDCmXlEfYNxxmnx3yrM4FDQHFLa1hBRg9WNw
	 G93UmNmqn6/Eg==
Date: Fri, 23 Oct 2026 13:42:35 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rafael@kernel.org,
	Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev
Subject: Re: [PATCH v11 07/16] genirq/msi: Cache MSI message in
 irq_chip_write_msi_msg()
Message-ID: <20261023184235.GA2800344@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929034510.2023173-8-praan@google.com>

On Tue, Sep 29, 2026 at 03:45:01AM +0000, Pranjal Shrivastava wrote:
> Currently, PCI MSI caches the composed MSI message into the MSI
> descriptor inside __pci_write_msi_msg(), whereas platform MSI and other
> device MSI domains do not cache the message in the core, forcing
> individual drivers to manually copy the message into desc->msg if they
> need to restore it across power transitions.
> 
> Cache desc->msg in irq_chip_write_msi_msg() before invoking the chip
> callback so all hierarchical MSI domains automatically record the
> latest message. Document why the redundant assignment in
> __pci_write_msi_msg() must remain for direct callers outside the
> irq_chip hierarchy.
> 
> Suggested-by: Thomas Gleixner <tglx@kernel.org>
> Signed-off-by: Pranjal Shrivastava <praan@google.com>

With the fix testing Thomas proposed:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/msi/msi.c | 6 ++++++
>  kernel/irq/msi.c      | 9 +++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> index 80a9db417dc8..f7bedc31d486 100644
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -257,6 +257,12 @@ void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
>  		pci_write_msg_msi(dev, entry, msg);
>  	}
>  
> +	/*
> +	 * Although irq_chip_write_msi_msg() already caches the message,
> +	 * keep the assignment here for callers that invoke
> +	 * __pci_write_msi_msg() or pci_write_msi_msg() directly outside
> +	 * the irq_chip hierarchy.
> +	 */
>  	entry->msg = *msg;
>  
>  	if (entry->write_msi_msg)
> diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
> index fb5f372215bf..df460a574d80 100644
> --- a/kernel/irq/msi.c
> +++ b/kernel/irq/msi.c
> @@ -634,6 +634,15 @@ static unsigned int msi_domain_get_hwsize(struct device *dev, unsigned int domid
>  static inline void irq_chip_write_msi_msg(struct irq_data *data,
>  					  struct msi_msg *msg)
>  {
> +	struct msi_desc *desc = irq_data_get_msi_desc(data);
> +
> +	/*
> +	 * PCI Multi-MSI shares a single descriptor across all vectors and
> +	 * the device stores only the base message. Cache the message of the
> +	 * first interrupt only, so that sub-vectors cannot overwrite it.
> +	 */
> +	if (desc->irq == data->irq)
> +		desc->msg = *msg;
>  	data->chip->irq_write_msi_msg(data, msg);
>  }
>  
> -- 
> 2.56.0.rc1.315.gc6ed9934b7-goog
> 
