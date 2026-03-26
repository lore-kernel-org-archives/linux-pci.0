Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91795395241;
	Thu, 26 Mar 2026 12:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774527491; cv=none; b=GrLK4nF1BzD0GiluvTZ9PvrY5Ev1nG5tqPhvOJFMc0RLp0iMQw0pZMDhatzd/UpBd0y3AE52i33y+mWywV3BCtl1F+0HvMvd972jC5FgWjNT3Mt1wHwBlSWP90P8q/Mj1kvICSyPu9OEXkXDgXbvMGVKN1Pkil27bsanoOiYsVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774527491; c=relaxed/simple;
	bh=KDw7mVz5OUZNC7v7FVjD0E6Xl8UygPnihVPlnZ6sSbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJYr4Tjzda5tbCjqakUpWmanQWGiUcu0+l20RSi1oRjOahvtraZvAUXCSFrMWFiwS9RYjGbiqkN/8w5f10pdikh4tuv4ewmnSEwX7iYostAPuBQ8xBXQyak5Ri3flCkfYadgyDPoNsZecV1aQEkg4QYk+vpnIyhZwaqIa7bkT7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+nI8Dkp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+nI8Dkp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73460C19423;
	Thu, 26 Mar 2026 12:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774527491;
	bh=KDw7mVz5OUZNC7v7FVjD0E6Xl8UygPnihVPlnZ6sSbs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H+nI8DkpuT8xI9UzMoES0W390lZRM7wXj/RBIGaqXBKX2/yACDZ8SfrMRlbuuJ7uF
	 eDkdrIwzgQ+uhMPG1E9ySRv3Vl1BmKQvuyyzOp/omRQYRHsdm3bKmWz9bjwXio0XOS
	 yIJktfL5qYyrh+3bdotjGaLgTjFAghr1gU+MQMBQoP5Evd5Dp/B/vT3+VZrfpx5vQT
	 XLq9h58E/LfTvelBZBg+xguG8IEJF3mfLB9bkDPgy9ZYVZB8RUfysChMuxEdwlvvMc
	 47UTuUeu4qmJbBra/kOPaGY4VCJIJMLkzqj6j05836wrUMXs9Uwmjlp85YU5HBUPQs
	 yVdDE10DpxleA==
Date: Thu, 26 Mar 2026 17:47:56 +0530
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
Subject: Re: [PATCH v11 1/7] PCI: endpoint: Add auxiliary resource query API
Message-ID: <57ci3l6eyyvqdkscfrz66d53onpiolox5lvtjzn4nufkyqzmk7@6ltweu5hckwk>
References: <20260324083728.3744734-1-den@valinux.co.jp>
 <20260324083728.3744734-2-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260324083728.3744734-2-den@valinux.co.jp>

On Tue, Mar 24, 2026 at 05:37:22PM +0900, Koichiro Den wrote:
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
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
> Changes in v11:
>   - Drop PCI_EPC_AUX_DMA_CTRL_MMIO and PCI_EPC_AUX_DMA_CHAN_DESC from
>     the generic aux-resource API for now; keep only the DOORBELL_MMIO
>     resource used by this series.
> 
>  drivers/pci/endpoint/pci-epc-core.c | 41 ++++++++++++++++++++++++
>  include/linux/pci-epc.h             | 48 +++++++++++++++++++++++++++++
>  2 files changed, 89 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index 6c3c58185fc5..dc6d6ab4ea1e 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -156,6 +156,47 @@ const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
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

This feels like an awkward API design. This API returns 0 as a failure apart
other error nos and wants the callers to do:

	if (ret)
		return ret;
	else if (ret == 0)
		return -ENODEV;

I think this design comes due to the fact you have a single API doing both
resource count and resource get. This also evident in patch 7.

You should just split this API into two. One for returning resource count and
another for resource get.

- Mani

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
> index 334c2b7578d0..a6131f1636b0 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -61,6 +61,47 @@ struct pci_epc_map {
>  	void __iomem	*virt_addr;
>  };
>  
> +/**
> + * enum pci_epc_aux_resource_type - auxiliary resource type identifiers
> + * @PCI_EPC_AUX_DOORBELL_MMIO: Doorbell MMIO, that might be outside the DMA
> + *                             controller register window
> + *
> + * EPC backends may expose auxiliary blocks (e.g. DMA engines) by mapping their
> + * register windows and descriptor memories into BAR space. This enum
> + * identifies the type of each exposable resource.
> + */
> +enum pci_epc_aux_resource_type {
> +	PCI_EPC_AUX_DOORBELL_MMIO,
> +};
> +
> +/**
> + * struct pci_epc_aux_resource - a physical auxiliary resource that may be
> + *                               exposed for peer use
> + * @type:       resource type, see enum pci_epc_aux_resource_type
> + * @phys_addr:  physical base address of the resource
> + * @size:       size of the resource in bytes
> + * @bar:        BAR number where this resource is already exposed to the RC
> + *              (NO_BAR if not)
> + * @bar_offset: offset within @bar where the resource starts (valid iff
> + *              @bar != NO_BAR)
> + * @u:          type-specific metadata
> + */
> +struct pci_epc_aux_resource {
> +	enum pci_epc_aux_resource_type type;
> +	phys_addr_t phys_addr;
> +	resource_size_t size;
> +	enum pci_barno bar;
> +	resource_size_t bar_offset;
> +
> +	union {
> +		/* PCI_EPC_AUX_DOORBELL_MMIO */
> +		struct {
> +			int irq; /* IRQ number for the doorbell handler */
> +			u32 data; /* write value to ring the doorbell */
> +		} db_mmio;
> +	} u;
> +};
> +
>  /**
>   * struct pci_epc_ops - set of function pointers for performing EPC operations
>   * @write_header: ops to populate configuration space header
> @@ -84,6 +125,7 @@ struct pci_epc_map {
>   * @start: ops to start the PCI link
>   * @stop: ops to stop the PCI link
>   * @get_features: ops to get the features supported by the EPC
> + * @get_aux_resources: ops to retrieve controller-owned auxiliary resources
>   * @owner: the module owner containing the ops
>   */
>  struct pci_epc_ops {
> @@ -115,6 +157,9 @@ struct pci_epc_ops {
>  	void	(*stop)(struct pci_epc *epc);
>  	const struct pci_epc_features* (*get_features)(struct pci_epc *epc,
>  						       u8 func_no, u8 vfunc_no);
> +	int	(*get_aux_resources)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> +				     struct pci_epc_aux_resource *resources,
> +				     int num_resources);
>  	struct module *owner;
>  };
>  
> @@ -339,6 +384,9 @@ int pci_epc_start(struct pci_epc *epc);
>  void pci_epc_stop(struct pci_epc *epc);
>  const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
>  						    u8 func_no, u8 vfunc_no);
> +int pci_epc_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> +			      struct pci_epc_aux_resource *resources,
> +			      int num_resources);
>  enum pci_barno
>  pci_epc_get_first_free_bar(const struct pci_epc_features *epc_features);
>  enum pci_barno pci_epc_get_next_free_bar(const struct pci_epc_features
> -- 
> 2.51.0
> 

-- 
மணிவண்ணன் சதாசிவம்
