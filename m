Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF99B38B12E;
	Wed,  8 Jul 2026 23:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783553645; cv=none; b=kj0zocHqfGqeNNdbnLXY6G8xJiIOSGgeXEpmq7u/QuTlvZkl73zHVyRVV48N+DERvVb4wiffthclK8J5NZf8mQOxqY8rTP/zxfyqdjnJ2GDulJxqhv5XiiVD11yj2tkpcPCbg9VFoEp9qlwJyXiW90MYW1U6kUxI8iVSOBEc70E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783553645; c=relaxed/simple;
	bh=onc711SdW//NZsvlHBT8l7zijXHx/3Z2g/FsjH8aSMI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GW5bV/RRCHZM+7mPN/vY1WI723A3TmzNpRawYmcb4nTzMYjyJtMZE12yALWATrQr7V7a+ZspgBvhhTJIoMh2v324rA9AERNnJdyCe9RZLXcUWeXKGy+QwLFju24VO0Ej+vU2Z4fOveitlkD+JQk0/hAyH3xAjSnsXEKQZIhiNEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=JnLzaNQu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rDnigxWC; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="JnLzaNQu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rDnigxWC"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 4FF5DEC007C;
	Wed,  8 Jul 2026 19:34:03 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 08 Jul 2026 19:34:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1783553643;
	 x=1783640043; bh=jMJzTORZJSaB6w8omur7IBiSeqaWM+d9RB8D2w7PxRs=; b=
	JnLzaNQufQiVwQwXlLdfL/tjq5+49FcC8e1GA3DCTWYOi79svXdP72nJluHJKttF
	0jLnfRgcurg+ZQvlBKgGEzXKaQEj84eMFTcDXMF8t1zhMfPwYFxKdSY0n2nPdC+R
	tdkSwXwPEc78JeCzBUrdggNe9+WJF0YPVCuSYe6R/+zF2yqk9rS91MvwFwbeiJ+e
	hakd4aPqMNqvvw5HhfWa77WIRIM0lA+bh3WLxrSewLFUIdeU5iuJe1B65uLXeT6K
	VHgHkBPZZAuRN7ANjHHtdcbJRHd4RKq6bYtmwju/4Z0njt1YhjTag1nqe4YTFI5d
	eq+wdO9YnzlwyuR80D81Og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783553643; x=
	1783640043; bh=jMJzTORZJSaB6w8omur7IBiSeqaWM+d9RB8D2w7PxRs=; b=r
	DnigxWCQssFFWs8PBj0yUlEp8Q602/EYg4iZIbYapg+hJYJSID+nGZOBzsNe10yk
	ziTi0BN+ZmHoIF64ZO1n0PKPkjBVLDno5kTFqj1Xwaq95CzBVmelPreJYtoL7Ger
	9eyC6dcr7D5rlnqvlcZhu5INjX28vFxQgB42H905j931AUH2REX2GoT4w+fSezUG
	XADS30lOKRCNtZacJsjbDocPpDE/U4zcyvHz8Nlntved4On8mMzR8q1WTeaDkPHZ
	oKpdbC63fr/Xq/haDruAaxV3AMtKfZc0xMNy89rRBZjSvp8JBCWVQWifFj/net+g
	W2Cmin7WrqUwcAUI/gYEw==
X-ME-Sender: <xms:a95OagyOCwgawWgmhbRsGzQKGrHpHdWk7id6N6MiAjOfc-HkMKSDJQ>
    <xme:a95Oal2ASFy3FVv47bm46SWIDby8hwXBE8IijJG9cSpt_A-zuWEoFmDpbRzJgI9Rv
    Q6MQXcV6OZ31iLTfZGPEij6iJLwqijtaNN8ZvcPAk51ZkymsO9fvEU>
X-ME-Received: <xmr:a95OahnMeLAP66-9r_XUAg42XVzztnC34rFNVjOizZINo8TQwSSTywsslIc>
X-ME-Proxy-Cause: dmFkZTFte9WprN0NxcJROcfQFoEYm4B20MOLRP0aieXCyUdPRt+dzeE8Foerkd28PADnVQ
    Q2OHQyexbOYRg0rBSNOhchlTE+r/ewb9pSaPJb36wKXVH9KGO8zOd2ACKSAkP71biec0nW
    AiYi6lJEcJuY92jHX23f2U7Qb1Dg05BGKYh0T/ac7eHxqJqxnMLvbEkhPqn19+QJmg51Bi
    R83/qttr1Zc3Z5ixxRe9NSaWY+LnlyEwiLj4EwFEmOG4Lb+4OmLVuoXmcpjG+fAzjJwsof
    el3RyOoiWDxEYOLUI/eLpV38WJAiH7Apu9E5tR2zCkAGUlL+0Ao0YBSWPfngxFwsSk3UL8
    uwSvBzRKaKxw5sMIeJHs1xCJaNRk6YL25I1zikOJpRCfdlNt+7YUacktiob5Q7+R9O2Krf
    aoQuRTFsjZ+CtIOXE58gkwnKISrGZvI+5qYJPgwDMw1DGoEM3WiVxfuRInBOsNJ/PdJfYZ
    kDM5Lz0+xfLhID00VBfbQWghzUT9pFTzQlLB3sVwLldn/mZA4XdefTXzfoqnYusfJxQuRl
    Hae9CsA4abXsH5TP+xVTGLB+DzUAElxL/p4t3QPbrEx3Mc8Tjqlcb5bVW7L7Xxj+nUGSa7
    ZFNWJdb6TG0Xv6KPquddczg65H854OGAfsJHVBes1Jwa2gnaY6CJe921EZ8Q
X-ME-Proxy: <xmx:a95Oak8u2KpxnQcx9MIvvEnC7bZTElkhSiFgbs2TLFyK95ggtKDiSw>
    <xmx:a95OanK_E_R3KilqnFbenNoRkN2HFUcxfDTXE2qYN_MjYJcGdcXzWw>
    <xmx:a95Oahhu61XITjqYNvUzo_pXtbW-87MfquA3ICp1xN3pgLr3jtxeWg>
    <xmx:a95Oar-RN-XWsW8aI70GI8fd_4gRkuJm_-6nvxnUNxlB98xJmnYVjA>
    <xmx:a95Oavluz0I6OhODw7CIq89ZikN4QeV2rRLG7JyqjBBR72op1YWIyuW2>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 19:34:01 -0400 (EDT)
Date: Wed, 8 Jul 2026 17:30:36 -0600
From: Alex Williamson <alex@shazbot.org>
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: <jgg@ziepe.ca>, <helgaas@kernel.org>, <wathsala.vithanage@arm.com>,
 <wei.huang2@amd.com>, <zhipingz@meta.com>, <wangzhou1@hisilicon.com>,
 <wangyushan12@huawei.com>, <liuyonglong@huawei.com>, <kvm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, alex@shazbot.org
Subject: Re: [PATCH v19 14/18] vfio/pci: Implement VFIO_DEVICE_FEATURE_TPH
 and valid TPH config write support
Message-ID: <20260708173036.6be23aae@shazbot.org>
In-Reply-To: <20260702124224.57168-15-fengchengwen@huawei.com>
References: <20260702124224.57168-1-fengchengwen@huawei.com>
	<20260702124224.57168-15-fengchengwen@huawei.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 2 Jul 2026 20:42:20 +0800
Chengwen Feng <fengchengwen@huawei.com> wrote:

> Implement vfio_pci_core_feature_tph() to handle VFIO_DEVICE_FEATURE_TPH:
> - SET permits TPH feature usage for the device;
> - GET reports available TPH capabilities according to tph_policy and
>   root-port DSM support.
> 
> Previously VFIO dropped all writes to the TPH capability register.
> Now implement vfio_tph_config_write() to support legitimate TPH_CTRL
> modification after TPH feature is permitted.
> 
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> ---
>  drivers/vfio/pci/vfio_pci_config.c | 54 ++++++++++++++++++++++++++++++
>  drivers/vfio/pci/vfio_pci_core.c   | 36 ++++++++++++++++++++
>  include/linux/vfio_pci_core.h      |  1 +
>  3 files changed, 91 insertions(+)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
> index 06d7b2fbf866..388dd6fed16b 100644
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c
> @@ -1150,6 +1150,60 @@ static int vfio_tph_config_write(struct vfio_pci_core_device *vdev, int pos,
>  				 int count, struct perm_bits *perm,
>  				 int offset, __le32 val)
>  {
> +	u16 start = vfio_find_cap_start(vdev, pos);
> +	struct pci_dev *pdev = vdev->pdev;
> +	u32 org_ctrl, new_ctrl, cap;
> +	u8 mode, req, org_req;
> +	__le32 org_val = 0;
> +	bool extended;
> +	int ret;
> +
> +	if (!vdev->tph_permit)

We need to work on this variable name, tph_opt_in or something.

> +		return count;
> +
> +	down_write(&vdev->memory_lock);

Why is memory_lock involved in this sequence?  Taking the write lock
doesn't enable memory if it's already disabled, nor do we test the
memory state.

> +
> +	org_ctrl = le32_to_cpu(*(__le32 *)&vdev->vconfig[start + PCI_TPH_CTRL]);
> +	vfio_default_config_read(vdev, pos, count, perm, offset, &org_val);
> +
> +	ret = vfio_default_config_write(vdev, pos, count, perm, offset, val);
> +	if (ret != count)
> +		goto out;
> +
> +	new_ctrl = le32_to_cpu(*(__le32 *)&vdev->vconfig[start + PCI_TPH_CTRL]);
> +	if (new_ctrl == org_ctrl)
> +		goto out; /* Only care about changes in TPH_CTRL. */

We didn't need memory_lock for any of this.

> +
> +	cap = le32_to_cpu(*(__le32 *)&vdev->vconfig[start + PCI_TPH_CAP]);
> +	mode = FIELD_GET(PCI_TPH_CTRL_MODE_SEL_MASK, new_ctrl);
> +	req = FIELD_GET(PCI_TPH_CTRL_REQ_EN_MASK, new_ctrl);
> +	if (mode > PCI_TPH_ST_DS_MODE || !(cap & (1u << mode)) || req == 0x2 ||
> +		(req == PCI_TPH_REQ_EXT_TPH && !(cap & PCI_TPH_CAP_EXT_TPH)))
> +		goto restore; /* Drop invalid or unsupported write value */

Nor did we need memory_lock for this.

> +
> +	org_req = FIELD_GET(PCI_TPH_CTRL_REQ_EN_MASK, org_ctrl);
> +	if (req == org_req)
> +		goto out; /* Only care about requester enable */

What if mode is changed while enabled, don't we create an inconsistent
state?

> +
> +	ret = vfio_pci_set_power_state(vdev, PCI_D0);

We already did a runtime PM resume before calling vfio_pci_config_rw(),
why do we need this?

> +	if (ret)
> +		goto restore; /* Drop this write */
> +
> +	if (req == PCI_TPH_REQ_TPH_ONLY || req == PCI_TPH_REQ_EXT_TPH) {
> +		extended = !!(req == PCI_TPH_REQ_EXT_TPH);
> +		ret = pcie_enable_tph_explicit(pdev, mode, extended);
> +		if (ret)
> +			goto restore;
> +	} else if (req == PCI_TPH_REQ_DISABLE) {
> +		pcie_disable_tph(vdev->pdev);
> +	}

This sequence is really the only thing that appears to need memory_lock
and it should be using vfio_pci_memory_lock_and_enable() along with
vfio_pci_memory_unlock_and_restore().

> +
> +	goto out;
> +
> +restore:
> +	vfio_default_config_write(vdev, pos, count, perm, offset, org_val);
> +out:
> +	up_write(&vdev->memory_lock);
>  	return count;
>  }
>  
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 3f11a9624b9c..14944d3ea86e 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -30,6 +30,7 @@
>  #include <linux/sched/mm.h>
>  #include <linux/iommufd.h>
>  #include <linux/pci-p2pdma.h>
> +#include <linux/pci-tph.h>
>  #include <linux/seq_file.h>
>  #if IS_ENABLED(CONFIG_EEH)
>  #include <asm/eeh.h>
> @@ -610,6 +611,7 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
>  		goto out_disable_device;
>  
>  	vdev->reset_works = !ret;
> +	vdev->tph_permit = false;
>  	pci_save_state(pdev);
>  	vdev->pci_saved_state = pci_store_saved_state(pdev);
>  	if (!vdev->pci_saved_state)
> @@ -1607,6 +1609,38 @@ static int vfio_pci_core_feature_token(struct vfio_pci_core_device *vdev,
>  	return 0;
>  }
>  
> +static int vfio_pci_core_feature_tph(struct vfio_pci_core_device *vdev,
> +				     u32 flags,
> +				     struct vfio_device_feature_tph __user *arg,
> +				     size_t argsz)
> +{
> +	struct vfio_device_feature_tph tph = {0};
> +	int ret;
> +
> +	if (!pcie_tph_supported(vdev->pdev, false))
> +		return -EOPNOTSUPP;
> +
> +	ret = vfio_check_feature(flags, argsz,
> +			VFIO_DEVICE_FEATURE_GET | VFIO_DEVICE_FEATURE_SET,
> +			sizeof(tph));
> +	if (ret <= 0)
> +		return ret;

That's not the convention for testing vfio_check_feature() return.

> +
> +	if (flags & VFIO_DEVICE_FEATURE_SET) {

		if (tph.flags)
			return -EINVAL;

> +		vdev->tph_permit = 1;
> +		return 0;
> +	}
> +

	if (!vdev->tph_permit)
		return -EINVAL;

> +	tph.flags = VFIO_DEVICE_TPH_CAP_DMABUF;
> +	if (vdev->tph_policy != VFIO_PCI_TPH_POLICY_NO_ST &&
> +		pcie_tph_dsm_supported(vdev->pdev))
> +		tph.flags |= VFIO_DEVICE_TPH_CAP_CPU;
> +	if (vdev->tph_policy == VFIO_PCI_TPH_POLICY_LITERAL)
> +		tph.flags |= VFIO_DEVICE_TPH_CAP_LITERAL;

These should also account for the device capabilities, CPU is not
supported unless the device supports somewhere to program CPU values,
ie. IV or DS mode.  Same for LITERAL, not exposed unless the device has
a way to use it, (IV or DS) and POLICY_LITERAL.  Thanks,

Alex

> +
> +	return copy_to_user(arg, &tph, sizeof(tph)) ? -EFAULT : 0;
> +}
> +
>  int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
>  				void __user *arg, size_t argsz)
>  {
> @@ -1625,6 +1659,8 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
>  		return vfio_pci_core_feature_token(vdev, flags, arg, argsz);
>  	case VFIO_DEVICE_FEATURE_DMA_BUF:
>  		return vfio_pci_core_feature_dma_buf(vdev, flags, arg, argsz);
> +	case VFIO_DEVICE_FEATURE_TPH:
> +		return vfio_pci_core_feature_tph(vdev, flags, arg, argsz);
>  	default:
>  		return -ENOTTY;
>  	}
> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
> index a0641286dd90..9a6e82c5c00c 100644
> --- a/include/linux/vfio_pci_core.h
> +++ b/include/linux/vfio_pci_core.h
> @@ -150,6 +150,7 @@ struct vfio_pci_core_device {
>  	struct rw_semaphore	memory_lock;
>  	struct list_head	dmabufs;
>  	u8			tph_policy;
> +	bool			tph_permit;
>  };
>  
>  enum vfio_pci_io_width {

