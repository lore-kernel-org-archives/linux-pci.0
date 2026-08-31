Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116614E3EC7
	for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 14:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788186644; cv=none; b=CZVLJh7oWpUynwScgxqn/X8cLXKRpbboFLwfZ3OwcWwbrzSlVx3vKFFzzkYLfYs4FF5olhTXwmxCd+0hJY6NosZctnC4SL9csyYcaQDX93LBVfr9YelRl/SSN0RYYYI7SGsAvZxYWzlDowfDsOim4qQPeX9veygJzrTyXhM0i5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788186644; c=relaxed/simple;
	bh=zocsaEbdi2m+EJ1DguL8eejhcDp4FfjTaqEfFJtYdtg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dJ00tJa47AkU8I95kvODx8bkV4AEVnEbpi+JaXTmluYpisiQGKm0SYvy95z4duF2HBHgF72kqXO1CqN/0/c+ujTRYVM0VEh3Y7hEI5D0YtLV/Q51/VH9KL10rHm+SNfcFKKKCxaH2eBgpU/D6M1DIWLkJ/zaoCgIAnIGRidUxXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FOsjia2p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOsjia2p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C36421F00A3D;
	Mon, 31 Aug 2026 14:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788186642;
	bh=bEDWzzRQiOKEjPvJPqfpJ2SFpCHGN+ECP2e7/p3Nnv0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FOsjia2phteIGBAJqsvFh4coOwrDkJfRRctxRThNd9IoL3LtUXxfuCT1rUDA87q3I
	 6MEIonF+1jTv24iYmGPRz7AylMiCxVCYsR4E/EXSduB4Pfgw9ONWUU8g75EgTdbFr0
	 WiBKsG34MAk9INr5cdYEamx2fQ/P8w4sxQ/q68ilA2OdrGsIKAA23FDggZft6QWqwK
	 6R5ehIKRKLiNRGECoC+4MKrwXKgM0ag088QPN3u4jBZAdAxlV+8FUllzaMBk1BiKDd
	 v/v2B0EMxFLH83i/wnEhxY9FITPzRxCY1V0FdfhRoyNhXmCtUFM5ZUt+bpAmGMk2Zt
	 iUDTFqeAFESdg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-5.10] PCI: rockchip: Protect root bus
 removal with rescan lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260831133314.4125787-119-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-119-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 14:30:42 +0000
Message-Id: <20260831143042.C36421F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing cleanup of the chained IRQ handler leaves a dangling point=
er to freed memory, causing a use-after-free if the interrupt fires after u=
nbind.
- [High] Devm-managed shared IRQ handlers remain active while hardware cloc=
ks are disabled, risking a synchronous abort.
- [Medium] Clocks are disabled before regulators during remove, contrary to=
 standard teardown order and the probe error path.
--

commit 785072a32823f4b0e136466862c1fafc7b9d2215
Author: Hans Zhang <18255117159@163.com>

PCI: rockchip: Protect root bus removal with rescan lock

Hold the pci_rescan_remove_lock lock while stopping and removing a root bus
to avoid racing with concurrent rescan or hotplug operations triggered via
sysfs. Such races may lead to use-after-free issues or system crashes.

Link: https://patch.msgid.link/20260521161822.132996-8-18255117159@163.com

> diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/co=
ntroller/pcie-rockchip-host.c
> index ee1822ca01db3..d203c4876d304 100644
> --- a/drivers/pci/controller/pcie-rockchip-host.c
> +++ b/drivers/pci/controller/pcie-rockchip-host.c
> @@ -1012,8 +1012,10 @@ static void rockchip_pcie_remove(struct platform_d=
evice *pdev)
>  	struct rockchip_pcie *rockchip =3D dev_get_drvdata(dev);
>  	struct pci_host_bridge *bridge =3D pci_host_bridge_from_priv(rockchip);
> =20
> +	pci_lock_rescan_remove();
>  	pci_stop_root_bus(bridge->bus);
>  	pci_remove_root_bus(bridge->bus);
> +	pci_unlock_rescan_remove();
>  	irq_domain_remove(rockchip->irq_domain);

[Severity: High]
This is a pre-existing issue, but does this code leave a dangling pointer to
freed memory for the chained IRQ handler?

The driver teardown path in rockchip_pcie_remove() misses the critical clea=
nup
step for the chained handler before freeing resources. It was originally se=
t up
here:

drivers/pci/controller/pcie-rockchip-host.c:rockchip_pcie_setup_irq() {
...
	irq_set_chained_handler_and_data(irq,
					 rockchip_pcie_intx_handler,
					 rockchip);
...
}

Neither rockchip_pcie_remove() nor the rockchip_pcie_probe() error paths cl=
ear
this handler via irq_set_chained_handler_and_data(irq, NULL, NULL).

Since rockchip is devm-managed, it is freed by devres on device unbind. If =
an
interrupt fires after unbind, the IRQ subsystem retains a pointer to the
chained handler and the freed rockchip structure, causing a use-after-free
which likely results in a kernel panic.

> =20
>  	rockchip_pcie_deinit_phys(rockchip);

[Severity: High]
This is a pre-existing issue, but do devm-managed shared IRQ handlers remain
active while hardware clocks are disabled?

Further down in rockchip_pcie_remove(), clocks are manually disabled well
before the devm-managed IRQ handlers are unregistered. The IRQ is requested=
 as
shared and devm-managed:

drivers/pci/controller/pcie-rockchip-host.c:rockchip_pcie_setup_irq() {
...
	err =3D devm_request_irq(dev, irq, rockchip_pcie_subsys_irq_handler,
			       IRQF_SHARED, "pcie-sys", rockchip);
...
}

The handler unconditionally accesses device registers upon entry:

drivers/pci/controller/pcie-rockchip-host.c:rockchip_pcie_subsys_irq_handle=
r() {
...
	reg =3D rockchip_pcie_read(rockchip, PCIE_CLIENT_INT_STATUS);
...
}

Because the shared IRQ remains active until the devres cleanup phase, which
happens after rockchip_pcie_remove() returns, any concurrent interrupt trig=
ger
will attempt to read device registers with clocks disabled. Accessing hardw=
are
registers while the APB/core clocks are disabled leads to a synchronous
external abort.

[Severity: Medium]
This isn't a bug introduced by this patch, but are the clocks disabled befo=
re
regulators during remove, contrary to the standard teardown order?

The code unconditionally calls rockchip_pcie_disable_clocks() prior to call=
ing
regulator_disable() on the vpcie regulators. This contradicts the
rockchip_pcie_probe() error path, which correctly disables regulators before
disabling clocks.

Cutting clocks before cutting power regulators violates hardware power
sequencing and can leave the hardware in an undefined state.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-119-sashal@kernel.org?part=3D1
