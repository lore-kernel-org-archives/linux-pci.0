Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C983DEAF6
	for <linux-pci@vger.kernel.org>; Fri,  7 Aug 2026 15:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786117076; cv=none; b=cJiWhkTrsCuCojRz58jyI8RyvycYcVqGs0mt54SFMPDSfl68bu/CwM1s1TwU5d4RtyVSa0z1zAgzI9v1PSfDJLZCa1brXYx9Lff/ryqqD0g1czqINc9d7VjeXj6ub5L6CEw+Iq9nqHgxvi2gucxyvaVJwWNLmGjCcuEomgI2Ms0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786117076; c=relaxed/simple;
	bh=v/fFT5eFjTNJO9E9qngkeCz9OfX7EkUidOwl3XB6jSQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nQB8iLpuLPVclPszHes0HQCZ7bFlxLPVYeNDCG9f+GBsCbVia8Z4aRMcqSvNgtaqibpXhSo3zdo+24EBojxoFT8UDtOGfRUEwGyThkqN2v6gyBynDB9F03XfQvYloTSZoqAVZhFJ3kAIcCio7alFMUfc5ud82Q36W+W1pC6TkCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJjTf1ky; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJjTf1ky"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 859531F00A3E;
	Fri,  7 Aug 2026 15:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786117074;
	bh=riTa3Zbq54AVhARcmN/uFqzfqv2PhOheVrOCKAtLRNA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aJjTf1kyw4UMF9UK5+WflERvANNU6oecLq6iJ0+KW3JfNpIp1uXdOLw7Ing3I4532
	 vb99/v8cwDxPE2MPoS+9KWNAT4k49u7jFXUFuzTBoylbYQpWeHRenvJR6YI3VE5kep
	 nhV89KlPZvwecSFqWKmawHent4f5VgCfNBfbaysNyNHZMnbLxuatwb1jLRkUVGUaKC
	 KadfgZuOXI/fOnjUU3dVeuuueDcudJl/1d5ulkI9lVApkBHler9e4pjLezPDKHE5Hf
	 dP1QqyTL5cBer5K4YaQOEm6SdKbcBJSwcyX0H1fbUPzPs0uI3z9jwC4iKWmXX2aci1
	 BUMvrNa38wfUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V5 07/14] i3c: master: Fix potential UAF in
 i3c_device_match()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, Frank.Li@kernel.org, linux-i3c@lists.infradead.org, linux-pci@vger.kernel.org
In-Reply-To: <20260807145638.168865-8-adrian.hunter@intel.com>
References: <20260807145638.168865-1-adrian.hunter@intel.com>
 <20260807145638.168865-8-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 15:37:54 +0000
Message-Id: <20260807153754.859531F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The removal of the `i3cdev->desc` NULL check introduces a determin=
istic NULL pointer dereference in `i3c_device_match` during concurrent driv=
er binding.

Pre-existing issues:
- [High] Incomplete fix: A Use-After-Free of the descriptor is still possib=
le during master unregistration because it executes locklessly.
--

--- Patch [7]: [PATCH V5 07/14] i3c: master: Fix potential UAF in i3c_devic=
e_match() ---
commit 8aa5de79b60445da0abee6c6a17c70b1b9ec8be9
Author: Adrian Hunter <adrian.hunter@intel.com>

i3c: master: Fix potential UAF in i3c_device_match()

i3c_device_match() dereferences i3cdev->desc without holding the bus
normal-use lock.  Since the descriptor pointer can be replaced
concurrently, the dereference can race with descriptor replacement and
result in a use-after-free.

Protect access to i3cdev->desc with the normal-use lock.  While the lock
is held, the descriptor is guaranteed to remain valid, so the NULL check
is also unnecessary and can be removed.

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
Can removing this NULL check lead to a NULL pointer dereference during
concurrent driver binding?

Looking at master unregistration, the descriptor pointer is cleared
locklessly:

drivers/i3c/master.c:i3c_master_unregister_i3c_devs() {
        ...
        i3cdev->dev->desc =3D NULL;
        ...
}

If a concurrent sysfs bind operation triggers i3c_device_match(), it might
acquire the read lock but still observe a NULL descriptor since unregistrat=
ion
does not acquire i3c_bus_normaluse_lock(). Does the removed NULL check
now guarantee a crash in this race condition?

[Severity: High]
This is a pre-existing issue, but does taking the normal-use lock fully
prevent the use-after-free this patch aims to fix?

Master unregistration modifies and initiates cleanup of descriptors without
acquiring any bus locks, bypassing this protection entirely:

drivers/i3c/master.c:i3c_master_bus_cleanup() {
        ...
        i3c_master_detach_free_devs(master);
        ...
}

If a concurrent sysfs bind operation reads i3cdev->desc just before it is
cleared, the read lock here doesn't seem to serialize against the
unregistration thread proceeding to free the descriptor. Can the descriptor
still be freed while i3c_device_match() is dereferencing it?

>  		static_addr_method =3D i3cdev->desc->boardinfo->static_addr_method;
> +	i3c_bus_normaluse_unlock(i3cdev->bus);
> =20
>  	/*
>  	 * SETAASA-based devices need not always have a matching ID since

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807145638.1688=
65-1-adrian.hunter@intel.com?part=3D7
