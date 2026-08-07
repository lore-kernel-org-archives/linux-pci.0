Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7A337F334
	for <linux-pci@vger.kernel.org>; Fri,  7 Aug 2026 15:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786115586; cv=none; b=NvvCCi0cG3+Nrpf0A4ZAJet+PFzAzMgo9etUx6y4hRXYy8aJHjPN97hkbASf3a1Yamipnyb+o8rMWhZYLgu9VrVcJ1RekxKgcB3v2s/TDIlGKhWgyYLzlDRRgDpxKuxdwZnWObmvZ/JPIs93pjdF1Ynz8K+I9xTRHcdnMZY5SvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786115586; c=relaxed/simple;
	bh=wnxj7PvH2/Sdh5Y4IL1zSQEA5WErpQxqebL2AocF5Jw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QebmJtZqzi3L7odfpPZ2BHnjQzc9c3ERpp9Wl4QzV7ZUXyJkIvQOjbytYsSwJsCkxQh0Rct6Aaxbk0hD0z/wTiXjymZbSzUD1w6wjRSNFAoNTs0pL152HQvE/eGPA3RjdJH+UsKkQZ2hv5XqPj2e6ZONwt1Ai0WdoUYG6K7PR54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IO/OLbzH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IO/OLbzH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 486AA1F00A3A;
	Fri,  7 Aug 2026 15:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786115585;
	bh=jnmmGHDprAsNByhOkoHlwimX7baEFFIV0uZ433cWhw8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IO/OLbzHw22+3EDGKynmzj+2kup0AkTVFRpYy/0uRVdderh4ld+NkFLDLUcDzyvg2
	 dXR46Q/ZmGJutjcQLhNoQnFlGQIIuWOPbUVVnS1Lb2KY6x/U6ZyNKGqPRWDhJBiwBc
	 LOkmvvP8fX3KtqLsIbA8FTmyB8hZoewBpPz0BYC/Gog4cazd6xfJ/H9glKZAl0bvt4
	 ihJ3f4s/d+czfi/cjDxXjqD0cwxIjhPfFjjsIVf/EK3vQ9brnHgdc0Ih0N51RAKplZ
	 CHBYrq5/6WUlrS6BS4JEqLNcfWeNnf6OiWPsAJZSnrszWVWR2ix2SqfyeHJIKlgYwE
	 XBHHfEVFnyfLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V5 02/14] i3c: Fix unlocked dereference of dev->desc in
 i3c_device_get_supported_xfer_mode()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: Frank.Li@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-i3c@lists.infradead.org, linux-pci@vger.kernel.org
In-Reply-To: <20260807145638.168865-3-adrian.hunter@intel.com>
References: <20260807145638.168865-1-adrian.hunter@intel.com>
 <20260807145638.168865-3-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 15:13:04 +0000
Message-Id: <20260807151305.486AA1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unresolved lockless dereferences of `i3cdev->desc` and uninitializ=
ed stack memory leaks to user-space.
- [High] I3C master controllers are allocated using `devm_kzalloc` while em=
bedding a `struct device`, leading to a Use-After-Free during unbinding.
--

--- Patch [2]: [PATCH V5 02/14] i3c: Fix unlocked dereference of dev->desc =
in i3c_device_get_supported_xfer_mode() ---
commit e7d56c173e65ff36b79485393042fbeb29cba21d
Author: Adrian Hunter <adrian.hunter@intel.com>

i3c: Fix unlocked dereference of dev->desc in i3c_device_get_supported_xfer=
_mode()

This patch resolves an unlocked dereference of dev->desc by using dev->bus
to obtain the master controller instead. The commit notes that dev->desc
must not be dereferenced unless bus->lock is held.

> i3c_device_get_supported_xfer_mode() uses dev->desc to obtain the
> master controller.  However, dev->desc must not be dereferenced unless
> bus->lock is held, and this function does not take that lock.

[Severity: High]
This isn't a bug introduced by this patch, but since we are establishing
that dev->desc must not be dereferenced without bus->lock, are there
similar unresolved lockless dereferences elsewhere?

For example, looking at drivers/i3c/master.c:i3c_device_uevent():

	if (i3cdev->desc)
		devinfo =3D i3cdev->desc->info;
	manuf =3D I3C_PID_MANUF_ID(devinfo.pid);

If this races with descriptor freeing (such as during DAA/Hot-Join events
that swap or free descriptors), could this cause a Use-After-Free?

Additionally, if i3cdev->desc is NULL, devinfo remains completely
uninitialized on the stack. The function then unconditionally formats
devinfo.pid and devinfo.dcr into the MODALIAS string, which is exposed to
user-space via the uevent sysfs file. Could this leak kernel stack memory?

Similar lockless or NULL-unsafe accesses appear to exist in
drivers/i3c/device.c:i3c_device_match_id(),
drivers/i3c/master.c:i3c_device_match(), and driver probes like
drivers/misc/amd-sbi/rmi-i2c.c:sbrmi_i3c_probe().

[ ... ]

> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index d2fb1a1105218..c7bb52b71d884 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -102,12 +102,6 @@ void i3c_bus_normaluse_unlock(struct i3c_bus *bus)
>  	up_read(&bus->lock);
>  }
> =20
> -static struct i3c_master_controller *
> -i3c_bus_to_i3c_master(struct i3c_bus *i3cbus)
> -{
> -	return container_of(i3cbus, struct i3c_master_controller, bus);
> -}
> -
>  static struct i3c_master_controller *dev_to_i3cmaster(struct device *dev)
>  {
>  	return container_of(dev, struct i3c_master_controller, dev);

[Severity: High]
This is a pre-existing issue, but looking at the master controller lifecycle
managed here, is there a Use-After-Free risk during unbinding?

Almost all I3C master drivers (e.g. drivers/i3c/master/dw-i3c-master.c)
allocate their master controller structure using devm_kzalloc():

drivers/i3c/master/dw-i3c-master.c:dw_i3c_probe() {
...
	master =3D devm_kzalloc(&pdev->dev, sizeof(*master), GFP_KERNEL);
...
}

This structure embeds a struct i3c_master_controller, which in turn embeds a
struct device (accessed right here via dev_to_i3cmaster()).

When the driver is unbound, devres automatically frees the devm_kzalloc
memory once the remove callback finishes. If a user holds a sysfs attribute
open, the device reference count doesn't immediately drop to zero. Later,
when the sysfs file is closed, the driver core invokes the device's release
callback:

drivers/i3c/master.c:i3c_masterdev_release() {
...
	struct i3c_master_controller *master =3D dev_to_i3cmaster(dev);
...
	if (master->wq)
		destroy_workqueue(master->wq);
...
}

Since the memory was already freed by devres, won't accessing master->wq
here trigger a Use-After-Free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807145638.1688=
65-1-adrian.hunter@intel.com?part=3D2
