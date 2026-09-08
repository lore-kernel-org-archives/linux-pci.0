Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91441258EF3
	for <linux-pci@vger.kernel.org>; Tue,  8 Sep 2026 15:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788879888; cv=none; b=KUZCgQ+FGrQso7vokZBHxjjsycUXWYLsplp1B++F3T/evD2EgiNCBFBsRbRQolvsomVha1bU5qHjbTZTB40pIn0w2zsfdz/Um519Z/CYL5dthEgy64+02mEDPtd9y9+O0qX7FHi8jtyhee8WD4M/nszMFxBtFGGg35cAAQBqJak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788879888; c=relaxed/simple;
	bh=GeRfH0+6M6rAEURBlb3bylHGdpPjOLJqIN1HDndMMqg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mh130UNJbJJ0xWirY6YJpvfNq6p9e0CGETcflZXbF32LO8WM2VugpZw2NAxSo48Ww9h4+WAwWLsP2XSXv6oDjCPblUaZsaYHJSWkkxy/raoQ70t0nnvtYdlQfqvkCUD11SxYIbMUVPazAAzs6WX2/NSoOIdKb1SjJK8vzdh+qUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Db4DVefU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Db4DVefU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B26C01F00A3A;
	Tue,  8 Sep 2026 15:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788879880;
	bh=mKFq8a1be5dFe/rNXzvdpNcK4eVTRoWuVkimW/A8RKM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Db4DVefUzPamigmP+/eBG9RDzhukCcXNhcA03fQylnxgWtufmzwua6eA2vyxb74r6
	 gpnk+LDfxE3t3RhAhi76Q3BCdS7grkkVudRqgDWakotQOKZ7pYHn74t8VbZSpFmvT5
	 RiE945VHiuGDfuLe+sYcs3r/h0gsdjqc2lEdbXxv+M17v/6NAj07VeMxmOaYRpyMVj
	 PxPELmwF5Us2bkh4MjeVjpziTgaUxRK/WLGTPgp8W4njX3U5VW5P2pjaxgGOksI+0g
	 ncysOE7oflgnRUgDMjGKd9SUsizXHTvPXDJ8qgwaMPp0CdHzN8eWbBxZwIs+8qswsG
	 AtT2Eek1S6xrw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 03/10] PCI: dw-rockchip: Move devm_phy_get out of
 phy_init
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260908-rockchip-pcie-system-suspend-v6-3-fbabcca9921b@collabora.com>
References: <20260908-rockchip-pcie-system-suspend-v6-0-fbabcca9921b@collabora.com>
 <20260908-rockchip-pcie-system-suspend-v6-3-fbabcca9921b@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 15:04:40 +0000
Message-Id: <20260908150440.B26C01F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but iterating throug=
h `bus->devices` without holding the `pci_bus_sem` read lock risks a Use-Af=
ter-Free.
- [High] This problem wasn't introduced by this patch, but repeated devres =
allocations in rockchip_pcie_rc_reset_root_port() via rockchip_pcie_clk_ini=
t() cause a resource leak.
--

commit 2321e2492c7e546beab0727fbd3c7122dbf07abc
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

PCI: dw-rockchip: Move devm_phy_get out of phy_init

This patch moves the devm_phy_get() call from rockchip_pcie_phy_init() to
the probe routine. This allows the PCIe PHY to be re-initialized without
re-requesting the managed resource, which is necessary after operations
like system suspend/resume.

> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/=
controller/dwc/pcie-dw-rockchip.c
> index f67ad3c31c35b..7472ec78b4738 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
[ ... ]
> @@ -858,6 +852,13 @@ static int rockchip_pcie_probe(struct platform_devic=
e *pdev)
>  					     "failed to enable vpcie3v3 regulator\n");
>  	}
> =20
> +	rockchip->phy =3D devm_phy_get(dev, "pcie-phy");
> +	if (IS_ERR(rockchip->phy)) {
> +		ret =3D PTR_ERR(rockchip->phy);
> +		dev_err_probe(dev, ret, "missing PHY\n");
> +		goto disable_regulator;
> +	}
> +

[Severity: High]
This isn't a bug introduced by this patch, but while moving devm_phy_get()=
=20
to the probe function correctly prevents resource leaks during=20
re-initialization, there is a similar leak involving devm_clk_bulk_get_all(=
).

In rockchip_pcie_clk_init(), devm_clk_bulk_get_all() is called
unconditionally:

rockchip_pcie_clk_init() {
        ...
        ret =3D devm_clk_bulk_get_all(dev, &rockchip->clks);
        ...
}

This causes a leak because rockchip_pcie_rc_reset_root_port() calls
rockchip_pcie_clk_init() during a recurring reset flow:

rockchip_pcie_rc_reset_root_port() {
        ...
        ret =3D rockchip_pcie_clk_init(rockchip);
        ...
}

Since rockchip_pcie_rc_reset_root_port() is assigned to
pp->bridge->reset_root_port, it can be triggered dynamically via sysfs or
error recovery. Because devres resources are only freed when the device
unbinds, does every root port reset allocate a new set of clock handles
and leak the previous devres memory? Could the clock acquisition be moved
to the probe function as well, similar to what this patch does for the PHY?

[Severity: High]
This is also a pre-existing issue, but iterating through bus->devices
without holding the pci_bus_sem read lock risks a Use-After-Free.

In rockchip_pcie_rc_sys_irq_thread(), the thread processes hot reset or
link-down events and iterates over the bus:

rockchip_pcie_rc_sys_irq_thread() {
        ...
        for_each_pci_bridge(port, pp->bridge->bus) {
                if (pci_pcie_type(port) =3D=3D PCI_EXP_TYPE_ROOT_PORT)
                        pci_host_handle_link_down(port);
        }
        ...
}

Because bus->devices can be dynamically modified concurrently via PCIe
hotplug or user-initiated unbinds via sysfs, if a device is hot-removed
while the thread is iterating, could it dereference an invalid list
pointer? Should this iteration be protected by down_read(&pci_bus_sem)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-rockchip-p=
cie-system-suspend-v6-0-fbabcca9921b@collabora.com?part=3D3
