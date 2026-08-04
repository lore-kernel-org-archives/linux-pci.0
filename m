Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29423FF8A2
	for <linux-pci@vger.kernel.org>; Tue,  4 Aug 2026 15:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785856164; cv=none; b=P1EWoG0cq182Pq9uDAePAmd4KzB5jP0mIEM3WMXJw+eqYG0vJWGEDUMU8IRlmh2tS63CE336T7+SZvQVvrHnKWHqZB8QeKH7+/TcZdZ1CaaOADB3NE1x1hEnTBRfCpnDUDuQbC8bBWxwqkBcaWwbHjpTrupwbnYRiHkzrsqKCg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785856164; c=relaxed/simple;
	bh=jsHrwrInmVtIoAMwBhEqMjmN2ziZEucMwoFkB8SInIg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mBegXytfwxwqgnOj9pW4dIyeKsPFnzTwA0XFDWhYLvwDFFcloiQVPcVWc3CixhioXPnq0qZR/YSeaqnRI6nInVT1BeofhrDgDByI5BGfc6e/h3vgkP7VQ1FqpqZPLqAJJbyq8oJXO2YReqkZCIkb9KF3L7PXtSBAior5s10Lgrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJKcPRdx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJKcPRdx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01A091F000E9;
	Tue,  4 Aug 2026 15:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785856162;
	bh=G4tYNCEnE5m749kZGxdrQXu9yxjFPlI411cDrkz6vus=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GJKcPRdxllO2bA9DYNpYWBPqt2q2ZQhCS3h5uKelrWGnxdr0uYY78hlqSllWGRtkR
	 y+NJPoFa65hULNTdXuzdwXTlR3qME9YqeFIjH+lnU8rdScSg64K2Z1iEoiYZm1j8/N
	 suCZNceidRSQiz4zUYHpLclzjJ3zk2Pv45wOxwYBcaWSwjv+/1JL/KUeonBmOqRcPI
	 Po273N5ycFPqFm6P5NQyylYZRDX1cWZfQIqlweN3A1UN7RPDjjeI04CLgWRq3wJgaC
	 vBbl5aYQz13oGWwfrqARQk0UewWuNkVpAi1L7438hn3xZUWLwNp99BHW7Sa+H8ZdX+
	 BwEqw+oej+y8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 02/14] i3c: Fix unlocked dereference of dev->desc in
 i3c_device_get_supported_xfer_mode()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: linux-i3c@lists.infradead.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, Frank.Li@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260804133810.184905-3-adrian.hunter@intel.com>
References: <20260804133810.184905-1-adrian.hunter@intel.com>
 <20260804133810.184905-3-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 15:09:21 +0000
Message-Id: <20260804150922.01A091F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Critical] The patch transforms a predictable NULL pointer dereference in=
to an exploitable Use-After-Free of `master->this` when an I3C device outli=
ves its master controller's unregistration.

Pre-existing issues:
- [High] Uninitialized stack memory (`devinfo`) is used for driver matching=
 when `i3cdev->desc` is NULL.
- [High] A Time-of-Check to Time-of-Use (TOCTOU) race condition exists when=
 accessing `i3cdev->desc->boardinfo`, leading to a Use-After-Free or NULL p=
ointer dereference.
--

--- Patch [2]: [PATCH V3 02/14] i3c: Fix unlocked dereference of dev->desc =
in i3c_device_get_supported_xfer_mode() ---
commit 97cfccca08da732124561cbc1aa49b571a84dd8c
Author: Adrian Hunter <adrian.hunter@intel.com>

i3c: Fix unlocked dereference of dev->desc in i3c_device_get_supported_xfer=
_mode()

This patch modifies i3c_device_get_supported_xfer_mode() to use dev->bus
instead of dev->desc to obtain the master controller. This avoids a potenti=
al
unlocked dereference of dev->desc.

> diff --git a/drivers/i3c/device.c b/drivers/i3c/device.c
> index 101eaa77de686..a3778282e84c2 100644
> --- a/drivers/i3c/device.c
> +++ b/drivers/i3c/device.c
> @@ -309,7 +309,7 @@ EXPORT_SYMBOL_GPL(i3c_device_match_id);
>   */
>  u32 i3c_device_get_supported_xfer_mode(struct i3c_device *dev)
>  {
> -	return i3c_dev_get_master(dev->desc)->this->info.hdr_cap | BIT(I3C_SDR);
> +	return i3c_bus_to_i3c_master(dev->bus)->this->info.hdr_cap | BIT(I3C_SD=
R);

[Severity: Critical]
Does this change introduce a use-after-free if the device outlives the mast=
er
controller?

When a master is unregistered, i3c_master_unregister() calls
i3c_master_unregister_i3c_devs() to unregister child devices. If a child
device has an elevated refcount (e.g., from an open file descriptor), its
struct i3c_device outlives the unregistration.

i3c_master_bus_cleanup() then calls i3c_master_detach_free_devs(), which
explicitly frees master->this.

If the child device later calls i3c_device_get_supported_xfer_mode(), it
would dereference the explicitly freed master->this pointer. The previous
code safely faulted on a NULL dev->desc, but this new path appears to access
freed memory.

[ ... ]

[Severity: High]
This is a pre-existing issue, but does i3c_device_match() have a TOCTOU race
condition leading to a use-after-free?

drivers/i3c/master.c:i3c_device_match() {
        if (i3cdev->desc && i3cdev->desc->boardinfo)
                static_addr_method =3D i3cdev->desc->boardinfo->static_addr=
_method;
}

If i3c_device_match() accesses i3cdev->desc without holding the device lock
during concurrent master unregistration, a context switch could occur right
after i3cdev->desc is checked.

If the unregistration thread then frees the descriptor via kfree() in
i3c_master_bus_cleanup(), the subsequent evaluation of
i3cdev->desc->boardinfo will dereference a freed pointer.

[Severity: High]
This isn't a bug introduced by this patch, but can i3c_device_match_id()
evaluate uninitialized stack memory?

During concurrent driver registration and master unregistration, if
i3c_master_unregister_i3c_devs() sets i3cdev->dev->desc =3D NULL,
i3c_device_match() might still proceed to call i3c_device_match_id().

drivers/i3c/device.c:i3c_device_match_id() {
        struct i3c_device_info devinfo;
        ...
        i3c_device_get_info(i3cdev, &devinfo);
       =20
        manuf =3D I3C_PID_MANUF_ID(devinfo.pid);
}

If i3cdev->desc is NULL, i3c_device_get_info() bails out safely without
populating devinfo, leaving the stack memory completely uninitialized when
it is subsequently read for driver matching.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804133810.1849=
05-1-adrian.hunter@intel.com?part=3D2
