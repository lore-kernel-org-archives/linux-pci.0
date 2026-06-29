Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E05A311959
	for <linux-pci@vger.kernel.org>; Mon, 29 Jun 2026 09:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782726025; cv=none; b=pKyPMBoz+FuvvzUEdKKfl5tRCG/H/eUgol+0RlMgMKled/R0p54WziDBszGouP5cbGFeIB9if1sY8sflcxJ+RIwKnO10EogJMz6A73sGtYSAeftABj7Ydr944EpuB0164u3zZrpIJeyT/ZsVCC+BtPVKJyRhvvbtEiafo+9/vNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782726025; c=relaxed/simple;
	bh=bN35lL0a85YJhg7hzJSLhY6nr9ck1eOe5oNwJm7kWr0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uDhklUetasWKiU1S0Trcpz4Dr69D2fVgcdOns+AIvExrC7D/WLiTpJHA/wa+AhYeXrgjRoctaLZyGcKE4Vr/s0BzXU4Dd1AXuxhAgMa1IDtBE0vs0sR7q8ZCni452ORcsfWToU+ROUqxOtThS/3rNVBYs0mYeOxxIsg79D+/6Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hT5jTFyN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hT5jTFyN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA291F00A3D;
	Mon, 29 Jun 2026 09:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782726024;
	bh=xZP9U1WPdokQdFlCR8SfrfznYQdetaJYWazX8kLBtYU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hT5jTFyNmKNeUOBpjz+6u84Lry0yMfYIzeaapDOyiZbTiS3Mi9EzjfXR3QJIMAZrJ
	 P7aJHexlCLDJx59bsTEG3C5GQx/r01wcmZ++dbMIX70/ft2fqnhScaDu9V5qJ/pQ6F
	 H32WKXk9penUjX/p4W3Yr2mBMe/A0RA3Rxe6tQXZTSdG8H6lYv+pMIT72nm6fFbY54
	 gf7cefGmwa2eB/hM5e9lljp9PpAxf9658wrjhliGTIW8cz0johHxH3YAe6tcNIKuIK
	 utxi3wMAvqmkbG0WPK3bPtPKz0Y65q0vqRQtgGcRD1y6FmSI3z58PnEE4H4/oC/OBb
	 5o74AwrysTWIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] perf/dwc_pcie: Add support for Picoheart vendor
 devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yicong Yang" <yang.yicong@picoheart.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260629092717.74946-2-yang.yicong@picoheart.com>
References: <20260629092717.74946-1-yang.yicong@picoheart.com>
 <20260629092717.74946-2-yang.yicong@picoheart.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 09:40:23 +0000
Message-Id: <20260629094023.EDA291F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The new Picoheart entry in `dwc_pcie_rasdes_vsec_ids` breaks alphab=
etical sorting.
--

commit 86c4e43dc00cd979fb3b5c10fa079d5650a94f54
Author: Yicong Yang <yang.yicong@picoheart.com>

perf/dwc_pcie: Add support for Picoheart vendor devices

This commit adds PCI_VENDOR_ID_PICOHEART to pci_ids.h and updates the
DWC PCIe vendor table to enable PCIe PMU support for Picoheart devices.

> diff --git a/include/linux/pcie-dwc.h b/include/linux/pcie-dwc.h
> index 8ff778e7aec0e..b0ccb2ad74db7 100644
> --- a/include/linux/pcie-dwc.h
> +++ b/include/linux/pcie-dwc.h

[ ... ]

> @@ -32,6 +32,8 @@ static const struct dwc_pcie_vsec_id dwc_pcie_rasdes_vs=
ec_ids[] =3D {
>  	  .vsec_id =3D 0x02, .vsec_rev =3D 0x4 },
>  	{ .vendor_id =3D PCI_VENDOR_ID_SAMSUNG,
>  	  .vsec_id =3D 0x02, .vsec_rev =3D 0x4 },
> +	{ .vendor_id =3D PCI_VENDOR_ID_PICOHEART,
> +	  .vsec_id =3D 0x02, .vsec_rev =3D 0x4 },

[Severity: Low]
This isn't a bug, but should PCI_VENDOR_ID_PICOHEART be placed between
PCI_VENDOR_ID_AMPERE and PCI_VENDOR_ID_QCOM to maintain the alphabetical
sorting of the existing entries in dwc_pcie_rasdes_vsec_ids[]?

>  	{}
>  };
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629092717.7494=
6-1-yang.yicong@picoheart.com?part=3D1
