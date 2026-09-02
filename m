Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099FE3AD50D;
	Wed,  2 Sep 2026 07:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788334881; cv=none; b=GcoRj6/8R3uXFuapL4XNqhVV0lMQibqJ/J31kcwQtLNQ1C+petB6GgsYcRBCbqYj2KwGiEDTyFIrD3KLJiI5n/qXenoVLOwQILk6ZuvIQUjKmDJrCEH3hOeQ/pmTmwTRE7zVCt5w1alXeOwAS/ATgy484Ze0W2Oq2/RbuB7hs6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788334881; c=relaxed/simple;
	bh=E5kHKTOKLT7T+s/RAuuaTzAPfj4kN/zqL5XSC7/Bmcs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E8+CVQzwj0uOdEoVIJlws6YNo2SIiI93a12MVXFu7Y6T9gWoeqPNvWxd7oNEDfgPHz9Wo75IT6rgOD2qZJqDt4ptp7Pt/OHMZFSNGs2//40GeGLKypdvDaQMpndM/mQw/hpOo0H6hGwEzq7o7xBv0QQj+XfmAiavATmGKLS10F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KinyYTj6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KinyYTj6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F64E1F000E9;
	Wed,  2 Sep 2026 07:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788334879;
	bh=eyEYjO/DecUOVaaWHj4Ie2fojpHaj7xRaODDP8ZLkLg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KinyYTj6C7fL5Lxj/DTg935JNWaIhN5yKFmbj5i4DvB0yOPXF3stZkByttGCZ4Tw2
	 dOe6QoF3qXvuUN1uw60IzX87ybR9w/TZMav0YkMnY2jiiJ3xqNFEronnrpudUtPLVA
	 txHYZzIQfBAvi31D1KdNd3uUFW+milHIQ1KOKHrFvU92m3MpwsrogLwThek1l94poY
	 UCV6maQ7VsGIe9xOGRMWQ+ZrfmFoiDklAln7iA7mdSBnuIHQ5l5mc4NiFhv/nHOmBi
	 UZaf4fLBskeJ3FmjYkKYBRXVVdvs+R6qiVIZQcA66bDoOGRU0AdHpHydYuwxRaKFe3
	 YKeh3wN5lZomw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 05/12] cxl: Cache endpoint decoder settings during
 PCI enumeration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260902072804.665639-6-smadhavan@nvidia.com>
References: <20260902072804.665639-1-smadhavan@nvidia.com>
 <20260902072804.665639-6-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 07:41:19 +0000
Message-Id: <20260902074119.8F64E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Mixing goto-based error handling with scope-based cleanup helpers (=
`scoped_guard`) in `__pci_cxl_hdm_init()`.
--

commit 240aef0efe56885a67760e149786f74d4a709d41
Author: Srirangan Madhavan <smadhavan@nvidia.com>

cxl: Cache endpoint decoder settings during PCI enumeration

This commit populates pci_dev->hdm for CXL.mem functions from
pci_bus_add_device(), after final PCI fixups but before driver binding.
It uses the CXL Register Locator BAR Indicator to find the component
register BAR and reject unassigned or disabled memory BAR resources.

> diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
> index e6aa55079c76e..a43a29e086501 100644
> --- a/drivers/cxl/core/resource.c
> +++ b/drivers/cxl/core/resource.c
[ ... ]
> +static int __pci_cxl_hdm_init(struct pci_dev *pdev)
> +{
> +	struct cxl_register_map map =3D { 0 };
> +	struct cxl_hdm_info *info;
> +	int rc;
> +
> +	scoped_guard(rwsem_read, &cxl_rwsem.dpa) {
> +		if (pdev->hdm)
> +			return 0;
> +	}
[ ... ]
> +	info =3D kzalloc_obj(*info, GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	rc =3D cxl_pci_hdm_read_info(pdev, &map, info);
> +	if (rc)
> +		goto out_free_info;
> +
> +	scoped_guard(rwsem_write, &cxl_rwsem.dpa) {
> +		if (!pdev->hdm) {
> +			pdev->hdm =3D info;
> +			info =3D NULL;
> +		} else {
> +			cxl_pci_hdm_info_free(info);
> +		}
> +	}
> +
> +	return 0;
> +
> +out_free_info:
> +	cxl_pci_hdm_info_free(info);
> +	return rc;
> +}

[Severity: Low]
Does this code violate the cleanup API guidelines by mixing goto-based error
handling with scope-based cleanup helpers (scoped_guard) in
__pci_cxl_hdm_init()?

The expectation in include/linux/cleanup.h is that goto and cleanup helpers
are never mixed in the same function. Could this be converted to use
scope-based cleanup for the info allocation as well, to avoid confusing
ownership and maintenance hazards in the future?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902072804.6656=
39-1-smadhavan@nvidia.com?part=3D5
