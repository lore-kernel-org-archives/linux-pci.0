Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB272877C3;
	Mon, 10 Aug 2026 23:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786404643; cv=none; b=Fd+Yn2oa9l1amOYMYtuXnPsBcqeYSxvEpim/axD56rn+BJ9Q4emQ8B8qZEcfYABmXB3HmyhDC5OoK/GM54KgZXNwEQnIz7eRDLNwlo6GitLd8vcQL2KdI+qo+Ng4vfD1rVWv8vBTu6W1EqImwCRnoCGbE7KRTFdMUf2IkOruxfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786404643; c=relaxed/simple;
	bh=Ab/3H6BNSk3SNxVitDFQ9RBoYd3f0hX0875X7DPZkaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Y4t4bdMFN9e7MAsH0UeLq5B/Une2JU/FFTqESKNX8c8VYiVma5zuFT2s4Vfe+j5mTTv2WtzekmbFEZXooCh57D0OwT7jE9TtUIOh8U8DZ7mhrB7R4VWOw7XqXz7JmyWox5OTRBacy5jSSwRZts0W5CDYmTK4kbT2glkJyHO9xvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCng2b2i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCng2b2i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A801F000E9;
	Mon, 10 Aug 2026 23:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786404641;
	bh=+7hEmmS6m6/bDdPV7mlKcb6oV8gt+eTtfDb/u506UOc=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=VCng2b2iAaxGhTPcjiE8WLaFwvWHEnmcem+pvA/e46P2IQMJqbX1xJkcySP6UlV+B
	 G04Yk0Wv4tIzFB/PwbKipKH/mLJ3HgmvqNIkd4UpzxytzdkOHVNIWF+MdlAgcU0Bu9
	 7KJm9hp4XX//C77docNO8HF2UyeCr/9PDZmybdZVaUX7Tw2cuvGCsf3S4n1a+jIDzW
	 kvpCJyLY3I6QIu7PjU3Ai76Yy2CXWYNCPaRz4zZuqKb4IxJFpy/Jun8X1sYp8B3vRM
	 u3UdFVkgdDTS7BxNVaxzvAxJoPmmOArS1yuzeiJsqXipK6YnPaYIJi2UP/Brene7WW
	 qQwNX7LvkeyRw==
Date: Mon, 10 Aug 2026 18:30:40 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Han / =?utf-8?B?7ZWc7IOB7JqwU2FuZ3dvbw==?= <sangwoo.han@nearthlab.com>
Cc: jim2101024@gmail.com, florian.fainelli@broadcom.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	bhelgaas@google.com, bcm-kernel-feedback-list@broadcom.com,
	robh@kernel.org, linux-pci@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@kernel.org>
Subject: Re: [PATCH] PCI: brcmstb: Reserve only the MSI vectors that are
 handed out
Message-ID: <20260810233040.GA511779@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260804125057.GA1834533@bhelgaas>

On Tue, Aug 04, 2026 at 07:50:57AM -0500, Bjorn Helgaas wrote:
> [+cc Marc, author of 4615fbc3788d ("genirq/irqdomain: Don't try to
> free an interrupt that has no mapping"), Thomas; beginning of thread
> about multiple MSI vector alloc/free:
> https://lore.kernel.org/all/20260730072215.2090974-1-sangwoo.han@nearthlab.com]
> 
> On Tue, Aug 04, 2026 at 08:31:23PM +0900, Han / 한상우Sangwoo wrote:
> > > Several other PCI controller drivers have similar code.
> > 
> > I agree - eleven of them look like they can have the same problem.
> > 
> > > I think we should fix them all at once (or explain why they don't need
> > > similar fixes).  Might be worth a little helper so they all work the
> > > same way (e.g., some use order_base_2(), others use get_count_order(),
> > > which seems like a pointless difference).
> > 
> > I am working on a related fix for drivers/irqchip/irq-bcm2712-mip.c,
> 
> Similar pattern there, but it uses ilog2(), which differs from
> order_base_2() and get_count_order() in more cases.
> 
> > which I can test here.  I would rather not send changes to drivers I
> > cannot test, though, so I am leaving the eleven to whoever has the boards.
> > What I looked at is in the appendix, in case it is useful to them.
> > 
> > Two things seem more useful from where I am sitting.
> > 
> >  - The failure is silent.  Appendix A describes the symptom, so that
> >    anyone who hits it later can find this thread.
> > 
> >  - The contract is not written down.  It changed in 4615fbc3788d, where
> >    irq_domain_free_irqs_hierarchy() started freeing one vector at a time.
> > 
> > order_base_2() and get_count_order() give the same answer for any
> > nr_irqs >= 1, so consolidating those two is just cleanup.  Where a shared
> > helper should live I am not sure either.
> 
> I don't know either, but I hate fixing an issue in one place and
> leaving the same issue unfixed nearby.

Just to be clear here, I'm going to defer this until we can fix
everything in drivers/pci at once.  If we can add a fix early in the
cycle, e.g., soon after -rc1, people with other controllers can help
test it.

If we only fix one driver, the pattern will continue as people copy
and paste the bug into new drivers.

So that's why I haven't pulled the pci/controller/brcmstb branch
(which contains this patch) into pci/next.

> > Appendix A - the symptom
> > ========================
> > 
> > A PCIe device whose driver is unbound and rebound a few times, or whose
> > module is reloaded, ends up with fewer MSI vectors than it asked for.  It
> > does not recover until reboot.
> > 
> > Two things have to be true for it to happen: the device uses multi-MSI,
> > and the vector count it asks for is not a power of two.  Devices that ask
> > for a power of two are unaffected, and so is anything on MSI-X.
> > 
> > I have only seen the reduced-vector case.  A driver that insists on the
> > full count would fail to probe instead, but I have not seen that happen.
> > 
> > 
> > Appendix B - how I sorted the drivers
> > =====================================
> > 
> > I went through drivers/pci/controller/ while working out what my own fix
> > had to do, so this is that rather than a full audit.  Twenty of the
> > drivers own an MSI hwirq pool.  I asked three things about each:
> > 
> >  - does .alloc reserve a rounded-up block, or a single slot
> >  - does the core hand .free one vector at a time
> >  - can nr_irqs > 1 reach the driver at all
> > 
> > Eleven answer yes to all three:
> > 
> >   dwc/pcie-designware-host.c   pci-aardvark.c        pcie-apple.c
> >   pcie-aspeed.c                pcie-iproc-msi.c      pcie-mediatek-gen3.c
> >   pcie-rcar-host.c             pcie-rzg3s-host.c     pcie-xilinx-dma-pl.c
> >   pcie-xilinx-nwl.c            pci-hyperv.c
> > 
> > The other nine:
> > 
> >  - five reserve a single slot, so nothing rounds up:
> >    mobiveil/pcie-mobiveil-host.c, pci-xgene-msi.c, pcie-altera-msi.c,
> >    pcie-mediatek.c, plda/pcie-plda-host.c
> > 
> >  - vmd.c keeps a per-vector refcount instead of a bitmap
> > 
> >  - pci-tegra.c and pcie-xilinx.c reserve a rounded-up block, but neither
> >    lists MSI_FLAG_MULTI_PCI_MSI in msi_parent_ops.supported_flags
> > 
> >  - pcie-brcmstb.c is the one you applied
