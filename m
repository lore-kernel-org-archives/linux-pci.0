Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5DE38BF70;
	Fri, 28 Aug 2026 21:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787954077; cv=none; b=PksXyn2pnI4OtnMmLfz4LEZbgDyhkh9tJTR+rQhqBIYs5qkj43ShW3TJBNhTrWy6WSL6S3vhPAiw8OFIy6qWYwIjXFxr1r2qZSpaVonL9Eg0h4IE9R06LJxJWJFLKjzKyKU54DTzEg2fjj19Pb9x1g5Bqm5iwl1TOoY9pncFoqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787954077; c=relaxed/simple;
	bh=SwOdz/9d1IPah5p/5fi35v4EVL3lroRF7qvyloaClto=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aogCbnga4JKNx/VDM9uGiBV2vRubniGxckANCfLlYZXuI3Rqozg7e3wnYy4lPtUk9LX5OpNglylu159koOgRoeJgGK9WAmrdIPCLmbuawR+fmbGXBIhdvVTFGXMEH6mC3ZSJTN/g6tHn0yixQQTYEspd8GEMQiRD5htE/QS+j3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=FoQdHsg5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JYYDLMds; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="FoQdHsg5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JYYDLMds"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BB5C87A0151;
	Fri, 28 Aug 2026 17:54:32 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 28 Aug 2026 17:54:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1787954072;
	 x=1788040472; bh=FIHdEmS0olB01b8k7APcgX7ndOUk1mYAmTIUnPKBS+A=; b=
	FoQdHsg5hW5bQ/8rA+IllifGFK+EpLcJKDmuJ4tSEC+vAaEkGawS6dxN2lLkKj1O
	ipfXTM3xvyvk4tN0TI3Wt2ercMu4Cs3aOyG2nikSpZyHbqU6K70w6LrgTLC4UoEi
	rx9bKp6B9YQZ2tBW0wlhCpHoSeSaMflKbHZTeCO/WhddaTbPtUkpT8B1L7w4lDVN
	JsJqmyW/PaWKaeWRol61UUdzn8EU2jMcbe65JkQlBjhA8XVfaRvBgn2elOsi1DLk
	sLQoTb1OrFHjnJsuNdBYVMUM38l+Ayr16HSxpi3cjktcXohZBFb6r1ANfSJM2AhQ
	VMe36Qh9iFR1asRK6WCUww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787954072; x=
	1788040472; bh=FIHdEmS0olB01b8k7APcgX7ndOUk1mYAmTIUnPKBS+A=; b=J
	YYDLMds6+X/YrbvCREf975se/l/3ACp/VHYuSK3CmuMcsGBwsn1mfzZrZSq49q/h
	o42aeeMSC8tkHT/fDN9IawFZJNOI5wbEvTLQ5pKCFZsfxzFCONf3r8Zvs0KY+/5z
	KuvdRJivSqCuVZSElF7E3TsDO2ykbUTlD/FSVxyrOF0SAG/NJNxMKFA+B4Vc1UVw
	DYQ+VOBK4lr3g76r0HTw7PPaR5IX+klyJAMNOdnPHRGcgkmI9Ljs2bGytCnnvnB4
	fTKhIaxUoHLymmTz5/jbT/pahpMmKErq1aD9H5Y3GhMYUj0cCuU3nj/MvfCYDbgp
	V9O5xydXzISFz4ZlyqxVw==
X-ME-Sender: <xms:mAOSarXAUXtZ0xjdjzZZ_mgXq-36RwpRV7GExE_Ld8uRuNIcjAbWyg>
    <xme:mAOSahNmbd-uAmfShAMm1-fWv1J3_azZKYQm1RxBQ-LbhAG6E3CNMgIS1gUxs9ugW
    J2UmyPkJGXblnwIiVKh9nt9s2g2GJyocfDmjCGGFaBTTf4xCQyGZWo>
X-ME-Received: <xmr:mAOSauwZBs6_HagxV3dFSunjZTgbSZbsXS_8ekL1POBfvQ1EmbBfL_2ReIPirQ>
X-ME-Proxy-Cause: dmFkZTF5YnbSUo8TXmQYItJlQa8l76TKmkzo21w7i2g1aEp/uKyZg0o7VcP0xSKrFB51c0
    V5Owqxp/8TrS+nTx/gZ8Cl/CkLWSxB6W2djybM44uLnx2n6DzwhgzMkyoI+AipqtO7MCX9
    ffiMCi0F28CwZuWXMb647CmXjy7w6mIukcnrU78UtRx56W3a+Xu8yLoc3Nlclu74+fMaMv
    5J3lkDFCbE570Rl5wVyogXC/pecZL1kkN+8o1STA7Zb4kYYkGruYVRgt6JQN0PyG1TJZn9
    BVo7RukyKpjrcX023u0Py2xCpcjSUfDEosCkgvIRzaVg1IK6CjKsRIuHOJ7i72/3YF/Vo+
    wnKHmRRXw+3Pz7SRqaKEvmWBlMJLCfWILkgR/2+UASO4iz0u0ffwDaRA3NjrEpzP+zskrI
    AN76m3PBB8w22OImx3vFsiiSSXh9YoLMBne4tHgSXJFazMIdctaeCXDXFMxoJxMD4qpNGE
    sXWl/1+L07cf7QQdGJLxZeyYSDWC2SmysG+lOuF4DeLsCIrvaRGG1CPvuQy+nhf+lw7tfS
    iwGb40SReAEQhwVaAtY30SkDs8pMpg5ueyL/aLgQSTK6whoT/6G5Ed8FqwVGf+MPPR9LVh
    kX40AhHahKbbHAY27AQIUtjlp20hpdT80/T7XeDHr//0C/mH62nZbOHwHpDg
X-ME-Proxy: <xmx:mAOSaujdmpOKZDbKdLk7uHrW6_AisqqV6yPDFMEhGG0fuGIdbboLhA>
    <xmx:mAOSatSjFsiLjVsiuBTmnragq4dFy0N_SpX2HeC-mLDuhwxRSqOq4g>
    <xmx:mAOSajO600vPPQG7a2TIfKuiVI6kdN_XsNBI_eIo27d6etRJgJ8AlQ>
    <xmx:mAOSaqFkUm46AoOWZq0B3WnAjnz8Is9vnU42JyW1mT4BtG6XRfuI8Q>
    <xmx:mAOSatdEiXa-uKbS1Sk5EYm_5nG2lVJJJMN9_cnDiNecSvAfHoAD2aEK>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Aug 2026 17:54:30 -0400 (EDT)
Date: Fri, 28 Aug 2026 15:54:28 -0600
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
Subject: Re: [PATCH v4 22/27] vfio/cxl: Revoke the HDM mapping on reset and
 power transitions
Message-ID: <20260828155428.2b8bbbf5@shazbot.org>
In-Reply-To: <20260813093631.2288172-23-mhonap@nvidia.com>
References: <20260813093631.2288172-1-mhonap@nvidia.com>
	<20260813093631.2288172-23-mhonap@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Aug 2026 15:06:26 +0530 <mhonap@nvidia.com> wrote:

> From: Manish Honap <mhonap@nvidia.com>
> 
> The HDM region is a device region, not a BAR, so vfio_pci_zap_bars()
> leaves its PTEs in place. A runtime-PM entry, a D3 transition, or a reset
> would then leave the guest with live mappings into a quiesced device.
> 
> Add a zap hook, called alongside the BAR zap under memory_lock, that
> unmaps the window. The fault path already refuses to re-insert PFNs while
> the device is suspended or its Memory Space is disabled.

We need to think about what happens in the dmabuf mmap world[1].
Currently there are no device specific regions supporting mmap.
Zapping is left as a compatibility interface, but the right solution is
probably to use dmabuf for mmap where we can.  Otherwise zap should
likely be handled generically for device specific regions supporting
mmap rather than as a CXL one-off.

AFAIK, Matt's series is still in the works and this will conflict.
Thanks,

Alex

[1]https://lore.kernel.org/all/20260715174737.15287-1-matt@ozlabs.org/


> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>  drivers/vfio/pci/cxl/vfio_cxl_core.c | 29 ++++++++++++++++++++++++++++
>  drivers/vfio/pci/vfio_pci_core.c     |  8 ++++++++
>  include/linux/vfio_pci_core.h        |  2 ++
>  3 files changed, 39 insertions(+)
> 
> diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> index 0fb5ed5d86b7..f1c6bf06c408 100644
> --- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> +++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> @@ -530,6 +530,31 @@ static void vfio_cxl_release_device(struct vfio_pci_core_device *vdev)
>  	vdev->cxl = NULL;
>  }
>  
> +static void vfio_cxl_zap(struct vfio_pci_core_device *vdev)
> +{
> +	struct vfio_cxl_state *cxl = vdev->cxl;
> +
> +	lockdep_assert_held_write(&vdev->memory_lock);
> +
> +	if (!cxl)
> +		return;
> +
> +	/*
> +	 * Revoke the mapping so a later access re-faults. Do not touch hdm_valid
> +	 * here: zap also runs on a plain PCI Memory-Space disable, across which
> +	 * the committed HDM decoder stays valid (CXL.mem is not gated by PCI
> +	 * Memory-Space). hdm_valid tracks decoder validity and is cleared only by
> +	 * the paths that can leave the decoder unrestored (a failed reset or PM
> +	 * restore). A reset or D3 transition holds memory_lock for write while it
> +	 * runs, so no fault races the revoke, and a runtime-suspended device is
> +	 * caught by the pm_runtime_engaged check on the insert path.
> +	 */
> +	unmap_mapping_range(vdev->vdev.inode->i_mapping,
> +			    VFIO_PCI_INDEX_TO_OFFSET(VFIO_PCI_NUM_REGIONS +
> +						     cxl->hdm_region_idx),
> +			    range_len(&cxl->hpa_range), true);
> +}
> +
>  static int vfio_cxl_open_device(struct vfio_pci_core_device *vdev)
>  {
>  	struct vfio_cxl_state *cxl = vdev->cxl;
> @@ -594,6 +619,9 @@ static int vfio_cxl_open_device(struct vfio_pci_core_device *vdev)
>  	if (ret)
>  		goto err_free_shadows;
>  
> +	/* Remember where the HDM region landed so it can be zapped by index. */
> +	cxl->hdm_region_idx = vdev->num_regions - 1;
> +
>  	ret = vfio_pci_core_register_dev_region(vdev, VFIO_REGION_TYPE_CXL,
>  						VFIO_REGION_SUBTYPE_CXL_COMP_REGS,
>  						&vfio_cxl_comp_regops, cxl->hdm_len,
> @@ -738,6 +766,7 @@ static const struct vfio_cxl_ops vfio_cxl_ops = {
>  	.close_device	= vfio_cxl_close_device,
>  	.config_read	= vfio_cxl_config_read,
>  	.config_write	= vfio_cxl_config_write,
> +	.zap		= vfio_cxl_zap,
>  	.owner		= THIS_MODULE,
>  };
>  
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 77f8f39dd670..1a54f15d1c2c 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -1832,6 +1832,14 @@ void vfio_pci_zap_and_down_write_memory_lock(struct vfio_pci_core_device *vdev)
>  {
>  	down_write(&vdev->memory_lock);
>  	vfio_pci_zap_bars(vdev);
> +	/*
> +	 * The HDM region lives in the device-region offset range that
> +	 * vfio_pci_zap_bars() does not cover, so revoke it here too. Otherwise
> +	 * a runtime-PM entry, D3 transition, or reset would leave the guest
> +	 * with live mappings into a quiesced device.
> +	 */
> +	if (vdev->cxl_ops && vdev->cxl_ops->zap)
> +		vdev->cxl_ops->zap(vdev);
>  }
>  
>  u16 vfio_pci_memory_lock_and_enable(struct vfio_pci_core_device *vdev)
> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
> index 294e95b5e881..8b93949d4484 100644
> --- a/include/linux/vfio_pci_core.h
> +++ b/include/linux/vfio_pci_core.h
> @@ -76,6 +76,8 @@ struct vfio_cxl_ops {
>  			       int count, __le32 *val);
>  	int     (*config_write)(struct vfio_pci_core_device *vdev, int pos,
>  				int count, __le32 val);
> +	/* Revoke the HDM mapping; paired with the BAR zap */
> +	void    (*zap)(struct vfio_pci_core_device *vdev);
>  
>  	/* Pinned per bound CXL device so vfio-cxl cannot unload under usage */
>  	struct module *owner;

