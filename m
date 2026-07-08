Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D641037E2E2;
	Wed,  8 Jul 2026 23:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783553650; cv=none; b=sxCEgeRBcrLovI+EqnqGLNgisThGBH8OU/N2zbfyblEa9iNnZwYRoc/cjR0VwyqPgTKsvSG8eGeHaZah8bqxjSOp4IiSXITQtra3M6hmf5CrV7lSOCeHHI5LNO/jEigWaiXif+DPOpNEqmI6hVc2jvKb5n4oWHPjUhVBsZm54Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783553650; c=relaxed/simple;
	bh=axRByRxelrkFqgEv23wD/UsPVPrlv+8YX23UAy/oGxM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M3zP1ox/Fp8IRGQ2saa+zErGYONep4EFf9R6Vx1o1qvFg5uGymmbUk6CRAvY2MmTbPdL+4Ax9iOVopxHCFntl8xDs2H9g0ySD2VpfoBuQ7SYYHF95w7X7M34rmahAnQ/dmhEc20QetkeA+Wx9WRGrYX2O0RRHSzumBXnaDNLb90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=ci18Xcdj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BqheIICr; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="ci18Xcdj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BqheIICr"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4330A14000A2;
	Wed,  8 Jul 2026 19:34:06 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 08 Jul 2026 19:34:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1783553646;
	 x=1783640046; bh=gNzvrxNv7zQ9srJ7QGENVoB+ORW9mDFFs6dEKRh1E84=; b=
	ci18XcdjNL9l4jBV1mw4skYHWxIZMYScoXF3UJm4FtuMs7oR9/o9aRs+5i1UYSPG
	Nx1y2Km+DttjSiElRCSNYL8RUcP3QfHeqfCdNa8OBPSf28yyOP/7KxDTZSkuXRWh
	ACw1SSWB2H7FBpoSN7+KugzBWqdyR5jhjwfm8bWvpcotcaZ5HzuTNoqTI8LZ9fih
	U7IGrD/gQ+qmr5LUTHMi13jHnhFhoKu/QoRg9nxWjTgR25+ycmSw6wZ5ngX5pIAP
	eVyh/h8ZzcGI6gq1UzF+Uht4hajORgeCQgMaupqod3vM+lcNRtZQ3HTDgSH9askS
	MInEpS2du7XhknU/Iwd82A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783553646; x=
	1783640046; bh=gNzvrxNv7zQ9srJ7QGENVoB+ORW9mDFFs6dEKRh1E84=; b=B
	qheIICrqhuipstZSAqClHG5hW9hFPKrYWRvM6+b+g1hQzcjZbsNjwWLdCCN6qbsy
	gb31f2wdamXNeQ9CQlKT7a2fPJrPjvIvScuPVvZ3lu+vKD0IfpBmkKsZUBb+EDRj
	gveI9bKCEV4HMcOpOrkUcT0T6hJyjRGgfTs9R6eh+Y+A59ksDRpTV/RtIBPmDg0P
	UsuT2uL/XG3lR59yRMCF7hNnnudcI1NHi7+fizGaOMZXIii5i7ympFxp+xYfBNzd
	b9H9gUusKb6v1pYqELf7xh0w2/F2igUbTUi7h7wSl8NUQcXv3BFsNMSdBv9JNl09
	q4s1w6mE5DJjGsREVgYdg==
X-ME-Sender: <xms:bt5OahQlt_xQbFEtO4PRwLGMUaN0MxrRccs1QghMSYyf_S6gTyf99g>
    <xme:bt5OagRYRfKZSm6fFufvVe0Lmza_vph22cGqYLZavWNInVwEWnxD270tXIVNYCzIK
    XjIrxhtbEM8fG44Om36aUybTnnDvvG1yrxRUoQmAhNAbHTpVQH5BA>
X-ME-Received: <xmr:bt5Oal7jSDsjhBZdE3aUD-yYUbOJOdkiX_JNQyhicd_8ldTL7wk9KvwLZMs>
X-ME-Proxy-Cause: dmFkZTF7UcUU4Y3WDZRTQWDCK1Byb23HRnJp+Faq1G3D8RtL7hYGl6JFjaGdMXzAICQHA+
    XqcIU6GZsrthOywnQjf1wxVvn4pLS1EXq646WTLg8DOELNUY4w/wQJOKp10J/PZbJUSK4v
    Fx0R4HXnsIh4g6B9RzzhJzwe7PMFO6Vxx203G4GNcRGcjThD6sD8GyRFSV1IrKHpLw2XXx
    /GFEe6JZQ8jywi4eGClo6TvyyXcHYqUqIFdc4zrub7KyT3YnYVzkHoIvsK1a/EuUNFqUPo
    ijwv/0xb+0b/ynjmyMkXG/330YEmG/AW9ulMXS92NurtWcjcsNOTw07hSbFPDObnsjOmZg
    5wwe1Y5QOzoddOY0H9hU4ZszRwEvr8G2uC/K7+XF6fhA68daE3KLpHrh3OBM5FAy1DzWog
    o817bT8LJy9mI3u4BcBf4fnfSuS8v3T61J/3LIh9piuQf6/dfXAz5CvttDgB6rlcTUt6md
    8MQkJbj47BkpPFIg7/BmcX8YOufjazlFp2CWMykQpCR7mgJyfK35cuUIoigwdUdzQ1DgrR
    FZQEmMtET7TIqoO4KTYmy2oY8tDmUgeQWfPIdiqjmhrEvJcg+hDzcZAwhG6pJoJ0KhCBCt
    EDOnc5b3MKJr6/zAqm4EsllvKLJ+CY2YqpzoU66sT/97W73PEta+ym0terEQ
X-ME-Proxy: <xmx:bt5OatVQkKKQb2YxYmDGsvUkdQ__V7Gcx9R-wKG-zxZi_9Ru7aenEA>
    <xmx:bt5Oaj9H2Gy4Pb_sJhm01uQqrlgQZUCkPXowT80kT3C3EOm5QxNFtQ>
    <xmx:bt5OaloRHXU4VXjXReZ8C0ZoM_7jNFEXK-buSYSOa7gxPnOjHbkkmw>
    <xmx:bt5OauLeXGvY1wOFv8QxxIIjmf2ttv60Pc5z61oTBRVlAdkKoQHEXg>
    <xmx:bt5OajyVCiFDJg7f919UruAXc9Q-cPmyJtNQ6FflCMDrkOcCvhxjE0nb>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 19:34:05 -0400 (EDT)
Date: Wed, 8 Jul 2026 17:29:54 -0600
From: Alex Williamson <alex@shazbot.org>
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: <jgg@ziepe.ca>, <helgaas@kernel.org>, <wathsala.vithanage@arm.com>,
 <wei.huang2@amd.com>, <zhipingz@meta.com>, <wangzhou1@hisilicon.com>,
 <wangyushan12@huawei.com>, <liuyonglong@huawei.com>, <kvm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, alex@shazbot.org
Subject: Re: [PATCH v19 16/18] vfio/pci: Implement TPH_ST feature for batch
 ST table programming
Message-ID: <20260708172954.14bff5c4@shazbot.org>
In-Reply-To: <20260702124224.57168-17-fengchengwen@huawei.com>
References: <20260702124224.57168-1-fengchengwen@huawei.com>
	<20260702124224.57168-17-fengchengwen@huawei.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 2 Jul 2026 20:42:22 +0800
Chengwen Feng <fengchengwen@huawei.com> wrote:

> Add vfio_pci_core_feature_tph_st() to implement the SET-only
> VFIO_DEVICE_FEATURE_TPH_ST uAPI for batch TPH ST table programming.
> 
> Implement helper routines to calculate ST table size and resolve ST tags
> from multiple sources: NONE, DMABUF, CPU volatile/persistent, and LITERAL.
> 
> Batch program contiguous ST table entries according to user inputs, support
> stop-on-zero-ST semantics, and return the number of successfully written
> entries. Hold memory_lock and ensure device is in D0 state during hardware
> operations.
> 
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c | 119 +++++++++++++++++++++++++++++++
>  1 file changed, 119 insertions(+)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index ed6bbffa8b26..7251e251824a 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -1713,6 +1713,123 @@ static int vfio_pci_core_feature_tph_resolve(struct vfio_pci_core_device *vdev,
>  	return copy_to_user(arg, &resolve, sizeof(resolve)) ? -EFAULT : 0;
>  }
>  
> +static u32 tph_calc_st_size(struct vfio_pci_core_device *vdev)
> +{
> +	struct pci_dev *pdev = vdev->pdev;
> +	u32 loc = pcie_tph_get_st_table_loc(pdev);
> +	int ret;
> +
> +	if (loc == PCI_TPH_LOC_CAP) {
> +		return pcie_tph_get_st_table_size(pdev);
> +	} else if (loc == PCI_TPH_LOC_MSIX) {
> +		ret = pci_msix_vec_count(pdev);
> +		if (ret < 0)
> +			return 0;
> +		return ret;
> +	} else {
> +		return 0;
> +	}
> +}
> +
> +static int tph_get_st_tag(struct pci_dev *pdev, u32 src_bits, u32 src_hndl,
> +			  bool extended, u16 *tag)
> +{
> +	int ret = 0;
> +	u8 ph;
> +
> +	if (src_bits & VFIO_DEVICE_TPH_SRC_NONE)
> +		*tag = 0;
> +	else if (src_bits & VFIO_DEVICE_TPH_SRC_DMABUF)
> +		ret = vfio_pci_dma_buf_get_tph_by_fd(src_hndl, extended,
> +						     tag, &ph);
> +	else if (src_bits & VFIO_DEVICE_TPH_SRC_CPU_VOLATILE)
> +		ret = pcie_tph_get_cpu_st_explicit(pdev, TPH_MEM_TYPE_VM,
> +					extended, src_hndl, tag);
> +	else if (src_bits & VFIO_DEVICE_TPH_SRC_CPU_PERSISTENT)
> +		ret = pcie_tph_get_cpu_st_explicit(pdev, TPH_MEM_TYPE_PM,
> +					extended, src_hndl, tag);
> +	else if (src_bits & VFIO_DEVICE_TPH_SRC_LITERAL)
> +		*tag = src_hndl;
> +
> +	if (ret != 0)
> +		*tag = 0;
> +
> +	return ret;
> +}
> +
> +static int vfio_pci_core_feature_tph_st(struct vfio_pci_core_device *vdev,
> +				u32 flags,
> +				struct vfio_device_feature_tph_st __user *arg,
> +				size_t argsz)
> +{
> +	u32 permit_flags = VFIO_DEVICE_TPH_SRC_MASK | VFIO_DEVICE_TPH_EXTENDED;
> +	struct vfio_device_feature_tph_st tph_st = {0};
> +	struct pci_dev *pdev = vdev->pdev;
> +	u32 src_bits, st_size;
> +	bool stop_on_zero_st;
> +	u32 *src_hndl = NULL;
> +	void __user *uptr;
> +	bool extended;
> +	int ret, i;
> +	u16 tag;
> +
> +	if (!vdev->tph_permit || vdev->tph_policy == VFIO_PCI_TPH_POLICY_NO_ST)
> +		return -EOPNOTSUPP;
> +
> +	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_SET,
> +				 sizeof(tph_st));
> +	if (ret <= 0)
> +		return ret;

Again, not how vfio_check_feature() convetion.

> +
> +	if (copy_from_user(&tph_st, arg, sizeof(tph_st)))
> +		return -EFAULT;
> +

MUST validate undefined flags are zero.

> +	src_bits = tph_st.flags & VFIO_DEVICE_TPH_SRC_MASK;
> +	if (vdev->tph_policy != VFIO_PCI_TPH_POLICY_LITERAL)
> +		permit_flags &= ~VFIO_DEVICE_TPH_SRC_LITERAL;
> +	if (!(tph_st.flags & permit_flags) || !is_power_of_2(src_bits))
> +		return -EINVAL;
> +	extended = !!(tph_st.flags & VFIO_DEVICE_TPH_EXTENDED);
> +	if (extended && !pcie_tph_supported(vdev->pdev, true))
> +		return -EINVAL;
> +
> +	st_size = tph_calc_st_size(vdev);
> +	if (tph_st.start >= st_size || tph_st.count > st_size - tph_st.start ||
> +		tph_st.count == 0)
> +		return -EINVAL;
> +
> +	uptr = u64_to_user_ptr(tph_st.dests);
> +	if (!(src_bits & VFIO_DEVICE_TPH_SRC_NONE)) {
> +		src_hndl = memdup_array_user(uptr, tph_st.count, sizeof(u32));
> +		if (IS_ERR(src_hndl))
> +			return PTR_ERR(src_hndl);
> +	}
> +
> +	down_write(&vdev->memory_lock);

No, vfio_pci_memory_lock_and_enable().

> +	ret = vfio_pci_set_power_state(vdev, PCI_D0);

No, PM runtime get/set, but once again it's already done in the call
path.

> +	if (ret)
> +		goto out;
> +
> +	stop_on_zero_st = !!(tph_st.flags & VFIO_DEVICE_TPH_REQUIRE_ST);
> +	if (tph_st.flags & VFIO_DEVICE_TPH_SRC_NONE)
> +		stop_on_zero_st = false;
> +	for (i = 0; i < tph_st.count; i++) {
> +		ret = tph_get_st_tag(pdev, src_bits, src_hndl ? src_hndl[i] : 0,
> +				     extended, &tag);
> +		if (ret || (stop_on_zero_st && tag == 0))
> +			break;

Missing bounds check on tag if !extended.

In IV mode, don't we need to know the vector is enabled?

> +		ret = pcie_tph_set_st_entry(pdev, tph_st.start + i, tag);

We're defeating the entire reason we created a batching interface by
not also implementing a batching interface in the PCI/TPH code.  This
does a disable before each set.  Thanks,

Alex

> +		if (ret)
> +			break;
> +	}
> +	ret = i;
> +
> +out:
> +	up_write(&vdev->memory_lock);
> +	kfree(src_hndl);
> +	return ret;
> +}
> +
>  int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
>  				void __user *arg, size_t argsz)
>  {
> @@ -1736,6 +1853,8 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
>  	case VFIO_DEVICE_FEATURE_TPH_RESOLVE:
>  		return vfio_pci_core_feature_tph_resolve(vdev, flags,
>  							 arg, argsz);
> +	case VFIO_DEVICE_FEATURE_TPH_ST:
> +		return vfio_pci_core_feature_tph_st(vdev, flags, arg, argsz);
>  	default:
>  		return -ENOTTY;
>  	}

