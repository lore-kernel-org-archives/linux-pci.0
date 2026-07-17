Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF843B995D;
	Fri, 17 Jul 2026 15:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784301122; cv=none; b=TNUgj108cWmqkM5q0YiKWTWXfzwTamTJJ/O03+O+Yl3THltcHFmw+Q/yJNYBCqId4dr5oTyZr3Pi4NMYq97jox7+0NwMJotcFfcUqLiy7xlrElx3Egkq2vT3FHJ5e1jYYqgLN2q6zDMmmg14bBHoKOyoxvmKfYhjtKLnbqeJFiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784301122; c=relaxed/simple;
	bh=9NDUP8+pQ2YpUgVrK8xJAlqPc1/M2oMYfr2wVIznAXg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E4kGfM9BD8FLVvVKjm0t8jca6WLZ61ERF9aXbQ4GVTQO4+ywNWSHHjrL+gcX3PJBCDqNW1TjBtVLICl2AeODlxYNvyJfd+68bh2BFEcoZcjL9wjMGiab0ia3DcySfRlIXfHDq20AHD/SiA1PIeDsfaA7cUsR0pOT6XoEIA1zGjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJpB+aH5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJpB+aH5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 854341F000E9;
	Fri, 17 Jul 2026 15:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784301120;
	bh=xarq2I7Bzjzek5e33kdGfmSmVlLRIlnOfmHk5ZK1tKQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gJpB+aH5NJ83aFaRv4/ajd7l0D9RxcBzuiwa+xdOpgOMn1S20a4TRc0vzo4LRkUcD
	 LYFs4eKNSOJSYz3JpJK+c5iB1aWns/m1eM0lZ3Gbs2kSJH98UyGFMpIMluzCm28Ax7
	 wJ5jvj52Fqfjnpng+6DgF9gN1DIfC8Weczv8JO1DHWGVqnriUwhJyPhmehq0VinWvK
	 iNzoo1X5oY6tjp0ziSKs3a2B3vCzHGLQjTPmChtfIHDJ56Oh9sw5CEeRDW9aHqIbbb
	 Vr35C1oOSl9MR9OkA2F45OhM17bAv4WtixwWILzNiNop4kEn0TmygDiTcPeC4zZt0Z
	 /w/uCzMrmla1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 02/10] drivers: core: Use fw_devlink_set_device()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260717145147.823749-3-herve.codina@bootlin.com>
References: <20260717145147.823749-1-herve.codina@bootlin.com>
 <20260717145147.823749-3-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 15:12:00 +0000
Message-Id: <20260717151200.854341F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lockless read of `fwnode->dev` can lead to Use-After-Free and NULL=
 pointer dereferences.
--

--- Patch [2]: [PATCH v10 02/10] drivers: core: Use fw_devlink_set_device()=
 ---
commit 80a2fb2740f34981de6ee4d63b13800473b38e85
Author: Herve Codina <herve.codina@bootlin.com>

drivers: core: Use fw_devlink_set_device()

This patch updates the driver core to use the dedicated
fw_devlink_set_device() helper instead of assigning the fwnode->dev field
directly.

> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 4d026682944f2..c205125344cf3 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
[ ... ]
> @@ -3925,7 +3925,7 @@ void device_del(struct device *dev)
>  	device_unlock(dev);
> =20
>  	if (dev->fwnode && dev->fwnode->dev =3D=3D dev)
> -		dev->fwnode->dev =3D NULL;
> +		fw_devlink_set_device(dev->fwnode, NULL);
> =20
>  	/* Notify clients of device removal.  This call must come
>  	 * before dpm_sysfs_remove().

[Severity: High]
This is a pre-existing issue, but does this lockless assignment expose a ra=
ce
condition with concurrent readers?

In device_del(), fwnode->dev is cleared locklessly via
fw_devlink_set_device(). Concurrently, other operations holding
fwnode_link_lock (which doesn't serialize with device_del()) read fwnode->d=
ev.

For example, if get_dev_from_fwnode() is called concurrently:

drivers/base/core.c:get_dev_from_fwnode() {
    ...
    return get_device((fwnode)->dev);
}

If the thread is preempted between reading fwnode->dev and dereferencing it
in get_device(), and device_del() finishes allowing the device to be freed,
could this result in a use-after-free?

Similarly, in __fw_devlink_pickup_dangling_consumers():

drivers/base/core.c:__fw_devlink_pickup_dangling_consumers() {
    ...
    if (fwnode->dev && fwnode->dev->bus)
    ...
}

Could the compiler reload fwnode->dev between the NULL check and the
dereference, leading to a NULL pointer dereference?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717145147.8237=
49-1-herve.codina@bootlin.com?part=3D2
