Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3A922157B;
	Fri, 22 May 2026 04:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779423049; cv=none; b=DG82RugI/noIhxNyB4NCBvO9KACxBiuNA5NHB4KGfPQF0NLx0joHuFIw2D4DpL6NY9XbfJzp7km2HbWJLVI9XreN9IRQsXIoUSMz7WiOQvEtzYIGnYtCg9LFEgV2p2FH34TEAtiBogTf+IRQaUhlb/TcjzBqtcoMGJAGhh7e+00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779423049; c=relaxed/simple;
	bh=TY2TuJ2Z33bsI9siTgwStbZVHW1F/Ek4z+5iw/bEKc0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jvcpKR/ol9/l/+Cxx8Zsey9YEIXxyxPun1nnELhwJPQPbHVf15TkJkTv3agEJOZHdwhYjI16ptfGi03x4O33qgSpEAb8xetc/E3sBZU/Q33I9oE2w08la2imP3WnjGAwVvz738Y9t5geX15eFg4AZrF2g1ddPBjrRpIZWpPr2jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=eprOi5ei; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iaQPdJ/S; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="eprOi5ei";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iaQPdJ/S"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 613411400009;
	Fri, 22 May 2026 00:10:45 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 22 May 2026 00:10:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779423045;
	 x=1779509445; bh=4b6Um9a9Wie52VnGqESWy3qTnjqY1k9Jq+fM0wQDCJs=; b=
	eprOi5eiurbD/WOmsihUkwVIzPnwJ17PJ0HxlXxYfbfqFFyKCppypj5edxQBk22y
	vcaJhn36EkgbBWQDh+8sSxwMpophdq92eaAPUcvJxJcj5zTI52eSqBiy27mePLBP
	AblDityHQ1p22ZPpX2VADXlT4X1CxdbLyeJELyrHrILYL4LNO/N0ndOYY/cRGz6e
	JI32B7ZTVy06Lac4uOrQNp2B3EGtzpjNzpvYZ8ggwSeln2SovfVdNdQtZOHGHG0h
	p5i0q6PIO2CqV9IUQejOJsCJ+H0gUUxMmwPz8EUYEl6YEp+lOqL1XIw0uvxHsCYY
	AIVIAoU3lkUipthl9nOmkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779423045; x=
	1779509445; bh=4b6Um9a9Wie52VnGqESWy3qTnjqY1k9Jq+fM0wQDCJs=; b=i
	aQPdJ/SEKF1rPR+l2r9/c2Bb3VjzO529tt+VC45HPTgyp4gHBumt3V1aophSB3bs
	O4k78RBgEnegyLJFWdObbzJzLW25Mkex07yRpHVPyumU7kjjVhwYtU1s5ZwWgCKk
	Q99GSgT+QpjtUYLLMrPnan1YfJ1qvsNDt4qovNITVNk3nJ9q6nuZ8zaw7ihXROwk
	KkQlJzok9Zz4oYkizSIQrJW9NP0fxhuRNjtyABtA4jr6xEnS1UYeEmG6K6hyL2j6
	SKUOAHsvAkbe7EmXRg9RkMOVugpWhHF17eRkAHM9NKDyvafNmo/A8Nqcwy1/NqBr
	RK8D9k2PfdjQuW5ync6wg==
X-ME-Sender: <xms:RNcPavlrWTqncFQZR1FVQy30l_tgzvmu7iv1-Sldxlsj_bht5Zozcw>
    <xme:RNcPahE1GQnJMPqzzaVPvX-AGuV0xPnIbSfrUuLVBp24FpuwBaHDeNVPX1H4lZoZR
    VblG5HSeLuze5Xmg7H0kisyN2TzCkn1rL3DagfnXZbIQ_y-Z9BBNQ>
X-ME-Received: <xmr:RNcPau8hYyavgS2ys4S09_vn9xkA3NbOTmWBzFg9RruFPrOVr7CzwZl0GK4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeelfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvkeefjeekvdduhfduhfetkedugfduieettedvueekvdehtedvkefgudeg
    veeuueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehfvghnghgthhgvnhhgfigvnheshhhurgifvghird
    gtohhmpdhrtghpthhtohepjhhgghesiihivghpvgdrtggrpdhrtghpthhtohepfigrthhh
    shgrlhgrrdhvihhthhgrnhgrghgvsegrrhhmrdgtohhmpdhrtghpthhtohephhgvlhhgrg
    grsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfigvihdrhhhurghnghdvsegrmhgu
    rdgtohhmpdhrtghpthhtohepfigrnhhgiihhohhuudeshhhishhilhhitghonhdrtghomh
    dprhgtphhtthhopeifrghnghihuhhshhgrnhduvdeshhhurgifvghirdgtohhmpdhrtghp
    thhtoheplhhiuhihohhnghhlohhngheshhhurgifvghirdgtohhmpdhrtghpthhtohepkh
    hvmhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:RNcPaqn_6umt7KoKw9VVOdaKtKlOkyzhreKJzmclBbUTzvLZWhi0JQ>
    <xmx:RNcPahDMV8iDF67tAWtPOO-4n8OuBhDNVioiQckQnpEE8vKGb5n9bQ>
    <xmx:RNcParWtqeoLrSZoox9kpdVtauHurtsayORcuo22eGLxAOEbpkNI1A>
    <xmx:RNcPan_NfD0f61b28Pt8-HLbSqTJnsI8OkRwihtSmmyMyDKdjYrPPw>
    <xmx:RdcPamTtpdYS3gJjcoSyx4Ttdmbqtp-Plk1Q8D_g_VHt7UNf7t9Za8Rz>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 May 2026 00:10:43 -0400 (EDT)
Date: Thu, 21 May 2026 22:10:08 -0600
From: Alex Williamson <alex@shazbot.org>
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: <jgg@ziepe.ca>, <wathsala.vithanage@arm.com>, <helgaas@kernel.org>,
 <wei.huang2@amd.com>, <wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
 <liuyonglong@huawei.com>, <kvm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, alex@shazbot.org
Subject: Re: [PATCH v11 5/5] vfio/pci: Add VFIO_DEVICE_FEATURE_TPH_ST for
 TPH ST entry management
Message-ID: <20260521221008.59ddf977@shazbot.org>
In-Reply-To: <20260518071701.25177-6-fengchengwen@huawei.com>
References: <20260518071701.25177-1-fengchengwen@huawei.com>
	<20260518071701.25177-6-fengchengwen@huawei.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 May 2026 15:17:01 +0800
Chengwen Feng <fengchengwen@huawei.com> wrote:

> Add VFIO_DEVICE_FEATURE_TPH_ST to allow userspace to manage PCIe TPH
> Steering Tag entries.
> 
> SET: Program contiguous ST entries when ST table resides in TPH Capability
>      or MSI-X table. U32_MAX CPU ID clears the corresponding ST entry.
> GET: Retrieve ST values per CPU ID, only available in DS mode.
> 
> Both operations are only valid when TPH is enabled on the device.

What?  That doesn't align with the hardware programming model.  The
specification even suggests that the device should be quiesced or TPH
disabled during programming of the steering tags for deterministic
behavior.

> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c | 91 ++++++++++++++++++++++++++++++++
>  include/uapi/linux/vfio.h        | 41 ++++++++++++++
>  2 files changed, 132 insertions(+)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 0d0140202280..13a22c1d6ea6 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -1558,6 +1558,95 @@ static int vfio_pci_core_feature_token(struct vfio_pci_core_device *vdev,
>  	return 0;
>  }
>  
> +static int vfio_pci_core_feature_tph_st(struct vfio_pci_core_device *vdev,
> +					u32 flags,
> +					struct vfio_device_feature_tph_st __user *arg,
> +					size_t argsz)
> +{
> +	bool is_set = !!(flags & VFIO_DEVICE_FEATURE_SET);
> +	struct vfio_device_feature_tph_st tph_st;
> +	struct pci_dev *pdev = vdev->pdev;
> +	enum tph_mem_type mtype;
> +	int i, j, ret;
> +	u32 *cpus;
> +	u16 st;
> +
> +	guard(mutex)(&vdev->tph_lock);

Wrong place for this lock.  Why do we even need it?  If a user races
SET/GET with enable/disable, that's their problem.

> +
> +	ret = vfio_check_feature(flags, argsz,
> +				 VFIO_DEVICE_FEATURE_GET |
> +				 VFIO_DEVICE_FEATURE_SET,
> +				 sizeof(tph_st));
> +	if (ret <= 0)
> +		return ret;
> +
> +	if (!enable_unsafe_tph ||

Why did we allow the feature to be probe if it can't be used?

> +		pcie_tph_enabled_mode(pdev) == PCI_TPH_ST_NS_MODE)

Here's that ambiguity of reporting NS_MODE for disabled, but as above
it's a bogus requirement.

> +		return -EOPNOTSUPP;
> +	if (!is_set && pcie_tph_enabled_mode(pdev) != PCI_TPH_ST_DS_MODE)

Why?  Let the interface be symmetric that GET works regardless of mode.

> +		return -EOPNOTSUPP;
> +	if (is_set && pcie_tph_get_st_table_loc(pdev) == PCI_TPH_LOC_NONE)
> +		return -EOPNOTSUPP;
> +
> +	if (copy_from_user(&tph_st, arg, sizeof(tph_st)))
> +		return -EFAULT;
> +
> +	if (tph_st.count == 0 || tph_st.count > VFIO_TPH_ST_MAX_COUNT ||
> +		tph_st.flags > VFIO_TPH_ST_MEM_TYPE_PM)

Wrong operation for a flags field.

> +		return -EINVAL;
> +	if (!is_set && tph_st.index != 0)

We can only GET index 0?  Why?

> +		return -EINVAL;
> +	if (is_set && (tph_st.index >= VFIO_TPH_ST_MAX_COUNT ||
> +		       tph_st.index + tph_st.count > VFIO_TPH_ST_MAX_COUNT))

DS can have more that 2048 steering tags.

> +		return -EINVAL;
> +
> +	cpus = memdup_array_user(&arg->data, tph_st.count, sizeof(*cpus));

Use an __aligned_u64 data_uptr like iommufd does and avoid copying this
into the kernel.  Isn't this steering tags, why's it named cpus?

> +	if (IS_ERR(cpus))
> +		return PTR_ERR(cpus);
> +
> +	mtype = tph_st.flags & VFIO_TPH_ST_MEM_TYPE_PM ? TPH_MEM_TYPE_PM :
> +							 TPH_MEM_TYPE_VM;

Then why did we use two flag bits for this?

> +	if (!is_set) {
> +		for (i = 0; i < tph_st.count; i++) {
> +			ret = pcie_tph_get_cpu_st(pdev, mtype, cpus[i], &st);

My understanding was that GET would return the translated values from a
previous SET, not translate on the fly.  I think in order to support
writing STs before enabling TPH, we're going to need to store them
somewhere anyway so that we can push them to the correct location when
TPH is enabled.  That means there a buffer for SET/GET regardless of
the mode that's enabled.

> +			if (ret)
> +				goto out;
> +			cpus[i] = st;
> +		}
> +		goto out;
> +	}
> +
> +	for (i = 0; i < tph_st.count; i++) {
> +		if (cpus[i] == U32_MAX) {
> +			ret = pcie_tph_set_st_entry(pdev, tph_st.index + i, 0);

Why do we need a magic value to set it to zero?  Hardware doesn't have
a "clear ST register value".

> +			if (ret)
> +				goto out;
> +			continue;
> +		}
> +
> +		ret = pcie_tph_get_cpu_st(pdev, mtype, cpus[i], &st);
> +		if (ret)
> +			goto out;
> +		ret = pcie_tph_set_st_entry(pdev, tph_st.index + i, st);
> +		if (ret)
> +			goto out;

Clearly broken for DS mode.

> +	}
> +
> +out:
> +	if (!is_set && !ret) {
> +		if (copy_to_user(&arg->data, cpus,
> +			tph_st.count * sizeof(*cpus)))
> +			ret = -EFAULT;
> +	}
> +	if (is_set && ret) {
> +		/* Roll back previously programmed entries to 0 */
> +		for (j = 0; j < i; j++)
> +			pcie_tph_set_st_entry(pdev, tph_st.index + j, 0);

The magic value is zero, not U32_MAX.  Thanks,

Alex

> +	}
> +	kfree(cpus);
> +	return ret;
> +}
> +
>  int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
>  				void __user *arg, size_t argsz)
>  {
> @@ -1576,6 +1665,8 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
>  		return vfio_pci_core_feature_token(vdev, flags, arg, argsz);
>  	case VFIO_DEVICE_FEATURE_DMA_BUF:
>  		return vfio_pci_core_feature_dma_buf(vdev, flags, arg, argsz);
> +	case VFIO_DEVICE_FEATURE_TPH_ST:
> +		return vfio_pci_core_feature_tph_st(vdev, flags, arg, argsz);
>  	default:
>  		return -ENOTTY;
>  	}
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 5de618a3a5ee..aca39d4e5307 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -1534,6 +1534,47 @@ struct vfio_device_feature_dma_buf {
>   */
>  #define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
>  
> +/**
> + * VFIO_DEVICE_FEATURE_TPH_ST - Get/Set PCIe TPH Steering Tag (ST) entries
> + *
> + * Provides userspace interface to manage PCIe TPH ST table entries.
> + * This feature is only available when device TPH is enabled.
> + *
> + * Upon VFIO_DEVICE_FEATURE_SET:
> + *   Program contiguous ST table entries from the starting @index.
> + *   Valid only for hardware with ST table located in TPH Capability
> + *   space or MSI-X table. If an entry CPU ID is specified as U32_MAX,
> + *   the corresponding ST entry will be cleared. @index and @count define
> + *   the contiguous entry range to be programmed.
> + *   If any entry programming fails, the operation will roll back and
> + *   clear all entries that were successfully programmed before the error.
> + *
> + * Upon VFIO_DEVICE_FEATURE_GET:
> + *   Retrieve the ST value mapped to each given CPU ID in the @data array.
> + *   Userspace fills @data with CPU ID array, the interface returns each
> + *   CPU's corresponding ST value back in place.
> + *   Valid only when TPH DS mode is enabled.
> + *
> + * @flags: Operation flags (VFIO_TPH_ST_MEM_TYPE_*).
> + * @index: Starting ST entry index, only valid for FEATURE_SET.
> + * @count: Number of contiguous entries to access.
> + * @data: Array of CPU IDs for both SET and GET. On SET it programs ST for
> + *        each CPU; on GET it returns the mapped ST value of each CPU.
> + *
> + * This feature is gated by enable_unsafe_tph module parameter.
> + */
> +#define VFIO_DEVICE_FEATURE_TPH_ST	13
> +
> +struct vfio_device_feature_tph_st {
> +	__u32 flags;
> +#define VFIO_TPH_ST_MEM_TYPE_VM		(0U << 0)
> +#define VFIO_TPH_ST_MEM_TYPE_PM		(1U << 0)
> +	__u16 index;
> +	__u16 count;
> +#define VFIO_TPH_ST_MAX_COUNT		2048
> +	__u32 data[] __counted_by(count);
> +};
> +
>  /* -------- API for Type1 VFIO IOMMU -------- */
>  
>  /**

