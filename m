Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514D542376D
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 13:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784209279; cv=none; b=fIX134HOF4sjGizJe1X1Q2d5aQTxH5PDFC39oG7D8ujpjG8WkDE9L/m0bjpDMftRWXbManVAbdjXHkqtd1Owv7T3uUj5NdfXZl1veI6kjKbtXl9DJbK4ln6OGigAdE0z7at+YIpJmrnMxdHTDYrBtYcq3ubgQ6cgR2IdxzZnrYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784209279; c=relaxed/simple;
	bh=O5rlaz5oyqntVstiviRd8nhCExT/svWS/SvDb+klhgk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SC6NAWrq8G/lECmThy2h0gtPyN+QDktSS0oBC5DzA6niQ701odEA7H6nZn0OSy4Hux2lFtfLepDgzo+xKgiiP0q4YhnUfneLRPgThL+JJcluiyrUrwIMaiOifhJd4KUVJ850mY1bN5ml+B+YeDfru1fr9SPG2JvpWu3ZEmQ3A5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fawsuw3N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fawsuw3N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 024EE1F00A3A;
	Thu, 16 Jul 2026 13:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784209278;
	bh=G7Bxd9rlIRcgxh0DmIeBXzrwYAA58E7/nQFA2F04bfg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fawsuw3NBIygpN06GfLMqgIvDX4aAILpsX7tD679P4ihiBoLCqBmz1niervFKflq2
	 3E6rTbrjmQGAVYL2CW0OYZGAKtT4oXnk66Pe0e8ay0IiCqw0vK/WyQPsne2aTkji65
	 dIHBwLLsHP0Fc2ZE/+s/0FPL6m9AKXKemlZBhnUrzFjNveyjb1bzDGtxNZLoEzUyrt
	 9xz1F49XRiHAPyrEwGwkhpF2lJPZGIcw8sMShcq97IXzZ3EVIaqdH1ASILdnhSSISV
	 K+nTDc72PeQe6Q/oTyXJi/Fl4bPa0+renP6gVXeFkL4pXM+BBhWYoCd3hFCz59sn22
	 AuNZ7FYsm6q6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/pwrctrl: tc9563: take i2c adapter module reference
Reply-To: sashiko-reviews@lists.linux.dev
To: "Johan Hovold" <johan@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260716132532.1565340-1-johan@kernel.org>
References: <20260716132532.1565340-1-johan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 13:41:16 +0000
Message-Id: <20260716134118.024EE1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing bounds check on `port` index allows out-of-bounds array ac=
cess on malformed device tree.
- [High] Missing device link to I2C adapter leads to Use-After-Free if the =
adapter is unbound.
- [Medium] Unconditional calls to `tc9563_pwrctrl_power_off()` cause regula=
tor usage count underflows.
--

--- Patch [1]: [PATCH] PCI/pwrctrl: tc9563: take i2c adapter module referen=
ce ---
commit ef55bbdfd2a346b4d8f7147c1d7a0c1ab090cb03
Author: Johan Hovold <johan@kernel.org>
Subject: PCI/pwrctrl: tc9563: take i2c adapter module reference

This commit switches to using of_get_i2c_adapter_by_node() to take a module
reference to the I2C adapter. This prevents the I2C subsystem from blocking
uninterruptibly during adapter deregistration when consumers are holding a
reference, allowing module unloads to fail gracefully instead.

> diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c b/drivers/pci/pwrct=
rl/pci-pwrctrl-tc9563.c
> index 488e1ec34a7fb..83ae9f256b69e 100644
> --- a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> +++ b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> @@ -549,7 +549,7 @@ static int tc9563_pwrctrl_probe(struct platform_devic=
e *pdev)
>  		return dev_err_probe(dev, ret, "Failed to read i2c-parent property\n");
> =20
>  	i2c_node =3D of_parse_phandle(dev->of_node, "i2c-parent", 0);
> -	tc9563->adapter =3D of_find_i2c_adapter_by_node(i2c_node);
> +	tc9563->adapter =3D of_get_i2c_adapter_by_node(i2c_node);
>  	of_node_put(i2c_node);
>  	if (!tc9563->adapter)
>  		return dev_err_probe(dev, -EPROBE_DEFER, "Failed to find I2C adapter\n=
");
> @@ -557,7 +557,7 @@ static int tc9563_pwrctrl_probe(struct platform_devic=
e *pdev)
>  	tc9563->client =3D i2c_new_dummy_device(tc9563->adapter, addr);

[Severity: High]
This is a pre-existing issue, but does this code leave the platform device
vulnerable to a use-after-free?

If a privileged user unbinds the I2C adapter via sysfs, the I2C core
unregisters and frees all child clients, including this dummy client. Since
no device link is created (such as with DL_FLAG_AUTOREMOVE_CONSUMER), the
platform device remains bound and unaware, holding a dangling pointer to the
freed client.

Could subsequent operations like device removal or PCI power callbacks
dereference this freed client?

[Severity: High]
This is also a pre-existing issue, but could a malformed device tree cause =
an
out-of-bounds access on the configuration array?

Looking further down in tc9563_pwrctrl_probe(), the port variable is
incremented for each child node without bounds checking:

	for_each_child_of_node_scoped(node, child) {
		port++;
		ret =3D tc9563_pwrctrl_parse_device_dt(tc9563, child, port);
		...
	}

If the device tree provides more child nodes than expected, does the port
variable increment beyond TC9563_MAX?

When passed to tc9563_pwrctrl_parse_device_dt(), this unvalidated index is
directly used to access the statically sized array:

	struct tc9563_pwrctrl_cfg *cfg =3D &tc9563->cfg[port];

Could this lead to memory corruption if the loop exceeds the array bounds?

>  	if (IS_ERR(tc9563->client)) {
>  		dev_err(dev, "Failed to create I2C client\n");
> -		put_device(&tc9563->adapter->dev);
> +		i2c_put_adapter(tc9563->adapter);
>  		return PTR_ERR(tc9563->client);
>  	}

[ ... ]

> @@ -625,7 +625,7 @@ static int tc9563_pwrctrl_probe(struct platform_devic=
e *pdev)
>  	tc9563_pwrctrl_power_off(&tc9563->pwrctrl);

[Severity: Medium]
This is a pre-existing issue, but could this unconditional call to power off
cause a regulator usage count underflow?

Because the regulators are only enabled lazily when the PCI core invokes
the .power_on callback, they may not have been enabled if
devm_pci_pwrctrl_device_set_ready() fails during probe.

>  remove_i2c:
>  	i2c_unregister_device(tc9563->client);
> -	put_device(&tc9563->adapter->dev);
> +	i2c_put_adapter(tc9563->adapter);
>  	return ret;
>  }
> =20
> @@ -637,7 +637,7 @@ static void tc9563_pwrctrl_remove(struct platform_dev=
ice *pdev)
> =20
>  	tc9563_pwrctrl_power_off(&tc9563->pwrctrl);

[Severity: Medium]
Similarly, this is a pre-existing issue, but if the device is removed before
being explicitly powered on by the PCI core, will this unconditional power
off also trigger a regulator usage count underflow during removal?

>  	i2c_unregister_device(tc9563->client);
> -	put_device(&tc9563->adapter->dev);
> +	i2c_put_adapter(tc9563->adapter);
>  }
> =20
>  static const struct of_device_id tc9563_pwrctrl_of_match[] =3D {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716132532.1565=
340-1-johan@kernel.org?part=3D1
