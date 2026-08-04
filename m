Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699E646AEF2
	for <linux-pci@vger.kernel.org>; Tue,  4 Aug 2026 14:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785852621; cv=none; b=A4TnSf/a5ijuWFr3pbhpACpAqEtEIpgV4WetR6a5IGn8RPnczOyyt87J+xRhrJKfEhiMNPnY8IM7IqSw1fKvgYTYQ+oS6JRKhTFC8iNHyU8HvjnEa4vW5OlFvrAuovQsie7ywh+MbB8kx3HQIOaT4Xt1AbCucP8phGQek6jVllI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785852621; c=relaxed/simple;
	bh=t8hJi5cjhcD58kFtWFH1yCcgiKfG9TEQEIcqbyJowTo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n/lNmb7QBaUkEU5h1A/j1eB0CVbisek/zlUr329ERr++ZgYMrcEriI8JPIf81v57n95bqHl2nhu1ldp+DNLBurWhJSatduQ2X7UXhl0yVE4tr4BkJe3sU2eqv+4t3SWz7ybyYpsy0AcmqPkkCqFSudAX7Osegu0Phny1lFFNt5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/6no5ds; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/6no5ds"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B9641F000E9;
	Tue,  4 Aug 2026 14:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785852615;
	bh=/2EpyqNJbzQaU0bFvsI6Q0Ns24LoWCbbOyID6UOCoI8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z/6no5dsWXXyxvnFyhieAp3h1OCJU8Ag30dRaSugkZ9yXn4krdjgqRTbN1kWEu9FV
	 BS6KZi+G7R5FW7oK5Vh6H8uEu4EATgo2bPFzw4YIKQT4CEUtU0f4hS0NUaKDCea4yt
	 midetKbkpWfuuZnBsFhPF65OvJemXjBlNCW/scgAOgniGN2qorjUB0Ux6tvitj1ru7
	 tsQbLHb3bOZzK2ZyUEzdLBzTzIk+Qo+hT5Z0aCJ8zwKzuL14KQLtGwYOq1NiGu82X9
	 Jt7GqTzKQlI697fbZAu9YSCz/UIv73KnOBEyFlu/h5tBUQ+Jr0OI8c3klcH33/d9kT
	 9QbqH8U3vZHmQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 04/14] i3c: master: Fix use-after-free of
 master->this
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: Frank.Li@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-i3c@lists.infradead.org, linux-pci@vger.kernel.org
In-Reply-To: <20260804133810.184905-5-adrian.hunter@intel.com>
References: <20260804133810.184905-1-adrian.hunter@intel.com>
 <20260804133810.184905-5-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 14:10:14 +0000
Message-Id: <20260804141015.8B9641F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] A double free occurs in the error path of `i3c_master_set_info()` =
because `master->this` is left as a dangling pointer and is subsequently fr=
eed again in `i3c_masterdev_release()`.

Pre-existing issues:
- [High] Devres lifetime mismatch allows use-after-free of the master contr=
oller struct in `i3c_masterdev_release()`.
--

--- Patch [4]: [PATCH V3 04/14] i3c: master: Fix use-after-free of master->=
this ---
commit e74d33e25ba87fdc800277aa5702a984d20076ca
Author: Adrian Hunter <adrian.hunter@intel.com>
i3c: master: Fix use-after-free of master->this

This patch delays freeing master->this until i3c_masterdev_release(). By
doing this, it keeps master->this alive until all users of the master
device have gone away and the sysfs state is torn down.

> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index abb582645a2ed..4839c1c186eb0 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
[ ... ]
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
>  	struct i3c_bus *bus =3D dev_to_i3cbus(dev);

[Severity: High]
This is a pre-existing issue, but does this release function dereference
fields in the master struct after the driver's devres cleanup has already
freed the surrounding memory?

Master controller structures are typically allocated using devm_kzalloc().
When a driver is unbound, devres cleanup frees the master controller
structure. However, if userspace holds an open file descriptor to a sysfs
attribute (like /sys/class/i3c/i3c-0/bcr), the kobject refcount doesn't drop
to zero.

When the sysfs file is later closed, the final put_device() calls this
i3c_masterdev_release() function, which then dereferences fields like
master->wq, bus->devs, and now master->this, leading to a use-after-free.

>  	if (master->wq)
>  		destroy_workqueue(master->wq);
> =20
>  	WARN_ON(!list_empty(&bus->devs.i2c) || !list_empty(&bus->devs.i3c));
>  	i3c_bus_cleanup(bus);
> =20
>  	fwnode_handle_put(dev->fwnode);
> +
> +	i3c_master_free_i3c_dev(master->this);

[Severity: High]
Does unconditionally freeing master->this here cause a double free on the
error path of i3c_master_set_info()?

If i3c_master_attach_i3c_dev() fails during initialization in
i3c_master_set_info(), the allocated i3cdev is freed via
i3c_master_free_i3c_dev().

However, master->this and master->bus.cur_master were already assigned to
point to i3cdev and are not set back to NULL:

drivers/i3c/master.c:i3c_master_set_info() {
	...
	master->this =3D i3cdev;
	master->bus.cur_master =3D master->this;

	ret =3D i3c_master_attach_i3c_dev(master, i3cdev);
	if (ret)
		goto err_free_dev;
	...
err_free_dev:
	i3c_master_free_i3c_dev(i3cdev);
	return ret;
}

The failure propagates to i3c_master_register(), which calls
put_device(&master->dev) to abort driver registration. This calls
i3c_masterdev_release(), which now unconditionally frees master->this,
leading to a double free of the dangling pointer.

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804133810.1849=
05-1-adrian.hunter@intel.com?part=3D4
