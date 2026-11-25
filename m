Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795600007;
	b=gem/+ZIXcsXtSXecnyGNL4iImQwjY7SSGew1JTR2W/DOEWBeXPORYa7whfBlqvCwQOvB
	 z3ncHJ1TxQSvhS5Ht6k2T7GTjt0tC+P08CtMfUKdgetlW9jN5/cre8lizx76Mesmvtjpz
	 +e9lC2kGPU9KLZhN8NqUID9ls6Kvb2cPytoCEOvhWQy3HeM0/D9S4ewWmD2ad5jqafc+7
	 y9mkyo6jeI3gV17tT2WfggLy40nqqfDL8YIq2TQn5QYpu0J6KBngbXXijax/o45ujPJDm
	 e7BlvvRMOlW1x1wTQHZglq5DLPrbmoLFJTLXLWcGzu27eojyDzlUdsMu2gkEagyF6qA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795600007;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RWBoeh0cCfA0eWTMq5JvjQhZUGI96fnSZ7ClWVZscDU=;
	b=Et8S7J2nKX2lzPOKSWApLiCoBQ1MF0+HUEv+ktc2h3L/ePl+Q7NvT94TJFOCvtqPMKus
	 zdVhLvGPP8e5sbIxGum1W4SUoAF4tDgv4cX333Wm9hDbY4MlFH6dtIdMuZqkJbj9NIe/2
	 WflCNI+g3uDD6XTlhHAQD8/oq3XNNulPFhGfRYKV50z10gPBzCTfwbPjWnwzdltLWSPge
	 CI9bSEJbVu6EfSZgWAwsJJqi/M6UEBbw/VLVMOON4QBEwhbavwbVPd/vo86Vjer/2QCY6
	 dM/Y4YuEbzzffzRnzGlUiY9m9RUTRmE6VOzJn5bezC8BynBCtME/byhiGZsWr0T7MHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ALsxnhnv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C053606A32E;
	Wed, 25 Nov 2026 09:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ALsxnhnv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90AB21F000C6;
	Wed, 25 Nov 2026 09:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795600006;
	bh=RWBoeh0cCfA0eWTMq5JvjQhZUGI96fnSZ7ClWVZscDU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ALsxnhnvkAqyjTuADbB344pBK+fqbovKAUup0eUPhZmtbtNusKOnEC0n6fvp11ir6
	 twAwaXQLQdLsor/4Uv+v1/FrjJf0dwMM7fw8Zp2IHX1pjxbalnOJPTyPjKX78x3YVm
	 XGKAjrz1fXXH6yy2ByVG23AJeJO/l6fO1PQvMV/q5zoykHZvv8hysL3YAE6uwG8gpZ
	 9ddcA1N9VhqeuDWDhko0Q+3AYa2sxrAVxvOOo8D7nIisZSPmsWVhIqetjGoboJOWiz
	 kDSI13zBm1+DIZRpHXVqjeabmWhbdgjgKtAoAPGVIRuYSewwptRV8Ur3WMy2eIqxBi
	 3N7AdSZLEYFlQ==
Message-ID: <sashiko-outbox-233069@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 32/33] USB: Authorize interfaces through device trust
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-pci@vger.kernel.org, linux-sound@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261124-device-trust-core-v4-32-037eb0d17b1f@nvidia.com>
References: <20261124-device-trust-core-v4-0-037eb0d17b1f@nvidia.com>
 <20261124-device-trust-core-v4-32-037eb0d17b1f@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 09:46:46 +0000
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

commit 505017564cc702a2bd1b592d03460ab7095ffbb2
Author: Leon Romanovsky <leon@kernel.org>

USB: Authorize interfaces through device trust

This commit integrates USB interface default denial and authorization with
the device trust policy mechanism.

> diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
> index 1d488111a70fb..80f4d2644023b 100644
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

[Severity: Medium]
Can probing a deauthorized interface prematurely commit its lifetime trust
level before usb_probe_interface() rejects the bind?

Unlike usb_driver_claim_interface(), which checks iface->authorized before
calling device_trust_prepare(), the normal probe path runs
really_probe() -> device_trust_prepare() before calling
usb_probe_interface():

drivers/base/dd.c:really_probe() {
    ...
re_probe:
	ret =3D device_trust_prepare(dev, drv);
	if (ret) {
    ...
	ret =3D call_driver_probe(dev, drv);
    ...
}

If an unbound interface is deauthorized via sysfs (setting
intf->authorized =3D 0) and a matching driver probes it,
device_trust_prepare() applies any matching device_trust.driver=3D rule and
transitions dev->p->trust_state to DEVICE_TRUST_COMMITTED before
usb_probe_interface() returns -ENODEV.  The probe failure cleanup in
device_trust_clear() leaves trust_state committed.

Because trust_state is already committed by the rejected probe, subsequent
writes to the unbound interface's trust_policy sysfs attribute fail with
-EBUSY.  In addition, if a driver boot rule changed dev->trust_policy from
DEVICE_TRUST_POLICY_BLOCKED to DEVICE_TRUST_POLICY_ADVERSARIAL during that
failed probe, later re-authorizing the interface via
usb_authorize_interface() sees device_policy_is_blocked(dev) =3D=3D false a=
nd
skips requesting DEVICE_TRUST_POLICY_UNRESTRICTED.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124-device-tru=
st-core-v4-0-037eb0d17b1f@nvidia.com?part=3D32
