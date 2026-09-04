Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344D62FD7D3
	for <linux-pci@vger.kernel.org>; Fri,  4 Sep 2026 13:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788527235; cv=none; b=EiN0LDvEKSPIyA1FldienkcCwmpo97pmkJMhGvKf0u3g+KIFkjdTmvh3Oo56g7ARrqJBulaWkSaJlbpSoNKJ3+zfxSID6frfKb/KsyB3p+8xHmz9WlU5OxQE5n68c9tf1EWmtS1s2hg3xFm6msUtIUwWV0t+A+FXwNSDXpThQyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788527235; c=relaxed/simple;
	bh=ZCQccJl36xewbXiUcDkYhGL6p+hMfDYd20FGy3iplO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RRo10FYULnB5Owe8pWAFf6XUUjs31e6yDezRU64sb0kYtQ8wJEOZuJH+2q8FckR3Kzvrh8BzQB9pvtNEI7xJx57J4cN4H+D8ZjCO7QMrb39FKNkEzrjDIV3l7jjafjcwhlbP+660K56ka6BSuE+DXUke03PLk2RaUfMMBcOdF7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OF7/7GuZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OF7/7GuZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D0581F00A3D;
	Fri,  4 Sep 2026 13:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788527233;
	bh=gGkHkZzkVW6DGI/musisUQVSQ3nO7MJaOAJUcl+rmIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OF7/7GuZqjBa3t9j0zbucx1Cp4NHp2XVzcUd0a/nqMTYPlz5ft58IO5evUwy8KtjB
	 HuFJACgXPmH193rRZWkngSqtiE/SXtEZ4SilCZFW/M64l9TT54YNz2WIrJpLO+ParR
	 pvS6VbH8t90JwHhXe1whCD3rGQgh9yWWIFCzlgHbwgIvcfOCxur5kcTXddPHLh0Yjr
	 1P3GXYpK1KlGl69kWrNGqHLZMyKrWnyx7N8Rembpc2+r+rEurJWZJEtZ8TCH4lF9Dk
	 UoH5CsXsegCw85ezo6HLXa8LSjR38oexVeIZd2nOyHCJwrnbL9+vFaFPQFX4LmCI8s
	 W6IvIzgOKEyhA==
Date: Fri, 4 Sep 2026 15:07:09 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: Re: [PATCH v2 1/2] PCI: dw-rockchip: Move the INTx irq setup to
 probe and make it devm-managed
Message-ID: <aprCfVgc1dl_h24T@ryzen>
References: <1788484709-139123-1-git-send-email-shawn.lin@rock-chips.com>
 <1788484709-139123-2-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1788484709-139123-2-git-send-email-shawn.lin@rock-chips.com>

On Fri, Sep 04, 2026 at 09:18:28AM +0800, Shawn Lin wrote:
> Since commit b376b3ff9cb0 ("PCI: dw-rockchip: Implement .reset_root_port()
> and use for link down"), .reset_root_port() re-runs the host ops
> .init() callback to reprogram the Root Complex after a controller
> reset. That works for the register programming, but .init() is not
> re-entrant: it also creates the INTx irq domain and installs the
> chained INTx handler. Every root port reset therefore ends up with a
> second irq domain registered for the same fwnode: the previous one is
> leaked, as it is never removed, and worse, the INTx virqs of the
> downstream PCI devices were allocated in the previous irq domain and
> are never re-mapped, while the chained handler now looks up virqs in
> the new, empty domain. After a link down recovery, INTx interrupts
> are silently lost.
> 
> Fix it by moving the of_irq_get_byname() lookup, the INTx irq domain
> creation and the chained handler installation out of .init() and into
> rockchip_pcie_configure_rc(), right after dw_pcie_host_init(). This
> mirrors how the qcom driver requests its global IRQ, and leaves
> .init() with nothing but idempotent register programming, so both
> .reset_root_port() and dw_pcie_resume_noirq() can safely re-run it.
> Re-running of_irq_get_byname() on every resume is also gone.
> 
> With the irq setup now living in probe, tie its lifetime to the device
> with devres: create the irq domain with devm_irq_domain_instantiate()
> and uninstall the chained handler through the
> rockchip_pcie_intx_chained_release() devres action. The driver is
> builtin and cannot be unbound (suppress_bind_attrs), so probe failure
> is the only path that ever needs this cleanup, and devres takes care
> of it without sprinkling it over every error path. Since the irq setup
> is the last step of rockchip_pcie_configure_rc(), the only failure
> point left after the chained handler is installed is
> devm_add_action_or_reset() itself, whose failure mode runs the action,
> so the handler can never run against the devm-freed rockchip
> structure. devres also unwinds in reverse registration order, so the
> handler is always uninstalled before the domain is removed. There is
> no devm API for chained handlers, hence the small devres action
> wrapper.
> 
> Fixes: b376b3ff9cb0 ("PCI: dw-rockchip: Implement .reset_root_port() and use for link down")
> Suggested-by: Niklas Cassel <cassel@kernel.org>
> Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

I would have written it in two commits:
1/3 that moves the of_irq_get_byname() lookup, the INTx irq domain creation,
    and chained handler installation.
2/3 that makes the irq doman device managed, to not leak the resources, as
    flagged by Sashiko
(3/3 that masks the INTx IRQ during .reset_root_port())


Since fixing the resource leak seems like a separate issue.

The commit message for this patch does seem quite long, mostly because
it is fixing two separate issues.


Sorry that we did not detect this INTx issue when sending the
.reset_root_port() patch. Since RK3588 does not support INTx in EP mode,
it is unfortunately not tested when running the pci_endpoint_test selftest.


Kind regards,
Niklas
