Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0A34229A6
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 17:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785173970; cv=none; b=TXws3FeRZxsPTWWqSSAXo6uyB9agto9k6DMY7lsJpeOCyq3RfzuuMhJx1t2QwNsP47vv17DbRO8DoFF+uyii3YsrQmgblmWFfl9KfcixKo3p2q0H1ey1owj/6WVgMPk4IwEwrr1BqymHCL+3iHbiH7seX2EiPZHSW/gbFM7pZp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785173970; c=relaxed/simple;
	bh=680wwbNAAoZJ7okHTMj/VsRgoTAOt5I3CE1YO6N3qqk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H7jmcqCPnuZn7DYF/8ohtqPMW3H3foGkuzPy//zY53auyb5bvGKfKO9iN3fNBD0Z2UBeYebXhgNvC1ZvO9dMFJhAFMx8WFdy0uGNyF/HI+WGrYm3MLe/8uhcPZNsMRvrkdfjK4zlITCvuG+16Awd/NcAourhIOtGH8NjENKEJ/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=McShUfRz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="McShUfRz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FD0E1F000E9;
	Mon, 27 Jul 2026 17:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785173968;
	bh=680wwbNAAoZJ7okHTMj/VsRgoTAOt5I3CE1YO6N3qqk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=McShUfRzC7GpQ/C74yRc/4Sb97z4KUGDvDiyRnX5Qvs2iRPYjpbq5TvIrycM7TEbo
	 eqbFNbcSBE8QGRLNDuarBVuI7kHCxlBTBjN1/fQ29AqBsyoLFZYUaoeZmYGr8/5Ajn
	 s4A3D3GgmAAHsq1oJMlrlqW3kOckwWGCbDVIepW7KxGRLF+9aXsdqYCvQiL29ohyMU
	 lmUfgNEykYOwTE4AN9I4GQIerwbno9owgsSu/vJBsNigPXghwuP2VAHPvpjjhh+MUE
	 bJbSbmHwfM7YaX+1+dj6LHtkc5/jshqUBi2+F8jrwbKDfPlO95pwSQcFMq0C8TsH5q
	 AxFuk3oym8eJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/1] PCI: dw-rockchip: Add support to reset Root Port
 upon link down event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Niklas Cassel" <cassel@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260727172654.605988-4-cassel@kernel.org>
References: <20260727172654.605988-3-cassel@kernel.org>
 <20260727172654.605988-4-cassel@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 17:39:28 +0000
Message-Id: <20260727173928.6FD0E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] The patch calls `pci_host_handle_link_down()` which is neither def=
ined nor declared anywhere in the kernel tree.
- [High] The code attempts to assign a callback to a non-existent member `r=
eset_root_port` in `struct pci_host_bridge`.
- [High] Repeatedly calling probe-time initialization functions in the link=
-down reset handler causes severe devres memory and resource handle leaks (=
clocks, PHYs, and IRQ domains).
- [High] Early IRQ registration before structures are initialized causes a =
race condition leading to NULL pointer dereferences in the 'sys' IRQ handle=
r.
- [High] Iterating over the PCI bus devices list without holding the `pci_b=
us_sem` reader lock leads to potential list corruption or use-after-free.
- [High] Disabling APB clocks during reset races with interrupt handlers, l=
eading to synchronous external aborts.
--

--- Patch [1]: [PATCH 1/1] PCI: dw-rockchip: Add support to reset Root Port=
 upon link down event ---
commit 026e07d49a335504d0a8afc363c1f59787c29767
Author: Wilfred Mallawa <wilfred.mallawa@wdc.com>
PCI: dw-rockchip: Add support to reset Root Port upon link down event

This patch implements a reset_root_port callback for link down handling
on the Rockchip DWC PCIe host controller. It also adds a sys IRQ thread
to detect link-down events and issue the reset.

Note: The format of this review has been altered to provide a free-form
summary of findings, without directly quoting the original patch code,
due to recitation restrictions.

[Severity: High]
In the new sys IRQ handler rockchip_pcie_rc_sys_irq_thread(), the code
calls pci_host_handle_link_down(). Is this function defined or declared
anywhere in the kernel tree? It appears missing, which might cause a
compilation failure or linker error when this driver is built.

[Severity: High]
In rockchip_pcie_host_init(), the patch assigns
rockchip_pcie_rc_reset_root_port to pp->bridge->reset_root_port. Does
struct pci_host_bridge actually contain a reset_root_port member? It
looks like this member does not exist in include/linux/pci.h, which could
result in a hard compiler error.

[Severity: High]
When rockchip_pcie_rc_reset_root_port() is triggered, it calls probe-time
initialization routines such as rockchip_pcie_phy_init(),
rockchip_pcie_clk_init(), and pp->ops->init() (which eventually calls
rockchip_pcie_init_irq_domain()). Because these functions use devres (like
devm_phy_get and devm_clk_bulk_get_all) or create new linear IRQ domains
unconditionally, does this repeatedly leak PHY objects, clock arrays, and
devres memory on every link-down reset? Recreating the IRQ domain might
also break existing mappings.

[Severity: High]
In rockchip_pcie_configure_rc(), devm_request_threaded_irq() for the
"sys" IRQ is called before dw_pcie_host_init() completes. If the interrupt
fires immediately, the handler rockchip_pcie_rc_sys_irq_thread() will run
and iterate over pp->bridge->bus. Since pp->bridge and its bus are not
fully allocated and assigned until dw_pcie_host_init() finishes, could
this lead to a NULL pointer dereference?

[Severity: High]
The handler rockchip_pcie_rc_sys_irq_thread() iterates over the PCI bus
devices list using for_each_pci_bridge(port, pp->bridge->bus). Is it safe
to iterate this list without holding the pci_bus_sem read lock? Concurrent
PCI hotplug, sysfs rescan, or unbind operations might modify the list,
potentially leading to list corruption or a use-after-free.

[Severity: High]
In rockchip_pcie_rc_reset_root_port(), clocks are disabled via
clk_bulk_disable_unprepare() without synchronizing against active interrupt
handlers. If an interrupt such as the intx handler fires concurrently, it
will attempt to read APB registers like PCIE_CLIENT_INTR_STATUS_LEGACY
while the APB clock is off. Will this cause a synchronous external abort
and system hang?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727172654.6059=
88-4-cassel@kernel.org?part=3D1
