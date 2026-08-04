Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E9F3DBD5E;
	Tue,  4 Aug 2026 12:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785847867; cv=none; b=Chq5gUET60g/CY+5ww9kZgtg3K1kIld121dnykJxhNRDaxiMvA5EgPTqj0kF/tuxzArqBtdGjRawVLxS+8EyeBVcvIjFT36mXzrQwQ2IjAgYUeDqPAEDk71pRGUJemfbj4VcoZL8f04hOdne76YKcColtIjKxC+QkF4dEWHRaEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785847867; c=relaxed/simple;
	bh=ze2NKcp1Ur92lXklztz77pARWs2VrCoUl9y46wg+PDI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=siz4VQ/jN7WS2l1dAOx7P5i5ZlTTZp8HetEM56z7Z3CHdJwvX7mmqw+SuxZrI+ok1iZnD0l0MlD5A5f/bQSir/a2wtyKLKs5iqAhYULxB2srGWPkjdjWIxlPNvB7DVN6XASIgoVJbZ101yRZXrOvd0TtbvrSaov4QXjnd9aljME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NotD7S8r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NotD7S8r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A58871F000E9;
	Tue,  4 Aug 2026 12:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785847858;
	bh=/Ic2b8esDfm00wQm8WodgOpVR7+0Q8spRsCljIJsje8=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=NotD7S8rP6w1nuiTKm5/hfabEr/pEp92em01z9rz6orn+5A2ZPotdYZOdKqQdXa10
	 3OyDLP0EK3RO66S78ON4WB0UyZuzvoJDUUqQ1bLeRAOWxts2HRfj09/0Uc3V6QATVs
	 5DQpBBBzn6OxSUZNBDErjuU50S1YYsi0cY/6uxwHsqSaYGrFcIDhZJTfruAcw5yRvK
	 tKjspKcJjEy/0pu29nKWbdEnuK+ep8klVx2fSFuHPvekA5NameOtF01FqNXfd6/Hfs
	 wyigQePDrD7NU3+A73A2c7qJ1pW3XU+AlaaQLdKfbbvntF4q0vmTZ16J8SlKh5aj81
	 uk+IZz4LEIiUg==
Date: Tue, 4 Aug 2026 07:50:57 -0500
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
Message-ID: <20260804125057.GA1834533@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFg7d9YX3dXYHFvhXX6VBR_Wd5QzAD77Rgugso5sYD-SwANnLQ@mail.gmail.com>

[+cc Marc, author of 4615fbc3788d ("genirq/irqdomain: Don't try to
free an interrupt that has no mapping"), Thomas; beginning of thread
about multiple MSI vector alloc/free:
https://lore.kernel.org/all/20260730072215.2090974-1-sangwoo.han@nearthlab.com]

On Tue, Aug 04, 2026 at 08:31:23PM +0900, Han / 한상우Sangwoo wrote:
> > Several other PCI controller drivers have similar code.
> 
> I agree - eleven of them look like they can have the same problem.
> 
> > I think we should fix them all at once (or explain why they don't need
> > similar fixes).  Might be worth a little helper so they all work the
> > same way (e.g., some use order_base_2(), others use get_count_order(),
> > which seems like a pointless difference).
> 
> I am working on a related fix for drivers/irqchip/irq-bcm2712-mip.c,

Similar pattern there, but it uses ilog2(), which differs from
order_base_2() and get_count_order() in more cases.

> which I can test here.  I would rather not send changes to drivers I
> cannot test, though, so I am leaving the eleven to whoever has the boards.
> What I looked at is in the appendix, in case it is useful to them.
> 
> Two things seem more useful from where I am sitting.
> 
>  - The failure is silent.  Appendix A describes the symptom, so that
>    anyone who hits it later can find this thread.
> 
>  - The contract is not written down.  It changed in 4615fbc3788d, where
>    irq_domain_free_irqs_hierarchy() started freeing one vector at a time.
> 
> order_base_2() and get_count_order() give the same answer for any
> nr_irqs >= 1, so consolidating those two is just cleanup.  Where a shared
> helper should live I am not sure either.

I don't know either, but I hate fixing an issue in one place and
leaving the same issue unfixed nearby.

> Appendix A - the symptom
> ========================
> 
> A PCIe device whose driver is unbound and rebound a few times, or whose
> module is reloaded, ends up with fewer MSI vectors than it asked for.  It
> does not recover until reboot.
> 
> Two things have to be true for it to happen: the device uses multi-MSI,
> and the vector count it asks for is not a power of two.  Devices that ask
> for a power of two are unaffected, and so is anything on MSI-X.
> 
> I have only seen the reduced-vector case.  A driver that insists on the
> full count would fail to probe instead, but I have not seen that happen.
> 
> 
> Appendix B - how I sorted the drivers
> =====================================
> 
> I went through drivers/pci/controller/ while working out what my own fix
> had to do, so this is that rather than a full audit.  Twenty of the
> drivers own an MSI hwirq pool.  I asked three things about each:
> 
>  - does .alloc reserve a rounded-up block, or a single slot
>  - does the core hand .free one vector at a time
>  - can nr_irqs > 1 reach the driver at all
> 
> Eleven answer yes to all three:
> 
>   dwc/pcie-designware-host.c   pci-aardvark.c        pcie-apple.c
>   pcie-aspeed.c                pcie-iproc-msi.c      pcie-mediatek-gen3.c
>   pcie-rcar-host.c             pcie-rzg3s-host.c     pcie-xilinx-dma-pl.c
>   pcie-xilinx-nwl.c            pci-hyperv.c
> 
> The other nine:
> 
>  - five reserve a single slot, so nothing rounds up:
>    mobiveil/pcie-mobiveil-host.c, pci-xgene-msi.c, pcie-altera-msi.c,
>    pcie-mediatek.c, plda/pcie-plda-host.c
> 
>  - vmd.c keeps a per-vector refcount instead of a bitmap
> 
>  - pci-tegra.c and pcie-xilinx.c reserve a rounded-up block, but neither
>    lists MSI_FLAG_MULTI_PCI_MSI in msi_parent_ops.supported_flags
> 
>  - pcie-brcmstb.c is the one you applied
