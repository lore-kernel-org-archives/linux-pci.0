Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE9B39DBE5;
	Wed,  8 Jul 2026 23:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783553639; cv=none; b=feC9iHgBmBcV/8Wwwdm/YaBw5eqRvTPuLFT29VT9dS0/qEMYVGglLISpMbR81aRXR6Zt2Pg3rPq831mtl0cOmSync4+7VlM6//e6g5oO3pzZOCEiDp80NmsTANgUSTM6R2EBaVMNLM8KMBA9fw6zgcP+SwWOEoZWgJOHa5j2cZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783553639; c=relaxed/simple;
	bh=AOOoCGMLwjlkkuv2RN4oxVC72N/1yw0CiFH4GvvSavI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XG+cvApj8Xe86l9auQYGbc7A/HbJ5FYM1fVK7pj71N9jXOL63TiXliXuAlR2dz3qpZ2t16UdbDyb8GqlEjRP9EqCX4wI+r58t2OedIInAG7joXCAvD5SbFyuzwXYHQxByW0sSzLo16p8LwP8iu/7l0zLUAm8yK9BqAUq1OWX9G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=NpkNOdfa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VupyzQZK; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="NpkNOdfa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VupyzQZK"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 00CFDEC0077;
	Wed,  8 Jul 2026 19:33:57 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 08 Jul 2026 19:33:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1783553636;
	 x=1783640036; bh=fPWk6wF3HjAM4BheBisQCDSfzfMKZXsLZC7maNDhJHQ=; b=
	NpkNOdfaB9j1hYzmzVn4hEmLOM8kr2BykXSlAzEUyzzmyd2NHkUkdiJPQkTEGput
	lrlmeP1NDCEmT6DpTg79NLaDl8LRQzVUwjYDtxb3fG4ctBCHPLHcmfMKPxHzl5Ml
	LggThukNltWyAKlVwjICOidw6Txn7lWLmrQqtsGQzZEHr3wXc9qt6WQ9XwT6Bieu
	n09F+v0bzCuwvxQaqkO8tfdaunySe6mNLa1ey1O+De2R6lON8zkU+y8ZT2axGlWY
	2IIyj/Rxy55dQ/79nhUKlcrjKqsAt+/mgUYaslXn6+HlPv3IdnKnnOofT8RpeRS3
	PNwElhk6n8YAh5NeIA7U5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783553636; x=
	1783640036; bh=fPWk6wF3HjAM4BheBisQCDSfzfMKZXsLZC7maNDhJHQ=; b=V
	upyzQZKg+zkYw4NRdJ6zYytBwLvuBGkk7gvZIho/7jUw5EmVrEQxwM71t6hmjFWb
	UjfjMiS1M6xHf80UU3KO5ax27+X/CDD9on0Un9rVTdD2yjn1WvbfPWjDtCmyXdXd
	D8fk1OlcrbNUWT8fIx8cc+AIYnKgxE8QNIYsgykaLhveJcZ3zyUpaT2LsqvnTqZ5
	8yehxd/UYX1LHPGsMC+AIVg+EtOTicHs8E4fvCNwlFz4uy3ezU7SZaMP0dSFcx9P
	PrGbng62ZNEVmjMmtRWbQlH7lEz8oB/fOQlEqgWmg3NG1w112Fc6tpOTdy5sFSKE
	yvLVLzjAu359liFitBDAw==
X-ME-Sender: <xms:ZN5OakfINvr1sWVPTSwhTZmlwjCoUE11oMFWT0i0cBEeRNulsmVP2Q>
    <xme:ZN5OanxNZScMAbsMnJy7nKINqr3D89ycQKPlndaoz3AmMVoP2Bt4cOEUottM4ldLt
    EB1SVOe7rzBN62Guzi_lQZ4I6CJDviHlBdx0lh-oPHLSXsYLdMVvw>
X-ME-Received: <xmr:ZN5Oakz8mQY5Zgdxc3ZwItz88pJVwTcDdJverNf_glZ2NiMY11frUad40lc>
X-ME-Proxy-Cause: dmFkZTFte9WprN0NxcJROcfQFoEYm4B20MOLRP0aieXCyUdPRt+dzeE8Foerkd28PADnVQ
    Q2OHQyexbOYRg0rBSNOhchlTE+r/ewb9pSaPJb36wKXVH9KGO8zOd2ACKSAkP71biec0nW
    AiYi6lJEcJuY92jHX23f2U7Qb1Dg05BGKYh0T/ac7eHxqJqxnMLvbEkhPqn19+QJmg51Bi
    R83/qttr1Zc3Z5ixxRe9NSaWY+LnlyEwiLj4EwFEmOG4Lb+4OmLVuoXmcpjG+fAzjJwsof
    el3RyOoiWDxEYOLUI/eLpV38WJAiH7Apu9E5tR2zCkAGUlL+0Ao0YBSWPfngxFwsSk3Udk
    wznebDOZnGU/gW/YjUQjzqgSkdYolFw7rpPDsUbdUk/4Am+6Ai7RNhvJ++Uy39W8CubjZ/
    tr81kV0XnVpEaWPUp3rBnYaoJq1CjQpjP9SgiwdvDws3JvGhBDQxwNri0CnZYYCrVrCJ+z
    pP7C9m2OzCWNZekdhXStq4NlCboAHDOOHVk28Y2UGE1ZoxsLolL63C3dOakneA0QEQxhoP
    cH4dSEc9YNWVthTI3oTvZ3kppPZQg5suKY9FK4v4c6sF7zP3PwQb5fmuyPV1hpRQddIRz4
    FQYdFCJPwLSd6jYXUMn/jQbD1eETlsrNyQAIx55+fX1upQeGrfREkbDyhUjQ
X-ME-Proxy: <xmx:ZN5OagaGS9HwrCIvJBc4yqIZT9Uq1kSIlhesP4ElWvjIdrPUNoRmWA>
    <xmx:ZN5Oal2CsoLm-5cpTfrU7o05wBq0iyacz3iU--4FJsatcntV3wjzOA>
    <xmx:ZN5OaieORy2n7pGyhND7v9_yvZeZqrbPmCE1GRCiWA5zAuXgeUe1hg>
    <xmx:ZN5OaiKyEuxK1yospzWXQTLYgJbacKejE8pb0iaLoziR_NGrrxZbeQ>
    <xmx:ZN5OaggEwRytMnkxm6hHLvw4oETcYjka-zLbCezIn5HusS8zBT1be-FC>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 19:33:55 -0400 (EDT)
Date: Wed, 8 Jul 2026 17:31:06 -0600
From: Alex Williamson <alex@shazbot.org>
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: <jgg@ziepe.ca>, <helgaas@kernel.org>, <wathsala.vithanage@arm.com>,
 <wei.huang2@amd.com>, <zhipingz@meta.com>, <wangzhou1@hisilicon.com>,
 <wangyushan12@huawei.com>, <liuyonglong@huawei.com>, <kvm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, alex@shazbot.org
Subject: Re: [PATCH v19 15/18] vfio/pci: Implement TPH_RESOLVE feature for
 DMABUF and CPU source resolving
Message-ID: <20260708173106.21d26a9a@shazbot.org>
In-Reply-To: <20260702124224.57168-16-fengchengwen@huawei.com>
References: <20260702124224.57168-1-fengchengwen@huawei.com>
	<20260702124224.57168-16-fengchengwen@huawei.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 2 Jul 2026 20:42:21 +0800
Chengwen Feng <fengchengwen@huawei.com> wrote:

> Add vfio_pci_core_feature_tph_resolve() to implement the
> VFIO_DEVICE_FEATURE_TPH_RESOLVE GET-only uAPI.
> 
> Resolve PH/ST values from two supported sources:
> - DMABUF fd: retrieve stored TPH metadata via dmabuf helper
> - CPU ID: fetch ST tag from platform via PCIe TPH core helper
> 
> Gate supported source types dynamically according to the tph_policy level:
> No-ST/IV modes only permit DMABUF resolution, while DS+ modes additionally
> allow CPU volatile/persistent sources.

RESOLVE is not an oracle, it's not only the sources that can be
resolved, but whether the user has a means to use the value.  RESOLVE
should not return a LITERAL unless the device supports DS mode or
supports IV mode AND we're in POLICY_LITERAL.  Thanks,

Alex

 
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c | 75 ++++++++++++++++++++++++++++++++
>  1 file changed, 75 insertions(+)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 14944d3ea86e..ed6bbffa8b26 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -1641,6 +1641,78 @@ static int vfio_pci_core_feature_tph(struct vfio_pci_core_device *vdev,
>  	return copy_to_user(arg, &tph, sizeof(tph)) ? -EFAULT : 0;
>  }
>  
> +static int vfio_pci_core_feature_tph_resolve(struct vfio_pci_core_device *vdev,
> +			u32 flags,
> +			struct vfio_device_feature_tph_resolve __user *arg,
> +			size_t argsz)
> +{
> +	const u32 permit_src_mask[] = {
> +		[VFIO_PCI_TPH_POLICY_NO_ST] = VFIO_DEVICE_TPH_SRC_DMABUF,
> +		[VFIO_PCI_TPH_POLICY_IV_ST] = VFIO_DEVICE_TPH_SRC_DMABUF,
> +		[VFIO_PCI_TPH_POLICY_DS_ST ... VFIO_PCI_TPH_POLICY_LITERAL] =
> +					VFIO_DEVICE_TPH_SRC_DMABUF |
> +					VFIO_DEVICE_TPH_SRC_CPU_VOLATILE |
> +					VFIO_DEVICE_TPH_SRC_CPU_PERSISTENT,
> +	};
> +	u32 permit_flags = permit_src_mask[vdev->tph_policy] |
> +			   VFIO_DEVICE_TPH_EXTENDED;
> +	struct vfio_device_feature_tph_resolve resolve = {0};
> +	enum tph_mem_type mtype;
> +	bool extended;
> +	u32 src_bits;
> +	u16 tag = 0;
> +	u8 ph = 0;
> +	int ret;
> +
> +	if (!vdev->tph_permit)
> +		return -EOPNOTSUPP;
> +
> +	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_GET,
> +				 sizeof(resolve));
> +	if (ret <= 0)
> +		return ret;
> +
> +	if (copy_from_user(&resolve, arg, sizeof(resolve)))
> +		return -EFAULT;
> +
> +	src_bits = resolve.flags & VFIO_DEVICE_TPH_SRC_MASK;
> +	if (!(resolve.flags & permit_flags) || !is_power_of_2(src_bits))
> +		return -EINVAL;
> +	extended = !!(resolve.flags & VFIO_DEVICE_TPH_EXTENDED);
> +	if (extended && !pcie_tph_supported(vdev->pdev, true))
> +		return -EINVAL;
> +
> +	resolve.valid = 0;
> +	resolve.ph = 0;
> +	resolve.st = 0;
> +
> +	if (src_bits & VFIO_DEVICE_TPH_SRC_DMABUF) {
> +		ret = vfio_pci_dma_buf_get_tph_by_fd(resolve.src, extended,
> +						     &tag, &ph);
> +		if (ret)
> +			return ret;
> +		resolve.ph = ph;
> +		resolve.valid = VFIO_DEVICE_TPH_VALID_PH;
> +		if (vdev->tph_policy >= VFIO_PCI_TPH_POLICY_DS_ST) {
> +			resolve.st = tag;
> +			resolve.valid |= VFIO_DEVICE_TPH_VALID_ST;
> +		}
> +		goto out;
> +	}
> +
> +	mtype = (src_bits & VFIO_DEVICE_TPH_SRC_CPU_VOLATILE) ?
> +			TPH_MEM_TYPE_VM : TPH_MEM_TYPE_PM;
> +	ret = pcie_tph_get_cpu_st_explicit(vdev->pdev, mtype, extended,
> +					   resolve.src, &tag);
> +	if (ret)
> +		return ret;
> +	resolve.valid = VFIO_DEVICE_TPH_VALID_ST;
> +	resolve.st = tag;
> +
> +out:
> +	return copy_to_user(arg, &resolve, sizeof(resolve)) ? -EFAULT : 0;
> +}
> +
>  int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
>  				void __user *arg, size_t argsz)
>  {
> @@ -1661,6 +1733,9 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
>  		return vfio_pci_core_feature_dma_buf(vdev, flags, arg, argsz);
>  	case VFIO_DEVICE_FEATURE_TPH:
>  		return vfio_pci_core_feature_tph(vdev, flags, arg, argsz);
> +	case VFIO_DEVICE_FEATURE_TPH_RESOLVE:
> +		return vfio_pci_core_feature_tph_resolve(vdev, flags,
> +							 arg, argsz);
>  	default:
>  		return -ENOTTY;
>  	}

