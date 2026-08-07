Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8A44756AB
	for <linux-pci@vger.kernel.org>; Fri,  7 Aug 2026 15:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786116414; cv=none; b=ABuowSXovTxrQfbymh9UWpHv7kM6bOyjXl0enORU44wJxF0LyZu1r1l6Ezte+dwIjI7pmfiAeCx+/LWSXpEc7q7r6bjqkBPYrgL3ECYfMZq4OQpvr65W/r55qG/65uUjxbJ+G+7EVRGyLuJ9Eb/YR2D7e5KGJZAjq9ir8e6+qxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786116414; c=relaxed/simple;
	bh=yZkKHiK4Mgh+GC1Fi3tFP328yXtBeBViDtawa98+kzo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TBHZdkHMvdufa/bCL4XVHztB1QTQk8eDkHyDjxvDPv5WbpMV4ENFYycOmmWf7SjQoxiITKF4tdfhivjc1APP4b/YtqKQwbkiDBxD38yoi5HV0p2xJPXwx963iZ1Y8bttFQnCis/+juNpSu6xl/Au6d4ibjEKmTdR9H9tRcBEwEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ODKXERnA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ODKXERnA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D73EA1F00A3A;
	Fri,  7 Aug 2026 15:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786116412;
	bh=tjoL1P0VLWdpJPH2opD9TVkxhURrfC0eqWluaf/3ii4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ODKXERnAHXuJgji0ztzHFg79Vz2vBEN8mNC1NxMVlJoH0CHM7lSgcoyFFoxDoIl2G
	 nww+t3lvo9xSDFJJRhnrm8rrf0b0A70zgaxWcdDMUB/i6Z7Ekt2UQYUOo2OdapH8YP
	 BYex+xFj92fx/3DxnngImOyMuxnPg9Yh9KtrWJ/9qmhm8Cj4Q7zR/oL9h6czQVLacA
	 cKYlYq35bKwRwm/i+KP8LZRCUOdHjIIf3s4HWrs6IgewLyONIvZ11aS4YFeaiA14Oj
	 Kv4WPvsGlYKOb5zga4ciZj5bKgugCacfJovdH709hwAdafwvSVJrlP0/sC+OdO4kMK
	 p/14Yixhb3x1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V5 01/14] i3c: master: Fix recursive locking during
 device registration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, Frank.Li@kernel.org, linux-pci@vger.kernel.org, linux-i3c@lists.infradead.org
In-Reply-To: <20260807145638.168865-2-adrian.hunter@intel.com>
References: <20260807145638.168865-1-adrian.hunter@intel.com>
 <20260807145638.168865-2-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 15:26:51 +0000
Message-Id: <20260807152651.D73EA1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Dropping the bus lock during device_register() allows concurrent D=
ynamic Address Assignment (DAA) to free the underlying I3C device descripto=
r (i3cdev->desc), leading to a Use-After-Free in the uevent callback.

Pre-existing issues:
- [High] Unbalanced fwnode_handle_put in i3c_device_release leads to a refc=
ount underflow of the boardinfo fwnode on device registration failure.
--

--- Patch [1]: [PATCH V5 01/14] i3c: master: Fix recursive locking during d=
evice registration ---
commit 7ad9b7134d768d59739289af1d4be93dc5d74a13
Author: Adrian Hunter <adrian.hunter@intel.com>

i3c: master: Fix recursive locking during device registration
   =20
i3c_master_register_new_i3c_devs() registers newly discovered devices
while holding i3c_bus_normaluse_lock(), leading to a recursive
acquisition of the same rwsem. Fix this by separating device creation
from device registration.

> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index f485b98805cf6..d2fb1a1105218 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c

[ ... ]

> @@ -2104,25 +2113,37 @@ i3c_master_register_new_i3c_devs(struct i3c_maste=
r_controller *master)
>  		if (desc->boardinfo)
>  			device_set_node(&desc->dev->dev, desc->boardinfo->fwnode);
> =20

[Severity: High]
This is a pre-existing issue, but does device_set_node() take a reference to
the fwnode here?

When an i3c boardinfo is added, a reference to the fwnode is acquired.
However, it appears device_set_node() assigns this fwnode without
incrementing the reference count. When the device is freed, the reference is
unconditionally dropped:

drivers/i3c/master.c:i3c_device_release() {
    ...
    fwnode_handle_put(dev->fwnode);
    ...
}

If device_register() fails, put_device() will invoke i3c_device_release()
and drop the fwnode reference. If the device is subsequently rediscovered, a
new device is created with the same fwnode assigned, potentially leading to=
 a
refcount underflow and a use-after-free.

> -		ret =3D device_register(&desc->dev->dev);
> -		if (ret) {
> -			dev_err(&master->dev,
> -				"Failed to add I3C device (err =3D %d)\n", ret);
> -			desc->dev->desc =3D NULL;
> -			put_device(&desc->dev->dev);
> -			desc->dev =3D NULL;
> -		}
> +		list_add_tail(&desc->dev->node, &i3c_unreg_devs);
> +	}
> +
> +	i3c_bus_maintenance_unlock(&master->bus);
> +
> +	list_for_each_entry_safe(i3cdev, tmp, &i3c_unreg_devs, node) {
> +		ret =3D device_register(&i3cdev->dev);

[Severity: High]
Could dropping the bus lock around device_register() allow a concurrent
dynamic address assignment operation to free the i3c device descriptor?

During device_register(), the driver core invokes i3c_device_uevent(), which
accesses the descriptor without taking the bus lock:

drivers/i3c/master.c:i3c_device_uevent() {
    ...
    if (i3cdev->desc)
        devinfo =3D i3cdev->desc->info;
    ...
}

If a concurrent dynamic address assignment operation (like a hot-join)
executes, it takes the bus lock in write mode. If it detects the device as a
duplicate, it replaces the descriptor and frees the old one:

drivers/i3c/master.c:__i3c_master_add_i3c_dev_locked() {
    ...
    newdev->dev->desc =3D newdev;
    ...
    i3c_master_free_i3c_dev(olddev);
    ...
}

If i3c_device_uevent() fetches i3cdev->desc before the swap and dereferences
it after the free, is it possible this leads to a use-after-free?

> +		if (ret)
> +			dev_err(&master->dev, "Failed to add I3C device (err =3D %d)\n", ret);
> +		else
> +			list_del_init(&i3cdev->node);
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807145638.1688=
65-1-adrian.hunter@intel.com?part=3D1
