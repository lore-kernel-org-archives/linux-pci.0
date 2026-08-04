Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F277E3921E0
	for <linux-pci@vger.kernel.org>; Tue,  4 Aug 2026 15:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785856273; cv=none; b=SUwt6xFM7x1DxUNyO2kUh66L+kU+wo97tyrOzf5SrMXfCU6ID+29fTJZq7Ph8EGu3DqG1gytskbpF2JQeBs/HlUP9UlMaScHZiWNB2K0P3fw5q+Z3CsH6Il84+DAbXgKAuMJFCH374fhjgu0fm96EgMVp15oLz0eLZT1IZy8Fgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785856273; c=relaxed/simple;
	bh=ZVSoRw0A3XxKjePxP3T6mIHi/kG5JI+mL5D/pTQTNTY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cHIPfHnJfqJKUwDinEabEdS6UhfcAkeYQkO5nVbj0F8/nynzMV6nZh2gjzwkokUpACWxIu5eIwmGE2rQO/Kvkl2DX1FlBgVVUKk29wtfVNqtBFmLeq30Acx32Hx4OkoHb7HZkhbgXLu/Qx+fUhB2QlsuWrmRZ2734F2Gf7AC1pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xcsy5jWh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xcsy5jWh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 333DF1F000E9;
	Tue,  4 Aug 2026 15:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785856267;
	bh=0BfEsiuGtJ1q8aQ1OAIg3K8HEz5qNqgcILIY4mnu/HI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xcsy5jWhPQtKnrt396hoz8FyJfEe13tylAhDvkthxgh1sUZxqvDJG2mAcsfBOD9hT
	 I0BOV4KbGxRBq3HyuA7Nq9isVMO9yuqxfxpUOoB41PBEROHveE7RXmD7hVSPosIWkP
	 VspZzJ8JFHBQiKIhZTQx//58yCVN/ZOR+v5S7TQU9RD0yn0eTAm+cZyB5sj+VS8T0U
	 dBEPLm9YhrOb7lz8BneogJQiNPbQDmMQx9EAv8+SFnx2WPctqz6wVTmfybaA0MnhUu
	 tKRuzwQF3kphCHDHnQccVnyTYvx2z4Dfb9bu4bn7R1GsGXZcLRv9UV8Pwr/VIjw24d
	 hHZ1ouwTmqrbA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 07/14] i3c: master: Fix potential UAF in
 i3c_device_match()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: linux-pci@vger.kernel.org, Frank.Li@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-i3c@lists.infradead.org
In-Reply-To: <20260804133810.184905-8-adrian.hunter@intel.com>
References: <20260804133810.184905-1-adrian.hunter@intel.com>
 <20260804133810.184905-8-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 15:11:06 +0000
Message-Id: <20260804151107.333DF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Removal of the NULL check for `i3cdev->desc` introduces a guarante=
ed NULL pointer dereference in concurrent unregistration paths.
- [High] Unconditional access to `i3cdev->bus` in `i3c_device_match()` caus=
es a Use-After-Free if the parent master controller has been freed.

Pre-existing issues:
- [High] Preexisting use-after-free race condition in AMD SBRMI (`sbrmi_i3c=
_probe`) accessing `i3cdev->desc` without holding the bus lock.
--

--- Patch [7]: [PATCH V3 07/14] i3c: master: Fix potential UAF in i3c_devic=
e_match() ---
commit d088359c0cccb56067d426e92d0a49f24376de53
Author: Adrian Hunter <adrian.hunter@intel.com>

i3c: master: Fix potential UAF in i3c_device_match()

This commit protects access to i3cdev->desc with the bus normal-use lock
in i3c_device_match() to prevent a use-after-free during concurrent
descriptor replacement. It also removes the NULL check for i3cdev->desc,
assuming the lock guarantees validity.

> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index 947ab3c681d5e..e7ea410078891 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -347,8 +347,10 @@ static int i3c_device_match(struct device *dev, cons=
t struct device_driver *drv)
>  	i3cdev =3D dev_to_i3cdev(dev);
>  	i3cdrv =3D drv_to_i3cdrv(drv);
> =20
> -	if (i3cdev->desc && i3cdev->desc->boardinfo)
> +	i3c_bus_normaluse_lock(i3cdev->bus);

[Severity: High]
Does accessing i3cdev->bus here risk a use-after-free if the parent master
controller has been freed?

During unregistration, i3c_master_unregister() unregisters child devices,
and device_del() drops the child's reference to the parent by calling
put_device(parent). Once unregistration finishes, the parent platform device
unbinds and its devres frees the I3C master struct.=20

If a concurrent bus_for_each_dev() iterator (such as from driver registrati=
on)
holds a reference to the child device, the child outlives the parent. The
child's i3cdev->bus pointer would then remain pointing to the freed master
memory, leading to a use-after-free when acquiring the lock.

> +	if (i3cdev->desc->boardinfo)

[Severity: High]
Could removing the NULL check for i3cdev->desc lead to a NULL pointer
dereference during concurrent unregistration?

In i3c_master_unregister_i3c_devs(), i3cdev->dev->desc =3D NULL; is set wit=
hout
holding any bus locks.=20

If a concurrent driver matching thread invokes i3c_device_match(), it can
proceed in parallel because driver_match_device() operates outside
device_lock(). The thread acquires the bus lock, but since unregistration
doesn't hold it, it could read desc as NULL and crash when accessing
i3cdev->desc->boardinfo.

>  		static_addr_method =3D i3cdev->desc->boardinfo->static_addr_method;
> +	i3c_bus_normaluse_unlock(i3cdev->bus);
> =20
>  	/*
>  	 * SETAASA-based devices need not always have a matching ID since

[Severity: High]
This is a pre-existing issue, but I noticed a similar locking problem in
the AMD SBRMI driver.

In drivers/misc/amd-sbi/rmi-i2c.c:sbrmi_i3c_probe():

    if (I3C_PID_INSTANCE_ID(i3cdev->desc->info.pid) !=3D 1)

This dereferences i3cdev->desc without acquiring i3c_bus_normaluse_lock()
or using the safe i3c_device_get_info() API.

Since probe runs holding device_lock(), it is not mutually exclusive with
the bus maintenance write-lock used for descriptor replacement in
__i3c_master_add_i3c_dev_locked(). If a device's address is concurrently
re-assigned during DAA hot-join, could probe dereference a freed descriptor
when it resumes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804133810.1849=
05-1-adrian.hunter@intel.com?part=3D7
