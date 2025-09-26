Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31A8224FA;
	Fri, 26 Sep 2025 12:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758889908; cv=none; b=oT7Yezr1E2eVToczpdS5P4dsFW6tAy/GKtOInwGqukZPOsHh1eemrV5XfZZ8KxhxWbdsuL6QAFqDizZTOlkQZCGatY0ClbB5xm5QsVq78SjXUc9CB8kMPNntdNLT1rE3sLSe+Hd7xeoSSEp+ZIaPS0t62EJ56A1AZuYWu+nTHBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758889908; c=relaxed/simple;
	bh=kw9e9hX+qHyTZwjTMHqpMeFf4Ats1Mc0FvLjDKIewG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CxF10B0E8wBkobP9tzo0BtA+ZT3T0QqBV+tuCKAWgYotAiGW1hCvDfLp1h/J+CKpMP7uWMblBKxT+JKLtSnsjIKeUirFFO3ldr2jM5YsQg/hv5umCJNPon7Vk76w74ZIk/3xHbx//S3FGcEGaUK291wwqKTYRMvs/JXwwqy7aHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h1rVe1Ox; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h1rVe1Ox"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD29C4CEF4;
	Fri, 26 Sep 2025 12:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758889908;
	bh=kw9e9hX+qHyTZwjTMHqpMeFf4Ats1Mc0FvLjDKIewG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h1rVe1Ox+rHKkQtDUowYr86UwQCVziXJmcOkTGLQXzKmiGgl6SY3f7onXq6i1Kfrc
	 1GQzRjlD9wiMz9mrq3DDHte9+7qbDuudRhHys2KtU0/ifdsWOwoeipoIEdPD7GkQji
	 HeKKXVwMsP8EYj9k1IKJ5I31bvWRDH04JqeUa2IXXRIfcaANlZ/NFcoA52WWMy8FBx
	 w8QgN7OVtfsTK6UakxOWshzyhxlUb4Ec9sNasDtVpA3AK5wDXp5zxbIR1tvlMYyXSV
	 c50AVEu3InYORNYDJrpWxb2R3dsPsfsPilXHfXpAVqFOjJITDon65Z1HbDGAOE300s
	 tvs4emt0r61nA==
Date: Fri, 26 Sep 2025 14:31:42 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev, imx@lists.linux.dev
Subject: Re: [PATCH v3 1/3] PCI: endpoint: Add helper function
 pci_epf_get_bar_required_size()
Message-ID: <aNaHrj0rwLTtSRS3@ryzen>
References: <20250925-vntb_msi_doorbell-v3-0-ae0b0c93caae@nxp.com>
 <20250925-vntb_msi_doorbell-v3-1-ae0b0c93caae@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925-vntb_msi_doorbell-v3-1-ae0b0c93caae@nxp.com>

On Thu, Sep 25, 2025 at 01:01:47PM -0400, Frank Li wrote:
> Introduce pci_epf_get_bar_required_size() to retrieve the required BAR
> size and memory size. Prepare for adding support to set an MMIO address to
> a specific BAR.
> 
> Use two variables 'aligned_bar_size' and 'aligned_mem_size' to avoid
> confuse.

s/confuse/confusion/


> 
> No functional changes.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> change in v3
> - change return value to int.
> - use two pointers return bar size aligned and memory start address aligned
> - update comments about why need memory align size. Actually iATU require
> start address match aligned requirement. Since kernel return align to
> size's address.
> - use two varible aligned_bar_size and aligned_mem_size to avoid confuse
> use 'size'.
> 
> change in v2
> - new patch
> ---
>  drivers/pci/endpoint/pci-epf-core.c | 84 +++++++++++++++++++++++--------------
>  1 file changed, 53 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> index d54e18872aefc07c655c94c104a347328ff7a432..2cd0257831f9885a4381c087ed8f3326f5960966 100644
> --- a/drivers/pci/endpoint/pci-epf-core.c
> +++ b/drivers/pci/endpoint/pci-epf-core.c
> @@ -208,6 +208,49 @@ void pci_epf_remove_vepf(struct pci_epf *epf_pf, struct pci_epf *epf_vf)
>  }
>  EXPORT_SYMBOL_GPL(pci_epf_remove_vepf);
>  
> +static int
> +pci_epf_get_bar_required_size(struct pci_epf *epf, size_t size,
> +			      size_t *aligned_bar_size,
> +			      size_t *aligned_mem_size,
> +			      enum pci_barno bar,
> +			      const struct pci_epc_features *epc_features,
> +			      enum pci_epc_interface_type type)
> +{
> +	u64 bar_fixed_size = epc_features->bar[bar].fixed_size;
> +	size_t align = epc_features->align;
> +
> +	if (size < 128)
> +		size = 128;
> +
> +	/* According to PCIe base spec, min size for a resizable BAR is 1 MB. */
> +	if (epc_features->bar[bar].type == BAR_RESIZABLE && size < SZ_1M)
> +		size = SZ_1M;
> +
> +	if (epc_features->bar[bar].type == BAR_FIXED && bar_fixed_size) {
> +		if (size > bar_fixed_size) {
> +			dev_err(&epf->dev,
> +				"requested BAR size is larger than fixed size\n");
> +			return -ENOMEM;
> +		}
> +		size = bar_fixed_size;
> +	} else {
> +		/* BAR size must be power of two */
> +		size = roundup_pow_of_two(size);
> +	}
> +
> +	*aligned_bar_size = size;

I think this name is wrong.
The BAR size has not been aligned to anything.
The BAR size has to be a power of two, but that is a requirement of the PCI
specification, so that in an inherent property of a BAR.

Perhaps just name it size or bar_size?


Kind regards,
Niklas
