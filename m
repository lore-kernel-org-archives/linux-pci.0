Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A103AEF58
	for <linux-pci@vger.kernel.org>; Wed,  6 May 2026 20:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778100064; cv=none; b=P9EvtH46E0iDfgMdeI4sKIUCvTN/2ah3OOFVScTyGlurqarcGjsGBBsjdqKrEvgT7aYaQIEvQxeWkyTLwFo/2Nt10ECcV+UDFXuaMtfqgUyiK48WEmMXaJ4xSNoYqzrvcY12LIGzubWrBCTJHAfn3Q89z+zW/M4i2QPfElp0IO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778100064; c=relaxed/simple;
	bh=fV61oPfk/7QARAgmU2VIDLpMg1tmoZg/ndvn4gR5iWI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qRwjzXCbh+2TJ6MIklshyG6R01yHn5Ge1LH+iZTB+HWFvPRQslkCURe8MxHu7zbho9GAMzXkEIRJN3K420u2UvKiAJp3UJEDGc3l1nPqEKQ5vxj4iu1ZIqRFIBJaJvXLSPv7HjQlKysSnYVqtIl7A7vYf3k7thI6hiD78kkGJZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=on4JK0BN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="on4JK0BN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B359DC2BCB0;
	Wed,  6 May 2026 20:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778100063;
	bh=fV61oPfk/7QARAgmU2VIDLpMg1tmoZg/ndvn4gR5iWI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=on4JK0BN69Zy91ijktDaPpHdrP4P/+1j7oYZncbYQQWZCjQP4O+kfhWyEtn4/7djR
	 cIU/JVKKwbMZBzqW5oU7XYVO7iFSGNPki6j8O7pn5antliWjZdZOWNX4IhKLa/IBg2
	 tNm62/p38ja5/Fm9G+gPEUrZ6CDTSZAKJe0woJMR0of/o3EnMczdoP20xOn6JRlXYL
	 oXoPs693hQp8bX0xufQ7EsjBwWPtLwFAQQP2jLeHqP3X2IMowgawAjV5wXqW5WOTot
	 D8FDDbr56+1hOEgJSWhnRfDNEF8VPaUHVoZWiDD0ONjUUVflX0LnTOjajb/QEoyPXX
	 taOFDhkqJwSqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/9] drm/tegra: Explicitly specify PMC instance to use
Reply-To: sashiko@lists.linux.dev
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260506-pmc-v1-3-a6de5da7216b@nvidia.com>
References: <20260506-pmc-v1-3-a6de5da7216b@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2026 20:41:03 +0000
Message-Id: <20260506204103.B359DC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Resource Acquisition Order / Hardware Delay Inefficiency in tegra_d=
c_probe()
--

commit dfa12a000e50667e2028e62a77d85dddde33c3e6
Author: Thierry Reding <treding@nvidia.com>

drm/tegra: Explicitly specify PMC instance to use

Currently the kernel relies on a global variable to reference the PMC
context. Use an explicit lookup for the PMC and pass that to the public
PMC APIs.

> diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
> index 06370b7e0e567..e6099f5aced7a 100644
> --- a/drivers/gpu/drm/tegra/dc.c
> +++ b/drivers/gpu/drm/tegra/dc.c
> @@ -3231,12 +3232,17 @@ static int tegra_dc_probe(struct platform_device =
*pdev)
>  	clk_disable_unprepare(dc->clk);
> =20
>  	if (dc->soc->has_powergate) {
> +		dc->pmc =3D devm_tegra_pmc_get(dc->dev);
> +		if (IS_ERR(dc->pmc))
> +			return dev_err_probe(dc->dev, PTR_ERR(dc->pmc),
> +					     "failed to get PMC\n");
> +

Would it be better to move devm_tegra_pmc_get() earlier in tegra_dc_probe()
before the hardware operations and delays?

Looking at tegra_dc_probe(), this lookup happens after clk_prepare_enable(),
reset_control_assert(), and multiple usleep_range(2000, 4000) delays.

If devm_tegra_pmc_get() returns -EPROBE_DEFER, the probe aborts after execu=
ting
4-8ms of synchronous hardware delays.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260506-pmc-v1-0-a=
6de5da7216b@nvidia.com?part=3D3
