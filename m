Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2033933EB10
	for <linux-pci@vger.kernel.org>; Thu,  6 Aug 2026 13:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786023926; cv=none; b=U6buh8WEH/iSSVqjD7TYhXxmgZNS+pjFTLFsFW/xfTzEKK5MbH3FEBGK0OXun52SA2XGO80L8QNZAYnsq8H7/kR2KrgQ/N0efDDSSmFnyPMYo0wPVGz8yLTFu29rES3SI6YjaLqKkY/E0b0lXdjXcEHNa123sH2zxQjuKhY2E0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786023926; c=relaxed/simple;
	bh=a0CpvkwT2s6F2hup0qicJlJ4qQofjTpMoqfs73vMbWY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kBk0cOi4doYwi7EsyXMWiZP/gRx/lzEGqGAMPK4r4sfIQC3BlYDN2AituRKn2FJyW6U/r1OQ6knwoJe0KJlncDIjvQY8y0MOU/EPk1e9dfWwlUIT0QfkTTwDG67K7XL+keudVpduDqOeaNcZD5pFqFxzLkHQ3dbP3LRTywrBp68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VP/j/1WH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VP/j/1WH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DEEC1F000E9;
	Thu,  6 Aug 2026 13:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786023924;
	bh=XpQMAhFQd/di1nMC72MRSNQf97ZENnjMrFdp0Rain/8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VP/j/1WH64ZIpWOtVXJ1k5z03Q0s10kcA1pA/WbwcDapLk1YBAaIMGG52tgj5D8Iw
	 E/NMG0dwIuwsOTKz9HaW7QT0P7ZlIqYQVSliJ/A2K0WF2AbuWSdSvbXOgePArcgGGp
	 N8xZiyCkT1wA/uqF6xrSGBZU5Z0eMmZg2N+fJatGbqE/I3cLKsvKTRr3UXROFZJEEp
	 uhongZwjTscGEgZVmS7F8ZxnqcT4sfGvHoTpknDlXvY1jcxDNm5AQDjf8uDguIlz3r
	 jpbmLXD5UaQNV2BxgBh2oRPfyRC8wNetu5RSB8b0gYO5P4klxeYO5mTxNw9hOwQmxG
	 eud5jyVj9+EeQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V4 07/14] i3c: master: Fix potential UAF in
 i3c_device_match()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: linux-i3c@lists.infradead.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-pci@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260806131857.119830-8-adrian.hunter@intel.com>
References: <20260806131857.119830-1-adrian.hunter@intel.com>
 <20260806131857.119830-8-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 13:45:23 +0000
Message-Id: <20260806134524.6DEEC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Removing the NULL check for `i3cdev->desc` introduces a determinis=
tic NULL pointer dereference during device unregistration and registration =
error paths.
- [High] `i3c_device_get_info()` dereferences `dev->desc` without checking =
for NULL under the lock, causing a NULL pointer dereference.
--

--- Patch [7]: [PATCH V4 07/14] i3c: master: Fix potential UAF in i3c_devic=
e_match() ---
commit 4b5a3c82a1c4c5f9bf31e925977c2286520960fc
Author: Adrian Hunter <adrian.hunter@intel.com>

i3c: master: Fix potential UAF in i3c_device_match()

This commit protects access to i3cdev->desc with the normal-use lock to
prevent a use-after-free when the descriptor pointer is concurrently
replaced. Since the descriptor is assumed to remain valid while the lock is
held, the NULL check is removed.

> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index ee771ac0b203e..83e04a2c202a9 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -347,8 +347,10 @@ static int i3c_device_match(struct device *dev, cons=
t struct device_driver *drv)
>  	i3cdev =3D dev_to_i3cdev(dev);
>  	i3cdrv =3D drv_to_i3cdrv(drv);
> =20
> -	if (i3cdev->desc && i3cdev->desc->boardinfo)
> +	i3c_bus_normaluse_lock(i3cdev->bus);
> +	if (i3cdev->desc->boardinfo)

[Severity: High]
Is it safe to remove the NULL check for i3cdev->desc here?

If a userspace process writes to a driver's bind file via sysfs concurrently
with a device registration failure, bind_store() will call
driver_match_device() and eventually reach i3c_device_match().

In the error path of i3c_master_register_new_i3c_devs(), i3cdev->desc is set
to NULL under the write lock. When this code subsequently acquires the read
lock, i3cdev->desc will be NULL, which could cause a NULL pointer
dereference.

Similarly, i3c_master_unregister_i3c_devs() locklessly sets i3cdev->desc to
NULL during teardown, which can also race with this path.

>  		static_addr_method =3D i3cdev->desc->boardinfo->static_addr_method;
> +	i3c_bus_normaluse_unlock(i3cdev->bus);
> =20
>  	/*
>  	 * SETAASA-based devices need not always have a matching ID since
>  	 * it is not mandatory for such devices to implement deviceinfo
>  	 * CCC commands. Allow them to register through DT or ACPI.
>  	 */
>  	if (i3cdrv->id_table && i3c_device_match_id(i3cdev, i3cdrv->id_table))

[Severity: High]
Does this call to i3c_device_match_id() have a similar vulnerability?

i3c_device_match_id() eventually calls i3c_device_get_info(). While
i3c_device_get_info() does acquire the normal-use lock, it directly reads
dev->desc->info without checking if dev->desc is valid.

If a bind operation races with device unregistration or a registration error
path, dev->desc could be set to NULL before the lock is acquired, leading to
a crash when reading dev->desc->info.

>  		return 1;
> =20
>  	if (static_addr_method & I3C_ADDR_METHOD_SETAASA) {

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806131857.1198=
30-1-adrian.hunter@intel.com?part=3D7
