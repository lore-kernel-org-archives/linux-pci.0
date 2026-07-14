Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F73936A02F;
	Tue, 14 Jul 2026 11:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784027242; cv=none; b=aEUXVm2UIdurvOQW+gmmnVhV7FXCeecGOKB26XCxpfIrfoGCExUvajX8w/6/e6fPySZA4Ww+jHxHJQVzvJMozuDQGDC6RgxapQ3ulCCZK2PTvxIrCItezfQf81DtLUbnnuCBhAiG1LgVhR1t5VHgV/IH/iOV2PtaXpij3pW2bAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784027242; c=relaxed/simple;
	bh=Bkhd5hYJ2rlPBkP1eNtLR24wCwKi27eFdQOmhc71M8c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZmUcRrDVtjD+WGGl/zUlb7uTWhUTx3DdmqQyICzh0kPNf+hnID7PNRrP/OEkc5sLZjv5lXg5eerEhEXRhURoOEPioeKM/0cxqtJgV1fFn3Z1JJ35bToBDXGVacbVjaw9YYCFq7l8jjiRXpiRyRP0Ut+mZJ4gTCCT1y3IbisiX7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUv+E5pR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUv+E5pR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85261F000E9;
	Tue, 14 Jul 2026 11:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784027241;
	bh=V19QlAkowsVItiqm9ZPr6JVQbhOE86XS6KP9UxwiigM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oUv+E5pRlNgKzKdUzFwxzkYNYTdKJ3ZgS+Yd3ZWUFIMVneSflvuxqspLniBJ7xeGO
	 hGPLF5p/ucfo4v4AGZEvHpxO/sW/cw9W5loiNR56ODoQfigtAD6rMiW1eAuZNR42/R
	 UeKvlU0duwlx/BwMla4k1+WrteoE9KdVgPzH60R2ejKrBDZ95RS3JNAfFqP6iIaIsh
	 YPgva1fTdHetRTVnJn2vHZ6R4bE2ymXBAGFPCWqN6QI++pc/uhXvlYGXyNk9sYg66D
	 /go8Lh1sKlms44y6Sw9ti+cvTVMTwQvd2RK4jKEtlutN2oxawAqAHYXLpw1ke/JGL2
	 yf5DIO2+cxPPQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 09/16] PCI/TPH: Add macros to check standard and
 extended TPH support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260714104325.54444-10-fengchengwen@huawei.com>
References: <20260714104325.54444-1-fengchengwen@huawei.com>
 <20260714104325.54444-10-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 11:07:20 +0000
Message-Id: <20260714110720.E85261F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The macro `pcie_std_tph_supported()` erroneously returns true if=
 `tph_max_type` is set to the reserved TPH requester type value 2.
- [Low] The helper macros `pcie_std_tph_supported` and `pcie_ext_tph_suppor=
ted` are implemented as macros rather than static inline functions, causing=
 the !CONFIG_PCIE_TPH stubs to silently drop the pdev argument.
--

--- Patch [9]: [PATCH v20 09/16] PCI/TPH: Add macros to check standard and =
extended TPH support ---
commit 62018f833ad520cae3d9509aa5138e780c6df62a
Author: Chengwen Feng <fengchengwen@huawei.com>

PCI/TPH: Add macros to check standard and extended TPH support

This commit adds helper macros pcie_std_tph_supported() and
pcie_ext_tph_supported() for checking TPH capabilities. It relies on the
cached tph_max_type value and provides stub definitions for when
CONFIG_PCIE_TPH is disabled.

> diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
> index 6901f6e2f8c7a..04b521b7c2c7c 100644
> --- a/include/linux/pci-tph.h
> +++ b/include/linux/pci-tph.h

[ ... ]

> @@ -23,6 +23,18 @@ enum tph_mem_type {
>  };
> =20
>  #ifdef CONFIG_PCIE_TPH
> +/**
> + * pcie_std_tph_supported - check standard TPH requester support
> + * @pdev: PCI device
> + */
> +#define pcie_std_tph_supported(pdev) \
> +	((pdev)->tph_max_type >=3D PCI_TPH_REQ_TPH_ONLY)

[Severity: Medium]
Will this macro falsely return true if the hardware advertises the reserved
value 2?=20

If a PCIe Root Port incorrectly advertises the reserved value 10b (2) for i=
ts
TPH Completer Supported field, pci_tph_init() caches 2 into pdev->tph_max_t=
ype.
Since 2 >=3D PCI_TPH_REQ_TPH_ONLY (which is 1), this evaluates to true. How=
ever,
core functions like pcie_enable_tph_ext() explicitly reject req_type =3D=3D=
 2 with
-EINVAL.

> +/**
> + * pcie_ext_tph_supported - check extended TPH requester support
> + * @pdev: PCI device
> + */
> +#define pcie_ext_tph_supported(pdev) \
> +	((pdev)->tph_max_type =3D=3D PCI_TPH_REQ_EXT_TPH)

[ ... ]

> @@ -37,6 +49,8 @@ u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev);
>  u8 pcie_tph_enabled_req_type(struct pci_dev *pdev);
>  u8 pcie_tph_completer_type(struct pci_dev *pdev);
>  #else
> +#define pcie_std_tph_supported(pdev) false
> +#define pcie_ext_tph_supported(pdev) false

[Severity: Low]
Could these stub macros cause unused variable build warnings when
CONFIG_PCIE_TPH is disabled, since they silently drop the pdev argument?

Would it be better to implement these as static inline functions to guarant=
ee
consistent type checking and evaluation semantics across all configurations?

>  static inline int pcie_tph_set_st_entry(struct pci_dev *pdev,
>  					unsigned int index, u16 tag)
>  { return -EINVAL; }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714104325.5444=
4-1-fengchengwen@huawei.com?part=3D9
