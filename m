Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581E3393DF1
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 19:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779391203; cv=none; b=CRx/B1wv+IavYwsO345pr+0LK9vn5ZkIZjfavDnyORXxKKfVsK/uT4y7KhTKUPc4fEvutw4XhJrxAKimYVbqbpV8JM51nEQeb1mx3obFXwcYFaDWV866v0k/cemJGc2j2MWuUU+RURJ3I5CsGdipVvu83Q7/wksonBOUSjJSC88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779391203; c=relaxed/simple;
	bh=ep0604l6QLgoVbZXkwSctUWVgiFvmPHDcG7F6nZyEDo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TP6eP3IfA7UAENPrwGWOx5Z8hU24cMspIIXD6ymnn9fdWTCDjo5N8n1y2XbX8v3lQwZJINVBpnkoaz89YFr4HzD/SMhpMHdoHMbK2wjRhST94b6FJO+j5adSX2v3CBQyym7AOMjUngsaHuJIPg7conDLNxxdi78r3xtvNpgi/xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I2A+8qpN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2A+8qpN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5CFC1F000E9;
	Thu, 21 May 2026 19:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779391195;
	bh=znKZkIJmrgjGTbjSinT9WAKKaNk47tmyTgwd+TwuRqY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I2A+8qpNuw3zjnhS0CcQC/aUFxAWlbe5iDYJLSQsswf4exCAiFUiS6kXuInXu1GTp
	 jFSGXgqqUEdp1Ukhrhtv0qSeTG+yJQBQbozqs6XCNgqlyrQ5MZWnIKSUVls6Npdzkm
	 cJv5RLxLhimYL8mwLJXLr6SGRsWW7nu0hxK+hN1t8VbRKaJLdS0mA8Tt+fJhZ1kXQJ
	 rnXh0EX7uO8vzRnNUv4pxrJqmvYHLzz1oBMUMWZtr+PRUN8F7qg0SIxXSfVAapD7/Y
	 8jvRfSIsw4BCqp3AiufpDIdxgTIN5dQGP93CoKaR3272yCOydIk91iiQo4K6mH7ggC
	 QUbV9TDijOrWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/9] PCI: brcmstb: Protect root bus removal with rescan
 lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260521161822.132996-5-18255117159@163.com>
References: <20260521161822.132996-5-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 19:19:55 +0000
Message-Id: <20260521191955.C5CFC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Calling `brcm_pcie_remove()` on the `pci_host_probe()` error p=
ath triggers a Use-After-Free (UAF) or NULL pointer dereference.
- [High] The `pcie->bridge_lock` is used before it is initialized during de=
vice probe.
--

commit baacf34014bfc48de11be2860d0ae507bf20e383
Author: Hans Zhang <18255117159@163.com>

PCI: brcmstb: Protect root bus removal with rescan lock

Add missing PCI rescan lock protection in brcm_pcie_remove() before
removing the root bus.

> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controll=
er/pcie-brcmstb.c
> index 714bcab97b603..7ca27f0756c9b 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -1894,8 +1894,10 @@ static void brcm_pcie_remove(struct platform_devic=
e *pdev)
>  	struct brcm_pcie *pcie =3D platform_get_drvdata(pdev);
>  	struct pci_host_bridge *bridge =3D pci_host_bridge_from_priv(pcie);
> =20
> +	pci_lock_rescan_remove();
>  	pci_stop_root_bus(bridge->bus);

[Severity: Critical]
This is a pre-existing issue, but can calling brcm_pcie_remove() on the
pci_host_probe() error path trigger a use-after-free or null pointer
dereference here?

In brcm_pcie_probe(), if pci_host_probe() fails, the error path directly
calls brcm_pcie_remove(). If pci_host_probe() failed early because
pci_alloc_bus() returned null, bridge->bus remains null. If it failed later
during pci_register_host_bridge(), the allocated bus is freed via kfree(),
but bridge->bus is never cleared, leaving it as a dangling pointer.

When brcm_pcie_remove() is invoked, it unconditionally calls
pci_stop_root_bus(bridge->bus). Passing a null or dangling pointer here
causes a kernel crash on the probe error path.

>  	pci_remove_root_bus(bridge->bus);
> +	pci_unlock_rescan_remove();
>  	if (pcie->cfg->has_err_report)
>  		brcm_unregister_die_notifiers(pcie);

[Severity: High]
This is a pre-existing issue, but is pcie->bridge_lock used before it is
initialized during device probe?

During brcm_pcie_probe(), the function brcm_pcie_bridge_sw_init_set() is
called early in the initialization sequence. For devices where
pcie->cfg->has_err_report is true, this function acquires pcie->bridge_lock
via spin_lock_irqsave().

However, spin_lock_init(&pcie->bridge_lock) is not called until much later
in the probe sequence, after pci_host_probe() finishes. While the memory is
zero-initialized, unconditionally attempting to acquire an uninitialized
spinlock is structurally unsafe and can trigger lockdep warnings or crashes.

>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521161822.1329=
96-1-18255117159@163.com?part=3D4
