Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793813299;
	b=fHBmrQp+Kz1x0Nue06OZXz0Qaeg7Vo26LoX3IP824csgpT3JWtlrClwi+0b0RmuBa0e2
	 eSQtZ0D2dT0Eb7SUyU/AqSOOKJ2+b0/oFveX/5PJsXR1O7MJxzTTJ6x6VbO8MYO1ZHudb
	 ZDBP+BK8ryvYnQYkJnjvZGIDUaTe6eW65Ro+DfgA86yJoXisYCx0iSrTYTAnHFrhRMd8s
	 9aooMBG335ShuuNwv4wYgXHY+cA3AYCGjrdROcVBwZ4ES9GTbROwW1wDVXHT7LXwEfM9D
	 a58RceFmjgysS+UlI+2H0ep0YnKfB+gJnNQykO5uloY+FRI8g52HL9JoLvzUJEcH7bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793813299;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xz0NgmSr3mHgmniBSVGzbMxDflCFqn15cKTm4Urxf3s=;
	b=ntxbvt8TQ1+yp5ybH5P63yqamZ2Nrj57TzJ1rpqyfTAawp0G5l15xTkZmqWz0pGQ0iKv
	 qdhHsn0UUn79GvRzPDULSakRhzXovfAReIkax3B6FhxvTy8IkJT40kqfnoKI10p0Aa+ES
	 XN/b70oSQkGHwzemaZmJ8+YdjSoBefdWp43jzCylttvbs9qs5QHeeg1vzoJiI6tDuFJ6s
	 TD3hfxIjjmtOegZawRS+ONdhqD1DTHxxmWpNpe2EtnE7nVXai9YBAwLWh80qLWpFKI83M
	 zXYZJil+cv0TxS+8gsWXRs1cL47cdx3aQTPpQEBtc5hNJt+L61fRTHvn5UbuegGDOUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=elJPJR3p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D550A606A326
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 17:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=elJPJR3p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F0141F000C1;
	Wed,  4 Nov 2026 17:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793813298;
	bh=xz0NgmSr3mHgmniBSVGzbMxDflCFqn15cKTm4Urxf3s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=elJPJR3p8vY2sWyEe4fPn6YfgFdJI4ZYTt9Vci496UNiQYP73VWrhAhK6O8RyKs0I
	 SE3u0dw8iOwaCrPTvkM3rskLt/GeB5c8o7DN/VEuDKdOmhhCYQZ6uFEd8/iFFqUs3s
	 38vW6CUfFvehPcxJuPAtK0VJCa7bGU1AlhFZ1Wcxvd7ZQHGEuIrytJAVX96K+hDAaQ
	 4PirkWWXEyKclhPyST5jkf36dqF3c8V9/etgIjmKaIs4JNVrsaPpqcBSFLKb+qQ8EX
	 uTvoqZynw9j6bC8WgmAz34zlKpwif+9Z5CfOvxYDmCPEuloMH7l/MLgk4z/ATIOTzW
	 Q0hULJgUU1VhA==
Message-ID: <sashiko-outbox-197764@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] PCI: Avoid bus reset for Realtek RTL8126
Reply-To: sashiko-reviews@lists.linux.dev
To: "John Garry" <john.garry@arm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261103172758.1816004-1-john.garry@arm.com>
References: <20261103172758.1816004-1-john.garry@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 17:28:17 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] PCI: quirk_no_bus_reset() with DECLARE_PCI_FIXUP_FINAL runs too =
late
--

commit 6a48b331f38758a39c2143e3a32823e61b24d0c5
Author: John Garry <john.garry@arm.com>

PCI: Avoid bus reset for Realtek RTL8126

This commit adds a quirk_no_bus_reset() fixup for the Realtek RTL8126
(0x8126) PCI device to avoid bus-level resets that may fail to recover.

> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index fb3c5d517f91e..8346d223886a6 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3850,6 +3850,9 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ASMEDIA, 0x1=
164, quirk_no_bus_reset);
>  /* Intel DG1 0x4905 may not recover from bus reset */
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x4905, quirk_no_bus_reset=
);
> =20
> +/* Realtek RTL8126 may not recover from a bus reset */
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REALTEK, 0x8126, quirk_no_bus_rese=
t);

[Severity: Medium]
Should this use DECLARE_PCI_FIXUP_HEADER instead of
DECLARE_PCI_FIXUP_FINAL, matching the other quirk_no_bus_reset() entries?

During PCI enumeration in drivers/pci/probe.c, pci_device_add() runs header
fixups before probing and caching supported reset methods and registering
the device:

drivers/pci/probe.c:pci_device_add() {
	/* Fix up broken headers */
	pci_fixup_device(pci_fixup_header, dev);

	pci_reassigndev_resource_alignment(dev);

	pci_init_capabilities(dev);
		-> pci_init_reset_methods(dev);
	...
	ret =3D device_add(&dev->dev);
		-> pci_dev_reset_attr_is_visible()
}

Final fixups do not run until later in drivers/pci/bus.c:

drivers/pci/bus.c:pci_bus_add_device() {
	pci_fixup_device(pci_fixup_final, dev);
	...
}

Because PCI_DEV_FLAGS_NO_BUS_RESET is not set on dev->dev_flags when
pci_init_reset_methods() probes pci_reset_bus_function(), the bus reset
method still succeeds during probing and is recorded in
dev->reset_methods[].

As a result, when a Realtek RTL8126 is enumerated, reset_method in sysfs
still advertises bus, pci_dev_reset_attr_is_visible() still exposes the
reset attribute via pci_reset_supported() even when bus is the only reset
method, and calling pci_reset_function() still runs
pci_dev_save_and_disable() and pci_dev_restore() before
__pci_reset_function_locked() fails with -ENOTTY.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103172758.1816=
004-1-john.garry@arm.com?part=3D1
