Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038A83E44F0
	for <linux-pci@vger.kernel.org>; Sat, 22 Aug 2026 15:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787412058; cv=none; b=avHAM5SPkgVF9EOJad8Bwz7Aaf00NWGxX4rLSw6VdSRt+8QofyXsDo5EmW8WvRZi1YE6x7ChB9x3gGk3t7+U2Z0tmgeaGeS9jFOyBOC8s1DRDkjJJ81X+j/CXYKTu2p+uEIYLc8zoRfRdvtPcxqraAckq4YCFNGl9xbPOWYOU2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787412058; c=relaxed/simple;
	bh=l86J01pIRURfw5t7/EkGhdj+FNWK+CgqdhCGvKiWq9Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P1aKhB/oBCLOSAaEZFgW1iPASoyxBlzIH1uZ2+rvsxIOWkSmrXC8Mit9M7XD9MoJrheC3LR9RjIghRTCJZK7PSurYRCgGovlQIpBAMDqILkB9b7pmFXhnU52hb0iewEuzuEpTiOQk3UbZAERz07sIq+ZsN9r+ngrjldEEcAwtN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=co5n6Avk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="co5n6Avk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B181F00A3A;
	Sat, 22 Aug 2026 15:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787412056;
	bh=OTZFagiEqHY2fyo59Bse6R+y1K1rQJaFXFHBsfJr1I4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=co5n6AvkDZz/jQHhhkGaZ2/Gp14QpI9ETxrCovGBrZ2Oko2dwB2YD5AREfDmAU+tw
	 r+2xHdQB5GJ1HpJoIoDj4q770uHwiaHAzFtuSvphFqjwEzb08t2p8zWoklNdjNSqej
	 ebMGCtMrCm4B9BROcVmMQQVPT5aaIuvUN+QBrW4+XUmsp/5A5h75N1+HP2ckcs6NlB
	 YIK4RBrApRMHkm+kEkpYcG9B0lsDFfhZhAZoCZwNows4bBqzMUEYQ+Ya4QpLTTwLIX
	 wLUp62bMLwgcskIxNncyMigM5JaG/95JFy6+gl+dLF6yM5SHcscyTsZaD/Kfi/01s0
	 ISBbaKwZnZUFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] PCI: dra7xx: Fix device links leak when
 dra7xx_pcie_enable_phy() fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Felix Gu" <ustc.gu@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260822-dra7xx-v1-3-23e204d5548b@gmail.com>
References: <20260822-dra7xx-v1-0-23e204d5548b@gmail.com>
 <20260822-dra7xx-v1-3-23e204d5548b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 15:20:56 +0000
Message-Id: <20260822152056.69B181F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing `.remove` callback in platform driver leads to memory and =
state leaks on module unload.
- [High] Chained IRQ handler and IRQ domain are not cleaned up on probe fai=
lure, causing memory leaks and a Use-After-Free.
- [Medium] Improper asynchronous runtime PM cleanup in probe error paths le=
aks the active power state.
--

--- Patch [3]: [PATCH 3/3] PCI: dra7xx: Fix device links leak when dra7xx_p=
cie_enable_phy() fails ---
commit 10c75b44424d11b46ba7f7d99b796469558a6366
Author: Felix Gu <ustc.gu@gmail.com>

PCI: dra7xx: Fix device links leak when dra7xx_pcie_enable_phy() fails

When dra7xx_pcie_enable_phy() fails, the code returned immediately and left
the already created device links behind. This commit fixes the issue by
jumping to the err_link cleanup path instead.

> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/contro=
ller/dwc/pci-dra7xx.c
> index bf32b14436f97..5bd9d1df80ad3 100644
> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
> @@ -766,7 +766,7 @@ static int dra7xx_pcie_probe(struct platform_device *=
pdev)
>  	ret =3D dra7xx_pcie_enable_phy(dra7xx);
>  	if (ret) {
>  		dev_err(dev, "failed to enable phy\n");
> -		return ret;
> +		goto err_link;
>  	}
> =20
>  	platform_set_drvdata(pdev, dra7xx);

[Severity: High]
This is a pre-existing issue, but does the lack of a remove callback in the
platform driver lead to memory and state leaks on module unload?

The platform driver definition lacks a remove callback to pair with manual
state allocations in probe:

drivers/pci/controller/dwc/pci-dra7xx.c:
static struct platform_driver dra7xx_pcie_driver =3D {
	.probe =3D dra7xx_pcie_probe,
	...

If the module is unloaded, could all manual allocations and device states
(such as stateless device links, phy power state, and dwc core state) be
leaked since devres ignores manual resource acquisitions?


[Severity: Medium]
This isn't a bug introduced by this patch, but is the asynchronous runtime =
pm
cleanup in probe error paths handled correctly?

If probe fails after successfully calling pm_runtime_get_sync(), the error
path calls pm_runtime_put() followed immediately by pm_runtime_disable():

drivers/pci/controller/dwc/pci-dra7xx.c:dra7xx_pcie_probe() {
    ...
err_get_sync:
	pm_runtime_put(dev);
	pm_runtime_disable(dev);
    ...
}

pm_runtime_put() schedules an asynchronous suspend request, but the immedia=
te
call to pm_runtime_disable() cancels any pending asynchronous requests. Will
this leave the device and its power domains trapped in the resumed state?
Should pm_runtime_put_sync() be used here instead?


[Severity: High]
This is a pre-existing issue, but are the chained irq handler and irq domain
properly cleaned up on probe failure?

dra7xx_pcie_init_irq_domain() installs the chained handler with pp as data:

drivers/pci/controller/dwc/pci-dra7xx.c:dra7xx_pcie_init_irq_domain() {
    ...
	irq_set_chained_handler_and_data(pp->irq, dra7xx_pcie_msi_irq_handler,
					 pp);
    ...
}

If dw_pcie_host_init() subsequently fails:

drivers/pci/controller/dwc/pci-dra7xx.c:dra7xx_add_pcie_port() {
    ...
	ret =3D dw_pcie_host_init(pp);
	if (ret) {
		dev_err(dev, "failed to initialize host\n");
		return ret;
	}
    ...
}

The probe error path jumps to err_gpio, bypassing any cleanup for the
chained handler or irq domain. Devres will then free the pci structure
containing pp. If a hardware interrupt fires after this probe failure, could
this result in a use-after-free when the interrupt executes
dra7xx_pcie_msi_irq_handler with the freed pp pointer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822-dra7xx-v1-=
0-23e204d5548b@gmail.com?part=3D3
