Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2471A51C073;
	Tue, 22 Sep 2026 12:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790078589; cv=none; b=NN0j8U9mMB8s2xCTrOaA9rDcMR0S8dwz7JNZ2+Sk/0lr3YHzsMvUjlqzrw6n947WRLbPsGCKaCnJ/oKyNcobm8lScH+jO30S5+SZ5IzZmJT2MHjhs7XY4E1ta8ZI66G6Kv/hxVFFduQF2cXqAFNo4ngh9p0zIKhHTol+p12NbCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790078589; c=relaxed/simple;
	bh=ZPO5CXeCLqcvaH0I/WkgJHL+ISl1+ikBTCuS4DRjBw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHc2wiSAq6wmDlirGlgFzxt3Zubjj1s3wpozWemu4GTkqKMlB8cj8Bfo/bhV9R1SmHaSeWIX5EVEPnmzlmGSMXgYOWXZ1EsKGtUU+F9blgbm6T95nZ46zQf0RwtBgKtetOZ+ww67aYq6cE2W1OP8VKWimV6Ga69xf/T8LmFAGi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMUe1Z4L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMUe1Z4L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D55CC1F000FF;
	Tue, 22 Sep 2026 12:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790078587;
	bh=hCtAUGHVQbM0y1hSoXEuxktfPZV15cpsiXS3ZAOkNuQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZMUe1Z4L53RuG30fWJ2UTH54BMpZXR0WfIJI6nyJ8Xm+QthPKZmz/ASSHIJwFMOUT
	 TYVwKCiyQ5FdIky4MxWCcqX2BZb6KHXmQsweB/EEWhjRMFRuxnAiX2BeYJrQ+FoSXU
	 qd72eZT4cBzO9XoL86BC1k7YTseaG5k5SirTs9ubfrECUN13szjTqSqgfs+UfgBJAZ
	 Uj2PzppgqgLZvICsRh5e1nV+zzALqotEzwjrPC1M/bmLhwrpEOOC2toiHZ9fh7YYZ0
	 Qagg3f8E/mCpk7US2cRoVsF8iBqYa1p9PwbvC7/lc8N/suekd1mw90qZscUaYSFzDA
	 Izql067IUtRcQ==
Date: Tue, 22 Sep 2026 14:03:04 +0200
From: Niklas Cassel <cassel@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Shawn Lin <shawn.lin@rock-chips.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 1/3] PCI: dw-rockchip: Move the INTx irq setup to probe
Message-ID: <arJueF46fIYDiwUp@ryzen>
References: <1790044622-164744-1-git-send-email-shawn.lin@rock-chips.com>
 <1790044622-164744-2-git-send-email-shawn.lin@rock-chips.com>
 <20260922025140.5B4F31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922025140.5B4F31F000FF@smtp.kernel.org>

On Tue, Sep 22, 2026 at 02:51:39AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] pcie: missing dw_pcie_host_deinit() on error paths causes UAF
> - [High] pcie: late INTx IRQ domain registration breaks downstream INTx interrupts
> --
> 
> commit af2f81da80dcb1ab2a4b7035c602bf3d2a40f1c9
> Author: Shawn Lin <shawn.lin@rock-chips.com>
> 
> PCI: dw-rockchip: Move the INTx irq setup to probe
> 
> The commit moves INTx IRQ domain setup out of the host ops .init() callback
> and into rockchip_pcie_configure_rc() to avoid leaking the domain upon
> controller reset. It performs the IRQ initialization immediately after
> dw_pcie_host_init() completes.
> 
> > diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > index af26a07c0c9e5..59d9a1b095df6 100644
> > --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> 
> [ ... ]
> 
> > @@ -739,6 +725,24 @@ static int rockchip_pcie_configure_rc(struct platform_device *pdev,
> >  		return ret;
> >  	}
> >  
> > +	/*
> > +	 * This is done here instead of in the host ops .init() callback,
> > +	 * which is also re-run by .reset_root_port(), so that the INTx irq
> > +	 * domain is only created once, at probe time.
> > +	 */
> > +	irq = of_irq_get_byname(dev->of_node, "legacy");
> 
> [Severity: High]
> Does moving the INTx IRQ domain creation here cause downstream devices to lose
> their INTx interrupts?
> 
> Since rockchip_pcie_configure_rc() calls dw_pcie_host_init() right before this,
> which internally invokes pci_host_probe() to enumerate the PCIe bus, downstream
> devices will be probed before this new code is reached.  When those devices
> attempt to map their legacy INTx interrupts via the device tree, they won't
> find the IRQ domain since it hasn't been created yet, which seems like it would
> cause the mapping to silently fail.
> 
> This architectural issue appears to remain unaddressed at the end of the patch
> series.

This appears like a legit concern.

I was the one who recommended that we call the of_irq_get_byname(), from
looking at e.g. pcie-qcom.c.

But I incorrectly said we should do it after dw_pcie_host_init().

Looking at pcie-qcom.c platform_get_irq_byname_optional() call was before
dw_pcie_host_init(). But if we look at e.g. pcie-tegra194.c, the
platform_get_irq_byname() calls are before the tegra_pcie_config_rp() call,
which calls tegra_pcie_init_controller(), which calls dw_pcie_host_init().

So I think Sashiko is right, of_irq_get_byname() (and the IRQ domain creation)
probably has to be done before calling dw_pcie_host_init().


If we do that, the other problem reported by Sashiko will probably also be
resolved, since you will return error before calling dw_pcie_host_init().


Kind regards,
Niklas
