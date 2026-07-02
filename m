Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAB448034D;
	Thu,  2 Jul 2026 13:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782997240; cv=none; b=jqhGCaDEUv1cO15jrIzkPmcys4L8UZf8wm/KzR94t2weKyy5mQPZipAkvpOzkXGNUXojFtXIqWyFc1FTozXoxzBoY4BDVkzyJnfun26CBjqF7D1U5eZLGsdRFeCBfQ7ZXHuAnEoA3Ezbl2co1HSHX8IUDsJjnla79D75SVlsHEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782997240; c=relaxed/simple;
	bh=aax2f6OSqg3u+Hp+1gZSMJ3AtTad8GEEGiJL4rgFypQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J6aGD4CWd1hTrMBz1Tz1b61zxsWOZ9ptqvjD3M5zlsm2YkpKzA3iIMIaJP7e1rceGwgmiUSaRaT37C5i1p2QQ2SCWqtDmYUKNE/enXn5YCcbEdX5oMVCvSaTKw2WnL567lWpE5GsUfi/MtSqfhOEhuQOe+L0pk6dGD/71f5k3X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0/Dz75N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0/Dz75N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87A7B1F000E9;
	Thu,  2 Jul 2026 13:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782997239;
	bh=SgjFs0TO5rEakJEN2AQneEPw2dcJwZBe3ZQJ+nkaP7c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z0/Dz75NurBpgwYSLjdGjOmfnTAoyTfk0bPT7rd8Mle5U+yLT5oSl4EiaFORSMCXE
	 B75UeYPd2Bcl7rwmMexuRPkOA/OdjaMZ28aTjsa6UmNx4wn6xdzFv/3H9AR64AOT0H
	 TsLJpFk37n795EPmtvQbJAla86xgUw2tfizeM9uVbmB3Q1rOPhnXlmF8H9fmSVnfQO
	 MrIhSh3YczNWN7O8+4BsVAq2ALAezmCLiGwnA4mXneZK6TBEmuMwrRAOZ+ZsaDgXkY
	 ekJasgVpz/z9f2vAdOdnTu0N4Ex9GYEAfZTDpC/du4D5TF9qezYdX2Y3z4EqMjEXCs
	 NXNtiJHZka0vg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 09/18] vfio/pci: Hide TPH capability when TPH is
 unsupported
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260702124224.57168-10-fengchengwen@huawei.com>
References: <20260702124224.57168-1-fengchengwen@huawei.com>
 <20260702124224.57168-10-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 13:00:39 +0000
Message-Id: <20260702130039.87A7B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Hiding the TPH capability by returning a length of 0 unintentional=
ly grants the guest raw read/write access to the physical TPH registers.
--

commit 1d6f16c85a6a295f7dee447fc8d7ac56c232977a
Author: Chengwen Feng <fengchengwen@huawei.com>

vfio/pci: Hide TPH capability when TPH is unsupported

Check the device negotiated TPH support status before parsing the TPH
extended capability. Return zero length to hide the capability from
userspace if TPH is disabled during topology negotiation.

> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_p=
ci_config.c
> index a10ed733f0e3a..5c6ab172df6c0 100644
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c
[ ... ]
> @@ -1450,6 +1451,8 @@ static int vfio_ext_cap_len(struct vfio_pci_core_de=
vice *vdev, u16 ecap, u16 epo
>  		byte &=3D PCI_DPA_CAP_SUBSTATE_MASK;
>  		return PCI_DPA_BASE_SIZEOF + byte + 1;
>  	case PCI_EXT_CAP_ID_TPH:
> +		if (!pcie_tph_supported(pdev, false))
> +			return 0;

[Severity: High]
Does hiding the capability by returning 0 here inadvertently grant the guest
raw read/write access to the physical TPH registers?

When a length of 0 is returned in vfio_ext_cap_len(), the VFIO capability
parsing loop skips mapping the capability. This leaves the physical offsets
marked as PCI_CAP_ID_INVALID in vdev->pci_config_map.

Guest accesses to unmapped offsets fall back to unassigned_perms:

static struct perm_bits unassigned_perms =3D {
	.readfn =3D vfio_raw_config_read,
	.writefn =3D vfio_raw_config_write
};

This allows a guest to perform raw writes directly to the physical device
using vfio_raw_config_write(), bypassing VFIO isolation.

Could a malicious guest use this raw access to manually enable TPH and
configure Steering Tags to steer DMA to arbitrary CPU caches?

>  		ret =3D pci_read_config_dword(pdev, epos + PCI_TPH_CAP, &dword);
>  		if (ret)
>  			return pcibios_err_to_errno(ret);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702124224.5716=
8-1-fengchengwen@huawei.com?part=3D9
