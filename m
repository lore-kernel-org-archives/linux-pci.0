Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795600003;
	b=jbmNcdH72v7SjGnhC7zQb+yUA1Cyyg7hh6gNf0uqwk9vOE42B9XJhQrEEefv/3+xF6Qx
	 AuWakmqP4XkpYEHH60Jk61N0u7G9G0haYo8Ur4CgvZ5gZopLbK2oQkEQPr9vjD6yF/eCJ
	 vUVmhrCfAVhHs00MEsv9a5RifFynqIJulysSt9dMPBVcaA8KeC3DIKMvsbjxLY8Vq+Xys
	 UKrK0nlCtnBVL8O4laIGaeMyeLDs6+P2hyKplOYxouJ6iRcIRV/zBsjWPcmN3yfCmqQb4
	 D+WitymravU1iYSfVnlesbsGPWWCpgDJ1b9ODjnTUwsDmL/EwPhHJ5LCRa0l3hMSdQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795600003;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QzqRUgTyBhlz9suA1i/JRSrrIHk7A9vU9+e0WTkccaI=;
	b=nyo4ygT5Iu19Z6FuNpsMOGpttfRjNrRnoGPDBuyi3IRIr5ES8KZ7JUCGrLdgTqqlXXgp
	 QwLMEABISCvYgjPW203ygXvk14q4W6O9dBj2FEtsXblJvkuq8hgA2DrgrFbDUyBGNDTY5
	 jVEcUTUFT+LWyKf39FyTYvD2H7HS0ETc7yDIb3mNbHhRFaLh2bGoBoxcDDG/yIFfgS0Pq
	 DdoKss8exscqP72PVLT044dyT/vudU/4T+CDLnka8BwQap2sRtoxnj7a5/gMrfltVjBdI
	 PyBo3PlX/YWv3ukxVV+BJGhlSIovMC6VctmGg0fniKnvg0Hb/rl3gEkKduF3/7VuDxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QCwRkOwL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157DC606A31E;
	Wed, 25 Nov 2026 09:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QCwRkOwL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E59331F000C0;
	Wed, 25 Nov 2026 09:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795600002;
	bh=QzqRUgTyBhlz9suA1i/JRSrrIHk7A9vU9+e0WTkccaI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QCwRkOwLouEsDt1R8L2XRV0Z04QLzfi+eOsil7m+bAhxUUgjqo2VUEnMcADZ1T8E9
	 8bbX08ZQc0Lmg/hz8oyiB/I07JhchjgNXizpRlRb6MZunDkL7SS4723sqtQ0kpXJ+F
	 wtdYFhPSOueYmwOe0KMdRMAlO1RPTEXmK3nDJpTr6e7/GB2LDKy1Ua18S316vTTwic
	 BaFttYmXi2luuOnWN/HA6tRD6CfmMY325/JKDJ9vvUC2IAoujQlhv6JLjbr4oUxR5I
	 3NTmbZkV2bgW4BZQ5ITOpPutbDzwEkO26kz2oo7KshoAtpMmDze/V6P9Zrbti+yifS
	 7eGeXWaxmie/w==
Message-ID: <sashiko-outbox-233043@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/33] USB: Reject usbfs connect requests for
 unregistered interfaces
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-pci@vger.kernel.org, linux-sound@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261124-device-trust-core-v4-6-037eb0d17b1f@nvidia.com>
References: <20261124-device-trust-core-v4-0-037eb0d17b1f@nvidia.com>
 <20261124-device-trust-core-v4-6-037eb0d17b1f@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 09:46:41 +0000
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
- [Low] usb: core: devio: incorrect Fixes trailer in commit message
--

commit ef85167342ae0257c27f5a71e468b1906042fdf9
Author: Leon Romanovsky <leon@kernel.org>

> USB: Reject usbfs connect requests for unregistered interfaces
>
> USB core does not register DT-disabled interfaces, and an interface whose
> registration failed stays in the active configuration. USBDEVFS_CONNECT
> still asks driver core to attach a driver to such an interface:
>
> proc_ioctl()
>   device_attach()
>     __device_attach()
>
> The interface has no driver-core private data, so the request
> dereferences a NULL pointer.
>
> Return -ENODEV for an unregistered interface. An interface claimed by a
> sibling driver keeps reporting -EBUSY.
>
> Fixes: ef0ff68351be ("driver core: Probe devices asynchronously instead o=
f the driver")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

[Severity: Low]
Is the Fixes tag accurate?

Commit ef0ff68351be ("driver core: Probe devices asynchronously instead of
the driver") only changed bus_add_driver() and __driver_attach(), which
iterate over already-registered devices on bus->p->klist_devices.  At that
point, __device_attach() on an unregistered device with dev->driver =3D=3D =
NULL
did not dereference dev->p and instead reached driver_probe_device(), which
returned -ENODEV on !device_is_registered(dev).

The unconditional dev->p->dead dereference at the top of __device_attach()
was added later by commit 654888327e9f ("driver core: Avoid binding drivers
to dead devices"), while skipping registration for DT-disabled USB
interfaces was introduced by commit 01fdf179f4b0 ("usb: core: skip
interfaces disabled in devicetree").

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124-device-tru=
st-core-v4-0-037eb0d17b1f@nvidia.com?part=3D6
