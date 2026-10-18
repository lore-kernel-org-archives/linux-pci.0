Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55E23BF684;
	Sun, 18 Oct 2026 16:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792342038; cv=none; b=suGix1+mczOssvITLilIles+GIvrqpMdr2siRHUHCyNASXfHYl6KtcjZVpSUCe7XyXWcltYNnJA/rHF8K2XtM4VcxFqQ34w4c0TK0NtjHI3aGvhzYkFVVVhPZFNOiPR+dWIDViYHAjJT9AcbfYXxALxljvyLDRgB0KNaOfQEPeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792342038; c=relaxed/simple;
	bh=isU0Ku3imsd4vWs+kxfBGwUjKzROuG4ArDI6zLFet+I=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=mp2XMqCdZz8YpFZw08arZ0q9pJPj+z7W93GuHu5rcEnO4MhD+AAusdpnh+E1FXhiiyP3hou9AUwKabrDj0lFoHpaQPD24BlJ2gmdcP/aK0x6z4vINAgntbw8fwgcULYRUNsJjpUqBtl6hkOi4UPp6gg/bqsz1We4QlZf+sx12aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VmB7kGTT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VmB7kGTT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 082F11F000C4;
	Sun, 18 Oct 2026 16:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792342035;
	bh=1cAAGTlZsG+dIC1kWnvlbj8WRGLKlwHJMqx+2z1sasY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VmB7kGTTaRjuaYW1yJr5oGFt5qHEXZ0GfX7wfbWN97v23UjuCXT+W+cCtUxD/Wrju
	 gxAPvissch8BjVJbsX5ETObtvVkqJFKPjcZwXz7Ki8jCbM/YHpHbgDGTqYa6wjBjd/
	 3w+jiUk0O6ulXdR8clXXROCXEY0BEc8dgsvipvIGBqiayBVW9Dr561Nkd55xWwzRuw
	 WIh8BAQ5fLRPeyzqMs6wR2YiEts8BfRKPL1M9dT8uPprftAox9NkYizjYCk2Frkqu4
	 tdpfNBRkFg7UKWG10tk8D/cdUr+wycMBA74f73cxHS1T9VcoCwGrN8hbNAB5ELrdmU
	 oVxSTw93andZg==
Message-ID: <sashiko-outbox-176295@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] PCI: pciehp: Defer device replacement handling
 until ->resume()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cole Leavitt" <cole@unwrap.rs>
Cc: linux-pci@vger.kernel.org, linux-usb@vger.kernel.org
In-Reply-To: <20261018163910.132231-1-cole@unwrap.rs>
References: <20261018163750.130470-1-cole@unwrap.rs>
 <20261018163910.132231-1-cole@unwrap.rs>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 16:47:14 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> On a Lenovo ThinkPad P16 Gen3 with a discrete Thunderbolt 5 host
> controller (Intel JHL9580 "Barlow Ridge") below Root Port 0000:80:1b.4,
> resume from suspend-to-idle intermittently hangs with a black screen:
>=20
>   pcieport 0000:80:1b.4: Data Link Layer Link Active not set in 100 msec
>   pcieport 0000:80:1b.4: pciehp: Slot(25): Card not present
>   thunderbolt 0000:8a:00.0: RX ring 0 already stopped
>   ...
>   Oops: general protection fault, kernel NULL pointer dereference 0x32b
>   Workqueue: async async_run_entry_fn
>   RIP: 0010:tb_resume_noirq+0x3f/0x2e0 [thunderbolt]
>   Call Trace:
>    tb_domain_resume_noirq+0x42/0x60 [thunderbolt]
>    dpm_run_callback+0x4b/0x140
>    device_resume_noirq+0x16d/0x2c0
> [ ... ]
> followed by ->resume(), so resume from hibernation is fixed as well.
>=20
> Fixes: 9d573d19547b ("PCI: pciehp: Detect device replacement during syste=
m sleep")
> Cc: stable@vger.kernel.org # v6.11+
> Signed-off-by: Cole Leavitt <cole@unwrap.rs>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018163910.1322=
31-1-cole@unwrap.rs?part=3D1

