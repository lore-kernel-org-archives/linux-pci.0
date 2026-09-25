Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792DA4FECCD;
	Fri, 25 Sep 2026 22:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790374979; cv=none; b=qTrYxjYDGL8QNxizJCz1r263p/X3rTqSedYjQV3J6DUzZo3SsdMJG+Q1w7hSHjy/LKppscy9X5QK0yIVooffjibT3jZX7AKHr3m8z2cEw8qpusLzh0JDokUbh6dj5MMQ6PzmWYHJVggklXGLC7UjS2WSKyAf/K762ZFmsNxkFiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790374979; c=relaxed/simple;
	bh=gBU/v7lqms1redELFB8Hvl/sJjVFhl/Kc5ntjxiwMkE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sZe6fm/srQeL7WpdItWMCZdYyKXkhUrupTCDcXgY8xBCxZsllI9qfms3KRzFY52hF3basDXvveJ5in95Wb0W/iAKPizs94o8dWFj+zXXhi6hfgWM01MEJ9T5ODj/Zb3bqc3V6oqGTXwvYz+obpiPReqpbbOy/LCNE4X5bJI//98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUesvpNo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUesvpNo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 570191F00893;
	Fri, 25 Sep 2026 22:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790374976;
	bh=5eoijW9TbkwoxX6wQbNeciAfEkqIZ8Exnen5xO3IGjo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CUesvpNoA1DJAc7JNv3akHQEgyZOXtFpTBdPlbotZt8iwbUVVaUBaeE8XW3TXDquB
	 R7xv3p3fG+5Et5zE70L0gndxUJITsQCH1pZOQo6NIoHKy7r1y51pK7g0M7M4Dh/3Qi
	 Bp2bbthKAle+U7NA2S0J0jJLxAb9vJLg9CnKSPS3hd0vDTWe8L3ZERrXzvrvAFMLS7
	 8vwnNm2EmaqJ1MRsBhcQ4UpzLlSegLc7aOIL1eHdm1SFCsP474BmEA14od+qSBJi4f
	 4KrGFiKAqFlyAuKtitK2HTfk6kS+YbuacGwkDQJICi5KbZBN1X/1sm+Pjyp0jdT02j
	 WewiXOZPBZ1aw==
Date: Fri, 25 Sep 2026 23:22:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: <mhonap@nvidia.com>
Cc: <alex@shazbot.org>, <jgg@ziepe.ca>, <ankita@nvidia.com>,
 <dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
 <smadhavan@nvidia.com>, <corbet@lwn.net>, <skhan@linuxfoundation.org>,
 <dave@stgolabs.net>, <alison.schofield@intel.com>,
 <vishal.l.verma@intel.com>, <iweiny@kernel.org>, <ming.li@zohomail.com>,
 <yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
 <bhelgaas@google.com>, <dmatlack@google.com>, <kees@kernel.org>,
 <gustavoars@kernel.org>, <cjia@nvidia.com>, <kjaju@nvidia.com>,
 <vsethi@nvidia.com>, <zhiw@nvidia.com>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
 <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v5 16/27] vfio/cxl: Create the CXL memdev and set media
 ready at bind
Message-ID: <20260925232250.7d408311@jic23-hlaptop>
In-Reply-To: <20260916183540.3813685-17-mhonap@nvidia.com>
References: <20260916183540.3813685-1-mhonap@nvidia.com>
	<20260916183540.3813685-17-mhonap@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2026 00:05:29 +0530
<mhonap@nvidia.com> wrote:

> From: Manish Honap <mhonap@nvidia.com>
> 
> At bind, build the CXL memory device for the passed-through Type-2
> accelerator so it joins the CXL topology and its HDM region resolves to a
> host physical range. A Type-2 device has no mailbox, so there is no
> media-ready register to poll: set media ready directly once the component
> registers validate (mirroring drivers/net/ethernet/sfc/efx_cxl.c)
> 
> As per current vfio-cxl support, reject a device with:
> - more than one HDM decoder
> - interleaving enabled
> - whose reset the host cannot service
> 
> The CXL-core allocations are grouped with devres so a failed bind unwinds
> them: init failure falls back to plain vfio-pci with the device still
> bound, so devm would otherwise hold them until unbind.
> 
> A low-power transition would reset the CXL Type-2 function and lose
> its CXL.mem contents, so keep it in D0 while it is assigned.
> 
> Assisted-by: LLM
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
A small thing inline.

> ---
>  drivers/vfio/pci/cxl/vfio_cxl_core.c | 118 +++++++++++++++++++++++++++
>  drivers/vfio/pci/vfio_pci_core.c     |  16 ++++
>  2 files changed, 134 insertions(+)
> 
> diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> index cd5d41856404..0d92e6a409c1 100644
> --- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> +++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> @@ -6,15 +6,132 @@
>   */
>  
>  #include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/range.h>
>  #include <linux/vfio_pci_core.h>
> +#include <cxl/cxl.h>
> +#include <cxl/pci.h>
> +
> +/**
> + * struct vfio_cxl_state - per-device state for a vfio-cxl device
> + * @cxlds: CXL device state; kept first for devm_cxl_dev_state_create()
> + * @cxlmd: memory device joined to the CXL topology at bind
> + * @hpa_range: host physical range of the HDM region
> + */
> +struct vfio_cxl_state {
> +	struct cxl_dev_state cxlds;
> +	struct cxl_memdev *cxlmd;
> +	struct range hpa_range;
> +};
>  
>  static int vfio_cxl_init_device(struct vfio_pci_core_device *vdev)
>  {
> +	struct pci_dev *pdev = vdev->pdev;
> +	struct vfio_cxl_state *cxl;
> +	struct cxl_memdev *cxlmd;
> +	u64 hdm_size, serial;
> +	u16 dvsec;
> +	int ret;
> +
> +	/*
> +	 * pdev->hdm is cached at PCI enumeration, before any driver binds, so a
> +	 * device without it has no usable HDM decoder. Fall back to plain
> +	 * vfio-pci rather than deferring the bind forever.
> +	 */
> +	if (!pdev->hdm)
> +		return -ENODEV;
> +
> +	/* The guest drives one virtual decoder; multiple are unsupported. */
> +	if (pdev->hdm->decoder_count != 1)
> +		return -EOPNOTSUPP;
> +
> +	/* An interleaved decoder cannot be mapped 1:1 to the guest. */
> +	if (pdev->hdm->settings[0].interleave_ways != 1)
> +		return -EOPNOTSUPP;
> +
> +	/*
> +	 * The guest drives resets through the CXL Device DVSEC and polls the
> +	 * shadow for completion. If the host cannot service a function-scoped
> +	 * CXL reset, that request could never complete, so refuse the device
> +	 * rather than advertise a reset the guest would poll on forever.
> +	 */
> +	if (!cxl_reset_capable(pdev))
> +		return -EOPNOTSUPP;
> +
> +	hdm_size = range_len(&pdev->hdm->settings[0].hpa_range);
> +	if (!hdm_size)
> +		return -ENXIO;
> +
> +	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +					  PCI_DVSEC_CXL_DEVICE);
> +	serial = pci_get_dsn(pdev);
> +
> +	/*
> +	 * Group the CXL-core allocations so a later failure unwinds them here.
> +	 * A failed init falls back to plain vfio-pci with the device still
> +	 * bound, so devm would otherwise hold them until unbind.
> +	 */
> +	if (!devres_open_group(&pdev->dev, NULL, GFP_KERNEL))
> +		return -ENOMEM;
> +

I'd be tempted to factor out the stuff that is unwound via the
group. If this were simple a call to a helper function, that helper could
return directly on error giving us simpler code flow.  Then
you'd just check the helper return to find out if you should close
or release the group.

> +	cxl = devm_cxl_dev_state_create(&pdev->dev, CXL_DEVTYPE_DEVMEM, serial,
> +					dvsec, struct vfio_cxl_state, cxlds,
> +					false);
> +	if (!cxl) {
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +
> +	ret = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
> +				 &cxl->cxlds.reg_map);
> +	if (ret) {
> +		pci_err(pdev, "vfio-cxl: no component registers\n");
> +		goto err;
> +	}
> +
> +	if (!cxl->cxlds.reg_map.component_map.hdm_decoder.valid) {
> +		pci_err(pdev, "vfio-cxl: HDM decoder registers not found\n");
> +		ret = -ENODEV;
> +		goto err;
> +	}
> +
> +	/*
> +	 * A Type-2 accelerator has no mailbox and no media-ready register, so
> +	 * set media ready directly.
> +	 */
> +	cxl->cxlds.media_ready = true;
> +
> +	ret = cxl_set_capacity(&cxl->cxlds, hdm_size);
> +	if (ret)
> +		goto err;
> +
> +	cxlmd = devm_cxl_probe_mem(&cxl->cxlds, &cxl->hpa_range);
> +	if (IS_ERR(cxlmd)) {
> +		ret = PTR_ERR(cxlmd);
> +		goto err;
> +	}
> +
> +	cxl->cxlmd = cxlmd;
> +	devres_close_group(&pdev->dev, NULL);
> +
> +	/*
> +	 * Powering a CXL Type-2 function down and back up reinitializes its
> +	 * device state and discards the contents of its coherent memory. Pin
> +	 * it in D0 for as long as it is assigned so CXL.mem stays intact.
> +	 */
> +	vdev->disable_idle_d3 = true;
> +	vdev->cxl = cxl;
> +
>  	return 0;
> +
> +err:
> +	devres_release_group(&pdev->dev, NULL);
> +	return ret;
>  }
>  
>  static void vfio_cxl_release_device(struct vfio_pci_core_device *vdev)
>  {
> +	vdev->cxl = NULL;
>  }
>  
>  static int vfio_cxl_open_device(struct vfio_pci_core_device *vdev)
> @@ -59,3 +176,4 @@ module_exit(vfio_cxl_exit);
>  
>  MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("VFIO support for CXL Type-2 devices");
> +MODULE_IMPORT_NS("CXL");
