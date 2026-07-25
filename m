Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4AB2EEE8C
	for <linux-pci@vger.kernel.org>; Sat, 25 Jul 2026 10:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784977057; cv=none; b=BtDABPWM/6du7+mj9EgpzaW5ZGOEuphFrluKB7Y6D2GpjsrO48YA22Wd9QSzucinej4CSVT+O50XYefuvGCTTzCHLzohrNuF84MlVC9H3zZ/6tuCrcu0nOxHIUC4Pj0pWTDuYXQJsO317nKHE7m0VZPDhg4I4+Vski6vZ+qTYQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784977057; c=relaxed/simple;
	bh=L3Xp+7TpwcHXF07qty8MKaTdhvVv9bmPbZpcgXcK4XQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hzYziyieJcTEXYRM6gkRALj9FmaTmFXIx3hiJ58by6PGsr9FuI9+bXUy8NdSr5LgH1PCdnv2xGlPaDEWiXcqp883Tb8FjOOjSUDmw1tyU78BJXPYHMoBOAqbaJgGexUqDSqc8EigNkK10gDJwFh78bD2Vu8yO+He2MRyVIvCguc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHs5Kd1k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHs5Kd1k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C6C1F000E9;
	Sat, 25 Jul 2026 10:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784977056;
	bh=lhQQAljfxogViiWRU/V5YnfMYKzvX035NQvm+Uck+y8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FHs5Kd1k+YscMVBiNtPedqywsovTvaiv5zkI+gLBP0djczFMRxZc+oW6GyaLhrmPy
	 Fg+n1lzKeqFgTqFjLnAU8NFDQIzM7sj27yY1Pqa5wzg1656zBelQ7476FddxJskRoE
	 G7pu+66XVj60qxHoubdaqqxheOy0BmEBcCoWiT3Lx/fAWX/6zjPPIG1GKPQWsLUA/h
	 zcbh4ylCGqcHvMBY1dma+YHQs/hdQoF/Kqh5ux1ob5jsfyspM/Ubcp4uZKdR/cwrl1
	 2Bkd2R0/DHX6Z0Bj9L/Zbyr8F2QRFqdI7RB3sU7DRMyoiBUPWtKrWAhzySKS33wcNt
	 UQjBhbLsZBR6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Handle dev_set_name() failure in
 pci_setup_device()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rihyeon Kim" <rihyeon8648@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260725104747.226575-1-rihyeon8648@gmail.com>
References: <20260725104747.226575-1-rihyeon8648@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 10:57:35 +0000
Message-Id: <20260725105735.F3C6C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unhandled device_add() failure in pci_device_add() leaves a corrup=
t device on bus->devices, triggering NULL pointer dereferences.
--

--- Patch [1]: [PATCH] PCI: Handle dev_set_name() failure in pci_setup_devi=
ce() ---
commit a0f24b9a341960f58d26143c84bb644d8d2b737e
Author: Rihyeon Kim <rihyeon8648@gmail.com>

PCI: Handle dev_set_name() failure in pci_setup_device()

This commit checks the return value of dev_set_name() during
pci_setup_device() to prevent enumeration of unnamed devices. By
propagating the error early, it avoids a later failure in device_add()
that would trigger a NULL pointer dereference.

Reported-by: syzbot+87bb32e345aa80c0554b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3D87bb32e345aa80c0554b
Tested-by: syzbot+87bb32e345aa80c0554b@syzkaller.appspotmail.com

> Two things I noticed while working on this and deliberately left alone,
> since they look like separate changes:

[ ... ]

> - pci_device_add() ignores device_add() failure entirely; the WARN_ON() is
>   all there is and the half-added device stays on bus->devices.  I built a
>   kernel with [2] applied (it stops device_add() from freeing dev->p) and
>   the NULL dereference above does go away, but the WARNING and the stale
>   bus->devices entry remain.  Happy to follow up on that separately if you
>   think it is worth doing.

[Severity: High]
This is a pre-existing issue, but should the failure of device_add() in
pci_device_add() be handled with explicit error paths instead of just
emitting a warning?

When device_add() fails, it cleans up and frees dev->p:

drivers/pci/probe.c:pci_device_add() {
    ...
    ret =3D device_add(&dev->dev);
    WARN_ON(ret < 0);
    ...
}

Leaving the initialized device on the globally visible bus->devices list
allows pci_bus_add_devices() to iterate over it and pass it to
__device_attach().

Could this result in a kernel panic when __device_attach() unconditionally
dereferences the freed dev->p?

> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index dd0abbc63e18d..474c6cb327be5 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725104747.2265=
75-1-rihyeon8648@gmail.com?part=3D1
