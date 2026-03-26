Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF82231714B;
	Thu, 26 Mar 2026 12:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774528774; cv=none; b=RxIuSgNShzAFjHpmFcVeF16hqT94Wus75G8Ddf4DukyVzNvBIankdaXSVN60Fe9oZj8SE3QLu9+ZEKHzh+RKZv6PWg+26b6jlRSIyo2r02sPVhiZIdCkm7hvFFS91P6cd0VxPDoVD7QN0FdxpEWkL/+iba5dOKZ4MZ+zFPHw/l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774528774; c=relaxed/simple;
	bh=hu85lqU73zQ3SGUe4VTkyV4F4YG/ts1KXy5YKL7dlaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d9BwUYR1+pYk0GWtg56Aod71GDAEBfJ83e2N7jmWSGjJpAuu1k0SUm1vGQwEKkCx1nRtucGoXW+Cbdp898gjjnizBtQlmPiY+nhluSxo055VRKIIkc41bA6uJODqDsPe79BeOrUxpuBdt1eWMby3kXoojdqcGwCiF/U/FJXc524=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MiNID2rb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MiNID2rb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5767EC2BC87;
	Thu, 26 Mar 2026 12:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774528773;
	bh=hu85lqU73zQ3SGUe4VTkyV4F4YG/ts1KXy5YKL7dlaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MiNID2rbbdYyJvbFRaQRXf4ofl6wHYxxQiotJV+uU586Y7WYZ3XO+S3Jw4XDfjgU2
	 3xiz2h0jBi1wHKmhwasqz6/qvKaVNB0JLoxB53DHS5yyLzEZJxdVrJJyiY1Vx7nOsg
	 mB5bhrPhd03dhpd+3DwWOorRyXwVgvoRstCL/TtVYlWo9srecqw1D9f+hwi/7MiwCF
	 AYDoYARY1sooXb3CFTRaE5i1QN5Vo2BFvS2tlEFoLLPYD0Avkw4k/GyZM5fcJOQycA
	 Gt+U6JS4BnGyAH4vpOw3PAXR9Pqc/zl7oJTg4GoMqY6BtxibZQpyOIDunAhlunwgJb
	 XAy7hfaNOsDUw==
Date: Thu, 26 Mar 2026 18:09:18 +0530
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
Subject: Re: [PATCH v11 7/7] PCI: endpoint: pci-ep-msi: Add embedded doorbell
 fallback
Message-ID: <lfbv6sjevz4xtjr6zt2hl3wap3bfwkvigqb6fdztqmutxgcvld@3t4x5gstr4nj>
References: <20260324083728.3744734-1-den@valinux.co.jp>
 <20260324083728.3744734-8-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260324083728.3744734-8-den@valinux.co.jp>

On Tue, Mar 24, 2026 at 05:37:28PM +0900, Koichiro Den wrote:
> Some endpoint platforms cannot use platform MSI / GIC ITS to implement
> EP-side doorbells. In those cases, EPF drivers cannot provide an
> interrupt-driven doorbell and often fall back to polling.
> 
> Add an "embedded" doorbell backend that uses a controller-integrated
> doorbell target (e.g. DesignWare integrated eDMA interrupt-emulation
> doorbell).
> 
> The backend locates the doorbell register and a corresponding Linux IRQ
> via the EPC aux-resource API. If the doorbell register is already
> exposed via a fixed BAR mapping, provide BAR+offset. Otherwise provide
> the DMA address returned by dma_map_resource() (which may be an IOVA
> when an IOMMU is enabled) so EPF drivers can map it into BAR space.
> 
> When MSI doorbell allocation fails with -ENODEV,
> pci_epf_alloc_doorbell() falls back to this embedded backend.
> 
> Tested-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/pci/endpoint/pci-ep-msi.c | 139 +++++++++++++++++++++++++++++-
>  include/linux/pci-epf.h           |   8 ++
>  2 files changed, 144 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
> index 85fe46103220..331d84a79193 100644
> --- a/drivers/pci/endpoint/pci-ep-msi.c
> +++ b/drivers/pci/endpoint/pci-ep-msi.c
> @@ -6,6 +6,8 @@
>   * Author: Frank Li <Frank.Li@nxp.com>
>   */
>  
> +#include <linux/align.h>
> +#include <linux/cleanup.h>
>  #include <linux/device.h>
>  #include <linux/export.h>
>  #include <linux/interrupt.h>
> @@ -36,6 +38,117 @@ static void pci_epf_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
>  	pci_epc_put(epc);
>  }
>  
> +static int pci_epf_alloc_doorbell_embedded(struct pci_epf *epf, u16 num_db)
> +{
> +	const struct pci_epc_aux_resource *doorbell = NULL;
> +	struct pci_epf_doorbell_msg *msg;
> +	struct pci_epc *epc = epf->epc;
> +	struct device *dev = &epf->dev;
> +	size_t map_size = 0, off = 0;
> +	dma_addr_t iova_base = 0;
> +	phys_addr_t phys_base;
> +	int count, ret, i;
> +	u64 addr;
> +
> +	count = pci_epc_get_aux_resources(epc, epf->func_no, epf->vfunc_no,
> +					  NULL, 0);
> +	if (count == -EOPNOTSUPP || count == 0)
> +		return -ENODEV;
> +	if (count < 0)
> +		return count;

This should be avoided...

resource_count API should return 0 for success and errno for failure with a
separate argument for resource count.

And resource_get API should return 0 for success and errno for failure.

> +
> +	struct pci_epc_aux_resource *res __free(kfree) =
> +				kcalloc(count, sizeof(*res), GFP_KERNEL);
> +	if (!res)
> +		return -ENOMEM;
> +
> +	ret = pci_epc_get_aux_resources(epc, epf->func_no, epf->vfunc_no,
> +					res, count);
> +	if (ret == -EOPNOTSUPP || ret == 0)
> +		return -ENODEV;
> +	if (ret < 0)
> +		return ret;

And here, you do the same :/

> +
> +	count = ret;
> +
> +	for (i = 0; i < count; i++) {
> +		if (res[i].type == PCI_EPC_AUX_DOORBELL_MMIO) {
> +			if (doorbell) {
> +				dev_warn(dev,
> +					 "Duplicate DOORBELL_MMIO resource found\n");

I think technically it makes sense to have more than one doorbell resource per
endpoint. You may not warn here, but just ensure that you use the first unused
one. This also means, you need to track the allocated resource.

If you want to avoid the hassle, just assume that there will be only one
doorbell resource and add a TODO to extend it if needed.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
