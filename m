Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D8F485CE8;
	Wed, 26 Aug 2026 22:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787782656; cv=none; b=YwF1KSdITPmK75JfjmbgWt8YOUAeESgiAffpkdTf32xt2/BJBEn90JizqwfY0ll5I4alRJJkP1JeW8+ebf7/yS4ZHHAC5Lp7TMKclwqgbguuIEGYWtrWeJt3JvJAR6eSQjFd3srUbem2uDUnFBAaFVTwp1OfOMo0IYkyi121hdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787782656; c=relaxed/simple;
	bh=mZzIi/wlWpp+nPlHb+tzF7KaE0xhqmViUfNeeAQtN30=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q2OyqC8ORc8QPD3nnC7KK2+19/BHoKt+cc5ku3JLpmBlHp6+zJKw4KEpYoTuondqPzo2RLQyKQU+ueQnDmo4W9XHcC9st06sStotYrQwZMmAfkgunMr9SxlfApEisN3rle3WaRCdfJln4Rw6IhfTiYvg0da/ozk2JD7v5Kk0gp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=vdNxqlq/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RKY9bu4V; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="vdNxqlq/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RKY9bu4V"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 87146EC0246;
	Wed, 26 Aug 2026 18:17:31 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 26 Aug 2026 18:17:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1787782651;
	 x=1787869051; bh=6XHZKtGS9r7eVR3+1kXrY80yVGewlayF70fEl2LkXPM=; b=
	vdNxqlq/d5/BvmpygWelbNKbnx6E/mowEDi8Q3XLolVm4hVgKna53uL93NacDRbv
	Yi0tg47dJyJAZMnlmJchfrAjf6xCzqciEb2QYvyWOnhmWtolGvnLnL5KgaVFTway
	PH2NX2bEkdnNwnfrIUbFCeHdQ73HSfNVBMw01qaKkoqtvbiy6avJBRfuPT56CqmC
	ZKQx23hjlWvz29yNG5IS/fQtqZ9WY5fAd1ghwl2cSfmKxnXLu9dxzHUfHxJ/jMq7
	Pgz52v7EsRBZ7MwF3un+ahYALEqoHe7j7cs4CliypfIK/ZLMmK+VZ1hnPSqYcM/Z
	gMl+/z0PAo9Me7WH/q91fQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787782651; x=
	1787869051; bh=6XHZKtGS9r7eVR3+1kXrY80yVGewlayF70fEl2LkXPM=; b=R
	KY9bu4V80IBWIImTD/a81uvYCsOCu+1VIgaGfWhWsHOQ9VxjNNTuYZtwoDqUHBz9
	dLcwQ5LUHInPt7mkpHKfWwIsy3CdZp6l5Ygp+XIQ/6565J6ykS+mNKSvLtDBwwCx
	QD9GLyR4I2gBE9vnx9FnqGJxtuaehnFDpkseQowOlGEbVmY/07EuLMvtAQ7EP7u5
	Ut++F6Psi6f2gR4sGQuzsag+Dz07yK5qJBDoSdUadrQPnRN8P/urxV7VSx9z1uIn
	I03gZtcAd2BU40Yyo2k85ik8SPIFA6q1pcaSZKJpkWYhbKb2UR172D3yQXNBn0FC
	/chl236vtKjhwI1khFt0g==
X-ME-Sender: <xms:-mWPapO3u49ZhffqDXhnV_kqlBJwzRCnJ7ZjH0b4cQBfunIZqlDgxw>
    <xme:-mWPapn2_tyzsxzajdZjFmUvyivOhO3TppAI2DAbpoB9q_yUqrSRRxq7pg7ir0fWC
    jNfIjGbzaGu81IrTGGT12pChZOu7gMCakpkoxz3ISz7dU-GPaKk>
X-ME-Received: <xmr:-mWPavoGYfyXbCGwXj_PVgjybx3PrC2Hhs6xAaK4NiazfVue4wmZO2TFjKsaMg>
X-ME-Proxy-Cause: dmFkZTENpnsSKLoILcJgHHvBxLEE3Ev2YQQTKfGYXxnraj25Hq7sK/w4HvAb2OtQ3MFImJ
    ZzYL4mT6vjcBqIm4V0+KmjVJf5a42JzLFmZ8ENJjcB7BJ7zqMfoUMibLmVsPVh5gmYTQ58
    v6pw7vrf8rI/+I2q0N1N7tIigDUtSaFbq55Q5GDbTKPMjw4zMzb87McVEQgTCiWn4IqNzE
    acT2DkUbvvJ3GUULXyWkQ5dqIJ7Jgi+GckfxxvIqrY9SVn6aH6K4ZbJEauEbHqj/Eh37pk
    jDNctV0m6IEkqtNGVxN66YaeIa7IKsCmialOXmMqaZfguhllcz+cwOnMG8nZ/KstpXTskS
    5wnklmMxZ9E8Fs+Hd2J5snu/xUoHdOTyeii11vwO0ogPNfA2ar+c2WNkeBqPMBf1Nq04UK
    8c4WfaETCwjYhVT0sRznlVV+5sMzGDtQ8PD2qaT5lvaSHZMTycsrwgUeI87NfuPz9o5vgW
    UuGjmgHT51RTbl4gbZ/9f/q3ZWvJPpwDjgDs4vsRqB207R2dV797PPFYaDRnzAsZpvPDqK
    t7EtKmXTuX4feR1WPTjxmQeqRo2RwqltJoRc1UL7BJXHZo+rUiu1Eo+CckhvXu/vVqE09A
    NuXYK83+uCvwFbPkYZBUEn2Y+oPfSerP4IFjwaHRA6nraWRbZo2YOqmijyTw
X-ME-Proxy: <xmx:-mWPat5gNK6vNdQ8WXxQl2bAI1J5phkp8X7MyXOjk7lxK2W30ZdeFA>
    <xmx:-mWPapJq5BXmVpPzul-sgPsrT9W91PRUyZh9i1nLvUXqn5iF-2lmKw>
    <xmx:-mWPahkNKEj29ze__NdCAE94tGXyf_1XHcBcXxQWYiRIid5_PcNY2A>
    <xmx:-mWPao9UvICmr1SiOvsBQvTsb9jpGYt9bxoeN64AdSMe_paczlXDdg>
    <xmx:-2WPaq7tVC8PSP1lKAszBhxcT0ngy1PAxrs0tkEvM6kw22LKLZTcjuB0>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Aug 2026 18:17:28 -0400 (EDT)
Date: Wed, 26 Aug 2026 16:17:25 -0600
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
Subject: Re: [PATCH v4 07/27] vfio/pci: Detect CXL devices and load vfio-cxl
 on demand
Message-ID: <20260826161725.7af1915b@shazbot.org>
In-Reply-To: <20260813093631.2288172-8-mhonap@nvidia.com>
References: <20260813093631.2288172-1-mhonap@nvidia.com>
	<20260813093631.2288172-8-mhonap@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Aug 2026 15:06:11 +0530
<mhonap@nvidia.com> wrote:

> From: Manish Honap <mhonap@nvidia.com>
> 
> A CXL device needs the vfio-cxl callbacks, but pulling vfio-cxl and the
> CXL core in unconditionally would bloat every vfio-pci setup. At bind,
> detect a CXL device with pcie_is_cxl() and request_module("vfio-cxl")
> only then, and hand the device to the registered ops.
> 
> Each bound CXL device pins vfio-cxl through try_module_get() and drops
> the reference at release, so vfio-cxl can unload once no CXL device is
> bound. If vfio-cxl is absent the device is driven as plain vfio-pci.
> 
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c | 81 ++++++++++++++++++++++++++++++--
>  include/linux/vfio_pci_core.h    |  3 ++
>  2 files changed, 81 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 88e68d43af9a..0f9b5dfeea66 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -2176,6 +2176,44 @@ static void vfio_pci_vga_uninit(struct vfio_pci_core_device *vdev)
>  					      VGA_RSRC_LEGACY_MEM);
>  }
>  
> +static const struct vfio_cxl_ops *vfio_pci_cxl_ops;
> +static DEFINE_MUTEX(vfio_pci_cxl_ops_lock);
> +
> +static const struct vfio_cxl_ops *vfio_pci_get_cxl_ops(void)
> +{
> +	const struct vfio_cxl_ops *ops;
> +
> +	mutex_lock(&vfio_pci_cxl_ops_lock);
> +	ops = vfio_pci_cxl_ops;
> +	if (ops && !try_module_get(ops->owner))
> +		ops = NULL;
> +	mutex_unlock(&vfio_pci_cxl_ops_lock);
> +
> +	return ops;
> +}

Awkward flow, resolved with guards:

	guard(rwsem_read)(&vfio_pci_cxl_ops_lock);
	ops = vfio_pci_cxl_ops;
	if (!ops || !try_module_get(ops->owner))
		return NULL;

	return ops;

> +
> +/*
> + * A CXL Type-2 device advertises both CXL.cache and CXL.mem in its CXL DVSEC.
> + * pcie_is_cxl() is also true for Type-1 (cache only) and Type-3 (mem only)
> + * devices, which the vfio-cxl provider does not handle, so confirm the Type-2
> + * identity before engaging it.
> + */
> +static bool vfio_pci_is_cxl_type2(struct pci_dev *pdev)
> +{
> +	u16 dvsec, cap;
> +
> +	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +					  PCI_DVSEC_CXL_DEVICE);
> +	if (!dvsec)
> +		return false;
> +
> +	if (pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP, &cap))
> +		return false;
> +
> +	return (cap & PCI_DVSEC_CXL_CACHE_CAPABLE) &&
> +	       (cap & PCI_DVSEC_CXL_MEM_CAPABLE);
> +}
> +
>  int vfio_pci_core_init_dev(struct vfio_device *core_vdev)
>  {
>  	struct vfio_pci_core_device *vdev =
> @@ -2197,6 +2235,41 @@ int vfio_pci_core_init_dev(struct vfio_device *core_vdev)
>  	init_rwsem(&vdev->memory_lock);
>  	xa_init(&vdev->ctx);
>  
> +	/*
> +	 * Load vfio-cxl on demand for a CXL device. If it is absent, drive the
> +	 * device as plain vfio-pci rather than failing the bind.
> +	 */
> +	if (pcie_is_cxl(vdev->pdev) && vfio_pci_is_cxl_type2(vdev->pdev)) {

Nit, embed the pcie_is_cxl() test in vfio_pci_is_cxl_type2().

> +		const struct vfio_cxl_ops *ops;
> +
> +		request_module("vfio-cxl");
> +		ops = vfio_pci_get_cxl_ops();
> +		if (ops) {
> +			ret = ops->init_device(vdev);
> +			if (ret) {
> +				module_put(ops->owner);

Create a trivial vfio_pci_put_cxl_ops() for consistency.

> +				return ret;

This looks like a regression, a device that previously worked with
vfio-pci now fails if vfio-cxl .init returns an error.  It should
continue with a log message.

The disable_cxl option that comes later is a global opt-out, not an
opt-in.  Users can opt-in to a feature that might fail previous
behavior but they should not be required to opt-out to retain existing
functionality, especially with only global granularity.

> +			}
> +			vdev->cxl_ops = ops;
> +			/*
> +			 * Pin the device in D0 while bound rather than let
> +			 * the host power it down between opens.
> +			 */
> +			vdev->disable_idle_d3 = true;

Why?  Letting the host power down the device between opens is exactly
what we want for non-cxl devices.  If we're trying to do something
around preserving the coherent memory configuration, it needs to be
justified as such, and should happen at the point where it's relevant,
ie. in the vfio-cxl .init path.

However, this alone doesn't prevent the user from using low power
states, so it also seems insufficient by itself.

> +		} else if (IS_BUILTIN(CONFIG_VFIO_CXL)) {
> +			/*
> +			 * Only DEFER for a built-in provider so the bind
> +			 * retries once vfio-cxl registers its ops.
> +			 * A modular provider was already loaded synchronously
> +			 * by request_module() above, so if it is still absent
> +			 * it is missing, blocked, or failed to init; drive the
> +			 * device as plain vfio-pci then rather than defer the
> +			 * bind forever.
> +			 */
> +			return -EPROBE_DEFER;

LLM asks if the registration function should call
driver_deferred_probe_trigger() to make the retry explicit?

> +		}
> +	}
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(vfio_pci_core_init_dev);
> @@ -2206,6 +2279,11 @@ void vfio_pci_core_release_dev(struct vfio_device *core_vdev)
>  	struct vfio_pci_core_device *vdev =
>  		container_of(core_vdev, struct vfio_pci_core_device, vdev);
>  
> +	if (vdev->cxl_ops) {
> +		vdev->cxl_ops->release_device(vdev);
> +		module_put(vdev->cxl_ops->owner);
> +	}

Turn both of these into helpers:

static int vfio_pci_core_cxl_init(struct vfio_device *core_vdev);
static void vfio_pci_core_cxl_release(struct vfio_device *core_vdev);

Include the tests is-cxl/cxl_ops tests in the helpers to
compartmentalize cxl init/release.  Thanks,

Alex

> +
>  	mutex_destroy(&vdev->igate);
>  	mutex_destroy(&vdev->ioeventfds_lock);
>  	kfree(vdev->region);
> @@ -2670,9 +2748,6 @@ static void vfio_pci_dev_set_try_reset(struct vfio_device_set *dev_set)
>  	}
>  }
>  
> -static const struct vfio_cxl_ops *vfio_pci_cxl_ops;
> -static DEFINE_MUTEX(vfio_pci_cxl_ops_lock);
> -
>  int vfio_pci_core_register_cxl_ops(const struct vfio_cxl_ops *ops)
>  {
>  	int ret = 0;
> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
> index 14753972e714..117cd67995d8 100644
> --- a/include/linux/vfio_pci_core.h
> +++ b/include/linux/vfio_pci_core.h
> @@ -29,6 +29,7 @@ struct vfio_pci_core_device;
>  struct vfio_pci_region;
>  struct p2pdma_provider;
>  struct dma_buf_attachment;
> +struct vfio_cxl_state;
>  
>  struct vfio_pci_eventfd {
>  	struct eventfd_ctx	*ctx;
> @@ -109,6 +110,8 @@ struct vfio_pci_core_device {
>  	struct vfio_device	vdev;
>  	struct pci_dev		*pdev;
>  	const struct vfio_pci_device_ops *pci_ops;
> +	const struct vfio_cxl_ops *cxl_ops;
> +	struct vfio_cxl_state	*cxl;
>  	void __iomem		*barmap[PCI_STD_NUM_BARS];
>  	bool			bar_mmap_supported[PCI_STD_NUM_BARS];
>  	/* Flags modified at runtime - dedicated storage unit */

