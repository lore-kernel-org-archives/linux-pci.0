Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36714963CB
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2026 15:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778859120; cv=none; b=fmST1Pcg/y0CnsrSNhu2Eb0+SHW3F6URayZ1haLZ0DVYps+8EAJKjoUS6DjHfsFVeHwRIu/PaYaHCq9s5Ir9bF2fs6GF8RCas3pwxyJqhJb59NwbX/ov5mlpuUqi0S1+o1KEc++i/B9/WHjiHwxkPfn3tTtGrXItLBSXXEgdl58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778859120; c=relaxed/simple;
	bh=iJ+X1k3ReHy0+079hpACTN8UOiXWlhBqYhQenCGFNM8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EW9KKKG7nZcQ69kpoGFKccixmVdBL3NXqH2bWam3T6tTtVGj5M9iYToB84RDyFVTgspvrqSOiQtvBMKexw6qSkGRpv6wOvDabydG6tRcsYT8CB7W4r/tLX7Oj/+dkgiFRM5Tm3lNEWHu5SyWdv+yLXz613FJhFEBFyogOSd+03c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uZ9PXja3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uZ9PXja3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5348CC2BCC9;
	Fri, 15 May 2026 15:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778859120;
	bh=iJ+X1k3ReHy0+079hpACTN8UOiXWlhBqYhQenCGFNM8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=uZ9PXja3tz7Wc736CLIOKXIVwQvXKzC7Y0Vyrr+q5C8daBQFmaejKaoYg8k+haFS/
	 cxa5wNw2R8m9+LNSzHHw9TjcxOWWZxxuUrofgNZ8YtUoKXPtf513Ac+0KzJDgLwPxC
	 KRFTCGVgVuwzx6zCEIiPnXRfOJ1wIlSr3lggI5KZW4AOtcWL2J6G5W6c3kdE1vxwf4
	 GDuVkHMrkSDUd6kmVyjUtt1ZG33T9Dy4knNcxqaSr4vVEtHNJcmzBaiqAxSFR1b3k4
	 E8Wstqu/DcGnOuNql3H6XoC9Yz0/emCL3fpn9R2GEnpvgzSrrxviKshlZ7P70Ldf7t
	 FhMVJwHCDGu5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] powerpc/pci: Use official API to iterate over PCI
 buses
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gerd Bayer" <gbayer@linux.ibm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260515-priv_root_buses-v1-3-f8e393c57390@linux.ibm.com>
References: <20260515-priv_root_buses-v1-3-f8e393c57390@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 15:31:59 +0000
Message-Id: <20260515153200.5348CC2BCC9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Iterating over PCI buses inside the `pciconfig_iobase` syscall usi=
ng `pci_find_next_bus()` is vulnerable to Use-After-Free (UAF) due to concu=
rrent PCI hot-remove.
--

commit 84b1457ab2cb35e500a53ad0e4cc8f1330b88073
Author: Gerd Bayer <gbayer@linux.ibm.com>

powerpc/pci: Use official API to iterate over PCI buses

Replace iterating over pci_root_buses with the official
pci_find_next_bus() call provided by PCI core. This allows to make
pci_root_buses private to PCI core.

[ ... ]

> diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
> index e27342ef128b8..f816d063b984e 100644
> --- a/arch/powerpc/kernel/pci_64.c
> +++ b/arch/powerpc/kernel/pci_64.c
> @@ -248,7 +248,7 @@ SYSCALL_DEFINE3(pciconfig_iobase, long, which, unsign=
ed long, in_bus,
>  	 * used on pre-domains setup. We return the first match
>  	 */
> =20
> -	list_for_each_entry(tmp_bus, &pci_root_buses, node) {
> +	while ((tmp_bus =3D pci_find_next_bus(tmp_bus)) !=3D NULL) {
>  		if (in_bus >=3D tmp_bus->number &&
>  		    in_bus <=3D tmp_bus->busn_res.end) {
>  			bus =3D tmp_bus;

While the previous list_for_each_entry loop was also unprotected against
concurrent hot-removes, does the new pci_find_next_bus() loop still leave a
vulnerability to a use-after-free?

Since pciconfig_iobase is a syscall, it can execute concurrently with PCI
hotplug operations. The pci_find_next_bus() helper acquires and drops
pci_bus_sem internally, returning an unreferenced struct pci_bus pointer.

If a concurrent root bus hot-remove frees tmp_bus immediately after
pci_find_next_bus() releases the semaphore, wouldn't the accesses to
tmp_bus->number and tmp_bus->busn_res.end evaluate freed memory?

Furthermore, if the loop continues, could passing the freed pointer back in=
to
pci_find_next_bus() cause a crash when it evaluates from->node.next?

Would it be appropriate to hold pci_lock_rescan_remove() or acquire a refer=
ence
while traversing the buses here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515-priv_root_=
buses-v1-0-f8e393c57390@linux.ibm.com?part=3D3
