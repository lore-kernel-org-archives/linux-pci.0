Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF92437FF53
	for <linux-pci@vger.kernel.org>; Sat,  3 Oct 2026 01:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991234; cv=none; b=Q98xp/5yvy2RhiVzgLDjKEHjmY0JIduPYn4KhyProgSUmqD122yXWcBQOJt24DvaYsTkcad6AxIKPmdFW+dJOtuoB7oyS39RF+5iouHHrdNbdOldHoHWaxRnF6By6wEUZtMIUnFexpPwpY5gS46fLExHYEttrvew/n7m/agHQ88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991234; c=relaxed/simple;
	bh=QurYEiWjievQXHC84toNzrTw0xgU781Ibh+FuyASalo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C4okFq7D/6K3fzqx3y6drkJrGqWk5TY9a8PW0RBgPVsa8u4xwwvMJ3Vw8WvTTqjhzhD+8LmGM/zXqPFqmRACgaWgNM9jZA8ZnYQPv4YIhwGitKa4LiyPND+QKYJvBNY0jszbluAGDLI0mSKGYdAhR4GU9bHdAMMUqjNezXQDWYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aaz+71Eb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aaz+71Eb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8C831F0089D;
	Sat,  3 Oct 2026 01:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790991232;
	bh=xJLnC0yQ2D3VYTuwE5LnvvcuKU4iVbg6cwzSkt6MgBE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Aaz+71EbB78gLYyS+gLXF7rdbmVoz+wyzObwn+3i51Zb7V6LN3o/r4w5ybj1dOkIi
	 v/DNf/PDUbRWQ6Jj6buPYJFgvW6gLuY2+0z5ZEtIEdnNDo4vkse0FlGrpD+0Rh1/hN
	 f+2ql5oWWYU56F9nlXZYW6QPKHz/hx8OUiyPl30cxgeT65AH2fXWlo4/WwdBqmZ0L0
	 lWL+i8TNdUaQvGuMDkdnW8BTltjT+3a4yokMAtHGwy9qrcEWipzqfoBSy5Yh0aGJKN
	 1lne06nQsgoIWr5iOjiypWtbETOlf3qrIfu7nVsCekTRqXbE94X44p2rGpr0S8aeZ2
	 I4+aw0hzXxgjA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/2] PCI: Allow pci=hpreserve= to reserve bus
 numbers for a hotplug bridge
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maciej Grochowski" <maciej.grochowski@sony.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261002193111.51637-3-maciej.grochowski@sony.com>
References: <20261002193111.51637-1-maciej.grochowski@sony.com>
 <20261002193111.51637-3-maciej.grochowski@sony.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:33:52 +0000
Message-Id: <20261003013352.A8C831F0089D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] pci: hotplug_share calculation ignores buses used by normal bridges
- [Medium] pci: reserved bus numbers are lost if bridge is firmware-configu=
red
--

commit 34e2d44bc1e7840b0e80a2d0ea3f891f8e316ab9
Author: Maciej Grochowski <maciej.grochowski@sony.com>

PCI: Allow pci=3Dhpreserve=3D to reserve bus numbers for a hotplug bridge

When the kernel assigns bus numbers to the bridges on a bus,
pci_scan_child_bus_extend() divides the spare bus numbers equally
between the hotplug bridges. This commit adds a bus=3D key to
pci=3Dhpreserve=3D to allow a reserved hotplug bridge to get a
requested number of buses, with others sharing the remainder.

> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 27008e2ea5afc..086b7a549c27e 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
[ ... ]
> @@ -3115,12 +3127,28 @@ static unsigned int pci_scan_child_bus_extend(str=
uct pci_bus *bus,
>  	 * buses between hotplug bridges.
>  	 */
>  	for_each_pci_bridge(dev, bus) {
> -		if (dev->is_hotplug_bridge)
> +		if (dev->is_hotplug_bridge) {
> +			unsigned int reserved =3D pci_hotplug_reserved_buses(dev);
> +
>  			hotplug_bridges++;
> -		else
> +			if (reserved) {
> +				reserved_bridges++;
> +				reserved_buses +=3D reserved;
                                ^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: Medium]
Will these reserved bus numbers be lost if the bridge was already configure=
d by
firmware?

When a user reserves buses for a bridge that was assigned a smaller number =
of
secondary buses by firmware, the full reservation is deducted from the shar=
ed
pool here.

However, if the bridge is already configured, it retains its original
allocation and the remaining reserved buses are never added to used_buses.

> +			}
> +		} else {
>  			normal_bridges++;
> +		}
>  	}
> =20
> +	/*
> +	 * Hotplug bridges with a "pci=3Dhpreserve=3D" bus reservation get the
> +	 * number of buses they asked for; the others share what is left.
> +	 */
> +	if (hotplug_bridges > reserved_bridges &&
> +	    available_buses > reserved_buses)
> +		hotplug_share =3D (available_buses - reserved_buses) /
> +				(hotplug_bridges - reserved_bridges);
                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
Does this calculation over-allocate buses to non-reserved hotplug bridges?

When the parent bus contains a mix of normal bridges and non-reserved hotpl=
ug
bridges, available_buses does not account for buses already taken by the
normal bridges.

This inflates the calculated hotplug_share.

> +
>  	/*
>  	 * Scan bridges that are already configured. We don't touch them
>  	 * unless they are misconfigured (which will be done in the second
[ ... ]
> @@ -3152,12 +3180,34 @@ static unsigned int pci_scan_child_bus_extend(str=
uct pci_bus *bus,
>  			 */
>  			buses =3D available_buses;
>  		} else if (dev->is_hotplug_bridge) {
> +			unsigned int reserved =3D pci_hotplug_reserved_buses(dev);
> +
>  			/*
>  			 * Distribute the extra buses between hotplug
>  			 * bridges if any.
>  			 */
> -			buses =3D available_buses / hotplug_bridges;
> -			buses =3D min(buses, available_buses - used_buses + 1);
> +			if (!reserved) {
> +				buses =3D hotplug_share;
                                ^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
If a non-reserved bridge is processed before the reserved bridge, it consum=
es
this inflated hotplug_share. This can deplete the pool and leave the reserv=
ed
bridge with fewer buses than requested.

> +				buses =3D min(buses, available_buses - used_buses + 1);
> +			} else {
> +				/* used_buses already includes this bridge's bus */
> +				buses =3D available_buses + 1 > used_buses ?
> +					available_buses + 1 - used_buses : 0;
> +				buses =3D min(buses, reserved);
> +			}
> +
> +			/* Bridges configured in the first pass keep their buses */
> +			if (reserved && !dev->subordinate) {
                                        ^^^^^^^^^^^^^^^^

[Severity: Medium]
If the bridge is already firmware-configured, dev->subordinate evaluates to
true. This suppresses the warning about failing to fulfill the reservation,
masking the silent loss of the reserved bus numbers deducted from the pool
earlier.

> +				/* The secondary bus is allocated even for 0 */
> +				unsigned int granted =3D max(buses, 1U);
> +
> +				if (granted < reserved)
> +					pci_warn(dev, "only %u of %u reserved bus numbers available\n",
> +						 granted, reserved);
> +				else
> +					pci_info(dev, "reserving %u bus numbers\n",
> +						 granted);
> +			}
>  		}
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002193111.5163=
7-1-maciej.grochowski@sony.com?part=3D2
