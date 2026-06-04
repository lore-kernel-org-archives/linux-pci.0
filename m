Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2117B225403;
	Thu,  4 Jun 2026 13:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780580915; cv=none; b=aOm3zCAfWbxM/TwBKTb21cpjDY+zkxqKJf7A9imu0g21UQ0uNPV68UAqx+p2FbqceQ4vzUrWUBWyjqF2tA3E1VysjxlJnvBhF6uO80ci9Yjmv30xff/TnSEk+liluerkppGcNNOBX6/W74k3QGFUo/Y9wf4uGer9kI3FCwAKscE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780580915; c=relaxed/simple;
	bh=PnEgEQ632XisQvmjfKF0uuXQJ4LYvzbAxOpwWFQMRfg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y+V1nuYgdfJ4wcdSmiJ0g/01Wtc55voE5mg7kDwDdQ2sTOWjCzET7URvR8c0k88nY1Nw8/q/2RQ+94Nt6Ht+YNhEVAWPfxBIaioXEzvCEF9trYwCBxtWEAD0ApjHG057BiV3kdAByb1oYjT7JoeOmX1rI0vN8Ta+z6valIa9348=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BAaF0Vh0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BAaF0Vh0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 991281F00893;
	Thu,  4 Jun 2026 13:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780580913;
	bh=USNzHh52wuk0OoFgBY2F8TjiIoWulAGqxSoxEgFypQE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BAaF0Vh0tmgNpnXfl2crKqCtmwY4fP7+/19zvPuqg5pv/C+cxlWev/47SIhe31kFL
	 n80toSkuwqfaMr6+RyV1fS7vBdbwgR3CZrZ5cGot3edjIVJSGkgW2hA98kG8tKyn41
	 JErJl1q19EqvVTOvAkd4xGy7nkM1ph6Z5DQmAE/qLCrQlfe5C+yKcqj6ymjHeA1p+b
	 x/M92y1qHKJ8Dm3R2fCTdNSZApq5RcDbQlx3NFQU0jlz+yS62TdBSHQjHNwqx+2bRP
	 gtkiIngI+h8RCEGg1sbRJzaVlSGOk4vwzYDB/pIWTbT2G2P9z5RUx7MTAhq71DI9Eb
	 j9fprYyTeDzsg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 08/12] vfio/pci: Hide TPH capability when TPH is
 unsupported
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260604132804.28678-9-fengchengwen@huawei.com>
References: <20260604132804.28678-9-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 13:48:33 +0000
Message-Id: <20260604134833.991281F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing bounds check on parsed PCIe capability length causes h=
eap buffer overflow.
--

commit 2c400d6c4f255c3b600592b504b9399d3cd59033
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
>  		ret =3D pci_read_config_dword(pdev, epos + PCI_TPH_CAP, &dword);
>  		if (ret)
>  			return pcibios_err_to_errno(ret);

[Severity: Critical]
This is a pre-existing issue, but since we are adding support for another
variable-length capability, can the capability length returned here cause a
heap buffer overflow?

Looking at vfio_ecap_init() in drivers/vfio/pci/vfio_pci_config.c, the
returned length is used in memset() and vfio_fill_vconfig_bytes() without
bounds checking against the size of the config space buffer:

drivers/vfio/pci/vfio_pci_config.c:vfio_ecap_init() {
    ...
    len =3D vfio_ext_cap_len(vdev, ecap, epos);
    ...
    memset(map + epos, ecap, len);
    ret =3D vfio_fill_vconfig_bytes(vdev, epos, len);
    ...
}

If a malicious or compromised PCIe endpoint provides forged values for
capabilities like TPH or VNDR, resulting in a length that makes
epos + len > pdev->cfg_size, would this result in an out-of-bounds write
past the boundaries of the map and vconfig heap buffers?

A similar issue appears to exist for standard capabilities in vfio_cap_init=
()
where length is also not bounds-checked:

drivers/vfio/pci/vfio_pci_config.c:vfio_cap_init() {
    ...
    memset(map + pos, cap, len);
    ret =3D vfio_fill_vconfig_bytes(vdev, pos, len);
    ...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604132804.2867=
8-1-fengchengwen@huawei.com?part=3D8
