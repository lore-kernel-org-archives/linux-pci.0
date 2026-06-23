Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEBC305968
	for <linux-pci@vger.kernel.org>; Tue, 23 Jun 2026 16:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782230563; cv=none; b=nymI0g6BKQyxYb+SeuZmufHwZj3/5THHGrxABuiioql4QjRCSM5T8a/d0oBACt8nBstFd4dT7uvwZpVxKxrfeoFOJ+ZqbN+RaQKn6XMhPuxaJPx/Ozbwf99DqWFxw9Y/C5Y2/Joc3CBsJeJhmS/L3Sd162BuafglA7M66KimSUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782230563; c=relaxed/simple;
	bh=fnOj+o+1SJJH4kqiKW0T4NOnzRIgoFMoWdrHvcomVkw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BVKjNZUffXABDwgXQGw8C0aO7tWt9XllLnAtV1vzcwxPgp94GCnkTyATPm/niOyxqLaenXUFB3owxnpQfwuD+j4aCCMiZYixc2BNRURgiMx4+RRRBInTH8IUp4pAlAfhX0lsnl966SVftP2HxN9dBV4WlMDpoioEP3d2/pLTLWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXrL0of3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXrL0of3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C991F000E9;
	Tue, 23 Jun 2026 16:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782230562;
	bh=wHkd49EhJXsBXQN7fcwhzqEj7TFmzqPlL2yi/LNGmiQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kXrL0of3dEiSIa9I3Om1lbcpd/KlmxbsxU0Fh9zT9AE9b5aOtCwnnux3Gl2jJdzWS
	 2Pxc+EYbKo/scHRPJxrLsxe/Hn9Wnj0R6Vr6g7R1d8zK2PSaSSPpaAT4cDU2lBYgCs
	 NDQr61kyMVVyNPn9ztVCqhY5SNfo87HSgXd1ZrY9mIBFzzwcqCt4Guw6tipZ3rWWzI
	 yzfDOkqoDIlVmyp3bQwAUb8Q+A3y1Z0sBamBBcPdCzFJTYGwxEEVgfFpCg3evRD+fz
	 qIPcLoBTVJDHh0F5BfG98NFC78R0V+qtCGtrTLuNj3bnwKqBoKb2L+fQ70nQDrSusZ
	 hWoSwKd1c+WhQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/1] PCI: Fix bus number allocation for switches with
 multiple downstream ports
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicholas Johnson" <nicholas.johnson@outlook.com.au>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260623155256.32688-2-nicholas.johnson-opensource@outlook.com.au>
References: <20260623155256.32688-1-nicholas.johnson-opensource@outlook.com.au>
 <20260623155256.32688-2-nicholas.johnson-opensource@outlook.com.au>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 16:02:41 +0000
Message-Id: <20260623160241.E4C991F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The patch implementation completely contradicts the commit message=
, leaving the described bug unfixed and introducing unrelated changes.
- [High] The newly added `available_buses` fallback causes downstream hotpl=
ug bridges to greedily consume all remaining bus numbers from their parent,=
 starving sibling bridges.

Pre-existing issues:
- [High] Unsigned integer underflow in hotplug bridge bus distribution allo=
ws allocation of more buses than are actually available.
--

commit 31d3251a7010be0843a52900e047dba55580d13a
Author: Nicholas Johnson <nicholas.johnson@outlook.com.au>

PCI: Fix bus number allocation for switches with multiple downstream ports

This commit attempts to address an issue where the kernel fails to allocate
bus numbers beyond the first downstream port of a PCIe switch. It intends to
update subordinate bus tracking but instead modifies the available buses
calculation.

> The issue occurs in pci_scan_bridge_extend() when scanning an already con=
figured
> bridge in pass 1. The code updates 'max' using the old 'subordinate' valu=
e from
> pass 0 instead of 'cmax', the actual subordinate bus number returned from
> scanning the child bus. This causes the parent bridge to never advance pa=
st the
> first downstream port.
>
> Fix this by updating 'max' with 'cmax' instead of 'subordinate', ensuring=
 the
> parent bridge correctly tracks the bus numbers consumed by all its downst=
ream
> ports.

[Severity: High]
The commit message states this patch modifies pci_scan_bridge_extend() to
update max using cmax instead of subordinate. However, the diff below does
not contain any changes to pci_scan_bridge_extend() and instead adds new
logic to pci_scan_child_bus_extend().=20

Was the intended fix for the subordinate bus tracking accidentally omitted
from this patch?

> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index b63cd0c310bc0..8fb09cbb6df15 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c

[ ... ]

> @@ -3124,6 +3124,17 @@ static unsigned int pci_scan_child_bus_extend(stru=
ct pci_bus *bus,
>  			normal_bridges++;
>  	}
> =20
> +	/*
> +	 * Some host bridge scan paths pass available_buses =3D=3D 0 even though
> +	 * the bus-number resource contains space reserved for descendants.
> +	 * Preserve that space when this bus has a hotplug-capable bridge so
> +	 * it can be distributed during the second bridge scan.
> +	 */
> +	if (!available_buses && hotplug_bridges &&
> +	    bus->busn_res.end > bus->busn_res.start)
> +		available_buses =3D
> +			bus->busn_res.end - bus->busn_res.start;

[Severity: High]
Because bus->busn_res.end is temporarily set to the parent's limit during
creation, does this fallback calculation allocate the parent's entire
remaining bus space to this single child?

If evaluated with available_buses =3D=3D 0, it appears this would leave zero
buses for any sibling downstream ports, breaking their enumeration.


Later in pci_scan_child_bus_extend(), there is existing code that distribut=
es
the extra buses:

		} else if (dev->is_hotplug_bridge) {
			/*
			 * Distribute the extra buses between hotplug
			 * bridges if any.
			 */
			buses =3D available_buses / hotplug_bridges;
			buses =3D min(buses, available_buses - used_buses + 1);
		}

[Severity: High]
This is a pre-existing issue, but could this min() calculation underflow?

If used_buses exceeds available_buses + 1 (for instance, from SR-IOV
reservations), available_buses - used_buses + 1 would wrap around to a very
large unsigned integer.

This would cause the macro to select the requested buses instead of clamping
to 0, potentially assigning bus numbers outside the parent's resource window
and leading to overlapping buses.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623155256.3268=
8-2-nicholas.johnson-opensource@outlook.com.au?part=3D1
