Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C494733938E
	for <linux-pci@vger.kernel.org>; Thu,  6 Aug 2026 13:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786023577; cv=none; b=qFle3JYRvKLJJ3b8kXAwWwfwzhJv7Bn/7IvomjK49H1eeHtXCzecqxIRVBlAr2tTr13WTRThpdW+/nPXnVGpCwlYGvwRneje5wnls8O4OCDUSD4/W6NKUxTi2SCwl3gTpEAkfbNVNymduCGi01wlsrnIPh+r2fpX2qK7PT4LlhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786023577; c=relaxed/simple;
	bh=EauB4Nektk1kJClcihqtV2BL9R8KNo3KjLdOjj81bTs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ap9ryeqcC7fZtdvexviAKWVIPRYw/QumtAlNUJnqqJNEct+PsDWEtaowMxPqAmHSgKwFYAZQOlnLBT+XEt/TDXjzooV95WMD7of70nPcSE1KX0n4sxeZTHh1vyKDaW8yBrVeZmYIuYLSUxbuQwe0KqDB22aOxcBMaXW7Gk2mR40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=erl+O9OU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="erl+O9OU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 539991F000E9;
	Thu,  6 Aug 2026 13:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786023572;
	bh=wGbhhGFrjqmZSXkk04sJ9K3Q3HPSKlAOcxLLxPdoxg0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=erl+O9OUarCOrmqrCXkzzrZPVBHLZcOvWQnxd7Tg45T8VIocIiuT1Pt6jutCYONrq
	 dcSC2sdEqg6JyfJUdqt5sJEXOzBfekEg2MqWAQCyKmh/XC6cqzQt5OwkuX50Fd6vZT
	 jwsQ9FtacQSeWHnE3ssI/uYPj1h6l6LrlDDhqq0K7XBgKTTE10pYGBjIVzII3EmtVZ
	 40AmncprVkHpoZhfJdDkG97h2Ypp0HuyyfqtcNa/3i6Jam0icb7/cjhprp/pXJDFFu
	 eJTW6ABoOlHDdqV7qVZtGl4087890mwY7siKrKED/Gd75FS0KrXo3krwcrm26tNZ+p
	 +dSYV7ZOQALUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V4 04/14] i3c: master: Fix use-after-free of
 master->this
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: Frank.Li@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-i3c@lists.infradead.org, linux-pci@vger.kernel.org
In-Reply-To: <20260806131857.119830-5-adrian.hunter@intel.com>
References: <20260806131857.119830-1-adrian.hunter@intel.com>
 <20260806131857.119830-5-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 13:39:31 +0000
Message-Id: <20260806133932.539991F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Delayed device release triggers Use-After-Free of devm-allocated m=
aster structure.
- [High] If `idr_alloc()` fails in `i3c_bus_init()`, the error path will er=
roneously remove ID 0 from `i3c_bus_idr`, corrupting the state of another s=
uccessfully registered I3C master.
--

--- Patch [4]: [PATCH V4 04/14] i3c: master: Fix use-after-free of master->=
this ---
commit 327e5dd17c108564121fb788d79fe1ed7a32a2b4
Author: Adrian Hunter <adrian.hunter@intel.com>

i3c: master: Fix use-after-free of master->this

This commit aims to fix a use-after-free by keeping master->this alive until
i3c_masterdev_release() is called. It moves the freeing of master->this out
of the normal device detach path.

> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index abb582645a2ed..2357874bb9d6a 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -842,6 +842,11 @@ static struct attribute *i3c_masterdev_attrs[] =3D {
>  };
>  ATTRIBUTE_GROUPS(i3c_masterdev);
> =20
> +static void i3c_master_free_i3c_dev(struct i3c_dev_desc *dev)
> +{
> +	kfree(dev);
> +}
> +
>  static void i3c_masterdev_release(struct device *dev)
>  {
>  	struct i3c_master_controller *master =3D dev_to_i3cmaster(dev);
> @@ -854,6 +859,8 @@ static void i3c_masterdev_release(struct device *dev)
>  	i3c_bus_cleanup(bus);

[Severity: High]
This is a pre-existing issue, but can this unconditional call to
i3c_bus_cleanup() corrupt the ID pool if idr_alloc() fails during probe?

If idr_alloc() fails in i3c_bus_init(), the error path in
i3c_master_register() will call put_device(&master->dev), which leads to th=
is
release function.

Because the bus ID was not assigned on failure, i3cbus->id remains at its
default value of 0. Calling i3c_bus_cleanup() will then unconditionally call
idr_remove(&i3c_bus_idr, 0), removing ID 0 which might currently be in use
by another successfully registered I3C master.

>  	fwnode_handle_put(dev->fwnode);
> +
> +	i3c_master_free_i3c_dev(master->this);

[Severity: High]
This isn't a bug introduced by this patch, but does accessing master->this
here risk a use-after-free if the master structure was allocated with
devres?

Many I3C master drivers allocate their controller structures using
devm_kzalloc() and tie the memory lifetime to the platform device. If a
userspace process holds a sysfs attribute open for the master device, the
kobject refcount remains elevated.

When the master device is unbound (for example, if the module is unloaded),
devres will free the master structure before the final kobject reference is
dropped. When the sysfs file is eventually closed, this release callback
will execute, but the master structure it dereferences (for master->this and
master->wq) will have already been freed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806131857.1198=
30-1-adrian.hunter@intel.com?part=3D4
