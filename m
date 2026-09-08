Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932F45678DF;
	Tue,  8 Sep 2026 15:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788882320; cv=none; b=SXHnwoZPOGakro/mlxM5tK/iGT0pKmcDqHc3zAG9eZ+hNXDvn8oCZ6Zdq901sIJy/bQk+2Vr1vCJkcHGEzxHmY7+nwRPfCu5DDaIzjxvBDWUDsBDTgONhaBZL/W2SPZ/0kb9r1O2Nhd845UmmROciPl5HnRFA1N3bC9L+hGkfT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788882320; c=relaxed/simple;
	bh=s+i2iYjfpf3oGpLXgVneHdLN+v+Ty1O97nm3+NmUEkE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Cvi6I2JCOylD17T6IjWwe+BTVi/Od+SUv99IcyesHiQEiU5tmO/PtyjPPQXm8SxbJHL9sLY9asiZmKLpVA78Qlou/fH8nyYsiVtYUnEdffP5sqy896OVyu/l7UlHc38fw7UbaNtotRBAw92qs7g0BLLz/+53kKBu8sQ7+5KDZo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HCBtx7Yr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCBtx7Yr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C63C1F00A3A;
	Tue,  8 Sep 2026 15:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788882319;
	bh=CbT4+ZbiyNR7MUnQhTHO07gc3z7ywaNPI0+vPQykVQ4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HCBtx7Yry4DZHxcta0hzP+UhpZop2I3Wtlw1sE+1IVC7Rta3/9l0gOPQNVPilFLQ1
	 9ONzlF2Ikl+zxJ2QI7xLsHGaASnWi7A0Z/5o71o1wqlILJhGsDQMPAErSRUvA5PTxp
	 RAO5Y2pRnFS3e6b11EQl1iqk/vuS45uZiiHTL+9Urj6dHgYCvPbOeIWPGz9AsRTzaI
	 qHAYn8q6uPLuLTBHhfpG4UU3PjlrsEkUTwV9bro7m4jn5Kpw0JALsow/r53n5ViCnZ
	 VSm0GdCIm7RufunprRLUpkH8bP3wglAlCt0anbbDCrfMbLQ3vI61F0XRQY5K8BsjYA
	 Fthkn+0Wumznw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/5] PCI/pwrctrl: tc9563: Add GPIO auxiliary device
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lorenzo Bianconi" <lorenzo.bianconi@oss.qualcomm.com>
Cc: robh@kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260908-pci-tc9563-aux-v4-3-c7fc7778292b@oss.qualcomm.com>
References: <20260908-pci-tc9563-aux-v4-0-c7fc7778292b@oss.qualcomm.com>
 <20260908-pci-tc9563-aux-v4-3-c7fc7778292b@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 15:45:17 +0000
Message-Id: <20260908154519.4C63C1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Devm vs manual cleanup ordering bug: Auxiliary device is unregiste=
red via devres after the hardware is manually powered off and the I2C adapt=
er reference is dropped.
--

commit ee51cc5ce17159f5e9569310449014a414a8580e
Author: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

PCI/pwrctrl: tc9563: Add GPIO auxiliary device support
   =20
The commit adds GPIO auxiliary device support to the TC9563 PCI power contr=
ol
driver, allowing a companion GPIO driver to handle per-port reset signals.
It passes the tc9563 regmap to the auxiliary device and uses devres to
manage unregistration.

> diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c b/drivers/pci/pwrct=
rl/pci-pwrctrl-tc9563.c
> index 59ad219c26c02..3fb862105fa58 100644
> --- a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> +++ b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
[ ... ]
> @@ -393,6 +398,77 @@ static int tc9563_pwrctrl_parse_device_dt(struct dev=
ice_node *node,
>  	return 0;
>  }
> =20
> +static void tc9563_pwrctrl_adev_release(struct device *dev)
[ ... ]
> +static int tc9563_pwrctrl_adev_add(struct device *dev, const char *name,
> +				   struct device_node *of_node,
> +				   void *priv_data)
> +{
> +	struct auxiliary_device *adev;
[ ... ]
> +	ret =3D auxiliary_device_add(adev);
> +	if (ret) {
> +		auxiliary_device_uninit(adev);
> +		return ret;
> +	}
> +
> +	return devm_add_action_or_reset(dev, tc9563_pwrctrl_adev_remove, adev);

[Severity: High]
Does registering the auxiliary device unregistration to the devm cleanup ph=
ase
cause a teardown ordering issue?

Because devm actions execute after .remove() returns, tc9563_pwrctrl_remove=
()
will execute first:

static void tc9563_pwrctrl_remove(struct platform_device *pdev)
{
	...
	tc9563_pwrctrl_power_off(&tc9563->pwrctrl);
	i2c_put_adapter(tc9563->adapter);
}

Will this cause the hardware to be manually powered off and the I2C adapter
reference dropped before the child device is unregistered?

Could this lead to I2C transactions on a powered-off device if the GPIO
controller is accessed during the unbind window, and a potential use-after-=
free
if the adapter module is unloaded while the dummy client and regmap are sti=
ll
active?

> +}
[ ... ]
> @@ -596,6 +672,10 @@ static int tc9563_pwrctrl_probe(struct platform_devi=
ce *pdev)
>  	tc9563->pwrctrl.power_on =3D tc9563_pwrctrl_power_on;
>  	tc9563->pwrctrl.power_off =3D tc9563_pwrctrl_power_off;
> =20
> +	ret =3D tc9563_pwrctrl_add_gpio_adev(tc9563);
> +	if (ret)
> +		goto remove_i2c;
> +
>  	ret =3D devm_pci_pwrctrl_device_set_ready(dev, &tc9563->pwrctrl);
>  	if (ret)
>  		goto power_off;
> =20
>  	return 0;
> =20
>  power_off:
>  	tc9563_pwrctrl_power_off(&tc9563->pwrctrl);
>  remove_i2c:
>  	i2c_put_adapter(tc9563->adapter);
>  	return ret;

[Severity: High]
Is the same teardown ordering regression reproduced in this error path?

If devm_pci_pwrctrl_device_set_ready() fails, the code jumps to power_off,
which manually powers off the hardware and drops the I2C adapter reference.
Then probe returns the error, and devres will clean up the auxiliary device
afterward.

Could this create a race window where the child device is fully bound
and accessible to userspace or other subsystems while the underlying hardwa=
re is
already powered off?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-pci-tc9563=
-aux-v4-0-c7fc7778292b@oss.qualcomm.com?part=3D3
