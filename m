Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116590;
	b=bbS5/jkUWmQexxe6Q9UFK6+695jbLv0yGdctkgJIi70O144u9D8l80n3HlN3q/PprmMl
	 XWYMjuZ7OUq1ukD9PVSZnLCY1i8PIv+NQGtJBjHCu31C8Ely6KkcSeQO9cWdV0msXhriA
	 8rKtQ7w4U/cce2qTPaWuDuvefKFZM3PNwdORoZ0iDLHOAMW24JDhk9YGXcMcqrOuBjL7J
	 rp9OhzGj5763QqP0B0M0ZKGUtMH809fOjPaoj3owRW4+JRkoN0jVtRrLVrrvMZwjmMO3u
	 8xe1cHK/rrk2mAbcIMZzX71W8c6OVs1E9ald40gzAiCM2hwm+6VFs4vvT94sLoXhQ/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116590;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=a7N6XI5tnWVu04dgbEmMT0qwZEoTYg97lxHt2jFcuW8=;
	b=QJDhkVAAzzn714Ur81l9LEQffF6sahXVPx7Qb2thG9CrP93ErwLq1MV2J6P4xAVzRWGG
	 Fzt46PBShTJIIE3Z+Ff9+G6np/qUhDGjbrrfttHT8IEOatr6gjZRnRJLRZ1pP0Vf1lSk/
	 5leiLDCLsncBpSeIrSf8tF268jD1deyuBBH+lIWBAVUwNBKyCuL3SdiL9i67DOzq17MfO
	 jXl+q3mbxIw54eDlLUPKeE7iQvAdiEmivh49ahdPM32og9eCx5ypMYWUFEI1ULxwu4Ocr
	 niLsHhzUFgXyx9YnWQ+CEJgmqlX9dOAcGHmztbTvv1Een9bwqw9qypPwpVqlMizFDOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nMr9hL7d;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0471160A6F4E;
	Thu, 19 Nov 2026 19:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nMr9hL7d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 489941F000C6;
	Thu, 19 Nov 2026 19:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795116589;
	bh=a7N6XI5tnWVu04dgbEmMT0qwZEoTYg97lxHt2jFcuW8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nMr9hL7dFikXV5fEdJpOerhYQy/LNGDvI2hdiL+nrbn77Ds+WSzJSvF3vTfnAtsRM
	 H72sq1yW3xdjQ578oTu4Chg+ljytTyCV5DygokFKAfJSAQCzJXBmt6r++9CxQ0jCjW
	 NmktVnCWtoNwXMj8u3x/57a82bv6mrxmOFIY4uQuofMkAEPKo9yEEEQgLIlw91dSyF
	 OPFRNt2nUskDQbTxMrdqJLtRkYtB2iy2ik4if6yJljsUNIIDOS/1WzB/j4DbBh487P
	 tnLjGtWpYwWcVaT5Ewr5jQlgCdlHULD2KNL/9dXs3UjqLrsLyGB1+0lWtDTDT9YZ5M
	 5vo/1dM/Bfm7Q==
Message-ID: <sashiko-outbox-223916@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 30/31] USB: Authorize interfaces through device trust
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-pci@vger.kernel.org, linux-sound@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261118-device-trust-core-v3-30-d655875c4bfb@nvidia.com>
References: <20261118-device-trust-core-v3-0-d655875c4bfb@nvidia.com>
 <20261118-device-trust-core-v3-30-d655875c4bfb@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:29:48 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] usb: core: premature trust commit before
  usb_probe_interface() auth check
--

commit 29b5c9488497851706870c3e7bbd46c2212bd153
Author: Leon Romanovsky <leon@kernel.org>

USB: Authorize interfaces through device trust

This commit integrates USB interface authorization with device trust by
initializing default-denied interfaces to the blocked trust policy when
device trust is enabled and requesting the unrestricted policy when
authorizing an interface.

> diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
> index b10b80b5fd6d4..893bcdb430878 100644
> --- a/drivers/usb/core/driver.c
> +++ b/drivers/usb/core/driver.c
> @@ -338,7 +338,7 @@ static int usb_probe_interface(struct device *dev)
>  	if (udev->authorized =3D=3D 0) {
>  		dev_info(&intf->dev, "Device is not authorized for usage\n");
>  		return error;
> -	} else if (intf->authorized =3D=3D 0) {
> +	} else if (!usb_interface_authorized(intf)) {
>  		dev_info(&intf->dev, "Interface %d is not authorized for usage\n",
>  				intf->altsetting->desc.bInterfaceNumber);
>  		return error;
>  	}

[Severity: Medium]
Can probing a deauthorized interface prematurely commit its trust level bef=
ore
usb_probe_interface() rejects the probe?

Unlike usb_driver_claim_interface(), which checks !iface->authorized before
calling device_trust_prepare(), the normal probe path matches in
usb_device_match() without checking authorization, and really_probe() then
runs device_trust_prepare() before invoking call_driver_probe() ->
usb_probe_interface().

If an unbound interface is deauthorized via sysfs (setting intf->authorized=
 to
0 while its trust policy is not blocked, or when a matching
device_trust.driver=3D rule applies a non-blocked policy) and a driver prob=
es it,
device_trust_prepare() permanently sets dev->p->trust_state to
DEVICE_TRUST_COMMITTED before usb_probe_interface() returns -ENODEV. Later
writes to trust_policy on the unbound interface then fail with -EBUSY, and =
if
a driver boot rule changed dev->trust_policy from DEVICE_TRUST_POLICY_BLOCK=
ED
to DEVICE_TRUST_POLICY_ADVERSARY during that rejected probe,
usb_authorize_interface() sees device_policy_is_blocked(dev) as false and s=
kips
requesting DEVICE_TRUST_POLICY_UNRESTRICTED.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-device-tru=
st-core-v3-0-d655875c4bfb@nvidia.com?part=3D30
