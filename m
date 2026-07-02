Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2906F492195;
	Thu,  2 Jul 2026 13:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782997242; cv=none; b=QH/7t/PS55yiAHLW4swHypQasQxlYCu/ymFxsRWP5rTMiBnFSze0sG/dnKTuMRmdFQF8DqZsyaqMWx+RluiSFeOD2ZrTPrqMihMAeLredS6XEBnajedmPIy5On0ijQ8sMuAHVaBpu5OJBc8Rk5sfyHOKtljmpqACe6w/r0Cjb4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782997242; c=relaxed/simple;
	bh=LR+fDkkVDPjdDk/vKwcR50Ni7Ptoq9A8XG73pnGdz9g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cVffRiAv2zn5rmyUBDqr0PR4zZtSmsc9+V7sp5swaE12rotF3wumXw7waVpIgvUwYd503JtTMxC+R1//j5yHd24BZnhRbxBHivw+H4tCuqXiSzUyAs9pUBBtc/EsGCPEv6a31tzKXhnWAK/+tqgGJJOnLGdsQSUVtZL/p+2otnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6O2l5Vq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6O2l5Vq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBAB51F00A3A;
	Thu,  2 Jul 2026 13:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782997240;
	bh=PT1Gdc3z/wbi0N8om6DKabvbzCUoOAKeBYUxpU3aiQ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n6O2l5VqKzbUoFVw0wuV6dsKx3cE2CEW02kT7Ubds9yOC/YfdkS4mD4SbeIcP3S+E
	 c8KRXTlvm5+d4KhUodcUXQmDyfrH/T0q+GNlUSfTrytEt0+9zkCn46KWgX5+ufzRxq
	 R3cqih18GyHWfKePTRvT71zm4pLtVfYUP/RZHs2myC/FH94FGDgnwn08jZi9xHANzu
	 8kgs/TZS3qU/7RZN1ZabkcHDV4VpspbwNdwJCxyxQ4+0GyiWRekOMLhhUmr1ZVNYjQ
	 ddP6Vc/+lXwW0HYnpAgYI4py8I9duVEUjqCAURZY6zA4VdVSLBvv6Jfb9ka3hkSM6Z
	 /Jaf6PzwhB7/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 15/18] vfio/pci: Implement TPH_RESOLVE feature for
 DMABUF and CPU source resolving
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260702124224.57168-16-fengchengwen@huawei.com>
References: <20260702124224.57168-1-fengchengwen@huawei.com>
 <20260702124224.57168-16-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 13:00:40 +0000
Message-Id: <20260702130040.BBAB51F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Flawed bitwise logic in flag validation allows userspace to bypass=
 TPH policy restrictions and breaks forward UAPI compatibility.

Pre-existing issues:
- [High] Missing reservation lock `dma_resv_lock` before calling `vfio_pci_=
dma_buf_get_pci_tph` leads to a data race and lockdep assertion failure.
- [Medium] The VFIO_DEVICE_FEATURE_TPH SET operation fails to validate that=
 the provided payload flags are zero, breaking forward compatibility.
--

commit 0733cb5339faa744645461c3f2055477418d1f5e
Author: Chengwen Feng <fengchengwen@huawei.com>

vfio/pci: Implement TPH_RESOLVE feature for DMABUF and CPU source resolving

This commit adds vfio_pci_core_feature_tph_resolve() to implement the
VFIO_DEVICE_FEATURE_TPH_RESOLVE GET-only uAPI. It resolves PH/ST values=20
from two supported sources: DMABUF fds and CPU IDs, dynamically gating=20
source types based on the tph_policy level.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index 14944d3ea86e6..ed6bbffa8b26a 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -1641,6 +1641,78 @@ static int vfio_pci_core_feature_tph(struct vfio_p=
ci_core_device *vdev,
>  	return copy_to_user(arg, &tph, sizeof(tph)) ? -EFAULT : 0;
>  }

[Severity: Medium]
This is a pre-existing issue in vfio_pci_core_feature_tph() just above this
new code, but does the SET operation properly validate the user payload?

When VFIO_DEVICE_FEATURE_SET is passed, the function exits early without
reading the user's struct vfio_device_feature_tph payload via=20
copy_from_user():

vfio_pci_core_feature_tph() {
    if (flags & VFIO_DEVICE_FEATURE_SET) {
        vdev->tph_permit =3D 1;
        return 0;
    }
}

Does this silently ignore any non-zero flags in the payload, potentially
breaking UAPI forward compatibility if new flags are added later?

> +static int vfio_pci_core_feature_tph_resolve(struct vfio_pci_core_device=
 *vdev,
> +			u32 flags,
> +			struct vfio_device_feature_tph_resolve __user *arg,
> +			size_t argsz)
> +{

[ ... ]

> +	if (copy_from_user(&resolve, arg, sizeof(resolve)))
> +		return -EFAULT;
> +
> +	src_bits =3D resolve.flags & VFIO_DEVICE_TPH_SRC_MASK;
> +	if (!(resolve.flags & permit_flags) || !is_power_of_2(src_bits))
> +		return -EINVAL;

[Severity: High]
Does this validation logic correctly reject unsupported flags?

Since permit_flags unconditionally includes VFIO_DEVICE_TPH_EXTENDED,
wouldn't any user payload that sets VFIO_DEVICE_TPH_EXTENDED along with
an unpermitted flag bypass this check entirely? The bitwise AND would be
non-zero, making the NOT condition false and bypassing the policy rejection.

Could this be updated to use a strict subset check instead? For example:
    if ((resolve.flags & ~permit_flags) || !is_power_of_2(src_bits))

> +	extended =3D !!(resolve.flags & VFIO_DEVICE_TPH_EXTENDED);
> +	if (extended && !pcie_tph_supported(vdev->pdev, true))
> +		return -EINVAL;
> +
> +	resolve.valid =3D 0;
> +	resolve.ph =3D 0;
> +	resolve.st =3D 0;
> +
> +	if (src_bits & VFIO_DEVICE_TPH_SRC_DMABUF) {
> +		ret =3D vfio_pci_dma_buf_get_tph_by_fd(resolve.src, extended,
> +						     &tag, &ph);

[Severity: High]
This isn't a bug introduced by this patch, but does calling=20
vfio_pci_dma_buf_get_tph_by_fd() here trigger a lockdep splat?

Looking at vfio_pci_dma_buf_get_tph_by_fd() in
drivers/vfio/pci/vfio_pci_dmabuf.c, it delegates directly to
vfio_pci_dma_buf_get_pci_tph() without acquiring the dma_resv_lock:

vfio_pci_dma_buf_get_tph_by_fd() {
    dmabuf =3D dma_buf_get(fd);
    ...
    ret =3D vfio_pci_dma_buf_get_pci_tph(dmabuf, extended, tag, ph);
}

However, vfio_pci_dma_buf_get_pci_tph() expects the reservation lock
to be held, and asserts it:

vfio_pci_dma_buf_get_pci_tph() {
    dma_resv_assert_held(priv->dmabuf->resv);
}

Could this lead to unprotected concurrent reads of the priv struct fields
and a data race if the lock is not taken?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702124224.5716=
8-1-fengchengwen@huawei.com?part=3D15
