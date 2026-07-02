Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF6C48B399;
	Thu,  2 Jul 2026 13:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782997455; cv=none; b=MxUjI+RBzj/3+40JOzvKl4si6fwPcxtOSKahwaoGEVCl7/8d1rCxchr8PpoXBgTSFq8kW9TRziWZOekewoyPXW2bSfOjWCmnkBKI2uipsuF13NuTj/M5H3vEJ1SLLo9FjcbDjSQZBxjj3xvtvoQAxXBormXXEhi4z1gEkzfEHiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782997455; c=relaxed/simple;
	bh=Y2qdYSFAQBA+a/wWc7FfQBMvRCjLTckxhMc/EhZoZ60=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rLpeSl/52cPdkg/jArOhz/zoEX33vapkjppUoIWx5ojI0LhbAq6ZfYfmiwaQ03Wv4+anblPMvGSUFYUuoCVyQCN1Q65nSl3G0ppxMWwidClTQyNoT6d0nUWjeedfN/iCnFzYm3HCbmpIF9Gr9VnAGRzPbBq1MNhmysiRA2Asz9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/Ze9kcP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/Ze9kcP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D1781F000E9;
	Thu,  2 Jul 2026 13:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782997453;
	bh=Vj0KV29L1mGkncD603VAx0G4THhnlCLQ23G4S2KS6L8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X/Ze9kcPOmw0LaNg78YyvNc0flw2NlF1mYg7lKuEEbLPfUQyy2sJMVeH+LlnWvGiD
	 X03PYIDCmuyr7S1APt1ZWj1x/1A+jGhFwJ8upffjMPzeCvuquBBkyi5IOuBGr6oJqa
	 5XubWTlh+8pp8j7xmuZJexlVxoCPAanXVT2KTkTxII64/37tkjh4O7digEOjFqwTMM
	 nEeiT0ucgOl2AFr70/stMd92C8OwpHhH4dEmV61kw2jZQ3K6uwk9vFIxf6KFqNMVuJ
	 SD8BUOTjkG1C6zscnhqnXZmPDbe94/ln2/WxlRQb9OUwW6Why9vb/cNsvLqHMXRCN4
	 CHB7qLl4n8C+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 16/18] vfio/pci: Implement TPH_ST feature for batch
 ST table programming
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260702124224.57168-17-fengchengwen@huawei.com>
References: <20260702124224.57168-1-fengchengwen@huawei.com>
 <20260702124224.57168-17-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 13:04:13 +0000
Message-Id: <20260702130413.7D1781F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] TPH policy bypass due to flawed bitwise validation of uAPI flags.
- [High] Error codes during batch programming are overwritten, converting f=
ailures into silent successes.
- [High] The ioctl bypasses the TPH policy restrictions for IV_ST, allowing=
 userspace to program CPU ST tags when forbidden.
- [High] Programming MSI-X TPH entries without ensuring PCI Memory Space En=
able (MSE) is active can cause fatal Machine Check Exceptions (MCE).
- [Medium] Missing strict rejection of undefined/reserved bits in uAPI flag=
s.
- [Medium] Missing dma_resv_lock in vfio_pci_dma_buf_get_tph_by_fd() leads =
to unprotected access to dmabuf state.
--

commit 7b7176f5f74da5cf5059e3ca3ebda10567316f68
Author: Chengwen Feng <fengchengwen@huawei.com>
Subject: vfio/pci: Implement TPH_ST feature for batch ST table programming

This commit adds vfio_pci_core_feature_tph_st() for batch programming
of TPH ST table entries. It introduces helpers for calculating ST table
size and resolving tags. The ioctl iterates over user-provided handles
to look up and write tags while holding the memory lock and keeping the
device in D0.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index ed6bbffa8b26a..7251e251824a8 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -1713,6 +1713,123 @@ static int vfio_pci_core_feature_tph_resolve(stru=
ct vfio_pci_core_device *vdev,
>  	return copy_to_user(arg, &resolve, sizeof(resolve)) ? -EFAULT : 0;
>  }
> =20
[ ... ]
> +static int tph_get_st_tag(struct pci_dev *pdev, u32 src_bits, u32 src_hn=
dl,
> +			  bool extended, u16 *tag)
> +{
> +	int ret =3D 0;
> +	u8 ph;
> +
> +	if (src_bits & VFIO_DEVICE_TPH_SRC_NONE)
> +		*tag =3D 0;
> +	else if (src_bits & VFIO_DEVICE_TPH_SRC_DMABUF)
> +		ret =3D vfio_pci_dma_buf_get_tph_by_fd(src_hndl, extended,
> +						     tag, &ph);

[Severity: Medium]
Does this path safely access the dmabuf state?

Looking at the callee:
vfio_pci_dma_buf_get_tph_by_fd()
   vfio_pci_dma_buf_get_pci_tph(dmabuf, ...)

It appears the dmabuf is accessed without acquiring its reservation
lock (dmabuf->resv). Could this lead to data races when accessing
the TPH metadata if it changes concurrently?

> +	else if (src_bits & VFIO_DEVICE_TPH_SRC_CPU_VOLATILE)
[ ... ]
> +static int vfio_pci_core_feature_tph_st(struct vfio_pci_core_device *vde=
v,
> +				u32 flags,
> +				struct vfio_device_feature_tph_st __user *arg,
> +				size_t argsz)
> +{
> +	u32 permit_flags =3D VFIO_DEVICE_TPH_SRC_MASK | VFIO_DEVICE_TPH_EXTENDE=
D;
> +	struct vfio_device_feature_tph_st tph_st =3D {0};
> +	struct pci_dev *pdev =3D vdev->pdev;
> +	u32 src_bits, st_size;
> +	bool stop_on_zero_st;
> +	u32 *src_hndl =3D NULL;
> +	void __user *uptr;
> +	bool extended;
> +	int ret, i;
> +	u16 tag;
> +
> +	if (!vdev->tph_permit || vdev->tph_policy =3D=3D VFIO_PCI_TPH_POLICY_NO=
_ST)
> +		return -EOPNOTSUPP;
> +
> +	ret =3D vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_SET,
> +				 sizeof(tph_st));
> +	if (ret <=3D 0)
> +		return ret;
> +
> +	if (copy_from_user(&tph_st, arg, sizeof(tph_st)))
> +		return -EFAULT;
> +
> +	src_bits =3D tph_st.flags & VFIO_DEVICE_TPH_SRC_MASK;
> +	if (vdev->tph_policy !=3D VFIO_PCI_TPH_POLICY_LITERAL)
> +		permit_flags &=3D ~VFIO_DEVICE_TPH_SRC_LITERAL;

[Severity: High]
Is this missing a restriction for the VFIO_PCI_TPH_POLICY_IV_ST
policy?

In vfio_pci_core_feature_tph_resolve(), the IV_ST policy strictly
limits allowed sources to VFIO_DEVICE_TPH_SRC_DMABUF. However, here
permit_flags is initialized to VFIO_DEVICE_TPH_SRC_MASK and only
LITERAL is explicitly removed. Could this allow userspace to program
CPU ST tags when the device policy forbids it?

> +	if (!(tph_st.flags & permit_flags) || !is_power_of_2(src_bits))
> +		return -EINVAL;

[Severity: High]
Can this bitwise validation be bypassed if a user sets a forbidden
source flag along with a permitted flag?

If VFIO_DEVICE_TPH_EXTENDED is included in permit_flags and
provided in tph_st.flags, the bitwise AND evaluates to non-zero,
satisfying the first condition. If only one forbidden source bit is
set, is_power_of_2() also passes, completely bypassing the policy
restrictions.

(Note: This same validation pattern appears to be present in
vfio_pci_core_feature_tph_resolve() as well).

[Severity: Medium]
Does this logic ignore undefined or reserved bits in tph_st.flags
instead of strictly rejecting them?

If userspace passes uninitialized garbage in the upper bits, the kernel
won't return -EINVAL, potentially breaking forward compatibility for
future extensions.

> +	extended =3D !!(tph_st.flags & VFIO_DEVICE_TPH_EXTENDED);
[ ... ]
> +	for (i =3D 0; i < tph_st.count; i++) {
> +		ret =3D tph_get_st_tag(pdev, src_bits, src_hndl ? src_hndl[i] : 0,
> +				     extended, &tag);
> +		if (ret || (stop_on_zero_st && tag =3D=3D 0))
> +			break;
> +		ret =3D pcie_tph_set_st_entry(pdev, tph_st.start + i, tag);

[Severity: High]
Is it safe to program MSI-X TPH entries without ensuring the PCI
Memory Space Enable (MSE) bit is active?

While this function ensures the device is in the D0 power state,
userspace can dynamically disable PCI_COMMAND_MEMORY. Since
pcie_tph_set_st_entry() performs direct MMIO writes to the BAR,
could executing this unconditionally on a disabled BAR result in an
Unsupported Request (UR) and a fatal Machine Check Exception (MCE)?

> +		if (ret)
> +			break;
> +	}
> +	ret =3D i;

[Severity: High]
Does this unconditional assignment destroy the error code if the
loop breaks early?

If tph_get_st_tag() or pcie_tph_set_st_entry() fails on the very
first iteration, ret will hold a negative error code (like
-EINVAL). When the loop breaks, ret =3D i; overwrites it with 0,
causing the ioctl to silently return success to userspace.

> +
> +out:
> +	up_write(&vdev->memory_lock);
> +	kfree(src_hndl);
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702124224.5716=
8-1-fengchengwen@huawei.com?part=3D16
