Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C823BA232
	for <linux-pci@vger.kernel.org>; Tue, 25 Aug 2026 11:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787658768; cv=none; b=IsRRYd/A62UsFk9oMV+NNUDud2MnVJS2O6mJND1o6Oo9TGokBKKN8xwoVxfpJXCutVUIklKHTELarPM46nPHLtIEopME5v8/rpFkNRZQvEJIWuAbK3DZCBETQbLzIVIJVZ/FqpkK+BtiMNBj5TbLbjd4lC0A0bPO826C/gk9ZQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787658768; c=relaxed/simple;
	bh=vMxVW38LIPG7KjUFGI3MFP0aDXezY0BKFoXRTyEbJPk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RlUj+79SNWkqLYtVD2NiuKnl+xvH55guN2pBFDpDczauR0KYdk2IEACe1q2UyTtZomm42/7U+Xo3c3I/DLuGfI/MWGNBeUwAc7SE1NahYk7aHRxDh12wN6OJYWJtm+Bnt8dFrINURFwtZONmYBba+ovmgJkEPOK4AyuAh+jkI0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NkkK5wtX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NkkK5wtX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C8691F000E9;
	Tue, 25 Aug 2026 11:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787658766;
	bh=F6h1GVl7t/vhtqG8RZT0fgnKIkLWcGXEBB9sECIQHFk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NkkK5wtXqHVV07SFrmFlZwPx14kw9EPZXhjeR+SbBFmfcfCIIX6k4YzUEdhFl7Wee
	 U1oO7kICpI+R0I+0M+0k2lwa8Bwi9pLM6ffvDcAoRnd6wQARESppQOa69e3CldXSTy
	 aTMMgGRUVtENISMZxAuOJqM7wCIm7EJOr4wURLC6QMkkG7FNjZfNzF8hutddqvVW5z
	 IntPCPRdby1DvqqiymMEnecOGsSzCmDqTuLJW0zr93Lv9LBB5Th1HGV8wF95EVJT4o
	 87YHWpIQWkUd42FRzNuRuyFKFF3HEL5ZoQk+UtNqWV1B0/kL7lTc3ksiZPWwNG6zUl
	 gyPOjcjrE4I5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/pwrctrl: tc9563: Use gpiod_set_value_cansleep() for
 RESX
Reply-To: sashiko-reviews@lists.linux.dev
To: "Abel Vesa" <abel.vesa@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260825-pci-pwrctl-tc9563-use-cansleep-for-resx-v1-1-0dbe7cfd8200@oss.qualcomm.com>
References: <20260825-pci-pwrctl-tc9563-use-cansleep-for-resx-v1-1-0dbe7cfd8200@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 11:52:46 +0000
Message-Id: <20260825115246.8C8691F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] I2C/SPI transfers during the noirq phase of system suspend/resume =
will timeout and fail if the host controller relies on interrupts.
--

--- Patch [1]: [PATCH] PCI/pwrctrl: tc9563: Use gpiod_set_value_cansleep() =
for RESX ---
commit cc5d1431bebcee3e75ac6e1b5150b5971fe40f41
Author: Abel Vesa <abel.vesa@oss.qualcomm.com>

PCI/pwrctrl: tc9563: Use gpiod_set_value_cansleep() for RESX
   =20
This patch changes gpiod_set_value() to gpiod_set_value_cansleep() for the
RESX GPIO in the TC9563 power-on and power-off callbacks. This prevents
warnings when the GPIO is provided by a sleeping controller, such as an I2C
or SPI I/O expander.

> diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c b/drivers/pci/pwrct=
rl/pci-pwrctrl-tc9563.c
> index fd53a7db9875d..1b7718d07d15d 100644
> --- a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> +++ b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> @@ -481,7 +481,7 @@ static int tc9563_pwrctrl_power_off(struct pci_pwrctr=
l *pwrctrl)
>  	struct tc9563_pwrctrl *tc9563 =3D container_of(pwrctrl,
>  					    struct tc9563_pwrctrl, pwrctrl);
> =20
> -	gpiod_set_value(tc9563->reset_gpio, 1);
> +	gpiod_set_value_cansleep(tc9563->reset_gpio, 1);
> =20
>  	regulator_bulk_disable(ARRAY_SIZE(tc9563->supplies), tc9563->supplies);
> =20
> @@ -501,7 +501,7 @@ static int tc9563_pwrctrl_power_on(struct pci_pwrctrl=
 *pwrctrl)
>  	if (ret < 0)
>  		return dev_err_probe(dev, ret, "cannot enable regulators\n");
> =20
> -	gpiod_set_value(tc9563->reset_gpio, 0);
> +	gpiod_set_value_cansleep(tc9563->reset_gpio, 0);

[Severity: High]
This isn't a bug introduced by this patch, but it makes a pre-existing issue
more apparent by acknowledging the GPIO's I2C/SPI dependency.

Will I2C/SPI transfers during the noirq phase of system suspend/resume time=
out
and fail if the host controller relies on interrupts?

During system suspend/resume, the PCIe host controller executes
qcom_pcie_suspend_noirq() or qcom_pcie_resume_noirq(), which eventually call
pci_pwrctrl_power_off_devices() or pci_pwrctrl_power_on_devices(). These
invoke tc9563_pwrctrl_power_off() and tc9563_pwrctrl_power_on().

During the noirq phase, device interrupts are disabled system-wide via
suspend_device_irqs(). Because local CPU interrupts remain enabled,
i2c_in_atomic_xfer_mode() evaluates to false, causing the I2C core to use t=
he
standard interrupt-driven master_xfer() rather than master_xfer_atomic().

Since the I2C controller's device interrupt is disabled, won't the transfer
time out and fail, potentially causing a system freeze or suspend/resume
failure?

This would affect both the sleeping GPIO expander and the I2C bulk writes
performed later in tc9563_pwrctrl_power_on() when calling
tc9563_pwrctrl_disable_port().

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825-pci-pwrctl=
-tc9563-use-cansleep-for-resx-v1-1-0dbe7cfd8200@oss.qualcomm.com?part=3D1
