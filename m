Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69595495AC0;
	Wed, 16 Sep 2026 16:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789576582; cv=none; b=V3Wv73LPk2GZqlMfFnPeiI/IXZX/PFl4Z7loYbUCcat9ZlYnSHkAdKDCRwQjbGTEJPtlCkQchjAgZoicr58CXDIpg1/C4Pu+PSR/4YdEho/x5XTkYRTGrgZTJ2+6PaRlrETIHwrVfrQIra++eODAlbip1qdmx6tNdT3P6O+YuAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789576582; c=relaxed/simple;
	bh=lP0PNuTOzAf1niRdMyk8DC2qQ5nMAHczVp7Sif7J3oY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=WjDpfgGls/DqtGR624GoP2O6qcESa3u+NpHG4zex96k9pTylQnsqqbSmnxLUZvTsG98nSmdSQJh2FtcTNuUxOoGeClIPQdd4LKaGijc1VTNgqt6+l6v68MB+7+PWMi1jXCJn7TjTAtC4OTKBItTuLjXfSacuwlnjsdj77k/Tp6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UvJ337nk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UvJ337nk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D2C01F000FF;
	Wed, 16 Sep 2026 16:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789576577;
	bh=cTDQU2a4xA6zMCGkHZ1RKkFxyNk98kBgQHraj3q3KGU=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=UvJ337nkiarHTREPKIx+MfkaHS85iCrr+b/Xzi5MEKY9g9kAuAxhLIQkXY36Xafgm
	 CTcgB3CIgJeyG+pU1nawACvwmcuNQzME+001LPW5zsBKNo2QqVFegl0cmgycrznOOy
	 KMMPhACcbjxk0SqABN68Dy6WdKs82by0T/et4cjviSloYQ8x4ZARychMQv3P0vsGxF
	 2PNengmoaEmL0ZWVYfkPkwwtQDvF9XcrxUfZ3Lo5wi8PAapMdRhxvlDTvtSFTxl1/Z
	 gXquUIIvYYXUkQR5k9P2zhqxqG9qUIQHPASUmo9feNw7i4obC5lChx1d9GhPK9/m6w
	 0w6k3x68UZsOA==
Date: Wed, 16 Sep 2026 11:36:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Qiang Yu <qiang.yu@oss.qualcomm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
	Andrew Scull <ascull@google.com>
Subject: Re: [PATCH v2] PCI: qcom: Block accesses to downstream devices on
 link down
Message-ID: <20260916163615.GA927772@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86jyol62sx.wl-maz@kernel.org>

On Wed, Sep 16, 2026 at 09:03:26AM +0100, Marc Zyngier wrote:
> On Wed, 16 Sep 2026 00:14:21 +0100,
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> > 
> > [+cc James, Andrew, Marc for guidance on generic arm64 PCIe error
> > recovery; beginning of thread:
> > https://lore.kernel.org/all/20260819-ecam_blocker-v2-1-e7a8fdc1c5cb@oss.qualcomm.com]
> > 
> > On Tue, Sep 15, 2026 at 07:16:11PM +0200, Manivannan Sadhasivam wrote:
> > > On Fri, Sep 11, 2026 at 12:18:07PM -0500, Bjorn Helgaas wrote:
> > > > On Fri, Sep 11, 2026 at 08:17:29AM +0200, Manivannan Sadhasivam wrote:
> > > > > On Tue, Sep 08, 2026 at 06:00:30PM -0500, Bjorn Helgaas wrote:
> > > > > > On Wed, Aug 19, 2026 at 11:36:54PM -0700, Qiang Yu wrote:
> > > > > > > After a PCIe link goes down, software may still access the
> > > > > > > BAR (MMIO) space or configuration space of devices behind
> > > > > > > that link before recovery has run. As the link is down,
> > > > > > > these accesses never complete, resulting in a storm of
> > > > > > > Completion Timeout AERs.
> > > > > > 
> > > > > > What is special about qcom here?  It seems like the Completion
> > > > > > Timeouts and AER interrupts should happen with every PCIe
> > > > > > controller.
> > > > > 
> > > > > The special behavior which is common across many (not all) ARM
> > > > > SoCs is that they don't synthesize all-one response for
> > > > > completion timeouts, unlike RCs in x86 machines. Rather, they
> > > > > return AXI error response, resulting in CPU treating them as
> > > > > SError, in-addition to AER storm.
> > > > > 
> > > > > Commit message missed mentioning SError though.
> > > > 
> > > > I don't know how SError works, but this sounds like a pretty big
> > > > open issue with respect to RAS.  I don't think we want a kernel
> > > > panic because a device failed to respond to a config or MMIO
> > > > access, e.g., if a card or Thunderbolt cable got unplugged.
> > 
> > I still don't know anything about arm64 or SError, but I see these KVM
> > commits about using ESB to manage SError in some cases:
> > 
> >   0e5b9c085dce ("KVM: arm64: Consume pending SError as early as possible")
> >   472fc011ccd3 ("KVM: arm64: nVHE: Don't consume host SErrors with ESB")
> > 
> > I assume it's not possible or practical to use ESB in the native host
> > case to deal with issues like this in a generic way instead of the
> > vendor-specific feature Qcom is using here?
> 
> In general, an SError is fatal. No ifs, no buts. It is asynchronous,
> and has no syndrome information. Once you find out about it, you're
> already dead.
> 
> ESB is a way to paper over this sorry state of affair by making sure
> that the error is observed at a known point. You can think of it as a
> barrier synchronising potential errors for transactions in flight. KVM
> uses that to attribute SErrors triggered by a guest, on an exception
> boundary.
> 
> That's not applicable to the kernel itself, unless you want to place
> an ESB after each and every load/store in the kernel (/s).
> 
> Modern versions of the architecture allow these errors to be reported
> as *synchronous* exceptions, with all the syndrome information you
> want. I guess this HW doesn't implement it, which is a pretty big
> mistake for systems that allow surprise removal of devices...

Thanks a lot for this background, Marc.

I guess we should take advantage of this qcom feature to at least
avoid some issues.  I think we just need to update the commit log to
clarify:

  - The reason this is important: apparently lots of AER interrupts
    but sounds like unrecoverable SError in some cases; I think it
    would be useful to understand the differences and whether CT and
    UR are handled differently.

  - What the result of the ECAM blocker is.  IIUC it blocks both
    config and MMIO.  I assume it prevents transactions from reaching
    PCIe so they don't cause UR or CT; maybe writes are dropped and
    reads return ~0 for both config and MMIO?

  - This is best-effort but not 100% because accesses between
    link-down and ECAM blocker being enabled can still cause AER
    interrupts and SError.

I'm more interested in these PCIe-level details than in the nitty
gritty of programming the controller; we need that too, but maybe some
of that can be addressed by code comments, e.g., the mutex could have
a one-line comment about avoiding races with RP resets via AER
recovery.
