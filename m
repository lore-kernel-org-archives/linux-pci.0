Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3D74BC001;
	Tue,  4 Aug 2026 19:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785873592; cv=none; b=DQ8Hn1OZsUN00Y0uk3Tem+Jn61GSX0dh5O1/RSUepR/0z6aS99L0GzRu114Tso6ZOyGa4nFS5vjILN1UgbVRSQvB5yIigozIfh7ALkhJJMm9cumT5tDvCmnuD4j0qSnHqtBB19UBKuQL8d0l+5gQvOghT/FHjO++d5HL8D4pO0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785873592; c=relaxed/simple;
	bh=kAcLG07OvZRp1iCxt+6RcMROQaTZug33aGgdbvq81Ro=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kjaZO+fNQslKuKcD1uQjM6SgFc35dMiuPjooim7dPmPn+5fIBcbxXb9nGn6hYP6lQjO38Jrn7C5gvd4ulx6BgW38vfBxY/ITCUlg9LLfo2/MTVjFGmuPAB/dOejSelxfEDw17rYKX/4s3lgX/suKL6kRQey4+i85NZsMsJ2AV6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEqSW24Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEqSW24Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B5E1F00A3A;
	Tue,  4 Aug 2026 19:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785873591;
	bh=RkHJTJ2QZf9oj93grXxeMt8a4/zlOUVSAUpSVYFXD1M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eEqSW24Yuu+OvN0BZAhwDCmck4bfrtbseJrHVIwNLvNUFpKxI3X/rqxXlnQzOQJWY
	 5TjLsPJQpv2YMep4R9S44Iq2b1kUv/dhXEE6TZS+BJ62MKjHEirrRgcJxyMRQAf79l
	 PmQma5iZOQXbpvEVJovOkLOKPr/QCsMUg7r7xmr2ZI++Z/a+5MRfhI4HujRiyjo6rV
	 Dah2t2JIfVNnSHPsBT+UvA47ahx6ENUpSeZjAhvOk6eNpHKefVpXCnIbTj22zf4P89
	 S3weXA0jV97jpirfNiRo8pfgI/K9i71ZL8kYlkOu/XRchvMkjwja+R+2GZQvswAYx5
	 GW0NYdw+i+WGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 12/12] PCI/CXL: Restore HDM state after CXL bus
 reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260804192958.1823952-13-smadhavan@nvidia.com>
References: <20260804192958.1823952-1-smadhavan@nvidia.com>
 <20260804192958.1823952-13-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 19:59:50 +0000
Message-Id: <20260804195951.23B5E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] cxl_bus reset method is bypassed by standard bus reset if SBR is u=
nmasked, silently dropping HDM state.
--

--- Patch [12]: [PATCH v10 12/12] PCI/CXL: Restore HDM state after CXL bus =
reset ---
commit 40f2649e2ecc899dc17ea040e81eb83bfd2d204c
Author: Srirangan Madhavan <smadhavan@nvidia.com>

PCI/CXL: Restore HDM state after CXL bus reset

The commit attempts to restore CXL HDM decoder state after a successful CXL
bus reset while the IOMMU reset block is active. It restores PCI config
state first so BARs are valid before HDM MMIO access. It also adds a check
to reject CXL bus reset for multifunction devices.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index ef25ba5f7fe95..7d1e968a2aa2d 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c

[ ... ]

> @@ -5004,6 +5007,9 @@ static int cxl_reset_bus_function(struct pci_dev *d=
ev, bool probe)
>  		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
>  				      reg);
> =20
> +	if (!rc)
> +		rc =3D cxl_restore_hdm_after_pci_reset(dev);
> +
[Severity: High]
This isn't a bug introduced by this patch, but is there a situation where
cxl_reset_bus_function() is bypassed by the standard bus reset?

Looking at the pci_reset_fn_methods array in drivers/pci/pci.c:

const struct pci_reset_fn_method pci_reset_fn_methods[] =3D {
	...
	{ pci_pm_reset, .name =3D "pm" },
	{ pci_reset_bus_function, .name =3D "bus" },
	{ cxl_reset_bus_function, .name =3D "cxl_bus" },
};

The standard "bus" reset precedes the "cxl_bus" reset.

If a CXL device has its Secondary Bus Reset (SBR) unmasked, will the
standard bus reset probe successfully and handle the reset instead?

If so, does this cause the new cxl_restore_hdm_after_pci_reset() logic to
be silently skipped during a PCI reset (e.g., from VFIO or sysfs)?

Could this result in the CXL HDM decoder state being wiped without getting
restored, potentially breaking CXL memory access and leading to Machine
Check Exceptions?

>  	pci_dev_reset_iommu_done(dev);
>  	return rc;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804192958.1823=
952-1-smadhavan@nvidia.com?part=3D12
