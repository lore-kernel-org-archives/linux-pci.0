Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E583B52E1;
	Fri, 18 Sep 2026 03:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789702412; cv=none; b=YkY+bxtOeCk2G1gT43yniaws1l0Jj+ifxMru731RCGnxM+KfcYzs7x4i3Lj/YiBvXbjoZEzyECGhtln6myEQISwlHdj26NPCu3x7fJERvqT2B19DpybShxNa6PbHQdcA8IiKj6GaanWLB8/arSuJkkGRTMl1QJfkL04npKxEBp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789702412; c=relaxed/simple;
	bh=9dnVafv+T6FSy/sF/3kuzO8K3HFIMXAv7O45usQ86Go=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QuFc3pUuNTZfCKyYPhPnoT8qeg3bWgk/c3IphYoF3mYOoKwhE1hV9dAY9PUiobhRlyOrViqRdJJW1IO8xHR1DBL4C1CayRMPE2fRAgFySjtXxsbvbhM7UrfkZgzwWNUCG/47IDdSFRyfjIYNOzj6QduNofbYRoKvskCck9SeocA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOunwnGR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOunwnGR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C4071F000FF;
	Fri, 18 Sep 2026 03:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789702408;
	bh=Ix9pBIrbQKLViGxE/KM2OGoksgSqNh/dTsAqkw8jbw8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SOunwnGRZDQcwYpThD1IY1h5x921zO3GB6eTkqrokupYuRK1fLks3bdubcsfK1dUY
	 q7wcn21oWvSuKfGqXImDjgLPs+CE89o67P7EhlZm2fvqRmXFI3PcrEBptQrpvfb2LZ
	 Ng1ttXcH3sEaS9MwLChCmtxJRCQRw5m+TKlz1E6KryQNnQwFo/+EW/YP+3IXHvhmJO
	 b6GNgoFL155jvhQqBPmr6sixBEB1lpso0lcPPWBCBgvyGbVvMB/g4N5/X24dMQtCv3
	 VcE34bsPi/ChuC49E0YtraSPBHD2CZ2YWbpMhxdfvqxlgYU9OqWRVqZmoKsWiYBcvn
	 sr1AUyVefhWSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/11] PCI: rcar-gen4: Recover the Root Port on link
 down
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260918032038.2216471-8-den@valinux.co.jp>
References: <20260918032038.2216471-1-den@valinux.co.jp>
 <20260918032038.2216471-8-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 03:33:27 +0000
Message-Id: <20260918033328.3C4071F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] pci: use-after-free traversing bus devices without pci_bus_sem
- [Low] cleanup: mixing goto-based error handling with guard()
--

commit 945529b2e76a7eb8d868ae35745dd98c440ca944
Author: Koichiro Den <den@valinux.co.jp>

PCI: rcar-gen4: Recover the Root Port on link down

This commit introduces a mechanism to recover the Root Port on R-Car Gen4
when the link goes down. It uses a pre-MSI callback to handle the reset
status and schedules recovery work.

> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/co=
ntroller/dwc/pcie-rcar-gen4.c
> index 5b983ef6dc47d..238755852045e 100644
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
[ ... ]
> @@ -435,6 +486,134 @@ static int rcar_gen4_pcie_host_msi_init(struct dw_p=
cie_rp *pp)
>  	return ret;
>  }
> =20
> +/* Returns true if a latched reset-request status was consumed. */
> +static bool rcar_gen4_pcie_handle_link_down(struct rcar_gen4_pcie *rcar)
> +{
[ ... ]
> +	if (schedule)
> +		schedule_work(&rcar->link_down_work);
> +
> +	return true;
> +}
> +
> +static void rcar_gen4_pcie_link_down_work(struct work_struct *work)
> +{
> +	struct rcar_gen4_pcie *rcar =3D
> +		container_of(work, struct rcar_gen4_pcie, link_down_work);
> +	struct dw_pcie_rp *pp =3D &rcar->dw.pp;
> +	struct pci_dev *port;
> +
> +	for_each_pci_bridge(port, pp->bridge->bus) {
> +		if (pci_pcie_type(port) =3D=3D PCI_EXP_TYPE_ROOT_PORT)
> +			pci_host_handle_link_down(port);
> +	}

[Severity: High]
Can this loop traverse the PCI bus devices list asynchronously without
holding the mandatory pci_bus_sem or acquiring a reference on port?

Iterating the devices list of the PCI bus without holding the required
read lock (pci_bus_sem) can lead to list corruption or Use-After-Free.
Concurrently, a PCI hotplug event or a sysfs device unbind could remove
the device from the list. Furthermore, the downstream call
pci_host_handle_link_down(port) uses the port pointer across
sleep/lock-acquisition points without holding a reference
(via pci_dev_get()).

Could this be protected by holding pci_bus_sem or acquiring a reference
to the device?

> +
> +	if (test_bit(RCAR_PCIE_LINK_DOWN, &rcar->state))
> +		dev_err(rcar->dw.dev,
> +			"Root Port reset failed; keeping the controller's interrupts masked u=
ntil a reset succeeds\n");
> +}
[ ... ]
> @@ -574,7 +762,7 @@ static int rcar_gen4_pcie_reset_root_port(struct pci_=
host_bridge *bridge,
>  	dev_dbg(dev, "Root Port reset completed\n");
> =20
>  out:
> -	rcar_gen4_pcie_resume_irqs(rcar);
> +	rcar_gen4_pcie_resume_irqs(rcar, !ret);
> =20
>  	return ret;
>  }

[Severity: Low]
Does rcar_gen4_pcie_reset_root_port() mix guard() and goto error handling?

Looking at rcar_gen4_pcie_reset_root_port(), it defines a guard at the top
and uses goto for error handling:

	guard(mutex)(&rcar->reset_lock);

	rcar_gen4_pcie_quiesce_irqs(rcar);

	dw_pcie_stop_link(dw);

	ret =3D rcar_gen4_pcie_host_hw_init(pp);
	if (ret) {
		dev_err(dev, "Host init failed: %d\n", ret);
		goto out;
	}

The cleanup subsystem guidelines explicitly state that goto and guard()
should never be mixed in the same function, as it introduces potentially
confusing ownership semantics and ordering issues.

Could this be converted to avoid the goto jumps?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918032038.2216=
471-1-den@valinux.co.jp?part=3D7
