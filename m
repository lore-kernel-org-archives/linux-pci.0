Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914D637C11C
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 16:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785257842; cv=none; b=bTMLW5dxgu2E2wUPk9lFeldyz0QVRh1uraCKFlDTENU6ZsKdxQTQ4GAGAH4GfjYnaBCjMSu7inJVzpSu8ICDz0WYCia9HUNpnMHeb4Kzu9AvfwIdVA7E/ZCk/hvjOwkw3bcdnuo8wrQOCNds7XtynR0eAT5FsiYYblpPqpRdtKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785257842; c=relaxed/simple;
	bh=NOlsPciF6wd6WiAkWU8JJDNc/+rD3J7yd1IJ11hWfJ0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i+RmiWvAW0EYe7U9foEPLQjAfoV2fdODnMKqJILNHhXjxSjCoquLaOql2sEwVvtQr3iD+XCLoEIMfIr8trBFWGWLf7o6VgdWGNpsS/alPEdATm9jVG1U6MkN8KF+cu2G9cs/mhtU+S/+Kn1ho4HqDWaME8XHMjtWal7zQY6Bz4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G94KgoB/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G94KgoB/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D756D1F000E9;
	Tue, 28 Jul 2026 16:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785257841;
	bh=Qkp7J6Er95BTurBahBm2sbESGUaIO1hI6OuP9BoFuIQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G94KgoB/Z7px88F/BB4J4CIKAN33wHzZ1FgKgsIzmPX+nwfpJBkz2wR79U8cDRvP7
	 h4lEv5msHBIiWTgehkuHTqXgNWCu5agrd/qd8qlrsIazQmYUEdthRM215phmCoh+2C
	 7HyDIE47rp5GYjh1rCC0tR7wiYGA2d42LciTw7dr5hxeVnQNCiZk20fHyQzFAgieSb
	 FhLNjAE15Qk/+RzyVjQld2TLRTuccrsDqN00PmlFTxvg48XNUXhLJWEZ+M1gj10rrR
	 5Buk1o+8ch4aqkxu1kOwF+Qz7mDMxo8kRS71JQVS3El2mC+h+faBWGqrmf3gsnBlmM
	 43r8Sph1PS8Zg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V2 4/8] i3c: master: Add helper to query bus wakeup
 requirements
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: linux-pci@vger.kernel.org, linux-i3c@lists.infradead.org, Frank.Li@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260728155308.142713-5-adrian.hunter@intel.com>
References: <20260728155308.142713-1-adrian.hunter@intel.com>
 <20260728155308.142713-5-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 16:57:20 +0000
Message-Id: <20260728165720.D756D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lockless access to other devices' `ibi` structures in `adi_i3c_mas=
ter_disable_ibi()` leads to Use-After-Free.
--

--- Patch [4]: [PATCH V2 4/8] i3c: master: Add helper to query bus wakeup r=
equirements ---
commit 26d68568db9401a6324a05672a046e8465035dde
Author: Adrian Hunter <adrian.hunter@intel.com>

i3c: master: Add helper to query bus wakeup requirements

Adds i3c_master_any_wakeup_enabled() to iterate over devices on an I3C
bus and report whether any are enabled for system wakeup and have ibi
enabled. Controller drivers can use this helper to determine whether
wakeup support must remain available while the system is suspended.

> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index 9d56ca08569a1..dd49652425b48 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c

[ ... ]

> @@ -2048,6 +2048,36 @@ static void i3c_master_reg_work_fn(struct work_str=
uct *work)
>  	i3c_master_register_new_i3c_devs(master);
>  }
> =20
> +/**
> + * i3c_master_any_wakeup_enabled() - check if any device can wake the sy=
stem
> + * @master: I3C master controller
> + *
> + * Iterate over devices on the bus and return true if any device has
> + * system wakeup enabled and IBI enabled.
> + *
> + * Return: true if any device may wake the system via IBI, false otherwi=
se.
> + */
> +bool i3c_master_any_wakeup_enabled(struct i3c_master_controller *master)
> +{
> +	struct i3c_dev_desc *desc;
> +	bool wakeup =3D false;
> +
> +	i3c_bus_normaluse_lock(&master->bus);
> +	i3c_bus_for_each_i3cdev(&master->bus, desc) {
> +		if (!desc->dev || !device_may_wakeup(&desc->dev->dev))
> +			continue;
> +		guard(mutex)(&desc->ibi_lock);

[Severity: High]
This is a pre-existing issue, but seeing the correct locking here in
i3c_master_any_wakeup_enabled() brings to mind a similar loop in
adi_i3c_master_disable_ibi() in drivers/i3c/master/adi-i3c-master.c.

Does that loop also need to hold the ibi_lock? It currently accesses
i3cdev->ibi of other devices on the bus without holding their respective
ibi_lock:

drivers/i3c/master/adi-i3c-master.c:adi_i3c_master_disable_ibi() {
    ...
    i3c_bus_for_each_i3cdev(&m->bus, i3cdev) {
        if (dev !=3D i3cdev && i3cdev->ibi)
            enabled |=3D i3cdev->ibi->enabled;
    }
    ...
}

Could this lead to a use-after-free if another device's ibi resources are
concurrently freed? For example, if i3c_device_free_ibi() is called for
another device during concurrent unbinds, it takes the same bus read lock
but could free the ibi pointer while this loop is evaluating
i3cdev->ibi->enabled.

> +		if (desc->ibi && desc->ibi->enabled) {
> +			wakeup =3D true;
> +			break;
> +		}
> +	}
> +	i3c_bus_normaluse_unlock(&master->bus);
> +
> +	return wakeup;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728155308.1427=
13-1-adrian.hunter@intel.com?part=3D4
