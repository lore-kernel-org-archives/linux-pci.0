Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793731430;
	b=O5dTsrs422JQMlpcOwH7fgvtspXPeedMee9dE4vmFdv3Aj6C0WXsbNMCpvcmtq8V2FT7
	 VaocGKQofP39tUnNuoCtHMV098LEUN7EQILoWcWb33+g4IKIdioxxUb3kLwlrkeeWOSau
	 vLkb/O/4v3z7NH43lIJgiOa1t0RrpxFftIyNmESEfHUZn6AIjX/y2rm39FE+GOfI3PJVr
	 sTM+sAhhRatK6u7GzctDAhYJpEz7CfKWc4D8HVCfUe6kuyfhnQ3hNSwPj0kwLsphf1F4X
	 CsOg3FoQkzgu0GZ/lYyW56t7Gg1vbdf8egdk1WDwQqRXHVpJbk8y/96pKa0g8yT8ejA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793731430;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2ELIPUxdYCas+giNcZHXG1XyrnNeubGowCuapGpU38I=;
	b=tDlM41tYiWGM7kvNUFFYZ/6WnHMjzNSqWJX2uqpew8bXCvSWbcuJ3VeuhoyapPnU+G+g
	 01zCcWuG/m6YRBt2SFU8WKAbH5sIhWOlYs8lgUUeXZnxo68QZIT6WnNDEWb2HeZGqz5s2
	 Xq9tstR3x80JSf921N11wxhoMlGcqeLnOJtHwDE693eoMOEabpN0jC40lFlulq+imu8jn
	 fu/7oW0znrDWwHnTkxpLj3k5BG0o22agsnNKDPziR9esvcUmQlFwjyb/JdEr2FqAgc76I
	 sXEYHyo0vE6rxkExHJWV5cXHdgL/24GlbMbomB91ajhAw0u/wr4ZGQCMeHL7wMsi+9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="QDh51/pT";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1057A606A326
	for <linux-pci@vger.kernel.org>; Tue,  3 Nov 2026 18:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QDh51/pT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DFD01F000C1;
	Tue,  3 Nov 2026 18:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793731429;
	bh=2ELIPUxdYCas+giNcZHXG1XyrnNeubGowCuapGpU38I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QDh51/pTwULs7nNLO/FXmDWaGzQlSn/VM3+lsfcnXx8kl6AYPem40MTyfOHspBUFn
	 wnF4mSrfk6agxyGGUa3U3x1mdQArWOpo9RSdebBZX3D15KCY0oLE0z3pvgLIsM6ktB
	 AOG3K81BO4e5q8LPMhfF0hrWQUluIyJkd/C5CGkC//KPoBfLlvkprsrdFa0U9yWIW6
	 9JTlr7bLmq0M7AKBVaPS2EPrxx8FVg9TmGejpx3ZC56ZMCEpqsm/CBfdYJuLD26Ov/
	 RgYryH5N7K2t+GvoIEpCjG1V0+oQqupI+HtDTc/rCc5xSC208zs4gSzgtktufC7SU+
	 Mdvgo16Hzt6cQ==
Message-ID: <sashiko-outbox-195857@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 1/2] PCI: Allow hpmmiosize and hpmmioprefsize for
 specific hotplug bridges
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maciej Grochowski" <Maciej.Grochowski@sony.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <7d68c3c861a92c944bcba84b0096f16550ca0403.1793724065.git.Maciej.Grochowski@sony.com>
References: <cover.1793724065.git.Maciej.Grochowski@sony.com>
 <7d68c3c861a92c944bcba84b0096f16550ca0403.1793724065.git.Maciej.Grochowski@sony.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 18:43:49 +0000
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
- [Medium] PCI: pbus_size_mem() adds children_add_size on top of scoped hp_=
size
--

commit 926f817ace771cfa772ae856e4b49cefab5e63e8
Author: Maciej Grochowski <maciej.grochowski@sony.com>

PCI: Allow hpmmiosize and hpmmioprefsize for specific hotplug bridges

This commit extends the pci=3Dhpmmiosize=3D and pci=3Dhpmmioprefsize=3D boot
parameters to accept per-bridge <size>@<pci_dev> entries, applying the
specified size as a required minimum window size and head alignment in
pbus_size_mem().

> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index ed16ef7c26fa7..f3992859d90f2 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
[ ... ]
> @@ -1349,6 +1351,27 @@ static void pbus_size_mem(struct pci_bus *bus, str=
uct resource *b_res,
>  	win_align =3D pci_min_window_alignment(bus, b_res->flags);
>  	min_align =3D calculate_head_align(aligns, max_order);
>  	min_align =3D max(min_align, win_align);
> +
> +	/*
> +	 * A hotplug size given for this bridge is a required minimum, not
> +	 * optional space like the global size: aligned for the largest BAR
> +	 * that fits in it, so it is in place before the devices that need
> +	 * it appear below the bridge.
> +	 */
> +	if (bus->self &&
> +	    pci_hotplug_dev_size(bus->self, b_res->flags, &hp_size)) {
> +		if (hp_size) {
> +			size =3D max(size, hp_size);
> +			min_align =3D max_t(resource_size_t, min_align,
> +					  rounddown_pow_of_two(hp_size));
> +			pci_info(bus->self, "bridge window to %pR: reserving %s size %#lx ali=
gn %#llx\n",
> +				 &bus->busn_res,
> +				 b_res->flags & IORESOURCE_PREFETCH ?
> +				 "prefetchable" : "non-prefetchable",
> +				 hp_size, (unsigned long long)min_align);
> +		}
> +	}
> +
>  	size0 =3D calculate_memsize(size, realloc_head ? 0 : add_size,
>  				  0, win_align);

[Severity: Medium]
In pbus_size_mem(), when realloc_head is non-NULL, required child resources
are summed into size while optional child resources (such as child hotplug
bridges, SR-IOV BARs, or disabled ROMs) are accumulated into
children_add_size via pbus_size_mem_optional().

Subsequently, size1 is calculated as:

	if (realloc_head && (add_size > 0 || children_add_size > 0)) {
		add_align =3D max(min_align, add_align);
		size1 =3D calculate_memsize(size, add_size, children_add_size,
					  win_align);
	}

where calculate_memsize() computes max(size + children_add_size, min_size).

Because size is overwritten with max(size, hp_size) before size1 is
calculated, doesn't calculate_memsize() add children_add_size on top of
hp_size rather than fitting those optional child resources within the
hp_size minimum window? When hp_size > size and children_add_size > 0, size1
becomes ALIGN(hp_size + children_add_size, win_align) even when
size + children_add_size <=3D hp_size, queueing an extra add_size =3D size1=
 -
size0 on realloc_head.

By contrast, when realloc_head is NULL (such as in earlier passes of
pci_assign_unassigned_root_bus_resources() with pci=3Drealloc),
pbus_size_mem_optional() returns false and optional child resources are
summed into size before size =3D max(size, hp_size), so they fit within
hp_size.

Would it make sense to keep size as the sum of required child resources and
apply hp_size as a minimum to size0 and size1 instead (for example, passing
max(add_size, hp_size) as min_size when computing size1)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793724065.gi=
t.Maciej.Grochowski@sony.com?part=3D1
