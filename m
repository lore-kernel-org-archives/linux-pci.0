Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794764365;
	b=i8h+w/kYSN4OJs3Fe5mT7H7R2WuHLe6I+0C6tXLhOrRXOtW2z3hXajZ3K05KF4U8HXhI
	 ZI0cJ0DK5DV/IzkU8wfP0h2iEfn0jN4wykQZMV9hSOkrlVZsCn+3pko1WXpw1iV6Reb1N
	 bW+uQKawEJrNJW4S5BhAtVhU4RT5+L4zZ/vG4VFaUw70yhPu5Zy+lpjYRPCCn4j5Un3n2
	 eORBCO08LDFPrJomlNCy6U6WKet7BBXdP6jKTn2nBaSTFTrZEauVkok2USkzWNi9Wc+Kk
	 0edNJrrTVvj6gq5iLkVrUG0flDRdoKwWTFI+EtNZDamgaTr7BogRBMi9NWTzTbWKsRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794764365;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Br7a4NMZTIn/3qu4MmLTLPE+0zvvvnVjOghs59wniEs=;
	b=s3IEpS6TYsTSyBzWrMPEGeBx0k8ZzEuw62u0MVo1oRqoDQoK6zuhx3wKnS2eXVEwav1s
	 1mCpmG80J5bQumeoNuIXp7Xwttee8HOPzKzq015pMcEVFbO6Yyl1AeNY+9k4TUJONFvLF
	 2n6bRQE4qZgwBfLeiFGSkxVe/yENQ8USkOTTOWKxgc7yB0MApk2HzuQZYqXR8acK2WRYh
	 9XwEiM5Q9VlrhddUpj7R2d0/go3KhnCGlRGqmvU13vHDawG/ySu5e/09/6485Rs+IVKEa
	 bEyIEXSz2luIaMU8iDrHmXnKbq5y5DmS7jVHfaL0+gWdbu90UrynGpt8MeLwyx08zrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IzT0MUts;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A7D606A31D
	for <linux-pci@vger.kernel.org>; Sun, 15 Nov 2026 17:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IzT0MUts
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F0EA1F000C9;
	Sun, 15 Nov 2026 17:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794764364;
	bh=Br7a4NMZTIn/3qu4MmLTLPE+0zvvvnVjOghs59wniEs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IzT0MUtsOdsT6wnofkVEbFGBALsRkVM38J2O3ajpkhdiUBrwgLMZGcMAUBaJc0J/c
	 XNHCu/PKR8Z0wqvLTP0nenXDXLLA/eHiJr93LrtJeoQANU7HVpBdIODURm5kUqX8Cr
	 SzkXF2OnYwGt5GuHhr2PydSMBzz3engrcpKqeEovJz707+fPzuKvrae/VCSlyYPWop
	 er8MRL1PJ78gEM38mtm4Tv8eg0F4OqIgOyYRq/FOY9jv4D02R4cjKTH8RqZzBEPGfx
	 XM5BlmIZMIX3DZ6v7XbYo0NoSqC6cCW+cc6BC8J9IIfefh9u96hp78CZCtU57beE+i
	 RK1Ohi/th91pg==
Message-ID: <sashiko-outbox-215685@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] PCI/PM: Honor PCI_DEV_FLAGS_NO_D3 in
 pci_bridge_d3_possible()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aviv Bakal" <avivb@amazon.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261115171831.1498006-2-avivb@amazon.com>
References: <20261115171831.1498006-1-avivb@amazon.com>
 <20261115171831.1498006-2-avivb@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 17:39:24 +0000
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
- [Medium] PCI/PM: pci_bridge_d3_possible() checks NO_D3 before final
  quirks
--

commit 5fefa5fbcbd02246d38adb690d51a8862ddc1cd4
Author: Aviv Bakal <avivb@amazon.com>

PCI/PM: Honor PCI_DEV_FLAGS_NO_D3 in pci_bridge_d3_possible()

This commit returns false from pci_bridge_d3_possible() when
PCI_DEV_FLAGS_NO_D3 is set on the bridge.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 7c6f2aba81443..1a23be4b6a073 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3055,6 +3055,10 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
>  		if (pci_bridge_d3_disable)
>  			return false;
> =20
> +		/* The port is known not to work correctly in D3 */
> +		if (bridge->dev_flags & PCI_DEV_FLAGS_NO_D3)
> +			return false;

[Severity: Medium]
Can this leave bridge->bridge_d3 stuck at true when PCI_DEV_FLAGS_NO_D3 is
set by a DECLARE_PCI_FIXUP_FINAL quirk?

During enumeration, pci_device_add() -> pci_init_capabilities() ->
pci_pm_init() initializes dev->bridge_d3 =3D pci_bridge_d3_possible(dev)
before final quirks run in pci_bus_add_device() or pci_apply_final_quirks().
When a final quirk such as quirk_plx_pex_no_d3() or quirk_tuxeo_rp_d3()
later sets PCI_DEV_FLAGS_NO_D3 on a port, pci_bridge_d3_possible() flips
from true to false, causing pci_bridge_d3_update() on child devices to retu=
rn
early without ever clearing bridge->bridge_d3:

drivers/pci/pci.c:pci_bridge_d3_update() {
	bridge =3D pci_upstream_bridge(dev);
	if (!bridge || !pci_bridge_d3_possible(bridge))
		return;
    ...
}

In addition, when a child device's final quirk (like quirk_tuxeo_rp_d3())
sets PCI_DEV_FLAGS_NO_D3 on its parent Root Port after pcie_portdrv_probe()
has already bound to the port, pci_bridge_d3_possible() returns true during
probe and false during pcie_portdrv_remove() and pcie_portdrv_shutdown(),
leaving runtime PM enabled and skipping the matching pm_runtime_forbid() and
pm_runtime_get_noresume() calls on removal.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115171831.1498=
006-1-avivb@amazon.com?part=3D1
