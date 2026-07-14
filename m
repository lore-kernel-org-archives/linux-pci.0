Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DF037E2F9;
	Tue, 14 Jul 2026 11:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784027557; cv=none; b=k9qXYls3SlFXzfKDzDXwYB4smqKb51BBDSkob55jAajfUomj4rD7NUceH1pgP7MvdcRklwLnOPyw4P5xjnsBl/iYG4cdpgI+HV/5QaVDE+5jscqLsgVkCa2L6lluUpkjh+sWevOaURHMAk2Eo+d8T/nEOpvIRsWjxgxJTY4TsNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784027557; c=relaxed/simple;
	bh=6VkxV9GwFeCMYWqjO9kausHqtNwuOX5K+1OAk2Likn4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KXsWIczexFsG5YsOOKr9kQavJGS8FJkaEFHn+u9VJl9MkFukitmFKyzr2uHHivrfJmPNTlreE9avlD+DaJ2cryuTmSfL402ytzfel9XO/O2wOgDC6TfFTSIkFm0NxAXW32rVD8G8LUoBVBuSVGGH/Fnf8nDo8nVThd2lVb55U5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ci3VKSo1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ci3VKSo1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D3D11F000E9;
	Tue, 14 Jul 2026 11:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784027555;
	bh=9rFUBpaR0WHHtht/I6OnDsKDXYJXGzHKi76QsUGK7MQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ci3VKSo16WyUuz34mKjmOandY2cWiHwd7qFhsgDKJa/N/sAD4avVMBDRdNKj5Pzc+
	 jd6odI3ZxiWJrMp9irgG+DjbB4pJmM1JL2ZisNLFMWpK95QN1n3E8+N+BNyOFcBTj+
	 ondy5Sdp2l22nMp4D2opeAFPyORW9x4mR1Kaz2Bw1pUcqljID4181bw18pxR/M5sgm
	 iosNKHWFcMYLut3ckmcMi5/99kEF3AWTqZF0TRvZnr5vR3NRuc0A7OBeUeyX01SD3S
	 MPiolaRoi71OfWs4mX74ZAuvE6/JHp6gj5WhfnrqIWXGWHk11kAXwE+g85WBSNAy3Q
	 0AUsDd+eG6PkQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 14/16] vfio/pci: Add DS-ST TPH policy and extend
 TPH_RESOLVE capabilities
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260714104325.54444-15-fengchengwen@huawei.com>
References: <20260714104325.54444-1-fengchengwen@huawei.com>
 <20260714104325.54444-15-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 11:12:34 +0000
Message-Id: <20260714111235.3D3D11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] The newly introduced UAPI capability flag `VFIO_DEVICE_TPH_CAP_R=
ESOLVE_DMABUF_ST` is never exposed to userspace.
- [Medium] DMABUF steering tag resolution returns a steering tag based sole=
ly on policy, ignoring physical device support.

Pre-existing issues:
- [High] Unbalanced lock release in `vfio_pci_get_dmabuf_tph()` due to unco=
nditionally calling `dma_resv_unlock()`.
--

--- Patch [14]: [PATCH v20 14/16] vfio/pci: Add DS-ST TPH policy and extend=
 TPH_RESOLVE capabilities ---
commit e8e0f1c694e6597598ac910df3f902bedd7601ee
Author: Chengwen Feng <fengchengwen@huawei.com>
Subject: vfio/pci: Add DS-ST TPH policy and extend TPH_RESOLVE capabilities

Extends VFIO TPH policy to add DS-ST level 2 policy, relaxing write=20
restrictions and extending TPH_RESOLVE logic. Adds support for CPU
memory sources and DMABUF sources returning both PH and ST under the
DS-ST policy.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index df31f4e8766fa..ae2e0e2252a1e 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c

[ ... ]

> @@ -1622,6 +1640,17 @@ static u32 vfio_pci_get_tph_capability(struct vfio=
_pci_core_device *vdev)
>  		if (pcie_tph_dsm_supported(vdev->pdev))
>  			flags |=3D VFIO_DEVICE_TPH_CAP_ST_CPU;
>  	}
> +	if (vdev->tph_policy >=3D VFIO_PCI_TPH_POLICY_DS_ST &&
> +		(vdev->tph_cap_virt & PCI_TPH_CAP_ST_DS)) {
> +		if (vfio_pci_get_tph_st_size(vdev) > 0) {
> +			flags |=3D VFIO_DEVICE_TPH_CAP_ST_NONE;
> +			flags |=3D VFIO_DEVICE_TPH_CAP_ST_DMABUF;
> +			if (pcie_tph_dsm_supported(vdev->pdev))
> +				flags |=3D VFIO_DEVICE_TPH_CAP_ST_CPU;
> +		}
> +		if (pcie_tph_dsm_supported(vdev->pdev))
> +			flags |=3D VFIO_DEVICE_TPH_CAP_RESOLVE_CPU_ST;
> +	}

[Severity: Medium]
The commit message and headers mention adding the capability
VFIO_DEVICE_TPH_CAP_RESOLVE_DMABUF_ST. Should it be added to the flags
bitmask here alongside VFIO_DEVICE_TPH_CAP_RESOLVE_CPU_ST?=20

If it's left out, userspace might not be able to discover that the feature
is actually supported.

> =20
>  	return flags;
>  }

[ ... ]

> @@ -1751,6 +1784,7 @@ static int vfio_pci_core_feature_tph_resolve(struct=
 vfio_pci_core_device *vdev,
> =20
>  	resolve.valid =3D 0;
>  	resolve.ph =3D 0;
> +	resolve.st =3D 0;
> =20
>  	if (user_flags & VFIO_DEVICE_TPH_SRC_DMABUF) {
>  		ret =3D vfio_pci_get_dmabuf_tph(resolve.src, extended,

[Severity: High]
This isn't a bug introduced by this patch, but looking at
vfio_pci_get_dmabuf_tph() which is called here:

vfio_pci_get_dmabuf_tph() {
        ret =3D dma_resv_lock_interruptible(dmabuf->resv, NULL);
        if (ret =3D=3D 0)
                ret =3D dma_buf_get_pci_tph(dmabuf, extended, st, ph);
        dma_resv_unlock(dmabuf->resv);
        ...
}

If dma_resv_lock_interruptible() fails (for example, if it's interrupted
by a signal and returns -EINTR), will the unconditional call to
dma_resv_unlock() corrupt the underlying ww_mutex state?

> @@ -1759,8 +1793,21 @@ static int vfio_pci_core_feature_tph_resolve(struc=
t vfio_pci_core_device *vdev,
>  			return ret;
>  		resolve.ph =3D ph;
>  		resolve.valid =3D VFIO_DEVICE_TPH_VALID_PH;
> +		if (vdev->tph_policy >=3D VFIO_PCI_TPH_POLICY_DS_ST) {
> +			resolve.st =3D tag;
> +			resolve.valid |=3D VFIO_DEVICE_TPH_VALID_ST;
> +		}
> +		goto out;
>  	}

[Severity: Medium]
Does this evaluation need to also check if the physical device supports the
DS-ST mode?

If the global module policy allows DS-ST but the device lacks the underlying
capability (vdev->tph_cap_virt & PCI_TPH_CAP_ST_DS), it seems this could
still return a valid steering tag to userspace for a tag it cannot actually
program.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714104325.5444=
4-1-fengchengwen@huawei.com?part=3D14
