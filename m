Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82415448CF3
	for <linux-pci@vger.kernel.org>; Tue,  4 Aug 2026 14:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785855080; cv=none; b=Qdn/Uvf0znVGIOv3t4k4k7Jch0B1p1hLd6NUOqjdSxHRCXy42Nm+dPnv2ZZZKVe9fyka62m5dpI1Ue7hIHPqVGoGfPx7quvfaG7UnB+L+Yk1Vugo5M13eGsyID2YMgbPdicjJcaoh3owSiqkCZgtx7A6WQAfKcdH8xgNMz1P+TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785855080; c=relaxed/simple;
	bh=gv2sU9rS4nKr5aydLiKbr2ZlTgXAXGz5jR9wqvrgYQk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eGxRao2HZyvQZNZ+sMXzk6Kjc4q7Ax1UtNXTZwsx2xnwKjN51DUlK83lEhqw8tdOhG3JRP8T0c2vWX9WUyJdaTRmjnRhRdgLdxZW+Cgoow2E/xIpahKRCkZGn3VEQBSkQdBWxyw2KKQ/podK1vCxRyZTxJcye0y9QtHm8wVBpvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijOfLo4J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijOfLo4J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FA131F000E9;
	Tue,  4 Aug 2026 14:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785855076;
	bh=ebjPrroxsv46bPIAjF8Z9fXkDK1VsFQ1N2mECFHkXjg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ijOfLo4JbiDNySzrWAmkKceaJO/+AN5fa6japnJsVGkL5jpiylWG3ojmeappGuTOe
	 wKAUTxJAgXOAskXlTjKYVPWq9nM/JWB372xvUNngG4Xgb7mjsLwpnyv3pZ2HlAyfkb
	 ns9zhV97euOl9TUBHZU6S8qKZp3Lyx7KATgnCG4L5e7VDgAC5GPOM/jtHt0gPfbkGu
	 mv4DPpGt8vIL16gjGU+MSd8EwTPZ63PaZ2DLcU3IX7ku8Ml1u5BloEvjsUXp4ctUm8
	 CiwDK7QFJhpYEICFZkvrKptqZKiJH3jyCS4lDL67n8HAY5KZVxC0T3ZXKcvaXcZq8C
	 xAd5iyVdMqy1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 01/14] i3c: master: Fix recursive locking during
 device registration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: linux-i3c@lists.infradead.org, Frank.Li@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-pci@vger.kernel.org
In-Reply-To: <20260804133810.184905-2-adrian.hunter@intel.com>
References: <20260804133810.184905-1-adrian.hunter@intel.com>
 <20260804133810.184905-2-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 14:51:15 +0000
Message-Id: <20260804145116.4FA131F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-After-Free of `i3cdev->desc` during unlocked driver core callb=
acks (e.g., `i3c_device_match`) racing with Dynamic Address Assignment (DAA=
).
--

--- Patch [1]: [PATCH V3 01/14] i3c: master: Fix recursive locking during d=
evice registration ---
commit b974ff3a9bff008bbc487a2d9b2d24a4539bff06
Author: Adrian Hunter <adrian.hunter@intel.com>

i3c: master: Fix recursive locking during device registration

This commit fixes recursive locking during i3c device registration by
separating device creation from registration. It populates the device
under the maintenance lock, collects unregistered devices into a list,
and calls device_register() only after releasing the lock.

> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c

[ ... ]

> @@ -2104,25 +2113,37 @@ i3c_master_register_new_i3c_devs(struct i3c_maste=
r_controller *master)

[ ... ]

> +	i3c_bus_maintenance_unlock(&master->bus);
> +
> +	list_for_each_entry_safe(i3cdev, tmp, &i3c_unreg_devs, node) {
> +		ret =3D device_register(&i3cdev->dev);

[Severity: High]
This is a pre-existing issue, but does dropping the maintenance lock here
expose driver core callbacks to a use-after-free of i3cdev->desc?

When device_register() runs without the maintenance lock, synchronous driver
core callbacks like i3c_device_match() can locklessly dereference
i3cdev->desc:

drivers/i3c/master.c:i3c_device_match() {
    ...
    if (i3cdev->desc && i3cdev->desc->boardinfo)
        static_addr_method =3D i3cdev->desc->boardinfo->static_addr_method;
    ...
}

Concurrently, a hot-join event triggering dynamic address assignment (DAA)
could take the maintenance lock and free the old descriptor if it identifies
the device as a duplicate:

drivers/i3c/master.c:__i3c_master_add_i3c_dev_locked() {
    ...
    i3c_master_detach_i3c_dev(olddev);
    i3c_master_free_i3c_dev(olddev);
    ...
}

Could this sequence cause a use-after-free when the unlocked callback
races with DAA freeing the duplicate descriptor?

> +		if (ret)
> +			dev_err(&master->dev, "Failed to add I3C device (err =3D %d)\n", ret);
> +		else
> +			list_del_init(&i3cdev->node);
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804133810.1849=
05-1-adrian.hunter@intel.com?part=3D1
