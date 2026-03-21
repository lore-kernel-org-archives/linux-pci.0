Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E5936EA8C;
	Sat, 21 Mar 2026 14:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774102668; cv=none; b=WYh7exocBj2OHeekHdV2kW+7u557QOiZySDm//iMcI16rLdRIEPhTn3LKYzt3RAqm/EW9PLqqWz/kYQaE/9N9r2XSQqexqByE/m60ZAn6w9LZj9su+b0Wp5SXqhOLl0PKp0DdjRxqfzb4g7OIRFKlee7YMPkzf1J+L5bM49TTk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774102668; c=relaxed/simple;
	bh=EjRLzIFXxpLSOjqNXm9qHnvAUFlVLBrEDeKaesBsmh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ibWG71FHWYMWbfK+8N9wa61nADGqbUdLZCbj+ObbQUtLCQD90Fn3qMJvhHlRlOq4fSO6nPMitd/jybR7tKoTT6s301dYUCufQnveJ5576QnEpWvy6C6K+VMLUnBPvCDSdSyufPrZA7tFFNpgJNLNwpAhnk1rLRkH3JQilC4RfjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jSYguq6G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSYguq6G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D253C19421;
	Sat, 21 Mar 2026 14:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774102668;
	bh=EjRLzIFXxpLSOjqNXm9qHnvAUFlVLBrEDeKaesBsmh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jSYguq6G5Ga9R4ElnGtMToCRk2k75Ju45ScynQEDrTx5So9ENZAjN3SE1P6EuYblC
	 SsO7l42HlXWQxoJpDU115iCvjGjPZ/mdFS3alXd7XqZNMWJqGyfOxGEWrU+GNPXh9M
	 Cjd5H+9yuba/fOpzRBQA1kH72PyGBuy94WkvIlzP4pcH7IaUZAuUFNrFqCUTGS5aYk
	 Y3uC8/OufH/geuruB9nhdFF0cspCWQOoQ8BY4fqD0Iq7VL56+DPaXsJjgXQyfLrfbC
	 Mblqcabne3KAI/ILKfkcRkMLtVNed6o53Q00etpVh1+BwNw4dYSZD17Zir5hfy55di
	 eqyOf+IjvJZ2A==
Date: Sat, 21 Mar 2026 19:47:32 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, Niklas Cassel <cassel@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>, Marco Crivellari <marco.crivellari@suse.com>, 
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Manikanta Maddireddy <mmaddireddy@nvidia.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH v10 1/7] PCI: endpoint: Add auxiliary resource query API
Message-ID: <4why3747pr6avu3e6vqp2ovxtudpjnrhuq4ryb2inlhjnmwylh@yxl44amyjyqk>
References: <20260302071427.534158-1-den@valinux.co.jp>
 <20260302071427.534158-2-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260302071427.534158-2-den@valinux.co.jp>

On Mon, Mar 02, 2026 at 04:14:21PM +0900, Koichiro Den wrote:
> Endpoint controller drivers may integrate auxiliary blocks (e.g. DMA
> engines) whose register windows and descriptor memories metadata need to
> be exposed to a remote peer. Endpoint function drivers need a generic
> way to discover such resources without hard-coding controller-specific
> helpers.
> 
> Add pci_epc_get_aux_resources() and the corresponding pci_epc_ops
> get_aux_resources() callback. The API returns a list of resources
> described by type, physical address and size, plus type-specific
> metadata.
> 
> Passing resources == NULL (or num_resources == 0) returns the required
> number of entries.
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Tested-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/pci/endpoint/pci-epc-core.c | 41 +++++++++++++++++++++++
>  include/linux/pci-epc.h             | 52 +++++++++++++++++++++++++++++
>  2 files changed, 93 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index 32cf9a9bc365..d63967622505 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -157,6 +157,47 @@ const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_get_features);
>  
> +/**
> + * pci_epc_get_aux_resources() - query EPC-provided auxiliary resources
> + * @epc: EPC device
> + * @func_no: function number
> + * @vfunc_no: virtual function number
> + * @resources: output array (may be NULL to query required count)
> + * @num_resources: size of @resources array in entries (0 when querying count)
> + *
> + * Some EPC backends integrate auxiliary blocks (e.g. DMA engines) whose control
> + * registers and/or descriptor memories can be exposed to the host by mapping
> + * them into BAR space. This helper queries the backend for such resources.
> + *
> + * Return:
> + *   * >= 0: number of resources returned (or required, if @resources is NULL)
> + *   * -EOPNOTSUPP: backend does not support auxiliary resource queries
> + *   * other -errno on failure
> + */
> +int pci_epc_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> +			      struct pci_epc_aux_resource *resources,
> +			      int num_resources)
> +{
> +	int ret;
> +
> +	if (!epc || !epc->ops)
> +		return -EINVAL;
> +
> +	if (func_no >= epc->max_functions)
> +		return -EINVAL;
> +
> +	if (!epc->ops->get_aux_resources)
> +		return -EOPNOTSUPP;
> +
> +	mutex_lock(&epc->lock);
> +	ret = epc->ops->get_aux_resources(epc, func_no, vfunc_no, resources,
> +					  num_resources);
> +	mutex_unlock(&epc->lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(pci_epc_get_aux_resources);
> +
>  /**
>   * pci_epc_stop() - stop the PCI link
>   * @epc: the link of the EPC device that has to be stopped
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index 63a24ebf144c..0827650acf93 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -61,6 +61,51 @@ struct pci_epc_map {
>  	void __iomem	*virt_addr;
>  };
>  
> +/**
> + * enum pci_epc_aux_resource_type - auxiliary resource type identifiers
> + * @PCI_EPC_AUX_DMA_CTRL_MMIO: Integrated DMA controller register window (MMIO)
> + * @PCI_EPC_AUX_DMA_CHAN_DESC: Per-channel DMA descriptor
> + * @PCI_EPC_AUX_DOORBELL_MMIO: Doorbell MMIO, that might be outside the DMA
> + *                             controller register window
> + *
> + * EPC backends may expose auxiliary blocks (e.g. DMA engines) by mapping their
> + * register windows and descriptor memories into BAR space. This enum
> + * identifies the type of each exposable resource.
> + */
> +enum pci_epc_aux_resource_type {
> +	PCI_EPC_AUX_DMA_CTRL_MMIO,
> +	PCI_EPC_AUX_DMA_CHAN_DESC,

I see that these resources are only used in [1], which is still in early stage.
It'd help if you can just keep DOORBELL_MMIO resource related code in this
series and add these resources when required.

- Mani

[1] https://lore.kernel.org/linux-pci/20260312165005.1148676-1-den@valinux.co.jp

-- 
மணிவண்ணன் சதாசிவம்
