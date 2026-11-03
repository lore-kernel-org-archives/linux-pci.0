Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793731318;
	b=XMUDCQwvo9aehiTr02lDzASSFMlXLIv18vhkZUNSXtDvm70zmmtfHihoiX5pLHW9pmz0
	 c/m2Cc5mk8vq/KignB/dbSH6Ye+JZe0gxCLP4dIB24fBuYFDt1/B/sH8BlX+WN7AUj2UY
	 kJ60qmd6BHTm6qJYcMx79SqS261f5Zfnu8wEq2+sWmYmk0JPXupDCnRAsj8YEqF+GApWv
	 UsLQus7xODiTsEIcdwdbrGK36d2A65sxzksqn/msDa7fRVwO8fHWov4HmoUl/QCGNnH5I
	 GFTJuC9ncFiH8+CShXC/6rIod1alQ8Z3J/um4cdyrQrLKIXxOD7TJkFKD1qrFLy4CJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793731318;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UJx7EBdvJZ4u/8KMy+260Wc+rYWlh6xxoGqa62UoP2k=;
	b=aUdO5Z32Q6ykacpctJRph0GEVawUkeU4ea6YHTERXOVy7ejy/ia2tT4xRbhq0U7cyRgn
	 yVacmDFtV/RzdyzRx5e3y0jZVlGkeozHki/r07xopPOHYr6Z+MqkXbNQ89OMpqAf7Bo6h
	 VxAvypLLDwYwEAyEJLjxVzQhxoOKqmV8UQzQT6ARxMTBtIrosjh7jHR3g4d72jRWb+O5N
	 1dolMJ7j+DliWkVm4BtmCkjiyQayKM591Zs5Fkv5cVKGBaRXXbXVyluMfiaGRNYbQJnNS
	 mO9miRoRijSVi3FYo6g14BXFFsDHVqSz6Dz0iud84Ro77xSpKkdgb6BMoG4WwAU9sqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ETEhkKaV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021DE606A324
	for <linux-pci@vger.kernel.org>; Tue,  3 Nov 2026 18:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ETEhkKaV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 715121F000C1;
	Tue,  3 Nov 2026 18:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793731317;
	bh=UJx7EBdvJZ4u/8KMy+260Wc+rYWlh6xxoGqa62UoP2k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ETEhkKaV5pXlwSoRwYuiAMksf4XTlhjepDUaNAeC6/t0KKXxeu2hz+RA28SZlMFsF
	 msobw/UO2sqh+gGW6XH1s5kzOXHDL/6H+SXhyg0xFvyTVKiUGlwXKG9B3L2MECW2tA
	 dF50CgGOLHGJNoJrgCdK5FAFX8foeK9meAcN4lAnCDulRvFGsgMDKyXz6Ia4vV1a2m
	 cJ3n2A8NS09tVOtl6h4mp8/ClRM8/tQhJrQ+Kj4XsgwcMVwWr8lKWWs5MG1q6G+MdN
	 xYG+0HfmgDufpsHok4fYnP97mdV0NWno7d3koEIQg/764Dti/xl3Ai60iWuB6zBS9A
	 Pi0emM/xhyLYA==
Message-ID: <sashiko-outbox-195855@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 2/2] PCI: Allow hpbussize for specific hotplug
 bridges
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maciej Grochowski" <Maciej.Grochowski@sony.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <4ba0c23099e4a4f5ade2b4754871dfbcf896f7dc.1793724065.git.Maciej.Grochowski@sony.com>
References: <cover.1793724065.git.Maciej.Grochowski@sony.com>
 <4ba0c23099e4a4f5ade2b4754871dfbcf896f7dc.1793724065.git.Maciej.Grochowski@sony.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 18:41:56 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] PCI: child bus extension in pci_scan_child_bus_extend() steals sib=
ling buses
- [Medium] PCI: unsigned underflow clamping buses in pci_scan_child_bus_ext=
end()
--

commit be51a5abd9a8e4940755184950c4647a492d014d
Author: Maciej Grochowski <maciej.grochowski@sony.com>

PCI: Allow hpbussize for specific hotplug bridges

This commit extends the pci=3Dhpbussize=3D boot parameter to accept per-bri=
dge
bus count reservations in the form <count>@<pci_dev>, recomputing the
share of spare bus numbers for unconfigured hotplug bridges on a bus and
applying the scoped minimum when scanning the bridge's child bus.

> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 9a178e0e5f7f4..b79a931edce55 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c

[ ... ]

> @@ -3163,7 +3228,16 @@ static unsigned int pci_scan_child_bus_extend(stru=
ct pci_bus *bus,
>  			 * Distribute the extra buses between hotplug
>  			 * bridges if any.
>  			 */
> -			buses =3D available_buses / hotplug_bridges;
> +			if (hotplug_reserve && available_buses) {
> +				if (!dev->subordinate) {
> +					reserve =3D pci_hotplug_bus_reserve(dev);
> +					buses =3D available_buses + 1 > used_buses ?
> +						available_buses + 1 - used_buses : 0;
> +					buses =3D pci_hotplug_bus_share(bus, dev, buses);
> +				}
> +			} else {
> +				buses =3D available_buses / hotplug_bridges;
> +			}
>  			buses =3D min(buses, available_buses - used_buses + 1);
>  		}

[Severity: Medium]
Can available_buses - used_buses + 1 underflow in unsigned arithmetic here?

Before calling pci_hotplug_bus_share(), this checks whether
available_buses + 1 > used_buses and passes 0 when used_buses is larger
(for example, when SR-IOV buses plus the one-bus-per-bridge count from the
first pass exceed available_buses + 1, or after earlier bridges consumed
more buses than available_buses).

However, pci_hotplug_bus_share() unconditionally returns at least reserve:

    reserve =3D pci_hotplug_bus_reserve(bridge) ?: pci_hotplug_bus_size;
    return max(reserve, share);

When min(buses, available_buses - used_buses + 1) then runs without that
guard, available_buses - used_buses + 1 wraps around to a large unsigned
value, leaving the non-zero buses count from pci_hotplug_bus_share()
unclamped instead of clamping it to 0.

> =20
>  		cmax =3D max;
>  		max =3D pci_scan_bridge_extend(bus, dev, cmax, buses, 1);
>  		/* One bus is already accounted so don't add it again */
>  		if (max - cmax > 1)
>  			used_buses +=3D max - cmax - 1;
> +
> +		if (reserve > max - cmax)
> +			pci_warn(dev, "only %u of %u bus numbers available\n",
> +				 max - cmax, reserve);
> +		else if (reserve)
> +			pci_info(dev, "reserving %u bus numbers\n", max - cmax);
>  	}
> =20
>  	/*
> @@ -3180,7 +3260,10 @@ static unsigned int pci_scan_child_bus_extend(stru=
ct pci_bus *bus,
>  	 * bus number if there is room.
>  	 */
>  	if (bus->self && bus->self->is_hotplug_bridge) {
> -		used_buses =3D max(available_buses, pci_hotplug_bus_size - 1);
> +		unsigned long bus_size =3D pci_hotplug_bus_reserve(bus->self) ?:
> +					 pci_hotplug_bus_size;
> +
> +		used_buses =3D max(available_buses, bus_size - 1);

[Severity: High]
When a hotplug bridge's scoped reservation is clamped by the parent bus in
pci_scan_child_bus_extend() so that 1 bus number remains per subsequent
sibling bridge, won't taking max(available_buses, bus_size - 1) on the
child bus override that clamp and consume the sibling bridges' buses?

On the parent bus, pci_scan_child_bus_extend() clamps the bridge's share
via:

    buses =3D min(buses, available_buses - used_buses + 1);

and passes that clamped count to pci_scan_bridge_extend(). In pass 1,
pci_scan_bridge_extend() creates the child bus with its temporary end set
to the parent's busn_res.end before recursing:

    pci_bus_insert_busn_res(child, next_busnr,
                            bus->busn_res.end);
    ...
    if (available_buses)
        available_buses--;
    ...
    max =3D pci_scan_child_bus_extend(child, available_buses);

Inside the recursive pci_scan_child_bus_extend(child, available_buses)
call, bus->self is that hotplug bridge. Using max(available_buses,
bus_size - 1) replaces the parent-clamped available_buses with the
unclamped bus_size - 1, and only bounds max =3D start + used_buses against
child->busn_res.end (which is still the parent bus's busn_res.end).

For example, if 5 hotplug downstream ports share 15 buses and port 3
requests hpbussize=3D12 after ports 0..2 take 1 bus each, the parent clamps
port 3 to 11 buses so 1 bus remains for port 4. In the child scan for port
3, available_buses is 10 while bus_size - 1 is 11, so max(10, 11) extends
port 3 all the way to the parent's busn_res.end, leaving no bus number for
port 4 and suppressing the "only %u of %u bus numbers available" warning.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793724065.gi=
t.Maciej.Grochowski@sony.com?part=3D2
