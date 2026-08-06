Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA475380FCD
	for <linux-pci@vger.kernel.org>; Thu,  6 Aug 2026 13:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786023562; cv=none; b=UFY8yAWUceLEtv2qREnUFv7qe63zO/CrT2pPoZWNxdLEslAuVgOGkVnQH2cxNd8B/4MiX6d6HPU8OU6VZMqiINZt2+JMh5JRln0vqrc15R5WWUDS3KvAKnDjR88QkgrIaMWPoAQBeEBZpdtRvR5n6REAUaA5CzM2JhLlpC21Q90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786023562; c=relaxed/simple;
	bh=WsXeVu+7T5dXUHPhNbT0eMNiwxXJu1ODZQcEjYUXUjY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SCl/LNeNT4V1IMFjlCIo2Li9TpTyhF9OcoopbcNPlNJxgfm5cMkGLuG5jysfrP8HXtENhRNQHRAiZRWzTJZSyk5jPuTBmbBzmeuwrXjmb2G4HYrDohmk5jm9c87kT4xFb2vtYbcqzsNYiHXkFGhQl0Vh8EZTEC14+37WVz7MYO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQlZQI3s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQlZQI3s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA761F000E9;
	Thu,  6 Aug 2026 13:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786023555;
	bh=F+I+ddnxFvrQEUitPJJrfAfpCyBasFub3M63eWzfy54=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EQlZQI3sBRE7RtPnJRrinAVBnsrwbK695BmLC+V8qPN8D02Bz8JX0GdAt4dsjPb2Q
	 mewXqHQGgtKaNGYY+gLMaue6OGkLSYpyp8Vdob9Wz0u7APeRSjmSidfxioDu0AMNNI
	 fXNsGaQdQWf4SXfOkukVk4WqKnMWQFGv3HceuSSS5sixoesHMd1MaYQRLXtTr/EcnG
	 IGBzQu7smWtad7XP4DP70cp3/lUSbqAUlhkg45Doo4Q9D/snkU2x85excnxpTOpUEe
	 7u22lPpN83Xo0IC4foGNRFrXrNtNLMEOIHlvQVqZ67Nj3ikEg+MCkYJUluVcIL0Hzi
	 ZZXcxyTVS+RkQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V4 01/14] i3c: master: Fix recursive locking during
 device registration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-pci@vger.kernel.org, Frank.Li@kernel.org, linux-i3c@lists.infradead.org
In-Reply-To: <20260806131857.119830-2-adrian.hunter@intel.com>
References: <20260806131857.119830-1-adrian.hunter@intel.com>
 <20260806131857.119830-2-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 13:39:14 +0000
Message-Id: <20260806133914.EDA761F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Dropping the bus maintenance lock around device_register() exposes=
 the I3C device descriptor to concurrent Use-After-Free.

Pre-existing issues:
- [High] Unbalanced fwnode reference count decrement in i3c_device_release(=
) leads to Use-After-Free.
--

--- Patch [1]: [PATCH V4 01/14] i3c: master: Fix recursive locking during d=
evice registration ---
commit b31a8482aa2ea710ccc853d0c74b77edebb131ff
Author: Adrian Hunter <adrian.hunter@intel.com>
Date:   Thu Aug 6 13:18:44 2026 +0000

    i3c: master: Fix recursive locking during device registration

This commit addresses a recursive locking lockdep warning by decoupling
device creation from registration. It collects newly populated devices into=
 a
temporary list under the maintenance lock, then releases the lock prior to
invoking device_register() to prevent probe deadlocks. Finally, the lock is
re-acquired to clean up any devices that failed registration.

> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -2104,25 +2113,37 @@ i3c_master_register_new_i3c_devs(struct i3c_maste=
r_controller *master)

[ ... ]

> +		list_add_tail(&desc->dev->node, &i3c_unreg_devs);
> +	}
> +
> +	i3c_bus_maintenance_unlock(&master->bus);
> +
> +	list_for_each_entry_safe(i3cdev, tmp, &i3c_unreg_devs, node) {
> +		ret =3D device_register(&i3cdev->dev);

[Severity: High]
Does dropping the bus maintenance lock around device_register() expose the
I3C device descriptor to a concurrent use-after-free?

During registration, the driver core can call subsystem functions like
i3c_device_match(), which read i3cdev->desc locklessly:

drivers/i3c/master.c:i3c_device_match() {
    ...
    if (i3cdev->desc && i3cdev->desc->boardinfo)
        static_addr_method =3D i3cdev->desc->boardinfo->static_addr_method;
    ...
}

Concurrently, an I3C Hot-Join or sysfs-triggered Dynamic Address Assignment
(DAA) could execute i3c_master_do_daa(), take the i3c_bus_maintenance_lock,
and call __i3c_master_add_i3c_dev_locked(). If DAA detects the device as a
duplicate, it replaces the descriptor and frees the old one:

drivers/i3c/master.c:__i3c_master_add_i3c_dev_locked() {
    ...
    i3c_master_detach_i3c_dev(olddev);
    i3c_master_free_i3c_dev(olddev);
    ...
}

If the registering thread is actively evaluating i3cdev->desc when this
happens, will it lead to memory corruption when reading fields like
desc->boardinfo?

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
> +		put_device(&i3cdev->dev);

[Severity: High]
This is a pre-existing issue, but does this error path cause an unbalanced
fwnode reference count decrement leading to a use-after-free?

During device initialization, device_set_node() assigns the fwnode without
incrementing its reference count:

drivers/i3c/master.c:i3c_master_register_new_i3c_devs() {
    ...
    if (desc->boardinfo)
        device_set_node(&desc->dev->dev, desc->boardinfo->fwnode);
    ...
}

However, when put_device() is called here on registration failure,
the release function unconditionally drops a reference:

drivers/i3c/master.c:i3c_device_release() {
    ...
    fwnode_handle_put(dev->fwnode);
    ...
}

Since the device object never acquired a reference to the boardinfo's fwnod=
e,
will repeated registration failures or unbind operations drop the refcount
below zero, eventually prematurely freeing the fwnode?

> +		desc->dev =3D NULL;
>  	}
> +
> +	i3c_bus_maintenance_unlock(&master->bus);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806131857.1198=
30-1-adrian.hunter@intel.com?part=3D1
