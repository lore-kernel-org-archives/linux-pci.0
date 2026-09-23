Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070FB568550
	for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2026 15:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790177148; cv=none; b=NwcgYL1UbWvK6ZzqcBMDvbxvnC+tUyqx4hwXzVdXbwGWrNxmjbCyhOrudwNdaWpGkbz6fzeX78Ken4pheIsTzce0En6zvTV2gUiIjffm06OCD4z3FlP2sAP9B3FtCkU12vOSuXygHrTxygyGzy67ugq5w/8E3sgBWcQ+cuUbuTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790177148; c=relaxed/simple;
	bh=r9Ab5a7Egx3XYpsLnGiCdtZY9Jt4nLTpFaULFI6qCHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pdmmgoZhQxrFqOQjuI7AhiLXsJC72FW/Zlb/cKOSYeypNvt5onkFYwTe8t+bJC1GZD1rUWl1sy1GKfVo4UcEKufGXh1TVRFL/G6HDiBj/zyygu1aorGNudpRl3ecw/rM6LGTKHhG6OlfNbIJnNgGn5r1FRt/jqf7ajq4h1ctPHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfnB3VF2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfnB3VF2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BFEB1F000FF;
	Wed, 23 Sep 2026 15:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790177141;
	bh=qHMkX2s9Ge8svmrLSvkdu6SgikwO19QmNNhQJas/lcM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jfnB3VF2Mun/fQccSLUyRjXMpQYqNRFR9bCzxnBRJTM0GCVE44C3FNuDX9wKN37Ea
	 IjHrTxYdx13JjKOb2UCZMDetm3QS/dP2bCmRznn7ajMlyv+6TR0njobemwvn6HBHd8
	 gEUmatf55G6LPyMJGuU3548oI+fbglph9jv9ziGZXsOBvpwRWTXOfAyvbfrnb9Ejf+
	 EW+YPAIcrrPAB/qVHbXVEb5ADlVyeW5NPAABidsROf5dhrOjtOVc4/or0/svc1nRZL
	 HznuI/36pKVGs3fAFCl5oTv5rgeljn0TXYETqEUcqaxXT7HnYcflESPVJGmNboRwjr
	 tcvr77JtUivGw==
Date: Wed, 23 Sep 2026 17:25:37 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Diederik de Haas <diederik@cknow-tech.com>,
	linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3 0/3] Small INTx fixes for Rockchip's dwc based PCIe
 controller driver
Message-ID: <arPvcQIu46N_gTmB@ryzen>
References: <1790044622-164744-1-git-send-email-shawn.lin@rock-chips.com>
 <DLMKWV1AH8TZ.2R3JK2NPM4KZB@cknow-tech.com>
 <08329b2b-449a-4036-8e82-ad67d0d037ee@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08329b2b-449a-4036-8e82-ad67d0d037ee@rock-chips.com>

Hello Shawn, Diederik,

On Wed, Sep 23, 2026 at 05:21:59PM +0800, Shawn Lin wrote:
> >
> > I build a kernel with this patch set (7.3~rc4-2) and got several warnings
> > like this, shortly followed by a stack trace:
>
> Sashiko already reportted some valid concern around this, and I'll plan
> to rework this series a bit later. Thanks for reporting this.

Just thinking out loud:

Patch 1/3 in this series fixes a regression, so it should be picked up as
soon as possible.

Patch 2/3 is converting the resources to be device managed.
However, after patch 1/3 (if the moved code is called _before_
dw_pcie_host_init()) the only thing left after dw_pcie_host_init() is the
PCIE_CLIENT_INTR_MASK_MISC write.

I.e. there is no error return remains that would need a dw_pcie_host_deinit().

So there is no strict need to convert to devm_().
You can do so, but that should be in a separate series IMO.


In fact, Diederik's later warnings are a result of Patch 2/3 which replaced
irq_domain_create_linear() with devm_irq_domain_instantiate():

   error: hwirq 0x0 is too large for :pcie@fe150000:legacy-interrupt-controller
   WARNING: kernel/irq/irqdomain.c:676 at irq_domain_associate_locked+0x118/0x1a0


The fix seems to be to add .hwirq_max = PCI_NUM_INTX, to
rockchip_pcie_init_irq_domain():

The fix is one line in rockchip_pcie_init_irq_domain() :
				.size = PCI_NUM_INTX,
				.hwirq_max = PCI_NUM_INTX,



Patch 3/3 looks like a theoretical problem that Sashiko found.

Is the underlying problem real? It's plausible, but nobody has reproduced it.
For it to happen, the controller's legacy IRQ output has to be asserted while
clocks are gated. Two ways that could happen:

- The output was high when clk_bulk_disable_unprepare() froze the logic.
- A device was still asserting INTx when an AER- or sysfs-triggered reset
  stopped the link.

Patch 3/3 is not enough though:

disable_irq() never masks this chained IRQ in hardware, so
rockchip_pcie_intx_handler() can still run and read the unclocked APB.

This is the kind of case IRQ_DISABLE_UNLAZY exists for, according to the
comment above irq_disable().

Minimal amend of patch 3/3 as it currently looks:

turn off lazy disable for this line when the chained handler is installed:
	irq_set_status_flags(rockchip->intx_irq, IRQ_DISABLE_UNLAZY);
	irq_set_chained_handler_and_data(rockchip->intx_irq,
					 rockchip_pcie_intx_handler, rockchip);

Such that irq_disable() masks the chained IRQ.

Do we want patch 3/3? Probably.. but this race seems very small...
probably most imporent to get patch 1 (with the code move _before_
dw_pcie_host_init()) accepted ASAP, as it currently is causing problems
for Diederik.


Kind regards,
Niklas
