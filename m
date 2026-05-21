Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FC81E1E16
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 20:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779396035; cv=none; b=k8gPVyCpB1tX270JP4JsFHe0Lz2QiR6vlbobaPHHuxWfj0yQwrBl9jvTSOAmomhkzMVPlQk1LYHuU1rgfOfHzO2HdrD21h3B5kj559u8N05nOXQXEzKKPYZZ7fE6jENxe1Z/9iNLOUulzaE+/2Z8nPXe7yAI3dE/T1RrHyoFNc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779396035; c=relaxed/simple;
	bh=TrRvgtXkYwFD0xAd18d/Kiut2mXPtiT+NwUq9vA6EQ4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=syd5tV4u9yG3u2N9iwUqp7R1jwPT8VY/r5WOrNG3iXaZRowm3MNXj3FpEnnAmHM566Y60OPwP/PXLma9kpWzMcCZfgqJ3oHVVAKjZ7wGWvmnbBmItuCPs0YI1XKde+nXetObZBwV1+wYhBz5cDnF8hVZ5Sk1pfPEqJTStJgfsTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IlXTIuyf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IlXTIuyf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A059F1F00A3C;
	Thu, 21 May 2026 20:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779396033;
	bh=Q3FjjYNg+QqHbesUDB2NsXdl9rtPDUkJdIFO3O0ld+Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IlXTIuyfJWL8mFr03opDQOx8opF/Yql24Vzfp9vveUsNJnXklWP0eEnQ9QLZ4qS3f
	 VMEJo1b6UKmrVeFWW0GewEmCsccCwvVNxRqUbPjmhy+tFIUoJL8QaFauVioEo9z0UC
	 E9F0rbcZN+jFmYcXc54D1v6wt9RZrvyXdtElxTiMFprUJULuhJ16QuWfhWA68gHu+e
	 q0WJy+mJ0rUlzcuyhAgjqfK521vMT6JDnrFaPzyLis5rBPl7jCCsO94FyHmdCHAwMz
	 6ZPpZlgHFMe5ngC0O/oDACvGOe01T7W+g7iSbqoaUAtHEnGZ+HeUYKpUvjNT4LKlEv
	 RO89b+r1cShoA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/9] PCI: rockchip: Protect root bus removal with rescan
 lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260521161822.132996-8-18255117159@163.com>
References: <20260521161822.132996-8-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 20:40:33 +0000
Message-Id: <20260521204033.A059F1F00A3C@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The chained IRQ handler for the 'legacy' interrupt is never cl=
eared during driver removal or probe failure, leaving a dangling pointer th=
at can cause a use-after-free crash.
- [High] Devm-managed interrupt handlers are not unregistered before hardwa=
re clocks and regulators are disabled, risking a synchronous abort if an IR=
Q triggers during or after teardown.
--

commit d2ff4e68d35e6bd8f1e9996d0dafb48fdb147cab
Author: Hans Zhang <18255117159@163.com>

PCI: rockchip: Protect root bus removal with rescan lock

This patch modifies the rockchip PCIe host driver to wrap the root bus
removal operations with the PCI rescan/remove lock. This serializes bus
deletion against concurrent bus rescan operations.

> diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/co=
ntroller/pcie-rockchip-host.c
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
> =20
>  	rockchip_pcie_deinit_phys(rockchip);

[Severity: High]
This isn't a bug introduced by this patch, but I have a question about the
interrupt teardown sequence that follows this code.

The sys and client interrupts are registered using devm_request_irq() with
the IRQF_SHARED flag. Because they are devm-managed, they remain active
until the devres teardown occurs, which happens strictly after
rockchip_pcie_remove() returns.

Later in this function, hardware clocks and regulators are disabled:

    rockchip_pcie_disable_clocks(rockchip);
    if (!IS_ERR(rockchip->vpcie12v))
        regulator_disable(rockchip->vpcie12v);
    ...

If a shared or spurious interrupt fires after the hardware clocks and
regulators are disabled, will the handlers attempt to read PCIe MMIO
registers? Could reading from unclocked or unpowered peripheral registers
trigger a synchronous external abort?

Should devm_free_irq() be called for these interrupts before the clocks
are disabled?

[Severity: Critical]
This is also a pre-existing issue, but I noticed the chained IRQ handler
for the legacy interrupt is never cleared during driver removal.

In rockchip_pcie_setup_irq(), a chained IRQ handler is set for the legacy
interrupt:

    irq_set_chained_handler_and_data(irq, rockchip_pcie_intx_handler,
                                     rockchip);

Unlike standard interrupt requests via devm_request_irq(), chained handlers
are not managed by devres and must be explicitly cleared.

Since the rockchip structure is allocated using devm_pci_alloc_host_bridge(=
),
it is freed by devres when the device is unbound. If a legacy interrupt
fires after the device memory is freed, could the IRQ core invoke
rockchip_pcie_intx_handler() and dereference the freed rockchip structure?

Should irq_set_chained_handler_and_data(irq, NULL, NULL) be called at the
end of rockchip_pcie_remove() to prevent a use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521161822.1329=
96-1-18255117159@163.com?part=3D7
