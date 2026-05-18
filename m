Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8556A3F5BD9
	for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 13:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779110862; cv=none; b=lnQwEiSSxa2UY/Kchc8cxx/YmRlzE/R+3lGSa1wEfV/tsb8xEUFkuSOPvajkbtI3lga3iUOEagZL6rSx7Vj1zIrGYPZe8eLnO5lKIFZzsXsPVM3fYmFs7t3BbKSXZvnx/lm4jwlgZ84ReodOKGAh+DDTirHWy+RNoDrHBqJBBro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779110862; c=relaxed/simple;
	bh=H156xECZKMyfkA+3Nd3RTpikNosqoW2RefcphARjSrU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k0XBxiFI9hSA895DB6r/6C3h3Vt8FFpComXY5EhqmZ90Arl6sSLimckCqVDYkpy02k9sQn5P36lhD7x6Dhoh9IW1z47XFDtCbZfzQYvVLBqYH382tos/SHIkPvpHPfZSvYLV6IwgC2MPTi4MUP4PqS2WpxrnjRS/hKZe86HKR8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ra/6vALy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ra/6vALy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 107D1C2BCB7;
	Mon, 18 May 2026 13:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779110862;
	bh=H156xECZKMyfkA+3Nd3RTpikNosqoW2RefcphARjSrU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Ra/6vALyIv5Kah9nEZTsmwyydwMTElh9B8Tmrhi9cz74m6Q4ijFBoZWDXQNokHrKo
	 +GVjx7fx+VzSENA1Gi39V8ccUElu/81uKsmk1060dhvCrLmREBxOwO9MReV1uEIYKz
	 kzT4MN+RYDxgIoq4IRoKEGCNEiCl2WTbMkO92N34Hct4DZc9b1ACrtTCLgb9F52BKn
	 MTTmURMw/fTwOK98xvbzbflhBj7rfn8LROpVm1rneW6A8uQuM2mncnhYZJWX/N7izx
	 7lklEPW3hwbC9rRxV2sMjZbG4gytUmPxAbbK0n4vb5/xLcFHekfrfVSGI8HdCSdN1y
	 n9Ojsnnk+zOzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/3] PCI: Add d3cold as general reset method
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jose Ignacio Tornos Martinez" <jtornosm@redhat.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260518124836.460805-2-jtornosm@redhat.com>
References: <20260518124836.460805-2-jtornosm@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 13:27:41 +0000
Message-Id: <20260518132742.107D1C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Missing IOMMU preparation and completion calls in the `pci_d3c=
old_reset` flow.
- [High] Missing wait for device readiness (CRS polling) after transitionin=
g from D3cold back to D0.
- [High] Bypassing device quirks and user constraints (`dev->no_d3cold` and=
 `dev->d3cold_allowed`) for D3cold transitions.
--

commit 6ccb7429bcb1b8c8a16f329c1b8caf009c316653
Author: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Subject: PCI: Add d3cold as general reset method

This commit adds a new PCI reset method using D3cold power cycling for
single-function devices. It utilizes ACPI _PR3 power resources to physically
cut power to the device.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 8f7cfcc000901..839903b596982 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c

[ ... ]

> +static int pci_d3cold_reset(struct pci_dev *dev, bool probe)
> +{
> +	int ret;
> +
> +	if (dev->multifunction)
> +		return -ENOTTY;
> +
> +	if (!pci_pr3_present(dev))
> +		return -ENOTTY;
> +
> +	if (probe)
> +		return 0;

Could this transition devices into D3cold even if they have the state
explicitly disabled via quirks or user constraints?

Should this check dev->no_d3cold and dev->d3cold_allowed before proceeding
with the transition?

> +
> +	if (dev->current_state !=3D PCI_D0)
> +		return -EINVAL;
> +
> +	ret =3D pci_set_power_state(dev, PCI_D3cold);

Does this reset method need to pause IOMMU fault handling and wait for
pending DMA transactions before dropping physical power?

Other reset methods like pci_pm_reset() call pci_dev_reset_iommu_prepare()
before performing the hardware reset. Is similar synchronization required
here to prevent IOMMU faults?

> +	if (ret)
> +		return ret;
> +
> +	return pci_set_power_state(dev, PCI_D0);
> +}

Does the device require time to reinitialize its link and internal state
after returning to PCI_D0?

The generic reset handler will immediately invoke pci_dev_restore() after
this returns. Should this function call pci_dev_wait() to check for
Configuration Request Retry Status (CRS) clearance, similar to how
pci_pm_reset() waits?

Also, if pci_dev_reset_iommu_prepare() is needed earlier in this function,
should pci_dev_reset_iommu_done() be called here before returning?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518124836.4608=
05-1-jtornosm@redhat.com?part=3D1
