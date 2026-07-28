Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C88B376BF2
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 16:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785255577; cv=none; b=hDjK66oTdXj+s9vy8vA4as5b2lhEsTIPc/hEmrRgsbw5gPIGXV1a9hr66A30kw+MypX3apOhafO5iAFOUnCnbvy9QhlnbEoNgDLpRkv2ZUdSFJkM1dIuhBUNmwPVnQLAZwNDWDHdQtwrwsvVqoLltBEYgHx0Jlj7bd7Qia2jRjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785255577; c=relaxed/simple;
	bh=lg5e8qaogR9UM8aFVZmSWy+VfJbmKL0oPMJj5c1nm9Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BeR27txPD3jgxDgiTZPzRTtDTxrpo+4GiQMIkGNT7jHcBfvXOtpTwZz+OXI8JE5gzkNd5n4wSjFZ+3TP78Be3i0Wfs5pbFIbvWOewjOwlBSrF8Lz2LYfkBlq5l/oDTy4jBt86pnL3b3SG8K4DGlw4jgVCC61eSOBUSNauuy8fWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0btHdfk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0btHdfk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C236F1F00A3A;
	Tue, 28 Jul 2026 16:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785255576;
	bh=peruRkkKr+azNeAOQhOqjTEeC5FtrRlabTA5htTlFOA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y0btHdfkjwL0gzq1s0PqOUlY3CsPtTmtOLrqnw40pBVKMez5Da3ejoxhhVOi/YneM
	 OZcFINxFN4zwqGrSmMyVZznJ/MQ7iiiz3FWS1fW8dCZCwEmPLNbDXkN1300v2F9/6Q
	 JbPhVMBJBnQ74ixqAqT9Nor30B3Agc3ehgtokogzqjI/BpkS903Zo870PgRdUPIclS
	 VQNIx9UIvbJ46L6E0tdJuSVdd0zgy0i0citZsEZJSC8UGTyFufRI6ce/rdY1qrXP8E
	 fb85w4TH6HsGur7q7i3nN9ZDEVK2FJwxwUFrWEJSgKBTpmgcntTbUyiatUImQLrEwh
	 ICCovjhC9mQVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V2 1/8] i3c: master: Fix recursive locking during device
 registration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: Frank.Li@kernel.org, linux-pci@vger.kernel.org, linux-i3c@lists.infradead.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260728155308.142713-2-adrian.hunter@intel.com>
References: <20260728155308.142713-1-adrian.hunter@intel.com>
 <20260728155308.142713-2-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 16:19:35 +0000
Message-Id: <20260728161935.C236F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Dropping the bus maintenance lock around device_register() exposes=
 i3c_device_uevent() and driver probe functions to a Use-After-Free if a co=
ncurrent DAA replaces the device.

Pre-existing issues:
- [High] i3c_device_uevent() leaks uninitialized stack memory to userspace =
when i3cdev->desc is NULL.
--

--- Patch [1]: [PATCH V2 1/8] i3c: master: Fix recursive locking during dev=
ice registration ---
commit 33a4dcd6c5626faef95bc7cd02ec4c56c6710c78
Author: Adrian Hunter <adrian.hunter@intel.com>

i3c: master: Fix recursive locking during device registration

This commit separates device creation from registration to fix a recursive
locking issue. It drops the bus maintenance lock around device_register()
to prevent deadlocks when probe callbacks invoke I3C helpers.

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index fd3e79d10c840..874f6e11b296d 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
[ ... ]
> @@ -1999,25 +2008,37 @@ i3c_master_register_new_i3c_devs(struct i3c_maste=
r_controller *master)
>  		if (desc->boardinfo)
>  			desc->dev->dev.of_node =3D desc->boardinfo->of_node;
> =20
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
Does dropping the maintenance lock around device_register() expose
i3c_device_uevent() and driver probes to a use-after-free?

If a concurrent I3C hot-join event or a sysfs write to do_daa occurs while
device_register() is running without the lock,
__i3c_master_add_i3c_dev_locked() could find a duplicate PID:

__i3c_master_add_i3c_dev_locked() {
        olddev =3D i3c_master_search_i3c_dev_duplicate(newdev);
        if (olddev) {
                newdev->dev =3D olddev->dev;
                if (newdev->dev)
                        newdev->dev->desc =3D newdev;
                ...
                i3c_master_detach_i3c_dev(olddev);
                i3c_master_free_i3c_dev(olddev);
        }
}

Meanwhile, device_register() triggers a KOBJ_ADD uevent. i3c_device_uevent()
reads i3cdev->desc locklessly:

i3c_device_uevent() {
        if (i3cdev->desc)
                devinfo =3D i3cdev->desc->info;
}

Could this lead to i3c_device_uevent() or driver probe functions dereferenc=
ing
the old descriptor while it is being freed?

> +		if (ret)
> +			dev_err(&master->dev, "Failed to add I3C device (err =3D %d)\n", ret);
> +		else
> +			list_del_init(&i3cdev->node);
> +	}
> +
> +	i3c_bus_maintenance_lock(&master->bus);
> +
> +	list_for_each_entry_safe(i3cdev, tmp, &i3c_unreg_devs, node) {
> +		list_del(&i3cdev->node);
> +		desc =3D i3cdev->desc;
> +		i3cdev->desc =3D NULL;

[Severity: High]
This is a pre-existing issue, but does setting i3cdev->desc to NULL before
unregistration or cleanup lead to leaking uninitialized stack memory in
i3c_device_uevent()?

When a device is unregistered (or if registration fails and triggers a ueve=
nt),
i3cdev->desc is set to NULL. This bypasses the initialization of devinfo
in i3c_device_uevent():

i3c_device_uevent() {
        struct i3c_device_info devinfo;
        u16 manuf, part, ext;

        if (i3cdev->desc)
                devinfo =3D i3cdev->desc->info;

        manuf =3D I3C_PID_MANUF_ID(devinfo.pid);
        ...
        return add_uevent_var(env, "MODALIAS=3Di3c:dcr%02Xmanuf%04X",
                              devinfo.dcr, manuf);
}

Since devinfo is uninitialized on the stack when desc is NULL, could this
broadcast uninitialized kernel stack data to userspace processes listening
to netlink uevents?

> +		put_device(&i3cdev->dev);
> +		desc->dev =3D NULL;
>  	}
> +
> +	i3c_bus_maintenance_unlock(&master->bus);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728155308.1427=
13-1-adrian.hunter@intel.com?part=3D1
