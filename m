Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F493BB4A
	for <linux-pci@vger.kernel.org>; Thu,  6 Aug 2026 13:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786023621; cv=none; b=W/6btZ+bsuFzEUjBU0P+5YyU8I0nBOrNc/ng3wHjpzF00KWSUsKTkQCV9GQavhImErEal/60l+gATcXLCTuRXLahawqROeD1qrlgnKv9hxZ5uvTB/HXW2p9zTxG9tA9rPOP6ncDAPM7DrjIU80iJNyHhNoZgEHw+7w5y4tM3Rog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786023621; c=relaxed/simple;
	bh=o2iMgUr6DOaCx5Nhw70NUpFNoVOgEPu+MVZsdMaNxpo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aP5NHRSeDMkZuPzckI23mpvp/5rsTO7ttvx6NLEVOAmxoeijv/Ugq9Nfy6IbPLJDVhA7esKGl4HAqWgjbix8QkgnvZRwWnDq1BKSzFfgOJ/hEBBhAC6ogJL3mG55UhE+vExAcyA/VNF+60Bd0kChOhAw9bnSaCYvZ2OGwK762AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlleqKl1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlleqKl1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44A591F000E9;
	Thu,  6 Aug 2026 13:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786023619;
	bh=ucb4F9aMO5K8ZLlhk8JclHc7o8cLrw3MXgUf5KBxI7A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nlleqKl1SOPCcHC0gxjBu2+nvaxmRs46rnIj7UOdbqO9717vessY1oCbnT2TgIhkn
	 IJBcBA/PfAiWxsdJIsz0XH6wzfl9m5nhJ1HDse1b1WuVDviAFt8I6XpkOOGVO8RE0u
	 Lj3dJNOxplSmoe0Jc/kAfDB3qFvUptmP8AcAWK35Kb6z9pCZNm9GEc3PxmDTPaGPys
	 z4+S+voOknnFmeqfEf00T2sBUrFk/mONpm3mQsBmTqr3cxlASn42d4ElqrohIp0ngB
	 CSxaNRKaoiNSqZxB4BpCWhib134DdbCaDrcgOzM1obxR/F/M3yEMphvBUcu2gQ98PE
	 1YPoW56M97V1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V4 03/14] i3c: master: Do not treat master device as a
 duplicate target
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: Frank.Li@kernel.org, linux-i3c@lists.infradead.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-pci@vger.kernel.org
In-Reply-To: <20260806131857.119830-4-adrian.hunter@intel.com>
References: <20260806131857.119830-1-adrian.hunter@intel.com>
 <20260806131857.119830-4-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 13:40:18 +0000
Message-Id: <20260806134019.44A591F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent sysfs access during controller unregistration causes Us=
e-After-Free on master->this.
--

--- Patch [3]: [PATCH V4 03/14] i3c: master: Do not treat master device as =
a duplicate target ---
commit fc7734e8f0ca4a890942ede6fbf8e3880e33f59c
Author: Adrian Hunter <adrian.hunter@intel.com>

i3c: master: Do not treat master device as a duplicate target

i3c_master_search_i3c_dev_duplicate() searches the bus for another I3C
device with the same PID as the reference device. The search can match
master->this, causing the controller itself to be returned as a duplicate.

> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index c7bb52b71d884..abb582645a2ed 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -2545,7 +2545,8 @@ i3c_master_search_i3c_dev_duplicate(struct i3c_dev_=
desc *refdev)
> =20
>  	i3c_bus_for_each_i3cdev(&master->bus, i3cdev) {
>  		if (i3cdev !=3D refdev && i3cdev->info.pid &&
> -		    i3cdev->info.pid =3D=3D refdev->info.pid)
> +		    i3cdev->info.pid =3D=3D refdev->info.pid &&
> +		    i3cdev !=3D master->this)
>  			return i3cdev;
>  	}
> =20

[Severity: High]
This is a pre-existing issue, but since this patch modifies how master->this
is handled, I noticed a potential concurrent use-after-free with master->th=
is
during unregistration.

When an I3C master controller is unregistered, i3c_master_unregister() calls
i3c_master_bus_cleanup() before device_unregister():

drivers/i3c/master.c:i3c_master_unregister() {
	...
	i3c_master_bus_cleanup(master);
	pm_runtime_disable(&master->dev);
	device_unregister(&master->dev);
	...
}

The cleanup function eventually calls i3c_master_detach_free_devs(), which
unconditionally frees all devices in the bus list, including master->this:

drivers/i3c/master.c:i3c_master_detach_free_devs() {
	...
		i3c_master_free_i3c_dev(i3cdev);
	...
}

Because device_unregister() has not yet executed, sysfs attributes attached
to the master device remain active.=20

If userspace reads a sysfs attribute during this window, would bcr_show()=20
dereference the freed master->this pointer?

drivers/i3c/master.c:bcr_show() {
	...
	desc =3D dev_to_i3cdesc(dev);
	ret =3D sysfs_emit(buf, "0x%02x\n", desc->info.bcr);
	...
}

The teardown path does not appear to hold the bus->lock, so the
i3c_bus_normaluse_lock() in the sysfs handler would still succeed. Could th=
is
cause a memory corruption or information leak?

Should device_unregister() or sysfs attribute removal happen before the bus
is cleaned up and the devices are freed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806131857.1198=
30-1-adrian.hunter@intel.com?part=3D3
