Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B823651990A;
	Fri,  4 Sep 2026 17:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788543246; cv=none; b=FFDAfSvB+N2MxFOFtjMGM01OrZi8Cfon8Rl+8eEB571DeZINskTpvd8E/rYPGQDrqyRZElktHiPIHisQKNpggGVEQIze9n6Ceb5+BfgRtMk5euEt1JHcLjkd0gEEnsgNGKmu8Jf2vNdykolfvvIMCra2usgQN8kJMxU0QiGpry8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788543246; c=relaxed/simple;
	bh=OEWVL1uSyHhFqcCnvtUazHk8ECQQYNgzl/JSF61fD88=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nbmDXzjEHr3++R0NB2qQ9TxNhwzCe09QIwIm9ui0lAqhP8gV6TBN9Elsx6fgiT5bznn2U4vGh6ZX/KQO+cvKSVA4ss09LcUQRBeUY0HNQf3eyXeMSma8V4Ve56mbmPCJtpE1KJsGvcefbParG0gYXSUJvLc4xzgCI4G9tl5O5qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+NB40mX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+NB40mX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A511F00A3D;
	Fri,  4 Sep 2026 17:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788543244;
	bh=3bzJALN0jIuzMzuUPyULB3E9z0lkByGxoofwt6iRgdo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T+NB40mXWDTikf03fMBDzUEKpM25EKt/sL3pzHWI5u5oq8cKzeC6wcyaIViiY9ntL
	 WabeXd4pOdeq9VnWFCoaBgC55AtVW+cfVdJYn3SGaw51Zu2AjfhEWvoVikFexEKXxT
	 kTBIMrfEOVCOEPMAcPB7AjikBX1wQqs8DDW4LGz5foeM67dbixd8xXLHcrnabp1eqN
	 DvCFYfiiHzZcmY5PnVXnWFRaPKFe1Kx5I0t3sDCbEs0lV8EnLSkNLqtLb0hcsUEx1w
	 Kxfd599XQntp5qvCWgh8YT2mHv7tL65cHjoe2wMGYYQUzFrHZLBCIvmj63l59pnQM/
	 NrbZZXywmd5Pw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/5] PCI/pwrctrl: tc9563: Add GPIO auxiliary device
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lorenzo Bianconi" <lorenzo.bianconi@oss.qualcomm.com>
Cc: conor+dt@kernel.org, linux-pci@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260904-pci-tc9563-aux-v3-3-5b1449d62ba2@oss.qualcomm.com>
References: <20260904-pci-tc9563-aux-v3-0-5b1449d62ba2@oss.qualcomm.com>
 <20260904-pci-tc9563-aux-v3-3-5b1449d62ba2@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 17:34:03 +0000
Message-Id: <20260904173403.B6A511F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The GPIO auxiliary device is unconditionally registered without ru=
ntime PM synchronization with the parent device, exposing unpowered hardwar=
e to I2C accesses.
- [High] Hardcoded auxiliary device ID causes a sysfs naming collision, bre=
aking support for multiple TC9563 controllers.

Pre-existing issues:
- [High] Inversion of teardown order between the I2C adapter reference and =
devm-managed resources.
--

commit 4ceb9152c94ce43b58577ae6c0490e74f1fcf9de
Author: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

PCI/pwrctrl: tc9563: Add GPIO auxiliary device support

The TC9563 embeds a GPIO controller used for per-port reset signals.
Create an auxiliary device for it so the gpio-tc9563 driver can
register the GPIO chip and enable DT-based GPIO lookups.

> diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c b/drivers/pci/pwrct=
rl/pci-pwrctrl-tc9563.c
> index 59ad219c26c02..2230765950b88 100644
> --- a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> +++ b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
[ ... ]
> @@ -393,6 +395,69 @@ static int tc9563_pwrctrl_parse_device_dt(struct dev=
ice_node *node,
[ ... ]
> +static int tc9563_pwrctrl_add_gpio_adev(struct tc9563_pwrctrl *tc9563)
> +{
> +	struct device *dev =3D tc9563->pwrctrl.dev;
> +
> +	if (!of_property_read_bool(dev->of_node, "gpio-controller") ||
> +	    !of_property_present(dev->of_node, "#gpio-cells"))
> +		return 0;
> +
> +	return tc9563_pwrctrl_adev_add(dev, TC9563_GPIO_DEV_NAME, 0,
> +				       dev->of_node, tc9563->regmap);
                                                                  ^
[Severity: High]
Does this hardcoded auxiliary device ID of 0 in
tc9563_pwrctrl_add_gpio_adev() (in drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c)
cause a sysfs naming collision?

If there is more than one TC9563 controller in the system, the first
will probe and register successfully. When the second probes, won't it
attempt to register the same name and fail with -EEXIST?

[Severity: High]
Will unconditionally registering the GPIO auxiliary device here expose
it to accesses while the parent device is suspended?

The PCI subsystem manages the hardware's power state via the pwrctrl
callbacks, powering it off when the PCI endpoint suspends. However, the
GPIO auxiliary device remains registered and active without runtime PM
synchronization.

When userspace or another subsystem accesses a GPIO via sysfs or libgpiod
while the PCI link is suspended, wouldn't the resulting I2C operations
target an unpowered chip?

> +}
> +
[ ... ]
> @@ -596,6 +661,10 @@ static int tc9563_pwrctrl_probe(struct platform_devi=
ce *pdev)
>  	tc9563->pwrctrl.power_on =3D tc9563_pwrctrl_power_on;
>  	tc9563->pwrctrl.power_off =3D tc9563_pwrctrl_power_off;
> =20
> +	ret =3D tc9563_pwrctrl_add_gpio_adev(tc9563);
> +	if (ret)
> +		goto remove_i2c;
> +

[Severity: High]
This is a pre-existing issue, but could dropping the I2C adapter
reference manually here and in tc9563_pwrctrl_remove() create a
use-after-free risk during devm teardown?

The driver acquires the I2C adapter via of_get_i2c_adapter_by_node() in
tc9563_pwrctrl_probe() (in drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c).
In the probe error path (and similarly in tc9563_pwrctrl_remove() during
unbind), i2c_put_adapter() is called manually before the devm teardown
runs.

With this patch adding the auxiliary device via devm, devm will
unregister the GPIO auxiliary device after the adapter reference is
dropped. If the GPIO driver performs any I2C transfers during its
teardown, it will access the I2C adapter after its reference has been
released.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-pci-tc9563=
-aux-v3-0-5b1449d62ba2@oss.qualcomm.com?part=3D3
