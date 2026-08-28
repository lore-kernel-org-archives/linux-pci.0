Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0606119B5A3;
	Fri, 28 Aug 2026 16:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787935189; cv=none; b=MeohO57il4OG1Bvt0adzP4mR/ya3wJThiKpLj9sR56Wn/Lt2ZVKCr5naG8avDmcnA1sdRcyvTvOnv4b0aciRUxex3jJvRQ7h4mBSYd0yAaUUET8ajZUXQZmizQUnxn6aZ967qOAiqPug8RxdqyDr1zbQIHf2Vziugjurg5S8aGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787935189; c=relaxed/simple;
	bh=/s6kUIX0BwNhNQrHUmOjHRd80OMtnSGCY0HjO6QMZww=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e+0x2voV+YTDAu33esyfuo2YBKhTtrSr2A7KAqC19SpVxoXPI9dSEq3EOh5K4sst/Ps++3gv/JFTwxve7mmsb2fm0LnBM9VvjSXmheEGmAbqldj+oguo44K97odxmg5IU7WrsYEoKOQO8sqp0g6mEX1L0YotOnv2flzG61G9Tw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=Fv4vkQga; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ed61ivDv; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="Fv4vkQga";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ed61ivDv"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1ECC27A016D;
	Fri, 28 Aug 2026 12:39:44 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 28 Aug 2026 12:39:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1787935183;
	 x=1788021583; bh=5NNbE1j8L0e/TPEqDv7jms/SKOZtBYmIxxgzvKw/064=; b=
	Fv4vkQgajXDhtps/zlmbW7XhvKvQepPWsSq5japtziAUJ1/3iFxlOizhSBMIbBr3
	Y2ZOtZWvrWUbtp5NhaGptyua1eFEMTct4UBgjA8Yha54JY2ET4iUcOPSmJjebRPn
	TJecxBAJhF13YGUbxD56KLMeZ6olKmSnl0ozIg62xtEXDwH2JIqxdFjLbUhnKqU6
	UT4ly8srKVt/lBlpkTUOAIO46smbveEYk/V3qC3H+wTj1FUXxvFNdTmDUT5us+Fb
	6hXect+ACWvF8zPtUu23p7ALrZx08lN+lZOxjXnN6+Pf8ui9YJdQDKbNiuDW+ntb
	8N6SbW01pK+uDqxVMPKbWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787935183; x=
	1788021583; bh=5NNbE1j8L0e/TPEqDv7jms/SKOZtBYmIxxgzvKw/064=; b=e
	d61ivDv29DHNU4nWWRO41vZ1LzpY1kC2WdHUgkMI9VBjIhUuDaQ7ooKpC1XljB94
	GO7QuwTeXnbVMQ7P7CWlwLrw/Q47PSynCNjX5QDG5IirPJ3K2S9nfTOYAInQDxV9
	7//jUCKwQbh5Ra0u250SLWwYJGf/zDKVFB1/A73N5TyiAxpjKPxG2oktzS+x9IIB
	SCejNzHT0lEOoxKtd9muKzIjobmGhTQdRFzaPj6FiOgwStGQt8V6rK04u2QbXtdr
	Kx+zjhhDSQV1lvdnmU0j5c2XH8r79PbTbyWhkPIH4o3Os+gvwNRIf1nL9EYFC4yM
	IboGOVpd8Pz/fPV6/6Y2w==
X-ME-Sender: <xms:z7mRahcHswUsBygA7InzYMBr8j9cwQjlSVngSgr5Jm8SH__51Ogs8w>
    <xme:z7mRas1pbA4-dAyNNC2KJrTUBzDigL0Pob1K6vM8cTMwtGFcnVImWO59dLFnKc7Ta
    9QGcBuUfbZiDKg6hAvBi_IQ9ryUJUHGwe3mKIjozIaABO3jefmFLTU>
X-ME-Received: <xmr:z7mRah7Ma6l3nnxDN8kXO_84xQfJI3tQzSwDiwKplADTTZeMJeBEp8Lc0I_Wow>
X-ME-Proxy-Cause: dmFkZTF8hhBUV9lp0uidJZuInZvlH+8zhcIpC5t/ZoJuX1SYP7C+kQ4g6OJDHvK3q7yZrF
    DQW59G/l3XmBbnYIF5B6etDZZizsYbPk1n5ISmcrxJvH0p4nvayk7XjkkPeTJAmu50Vmg8
    YsvWJ2f/s1cBV0ojTgLg8b0Xwijyi5fuVrBzopcsxmNwVlrUy5NOh684DIFy3DRbj/bXgq
    9pOyHxFYbnb8eTxAF6QaeFajGybz7IC3EJuPaQtnBDBne/BQXiCXZiBZ4RhB5CNEVwWwa3
    ORv6BblV7j2tHgtxcL21GxXZd2p2DmlQXaCU/zjH3pb1+t4bXaZZK6dbmGrLb22CwnzhY1
    HQSjiKoSpM4MnyqwcR6hG7RUl0LLP9w6aEAssPcvpV8KksrLvUbgEyZMWAvgg0oxg3zAED
    kbZHp+4t+sDNPPHFvh7YPg1GGlTuil9ADLmAxcKotugvblKQuoUHbIOIJIpSGYniPSP8kN
    Le5gCbwPm6Zmx+JR/wy2MGrYE+BljL9UNwx3jY/95KiJysS7HPPkWWXz7CQmZjf8r2nT/q
    QE8cnonknTL7uA7P0vE/naCOu/e16qzyMr99tLI5whoe9DOSP9IbHULw+BR1mF8NuBnyQk
    n+6VxVObEIqF1ZdhNPJu6ASpWsYqKQn4x7eLMG5+6w7tSBY6C26nTxb5KQBg
X-ME-Proxy: <xmx:z7mRajKpGP6xW-t8pfJSzKdZeRiD5VMq1f-p2pwu7GpnXUWSu2x6Kg>
    <xmx:z7mRalaugriYT3bI7IEMHdhPhMSKxrDBT1ry7mJQnZxwU-qlEiXHZQ>
    <xmx:z7mRao3_HCewNujLOG1REXq_UHIv7qHOchr03AvPiNMz7TLVekstUg>
    <xmx:z7mRavPHy5tj3XtljSYQmy_BT6weHpqCa3f8yO8XVapALkocm5So8w>
    <xmx:z7mRakID4pvmyWRykgJzDbwu4NjdApFpkx236vUt7eTuHzmzBSmwaKvb>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Aug 2026 12:39:40 -0400 (EDT)
Date: Fri, 28 Aug 2026 10:39:38 -0600
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
Subject: Re: [PATCH v4 17/27] vfio/cxl: Virtualize the CXL DVSEC
Message-ID: <20260828103938.3f8fb983@shazbot.org>
In-Reply-To: <20260813093631.2288172-18-mhonap@nvidia.com>
References: <20260813093631.2288172-1-mhonap@nvidia.com>
	<20260813093631.2288172-18-mhonap@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Aug 2026 15:06:21 +0530
<mhonap@nvidia.com> wrote:

> From: Manish Honap <mhonap@nvidia.com>
> 
> Serve reads of the CXL DVSEC body from the per-open shadow and keep guest
> writes in the shadow rather than letting them reach the hardware, so a
> guest cannot reprogram the device through the DVSEC. Accesses outside the
> CXL DVSEC return -ENODEV and take the default DVSEC handling, so a device
> that also exposes a vendor DVSEC is unaffected.
> 
> Route each shadow write through the CXL r4.0 field class rather than
> storing it verbatim: Control stays programmable, Status is
> write-1-to-clear, and Capability, Lock and the Range registers keep their
> firmware snapshot. The guest can no longer set Config Lock or scribble the
> capability and range fields.
> 
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>  drivers/vfio/pci/cxl/vfio_cxl_core.c | 88 ++++++++++++++++++++++++++++
>  drivers/vfio/pci/vfio_pci_config.c   | 36 +++++++++++-
>  include/linux/vfio_pci_core.h        |  5 ++
>  include/uapi/linux/pci_regs.h        |  1 +
>  4 files changed, 129 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> index 2e516a0929c6..9fed909cb9d3 100644
> --- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> +++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> @@ -148,11 +148,99 @@ static void vfio_cxl_close_device(struct vfio_pci_core_device *vdev)
>  	cxl->dvsec_shadow = NULL;
>  }
>  
> +/* Read a 16-bit DVSEC field from the shadow; @off is DVSEC-relative. */
> +static u16 vfio_cxl_dvsec16(struct vfio_cxl_state *cxl, u32 off)
> +{
> +	u32 dw = cxl->dvsec_shadow[off / sizeof(u32)];
> +
> +	return (dw >> (8 * (off % sizeof(u32)))) & 0xffff;
> +}

I don't understand the contract this function is providing.  It claims
to read a 16-bit field, but an odd offset either crosses between 16-bit
fields or drops the upper byte.  The contract would be more clear as:

	return (off & 2) ? (dw >> 16) : (dw & 0xffff);

The comment could also specify _aligned_ 16-bit fields.

> +
> +/*
> + * Apply the CXL r4.0 8.1.3 write class for the 16-bit DVSEC register at @off.
> + * Control is programmable, Status is write-1-to-clear, and Capability, Lock and
> + * the Range registers stay fixed at their firmware snapshot.
> + */
> +static u16 vfio_cxl_dvsec_field(u32 off, u16 old, u16 wval, u16 wmask)
> +{
> +	switch (off) {
> +	case PCI_DVSEC_CXL_CTRL:
> +		/*
> +		 * CXL.mem stays enabled for as long as the guest owns the device.
> +		 * The HDM decoder maps the guest window to device memory, so a
> +		 * store to it while CXL.mem is disabled completes on the device as
> +		 * an error that the host fabric reports as an SError, which is
> +		 * fatal. The spec does not pin down accesses to a decoder whose
> +		 * CXL.mem is off and many hosts SError, so ignore a guest request
> +		 * to clear the enable and keep the bit set.
> +		 */
> +		return ((old & ~wmask) | (wval & wmask)) | PCI_DVSEC_CXL_MEM_ENABLE;
> +	case PCI_DVSEC_CXL_CTRL2:
> +		return (old & ~wmask) | (wval & wmask);
> +	case PCI_DVSEC_CXL_STATUS:
> +	case PCI_DVSEC_CXL_STATUS2:
> +		return old & ~(wval & wmask);
> +	default:
> +		return old;
> +	}
> +}
> +
> +/* Config accesses never cross a dword, so a single shadow entry covers them. */
> +static int vfio_cxl_config_read(struct vfio_pci_core_device *vdev, int pos,
> +				int count, __le32 *val)
> +{
> +	struct vfio_cxl_state *cxl = vdev->cxl;
> +	int boff = (pos - cxl->dvsec) % sizeof(u32);
> +	__le32 dword;
> +
> +	if (pos < cxl->dvsec || pos >= cxl->dvsec + cxl->dvsec_len)
> +		return -ENODEV;
> +
> +	dword = cpu_to_le32(cxl->dvsec_shadow[(pos - cxl->dvsec) / sizeof(u32)]);
> +	memcpy(val, (u8 *)&dword + boff, count);
> +
> +	return count;
> +}
> +
> +static int vfio_cxl_config_write(struct vfio_pci_core_device *vdev, int pos,
> +				 int count, __le32 val)
> +{
> +	struct vfio_cxl_state *cxl = vdev->cxl;
> +	int idx = (pos - cxl->dvsec) / sizeof(u32);
> +	int boff = (pos - cxl->dvsec) % sizeof(u32);
> +	u32 off = idx * sizeof(u32);
> +	__le32 le_wval = 0, le_wmask = 0;
> +	u32 old, wval, wmask;
> +	u16 lo, hi;
> +
> +	if (pos < cxl->dvsec || pos >= cxl->dvsec + cxl->dvsec_len)
> +		return -ENODEV;
> +
> +	/*
> +	 * Place the guest bytes and a matching byte mask at the write offset,
> +	 * then let the per-field class decide what actually lands in the shadow.
> +	 * The hardware is never touched.
> +	 */
> +	memcpy((u8 *)&le_wval + boff, &val, count);
> +	memset((u8 *)&le_wmask + boff, 0xff, count);
> +	old = cxl->dvsec_shadow[idx];
> +	wval = le32_to_cpu(le_wval);
> +	wmask = le32_to_cpu(le_wmask);
> +
> +	lo = vfio_cxl_dvsec_field(off, old, wval, wmask);
> +	hi = vfio_cxl_dvsec_field(off + 2, old >> 16, wval >> 16, wmask >> 16);
> +	cxl->dvsec_shadow[idx] = lo | ((u32)hi << 16);
> +
> +	return count;
> +}
> +
>  static const struct vfio_cxl_ops vfio_cxl_ops = {
>  	.init_device	= vfio_cxl_init_device,
>  	.release_device	= vfio_cxl_release_device,
>  	.open_device	= vfio_cxl_open_device,
>  	.close_device	= vfio_cxl_close_device,
> +	.config_read	= vfio_cxl_config_read,
> +	.config_write	= vfio_cxl_config_write,
>  	.owner		= THIS_MODULE,
>  };
>  
> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
> index a10ed733f0e3..f088e4ce5e07 100644
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c
> @@ -1102,6 +1102,39 @@ void vfio_pci_uninit_perm_bits(void)
>  	free_perm_bits(&ecap_perms[PCI_EXT_CAP_ID_PWR]);
>  }
>  
> +/*
> + * DVSEC accesses are dispatched to vfio-cxl for a CXL device. It handles the
> + * CXL DVSEC and returns -ENODEV for any other DVSEC, for which the default
> + * handling then applies.
> + */
> +static int vfio_pci_dvsec_config_read(struct vfio_pci_core_device *vdev, int pos,
> +				      int count, struct perm_bits *perm,
> +				      int offset, __le32 *val)
> +{
> +	if (vdev->cxl_ops && vdev->cxl_ops->config_read) {
> +		int ret = vdev->cxl_ops->config_read(vdev, pos, count, val);
> +
> +		if (ret != -ENODEV)
> +			return ret;
> +	}
> +
> +	return vfio_direct_config_read(vdev, pos, count, perm, offset, val);
> +}
> +
> +static int vfio_pci_dvsec_config_write(struct vfio_pci_core_device *vdev,
> +				       int pos, int count, struct perm_bits *perm,
> +				       int offset, __le32 val)
> +{
> +	if (vdev->cxl_ops && vdev->cxl_ops->config_write) {
> +		int ret = vdev->cxl_ops->config_write(vdev, pos, count, val);
> +
> +		if (ret != -ENODEV)
> +			return ret;
> +	}
> +
> +	return vfio_raw_config_write(vdev, pos, count, perm, offset, val);
> +}
> +
>  int __init vfio_pci_init_perm_bits(void)
>  {
>  	int ret;
> @@ -1121,7 +1154,8 @@ int __init vfio_pci_init_perm_bits(void)
>  	ret |= init_pci_ext_cap_err_perm(&ecap_perms[PCI_EXT_CAP_ID_ERR]);
>  	ret |= init_pci_ext_cap_pwr_perm(&ecap_perms[PCI_EXT_CAP_ID_PWR]);
>  	ecap_perms[PCI_EXT_CAP_ID_VNDR].writefn = vfio_raw_config_write;
> -	ecap_perms[PCI_EXT_CAP_ID_DVSEC].writefn = vfio_raw_config_write;
> +	ecap_perms[PCI_EXT_CAP_ID_DVSEC].readfn = vfio_pci_dvsec_config_read;
> +	ecap_perms[PCI_EXT_CAP_ID_DVSEC].writefn = vfio_pci_dvsec_config_write;
>  
>  	if (ret)
>  		vfio_pci_uninit_perm_bits();
> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
> index 7354dae1dd85..b9202cb29d96 100644
> --- a/include/linux/vfio_pci_core.h
> +++ b/include/linux/vfio_pci_core.h
> @@ -72,6 +72,11 @@ struct vfio_cxl_ops {
>  	void	(*release_device)(struct vfio_pci_core_device *vdev);
>  	int     (*open_device)(struct vfio_pci_core_device *vdev);
>  	void    (*close_device)(struct vfio_pci_core_device *vdev);
> +	int     (*config_read)(struct vfio_pci_core_device *vdev, int pos,
> +			       int count, __le32 *val);
> +	int     (*config_write)(struct vfio_pci_core_device *vdev, int pos,
> +				int count, __le32 val);
> +
>  	/* Pinned per bound CXL device so vfio-cxl cannot unload under usage */
>  	struct module *owner;
>  };
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 4f5942ebd29b..00ca1c777b44 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1359,6 +1359,7 @@
>  #define  PCI_DVSEC_CXL_CTRL				0xC
>  #define   PCI_DVSEC_CXL_CACHE_ENABLE			_BITUL(0)
>  #define   PCI_DVSEC_CXL_MEM_ENABLE			_BITUL(2)
> +#define  PCI_DVSEC_CXL_STATUS				0xE
>  #define  PCI_DVSEC_CXL_CTRL2				0x10
>  #define   PCI_DVSEC_CXL_DISABLE_CACHING			_BITUL(0)
>  #define   PCI_DVSEC_CXL_INIT_CACHE_WBI			_BITUL(1)

This is still not the correct implementation.  We're only doing
virtualized and writable bit manipulation, with some RW1C manipulation
that doesn't require CXL callouts or module dependencies.  This could
all live in vfio_pci_config.c gated on fields in the core vdev, ex.
vdev->cxl_dvsec, vdev->cxl_dvsec_len.  We can setup a vdev->cxl_perms
field with similar use and initialization to msi_perms.  This would
also avoid the CXL DVSEC shadow setup in the previous patch as vconfig
already shadows this range.

The only CXL callouts I see later in the series are for reset, where
we can make much more discrete ops callouts for store flags to avoid
direct CXL module dependencies.  Thanks,

Alex
