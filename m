Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF963E6DD4
	for <linux-pci@vger.kernel.org>; Thu, 28 May 2026 13:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779973422; cv=none; b=ShxLDUsI5G5KbpBiuxqLpRFgKR7LHJG9vSrifaCu5oy+BwsAvVfqxRzgFrLaGeQTqCvj5DRn0ps4FN4vJxEF6CVRaQ2yt6LWHW75OHu3NgFTOTJHg0C0dCtbeNFfE7el+8FIKHqe6hQDbsvLeOuCWCj7raP1Gn48YJMG6B3t/1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779973422; c=relaxed/simple;
	bh=iFtmiKupOg4ipnTkiEXKzJ4cF5wuBxfG0/pr1D9pGrY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cfNuNOP8fs05H/ZZBQlHfLQVPHH3YMyFgOlKPLVasmmuMQdNkz/V0sHPxJEBj2bdt9o1kLr6d9m5QDLcJtUuMKM97A18tB5Rcpq8yCXetNYDvaP3BycemG2o8UM0CUfxoImzeLhD1Zc75oustfdBQYH2XOBgnksRjytl6Jp3GYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a1L2pIVw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1L2pIVw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 013001F000E9;
	Thu, 28 May 2026 13:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779973421;
	bh=OPW8AVB7+XhQZ13CYHBbk651XM7nfiS9QIsToE3JXfc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a1L2pIVwowuqf/CZ3KJj0KFLarki5/f26hKw4/Gwpc7rtPK5sIKd+BUVkfBhXaqvy
	 Hy4kIap2kfk0vAIyrOXMUH1suL6eZzMUGeESu1hPmMgA32PlKL2HoE29pi3vPP3DQd
	 JHr0VyTTQAwJEfPP7vE4DuNvRcM4jzSgtdOMyh01bwyIBE0Xta2oF4eNTuZvyIsL6p
	 Ij6nSuMN1i207xGtRwjt/Pa9W/IzTqYavBZB4m8KajFx5k4X0xf4OiyOUxIXuGVyhl
	 YEZvePb+2X7xp95LvzlKKF+oS/KE7awDTZFuwAGsyO6xGkuJ5vx4kbtgfLg4tPyYew
	 wh34vgRpKNWZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 8/9] cxl/memdev: Add cxl_reset sysfs attribute
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260528083154.137979-9-smadhavan@nvidia.com>
References: <20260528083154.137979-9-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 13:03:40 +0000
Message-Id: <20260528130341.013001F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The probe logic incorrectly restricts the 'cxl_reset' attribute to=
 Type 2 CXL devices, completely excluding standard Type 3 memory expanders.
- [High] The reset probe logic searches for the CXL Device DVSEC on the cur=
rent PCI function instead of Function 0, causing the capability probe to er=
roneously fail on multi-function devices.
--

commit 0a3bf8b7cbd748c710f06177b6aba985e72cc401
Author: Srirangan Madhavan <smadhavan@nvidia.com>

cxl/memdev: Add cxl_reset sysfs attribute

This commit exposes the CXL reset functionality via a write-only sysfs
attribute on the CXL memdev device. The attribute is only made visible
when the underlying PCI parent device advertises CXL Reset capability.

> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 486c447e98f3f..09f016544d245 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c

[ ... ]

> @@ -1207,6 +1207,22 @@ static bool cxl_reset_has_cache_or_mem(struct pci_=
dev *pdev)
>  	return cap & (PCI_DVSEC_CXL_CACHE_CAPABLE | PCI_DVSEC_CXL_MEM_CAPABLE);
>  }
> =20
> +static bool cxl_reset_is_type2(struct pci_dev *pdev)
> +{
> +	u16 dvsec, cap;
> +
> +	dvsec =3D pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +					  PCI_DVSEC_CXL_DEVICE);
> +	if (!dvsec)
> +		return false;
> +
> +	if (pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP, &cap))
> +		return false;
> +
> +	return (cap & PCI_DVSEC_CXL_CACHE_CAPABLE) &&
> +	       (cap & PCI_DVSEC_CXL_MEM_CAPABLE);

[Severity: High]
Does this logic unintentionally exclude standard Type 3 memory expanders?

Standard Type 3 devices only advertise the PCI_DVSEC_CXL_MEM_CAPABLE bit.
Because this function requires both the cache and mem bits to be set, it
will fail for Type 3 memdevs, preventing the cxl_reset attribute from
becoming visible.

> +}
> +

[ ... ]

> @@ -1966,3 +1982,87 @@ static int __maybe_unused cxl_do_reset(struct pci_=
dev *pdev, bool mem_clear)

[ ... ]

> +static bool cxl_memdev_probe_reset_capable(struct cxl_memdev *cxlmd)
> +{
> +	struct device *dev =3D cxlmd->dev.parent;
> +	struct pci_dev *pdev, *fn0;
> +	int dvsec;
> +	u16 cap;
> +
> +	if (!dev || !dev_is_pci(dev))
> +		return false;
> +
> +	pdev =3D to_pci_dev(dev);
> +	if (!cxl_reset_is_type2(pdev))
> +		return false;
> +
> +	fn0 =3D cxl_reset_get_fn0(pdev);

[Severity: High]
Can this capability probe erroneously fail on multi-function devices?

The code checks for the CXL Device DVSEC on the current PCI function
(via cxl_reset_is_type2(pdev)) before acquiring the Function 0 pointer.

Since the CXL specification requires the CXL Device DVSEC to be implemented
on Function 0, calling pci_find_dvsec_capability on pdev directly will fail
if the memdev is bound to a function greater than 0.

Could this check be moved to happen after getting fn0?

> +	if (!fn0)
> +		return false;
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528083154.1379=
79-1-smadhavan@nvidia.com?part=3D8
