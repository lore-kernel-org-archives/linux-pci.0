Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9923DB651
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 08:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790239902; cv=none; b=WDjIz+/nQ0Df4LhpJu6IF1NLjtQAruG9OVgbJlPQVrNI5ORlbu+G2Bur3VtiIZydB9gDj3Y37S6R53Ha6rIKA2TRSkrXTPHV07IO31TOL6c2rXBxcvNZtoXgIpURkL+l3rIV0S36rOX4Wbbqu0latSq9qTkRxiyoFz0w6hnl+bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790239902; c=relaxed/simple;
	bh=BmI0dZc1OzemChHjyFQiPaN1GIFVp2GMelZfEUPxMcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OThwmo+uVEoYhve35bmi4QsZQ0ecOsOUceWbfDpGBkkgampq6wIPv/b77PRzbnriitWlHQ8aKvDTsHgHu7HzqN22AnKMs8tkgIQfhpEaPFR7xxMBgLc3PUKMpaAFTfq98c9njLOms9+bN5vi2wXG9zUqhftGOsk/tKtqnuc8aDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHH0nGsP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHH0nGsP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 503591F00893;
	Thu, 24 Sep 2026 08:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790239898;
	bh=XEJJKZqaP8xjYZaVzZlwuqVJrOreSz0de3WYYv+5tUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UHH0nGsPJkpekPqs1QTIDu/AYhURtamo8RQoRiM7LNLjMyjGJlFnj8IZ9CPYKMaqC
	 v8n1Eu2AqNm0HqxO8LPw+lzI4i/9FAL5HtZm06RA5Z3VDO9YsZ6QBVvW2nvOlVoL1e
	 6fHHkW1OA9VJNGPMe2jbQpTnVFoYHSaPD9xGZlOeee87YGbOnMqj3q7l2dGS7J0615
	 G95WoHSvJm9mBVHLgowvAyI5jYuANpqeoW1WiaHMlnY5TlnKJ1Ok7ahLyKfzz827GE
	 xNBSsNjY20bpQqsil8/vv9U/2deOmFCy3ywVB+1Pxg7F3BAGV0g/gBR/7aEMoIRmTs
	 1lZmv4Klg5y+Q==
Date: Thu, 24 Sep 2026 10:51:34 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org,
	Diederik de Haas <diederik@cknow-tech.com>
Subject: Re: [PATCH v4] PCI: dw-rockchip: Move the INTx irq setup to probe
Message-ID: <arTklmgPsyKzQf93@ryzen>
References: <1790222793-77182-1-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1790222793-77182-1-git-send-email-shawn.lin@rock-chips.com>

On Thu, Sep 24, 2026 at 12:06:33PM +0800, Shawn Lin wrote:
> Since commit b376b3ff9cb0 ("PCI: dw-rockchip: Implement .reset_root_port()
> and use for link down"), .reset_root_port() re-runs the host ops .init()
> callback to reprogram the Root Complex after a controller reset. That
> works for the register programming, but .init() is not re-entrant: it
> also creates the INTx irq domain and installs the chained INTx handler.
> Every root port reset therefore ends up with a second irq domain
> registered for the same fwnode: the previous one is leaked, as it is
> never removed, and worse, the INTx virqs of the downstream PCI devices
> were allocated in the previous irq domain and are never re-mapped, while
> the chained handler now looks up virqs in the new, empty domain. After a
> link down recovery, INTx interrupts are silently lost.
> 
> Fix it by moving the of_irq_get_byname() lookup, the INTx irq domain
> creation and the chained handler installation out of .init() and into
> rockchip_pcie_configure_rc(), just before dw_pcie_host_init(). The
> lookup has to happen before the host is initialized, because
> dw_pcie_host_init() enumerates the bus and probes the downstream
> devices, and pci_assign_irq() maps their INTx interrupts at that point:
> if the domain does not exist yet, the mapping fails and the devices end
> up without a usable INTx. This also mirrors how the qcom driver requests
> its global IRQ, and leaves .init() with nothing but idempotent register
> programming, so both .reset_root_port() and dw_pcie_resume_noirq() can
> safely re-run it. Re-running of_irq_get_byname() on every resume is also
> gone.
> 
> Fixes: b376b3ff9cb0 ("PCI: dw-rockchip: Implement .reset_root_port() and use for link down")
> Suggested-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Reviewed-by: Niklas Cassel <cassel@kernel.org>
