Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF28C345EBE;
	Tue, 22 Sep 2026 02:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790043397; cv=none; b=eJbrQvpjb73Zp1pXczLCZRQWld057RhJ57fR+ReSfFr69CcQISKZkegwp9CTV/VbVZHVNb7GUV6f1V4yQGWw1NMmTaLfOpspAp254FxEOpRSZfervlgvEjkHUnSvCp7n5ibyd/vf6YiNBTvZC0s2NxN68C3O+gwF5XGxwMD5riE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790043397; c=relaxed/simple;
	bh=v3AhguYeagxBRzF3hLkOm9nkX3GYAmm+3CzgcbfKNLk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QI6VSTpaIpjyXvhCZmRk6WFTlKLg5Km+LxBS7g3PTtkhEQz7bVgu0KJMYPGef4Pz+LpUnDp6QWsrPN+owkAqDwigA3/gpz0ySe373y9YARE2f4KJWmMDmnhhy8sXXXmwCJppnWx5rvgtTnucbQ8foSCh5zFSPRA5O3js1tuNNeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=IRGFNGby; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BuHjQ67a; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="IRGFNGby";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BuHjQ67a"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 18C387A0040;
	Mon, 21 Sep 2026 22:16:34 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 21 Sep 2026 22:16:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790043393;
	 x=1790129793; bh=A9yCqC8k5h2lF2CDujXhO7CBkjvKJGzoJtss77hMSn0=; b=
	IRGFNGby79rwM6h4DZ+GyzRgqlyOnmqELwV0gZJvEJYngYobX1Ldo2ba20qNTPCL
	YayW40wbgleKiPZkzdgndhhSOxz14bq/9SrId+awxjMrlq33KlNYk7J1+3Mtc5NU
	3AERCU9oFyQhTY7G+S4gavSB4V5scAX0sYYUNuQCv8jYyasJY3utAyk3/b3cZaxg
	8G9Tn71OGIUeQ6y5pTNA5PEjpHPO+7uE/1oxr/5um5B71mfGAWSOlNPWXRKqCkIq
	seMlimpQAnxR4/KV//cyi8S5x9H1M3ot6EG4BKPWEUfe0JYv9qmI1A2SM0vf4zUb
	b68kmJfABi3S19xAi/K46Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790043393; x=
	1790129793; bh=A9yCqC8k5h2lF2CDujXhO7CBkjvKJGzoJtss77hMSn0=; b=B
	uHjQ67aTUOxp4uAeh0wou7nZKRnw1vbzhoLSYTQdu5xV/BZVzRrZi+Te3RmtNVP8
	LCjvoIrof6DzSnFVUQozMud/Jhlqib5D4kblmuHmi79wtsNkUl96vyDUH+DZ2q+l
	KWkg5sX84TTgULfb7WyzQ0UQChdhOUSw5RkWVx8+Fy+MAFKH2uYpO6qdCAxBjiIs
	bkZ9eeUYqwiGIVe1L8foFgJOalAv7YzI99Y8htLKFkCECRNHzTJQ9KAIA82hIJ2e
	WN6rredcHg8fgR0fUBaFLdFgKkSxYOcVB6aOceUrpuVOAZIwMvZTAxGlJ7ocfVW4
	K9E2ljPqwd96EPhD12nUg==
X-ME-Sender: <xms:AeWxamHK-3bY-y7YN8YD-GEBnYPUL6rLSExY-m4Q_jixR7NbktXeCQ>
    <xme:AeWxak8MFN76HuMV2QMd6gytxq-Gw3sVE7iQsBnhqgpFpf0qEsl6sBFNMWOok7bm6
    NoDNKcrvLdwB_0eUW2avO6gghVyfmyd1cWbBGPel77DwcaNCmDn_9M>
X-ME-Received: <xmr:AeWxanjJpDtQhtj2HQHGpbbThQOZbbSP1bJPV3h5HO25xeLf0wjl6WaSfChdbw>
X-ME-Proxy-Cause: dmFkZTGXJSHqMq/BnZYJ0YweOb4rS2VUXpPM7d5+lSYGhnppGFsNjl5Bysv+w6+cDnCJ/7
    /L3Cxi42gIwxQ2NUo+88ApQMAdaEv47yc8fAsLypxGx87oHF4HT7ama3q0ueulG4TPc0DY
    g9aq/+AIZ/88RBFY6z24OfxBW3WPjyGYAaKrF0WRpWdqsttcvGMxliaYSaCPsYHObnA4na
    kPveiLHd3CCXxarYrwtQo6T70Ls9xKt0FRJqIrLM1i8XMnEKMgqeJVG7tIy0ld86sgmRqY
    QTP1Xf0Z/CD0h9dlYVSVFIdwBL83CGpVR9ekjjvy4BxnnVieSYFxqs3RHn4BnowjRSHstH
    lbIlrTY4pKaLjfYPMi8lHe9J6BGjnfnaAx8PVKK8YYVfP0edxM7OBB5rEBgIf2W60YJdMX
    a/CA/YLjNT54W2ZcspFg0osOJTvGi4LG0lFyY+yJlyyV9xM1x2hzgxr+jN9YPFqAKuevta
    V6dkjdGvWo63Y40Lm8KSIj2Rbiu6VFA/VZR9coUHxhsh36yQsFezjme3cVR5dtqJgrQaz4
    o1JeoPRBdMu2TR263aGg9sjQgoBDxLhN494P4TKOAz5Dr1HEZVwb28rD3EIxqnYVA4ubK1
    BMKlomltuu3emJpFxVYdT/IAJwQglbJF2qrTVxeJrJfZlX4rAplcEt4c3B3Q
X-ME-Proxy: <xmx:AeWxaoRk8w7TTTleoMlLmsbis-u9W5LKzfG9O_VbYi1ClzSIq64szQ>
    <xmx:AeWxakAciDX7vAHwz1_bPpNde46YKbMk8FFndt0tmMgPH7GJpuNp7Q>
    <xmx:AeWxai8I5YKKjCbOKl5MwImxA9YleVSHpOcD8T97eY8WNgpiXPf5og>
    <xmx:AeWxau0AEdk823DHw6HMRME7h75X7et--O_BYk0ffD9cXiHiYnrJnQ>
    <xmx:AeWxarQnxOtf8DawSjoOwb8iNgsKHpUqbMjYkh5LToEYSlvssEMSUrzS>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Sep 2026 22:16:26 -0400 (EDT)
Date: Mon, 21 Sep 2026 20:13:06 -0600
From: Alex Williamson <alex@shazbot.org>
To: <mhonap@nvidia.com>
Cc: <jgg@ziepe.ca>, <ankita@nvidia.com>, <jic23@kernel.org>,
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
 <linux-kselftest@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
 alex@shazbot.org
Subject: Re: [PATCH v5 25/27] vfio/cxl: Run the CXL reset at the vfio reset
 points
Message-ID: <20260921201306.49247ac5@shazbot.org>
In-Reply-To: <20260916183540.3813685-26-mhonap@nvidia.com>
References: <20260916183540.3813685-1-mhonap@nvidia.com>
	<20260916183540.3813685-26-mhonap@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2026 00:05:38 +0530
<mhonap@nvidia.com> wrote:

> From: Manish Honap <mhonap@nvidia.com>
> 
> A CXL Type-2 function must not take an FLR: it resets the coherent
> CXL.mem state and corrupts the HDM decoder. The PCI core already reflects
> this, ordering cxl_reset ahead of flr in pci_reset_fn_methods[], so a
> function reset of a CXL device runs the DVSEC reset sequence rather than
> FLR.
> 
> Route the vfio function-reset points (VFIO_DEVICE_RESET and the
> virtualized PCIe/AF FLR writes) through a CXL reset op that runs
> cxl_reset_dvsec_sequence(). The sequence resets the function, always
> clearing device memory, and restores the HDM decoder and PCI config
> state, so it is a complete replacement for pci_try_reset_function() on a
> CXL device. The op runs under memory_lock and not the PCI device lock, so
> cxl_reset_dvsec_sequence() can take the device lock itself.
> 
> Clear hdm_valid for the duration of the reset so a fault cannot insert a
> PFN into a decoder that is being torn down, and restore it once the
> sequence has put the decoder back.
> 
> Assisted-by: LLM
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>  drivers/vfio/pci/cxl/vfio_cxl_core.c | 41 +++++++++++++++
>  drivers/vfio/pci/vfio_pci_config.c   | 49 +++++++++++++++---
>  drivers/vfio/pci/vfio_pci_core.c     | 77 +++++++++++++++++++++++-----
>  drivers/vfio/pci/vfio_pci_priv.h     |  1 +
>  include/linux/vfio_pci_core.h        |  4 ++
>  5 files changed, 152 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> index 55fa1f86850d..795362aea344 100644
> --- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> +++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> @@ -632,6 +632,45 @@ static void vfio_cxl_reset_done(struct vfio_pci_core_device *vdev)
>  		cxl->hdm_valid = false;
>  }
>  
> +/*
> + * Run the CXL DVSEC reset sequence in place of a PCI function reset. A CXL
> + * Type-2 function must not take an FLR (it would corrupt CXL.mem), so the vfio
> + * reset points route here. The sequence resets the function, always clearing
> + * device memory, and restores the HDM decoder. The caller holds memory_lock,
> + * and this path does not hold the PCI device lock, so cxl_reset_dvsec_sequence()
> + * can take it.
> + */
> +static int vfio_cxl_reset(struct vfio_pci_core_device *vdev)
> +{
> +	struct vfio_cxl_state *cxl = vdev->cxl;
> +	int ret;
> +
> +	lockdep_assert_held_write(&vdev->memory_lock);
> +
> +	/* Host CPU access to the HDM range is unsafe until the decoder is back. */
> +	cxl->hdm_valid = false;
> +
> +	ret = cxl_reset_dvsec_sequence(vdev->pdev);
> +	if (!ret)
> +		cxl->hdm_valid = true;
> +
> +	return ret;

Success oriented flow:

	if (ret)
		return ret;

	cxl->hdm_valid = true;

	return 0;

But I don't see how the case where hdm_valid remains false is really a
valid place for the user to land.  We don't really have a "your device
is now borked, give up" signal to the user.

> +}
> +
> +/*
> + * The HDM dma-buf may be armed only while the decoder is valid. After a failed
> + * reset hdm_valid is clear, so the generic memory-enable re-arm must skip the
> + * dma-buf rather than map DMA onto an unrestored decoder.
> + */
> +static bool vfio_cxl_hdm_active(struct vfio_pci_core_device *vdev)
> +{
> +	struct vfio_cxl_state *cxl = vdev->cxl;
> +
> +	lockdep_assert_held_write(&vdev->memory_lock);
> +
> +	return cxl->hdm_valid;
> +}
> +
>  static const struct vfio_cxl_ops vfio_cxl_ops = {
>  	.init		= vfio_cxl_init_device,
>  	.release	= vfio_cxl_release_device,
> @@ -639,6 +678,8 @@ static const struct vfio_cxl_ops vfio_cxl_ops = {
>  	.close_device	= vfio_cxl_close_device,
>  	.reset_prepare	= vfio_cxl_reset_prepare,
>  	.reset_done	= vfio_cxl_reset_done,
> +	.reset		= vfio_cxl_reset,
> +	.hdm_active	= vfio_cxl_hdm_active,
>  	.owner		= THIS_MODULE,
>  };

It's vfio_cxl_ops, so it's unique to CXL, but still leaking HDM to
vfio-pci-core as something it needs to care about is pretty ugly.
It should be something generic, but also this should be wrapped in some
abstraction in vfio-pci-core.

>  
> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
> index 9a020a768055..8a5a737efa31 100644
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c
> @@ -630,7 +630,14 @@ static int vfio_basic_config_write(struct vfio_pci_core_device *vdev, int pos,
>  		*virt_cmd &= cpu_to_le16(~mask);
>  		*virt_cmd |= cpu_to_le16(new_cmd & mask);
>  
> -		if (__vfio_pci_memory_enabled(vdev))
> +		/*
> +		 * Re-arm the dma-bufs on memory-enable, but keep a CXL device's
> +		 * HDM dma-buf revoked while the decoder is unrestored (a failed
> +		 * reset leaves hdm_valid clear); re-arming would map DMA onto a
> +		 * decoder the fault path still gates. Plain vfio-pci is unchanged.
> +		 */
> +		if (__vfio_pci_memory_enabled(vdev) &&
> +		    (!vdev->cxl_ops || vdev->cxl_ops->hdm_active(vdev)))

HDM space and BAR MMIO space are governed by different things, how can
we combine them here to say that dmabufs are invalid until both are
active?  That's not how the hardware works.  Does the HDM need a
separate address space of dmabufs to toggle independently?

>  			vfio_pci_dma_buf_move(vdev, false);
>  		up_write(&vdev->memory_lock);
>  	}
> @@ -720,7 +727,8 @@ static void vfio_lock_and_set_power_state(struct vfio_pci_core_device *vdev,
>  	}
>  
>  	vfio_pci_set_power_state(vdev, state);
> -	if (__vfio_pci_memory_enabled(vdev))
> +	if (__vfio_pci_memory_enabled(vdev) &&
> +	    (!vdev->cxl_ops || vdev->cxl_ops->hdm_active(vdev)))
>  		vfio_pci_dma_buf_move(vdev, false);
>  	up_write(&vdev->memory_lock);
>  }
> @@ -910,8 +918,14 @@ static int vfio_exp_config_write(struct vfio_pci_core_device *vdev, int pos,
>  		if (!ret && (cap & PCI_EXP_DEVCAP_FLR)) {
>  			vfio_pci_zap_and_down_write_memory_lock(vdev);
>  			vfio_pci_dma_buf_move(vdev, true);
> -			pci_try_reset_function(vdev->pdev);
> -			if (__vfio_pci_memory_enabled(vdev))
> +			ret = vfio_pci_reset_function(vdev);
> +			/*
> +			 * Keep the HDM dma-buf revoked if a CXL reset
> +			 * failed; re-arming would map DMA onto an
> +			 * unrestored decoder. Mirrors the reset ioctl.
> +			 */

We don't have granularity of "the HDM dma-buf".

> +			if (__vfio_pci_memory_enabled(vdev) &&
> +			    (!vdev->cxl_ops || !ret))
>  				vfio_pci_dma_buf_move(vdev, false);
>  			up_write(&vdev->memory_lock);
>  		}
> @@ -995,8 +1009,14 @@ static int vfio_af_config_write(struct vfio_pci_core_device *vdev, int pos,
>  		if (!ret && (cap & PCI_AF_CAP_FLR) && (cap & PCI_AF_CAP_TP)) {
>  			vfio_pci_zap_and_down_write_memory_lock(vdev);
>  			vfio_pci_dma_buf_move(vdev, true);
> -			pci_try_reset_function(vdev->pdev);
> -			if (__vfio_pci_memory_enabled(vdev))
> +			ret = vfio_pci_reset_function(vdev);
> +			/*
> +			 * Keep the HDM dma-buf revoked if a CXL reset
> +			 * failed; re-arming would map DMA onto an
> +			 * unrestored decoder. Mirrors the reset ioctl.
> +			 */

Same.

> +			if (__vfio_pci_memory_enabled(vdev) &&
> +			    (!vdev->cxl_ops || !ret))
>  				vfio_pci_dma_buf_move(vdev, false);
>  			up_write(&vdev->memory_lock);
>  		}
> @@ -1781,9 +1801,22 @@ static int vfio_cxl_dvsec_write(struct vfio_pci_core_device *vdev, int pos,
>  		status2 |= PCI_DVSEC_CXL_CACHE_INV;
>  	}
>  	if (ctrl2 & PCI_DVSEC_CXL_INIT_CXL_RST) {
> +		int ret = 0;
> +
>  		ctrl2 &= ~PCI_DVSEC_CXL_INIT_CXL_RST;
> -		status2 &= ~PCI_DVSEC_CXL_RST_ERR;
> -		status2 |= PCI_DVSEC_CXL_RST_DONE;
> +
> +		if (vdev->cxl_ops && vdev->cxl_ops->reset) {
> +			vfio_pci_zap_and_down_write_memory_lock(vdev);
> +			vfio_pci_dma_buf_move(vdev, true);
> +			ret = vfio_pci_reset_function(vdev);
> +			if (__vfio_pci_memory_enabled(vdev) &&
> +			    (!vdev->cxl_ops || !ret))
> +				vfio_pci_dma_buf_move(vdev, false);
> +			up_write(&vdev->memory_lock);
> +		}

Isn't this branch deterministic?  IIRC, we only install this handler
when vdev->cxl_ops and that ops always registers a reset function.

> +
> +		status2 &= ~(PCI_DVSEC_CXL_RST_DONE | PCI_DVSEC_CXL_RST_ERR);
> +		status2 |= ret ? PCI_DVSEC_CXL_RST_ERR : PCI_DVSEC_CXL_RST_DONE;
>  	}
>  
>  	*pctrl2 = cpu_to_le16(ctrl2);
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index f02a5240aa71..8bd4db7afefe 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -643,8 +643,27 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
>  		goto out_power;
>  
>  	/* If reset fails because of the device lock, fail this path entirely */
> -	ret = pci_try_reset_function(pdev);
> -	if (ret == -EAGAIN)
> +	if (vdev->cxl_ops && vdev->cxl_ops->reset) {
> +		/*
> +		 * VM power-on resets a CXL Type-2 device through its DVSEC
> +		 * sequence. vconfig is not built yet here, so take memory_lock
> +		 * and call the op directly rather than the wrapper.
> +		 */

B does not follow from A: what's vconfig got to do with taking
memory_lock here?

> +		down_write(&vdev->memory_lock);
> +		ret = vdev->cxl_ops->reset(vdev);
> +		up_write(&vdev->memory_lock);
> +	} else {
> +		ret = pci_try_reset_function(pdev);
> +	}
> +
> +	/*
> +	 * -EAGAIN means the reset could not run. For a CXL device any reset
> +	 * error must also fail the open: a failed DVSEC reset can leave the HDM
> +	 * decoder cleared or unrestored, and continuing would expose the HDM
> +	 * region for host access through a decoder in an unknown state.
> +	 */
> +	if (ret == -EAGAIN ||
> +	    (vdev->cxl_ops && vdev->cxl_ops->reset && ret))

This suggests to me that our abstraction is lacking.

>  		goto out_disable_device;
>  
>  	vdev->reset_works = !ret;
> @@ -845,16 +864,30 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
>  	 * overwrite the previously restored configuration information.
>  	 */
>  	if (vdev->reset_works) {
> -		bridge = pci_upstream_bridge(pdev);
> -		if (bridge && !pci_dev_trylock(bridge))
> -			goto out_restore_state;
> -		if (pci_dev_trylock(pdev)) {
> -			if (!__pci_reset_function_locked(pdev))
> +		if (vdev->cxl_ops && vdev->cxl_ops->reset) {
> +			/*
> +			 * VM power-off resets a CXL Type-2 device through its
> +			 * DVSEC sequence. The sequence takes its own device lock,
> +			 * so run it outside the lock below.
> +			 * vconfig is already freed here, so call the op directly
> +			 * under memory_lock rather than the wrapper.

Again, the comment doesn't actually justify the behavior.  In the
previous, vconfig is not setup, so take the lock, here vconfig is
already freed, so take the lock... meaningless.

Also, are we dropping the try-lock semantics?  How's that justified?

> +			 */
> +			down_write(&vdev->memory_lock);
> +			if (!vdev->cxl_ops->reset(vdev))
>  				vdev->needs_reset = false;
> -			pci_dev_unlock(pdev);
> +			up_write(&vdev->memory_lock);
> +		} else {
> +			bridge = pci_upstream_bridge(pdev);
> +			if (bridge && !pci_dev_trylock(bridge))
> +				goto out_restore_state;
> +			if (pci_dev_trylock(pdev)) {
> +				if (!__pci_reset_function_locked(pdev))
> +					vdev->needs_reset = false;
> +				pci_dev_unlock(pdev);
> +			}
> +			if (bridge)
> +				pci_dev_unlock(bridge);

Abstraction leaves a lot to be desired here.

>  		}
> -		if (bridge)
> -			pci_dev_unlock(bridge);
>  	}
>  
>  out_restore_state:
> @@ -1592,6 +1625,20 @@ static int vfio_pci_ioctl_set_irqs(struct vfio_pci_core_device *vdev,
>  	return ret;
>  }
>  
> +/*
> + * Reset the function. A CXL device runs the CXL DVSEC reset sequence in place
> + * of a PCI function reset: it replaces FLR (which would corrupt CXL.mem),
> + * always clears device memory, and restores the HDM decoder. Callers hold
> + * memory_lock for write.
> + */
> +int vfio_pci_reset_function(struct vfio_pci_core_device *vdev)
> +{
> +	if (!vdev->cxl_ops || !vdev->cxl_ops->reset)
> +		return pci_try_reset_function(vdev->pdev);
> +
> +	return vdev->cxl_ops->reset(vdev);

This is all inverted logic and I don't understand why we're trying to
leave the reset op optional, make it mandatory:

	if (vdev->cxl_ops)
		return vdev->cxl_ops->reset(vdev);

	return pci_try_reset_function(vdev->pdev);

But we're again losing the try semantics on the cxl path(?) and naming
of the wrapper drops the try semantics as well.

> +}
> +
>  static int vfio_pci_ioctl_reset(struct vfio_pci_core_device *vdev,
>  				void __user *arg)
>  {
> @@ -1614,8 +1661,14 @@ static int vfio_pci_ioctl_reset(struct vfio_pci_core_device *vdev,
>  	vfio_pci_set_power_state(vdev, PCI_D0);
>  
>  	vfio_pci_dma_buf_move(vdev, true);
> -	ret = pci_try_reset_function(vdev->pdev);
> -	if (__vfio_pci_memory_enabled(vdev))
> +	ret = vfio_pci_reset_function(vdev);
> +	/*
> +	 * Re-arm the dma-bufs on success. A CXL device whose reset failed leaves
> +	 * the HDM decoder unrestored and hdm_valid clear, so re-arming its HDM
> +	 * dma-buf would map device DMA onto a decoder the fault path still gates;
> +	 * keep it revoked until a reset succeeds. Plain vfio-pci is unchanged.
> +	 */
> +	if (__vfio_pci_memory_enabled(vdev) && (!vdev->cxl_ops || !ret))
>  		vfio_pci_dma_buf_move(vdev, false);

I don't think we're doing dmabufs correctly for CXL, I don't see how
they're the same address space, or TBH, how we can have a reset fail so
catastrophically.  Thanks,

Alex

>  	up_write(&vdev->memory_lock);
>  
> diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
> index c268c99aea82..e1ef21806a2f 100644
> --- a/drivers/vfio/pci/vfio_pci_priv.h
> +++ b/drivers/vfio/pci/vfio_pci_priv.h
> @@ -78,6 +78,7 @@ int vfio_pci_set_power_state(struct vfio_pci_core_device *vdev,
>  			     pci_power_t state);
>  
>  void vfio_pci_zap_and_down_write_memory_lock(struct vfio_pci_core_device *vdev);
> +int vfio_pci_reset_function(struct vfio_pci_core_device *vdev);
>  u16 vfio_pci_memory_lock_and_enable(struct vfio_pci_core_device *vdev);
>  void vfio_pci_memory_unlock_and_restore(struct vfio_pci_core_device *vdev,
>  					u16 cmd);
> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
> index 39a28cc6ae8c..231679dead45 100644
> --- a/include/linux/vfio_pci_core.h
> +++ b/include/linux/vfio_pci_core.h
> @@ -74,6 +74,10 @@ struct vfio_cxl_ops {
>  	void	(*close_device)(struct vfio_pci_core_device *vdev);
>  	void	(*reset_prepare)(struct vfio_pci_core_device *vdev);
>  	void	(*reset_done)(struct vfio_pci_core_device *vdev);
> +	/* Run the CXL reset (always clears CXL.mem) in place of FLR */
> +	int	(*reset)(struct vfio_pci_core_device *vdev);
> +	/* True while the HDM range is valid and its dma-buf may be armed */
> +	bool	(*hdm_active)(struct vfio_pci_core_device *vdev);
>  	/* Pinned per bound CXL device so vfio-cxl cannot unload under usage */
>  	struct module *owner;
>  };

