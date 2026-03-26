Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1098034D4DC;
	Thu, 26 Mar 2026 21:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774559096; cv=none; b=IRppzU4H0I/ONoVzfGfDLxIVGmGUMnw2yEmy5zW4uMCAu3XSJ1JJj0RKho45Z/k8NiSoOMvuraBXrp12/ZWm9nEWdIqTYvBbwZIgdP06IwQO6ledJuNozS0SqmA46OSvkoSIBF2PYXiWLiNAIBkDxIf8a6ofclIRq0zfZQPY2OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774559096; c=relaxed/simple;
	bh=8OgJ4jbQAz4yn5vV4PAVC3IJ+ThvFIUcEE3/++EiDTo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Y/zT+GlwLzWhrPJlBr/qZYpjkzt0V/XL47HbtTXhEUWxwawozwrk8xcCmkGQ/gxAfbT6oQtIFlYaMFmi3XbU1jeE5pmH59lE+k87EEU9zynXl98hPc0sKwgiB5wYuiSfxqsEo7nvrgLgMsvlOSzrPgvJhy6aDKz7bBpm0jjutdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BKR3mhna; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKR3mhna"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F94C116C6;
	Thu, 26 Mar 2026 21:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774559095;
	bh=8OgJ4jbQAz4yn5vV4PAVC3IJ+ThvFIUcEE3/++EiDTo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=BKR3mhnaFQNy1sN6YQRpjKlZQBN6UiXiAcpgI7Zzn0Wg3IZhCMwyYfAxy2mEbQzs4
	 ag0o0Hf2l6eqX6hDB9hNRZBZnSkUQDKjQMu4IbPTvRq/v0XwmU9AoCDWoBuzen4xvH
	 qUVwUTdC3HR3A9KyXXdQ9hzLpkdtmyzrzadsDyLYNnV3GlD1C+vQKWclhCw+At9q6h
	 Gfvqb0hZVu3L0Pf7oEFiLK1xrU6lCGV7EoMH6R3P8UglspifRhvUAvNfcbrtf0XpR9
	 1MEcamiJadpPzFs5ouv2zHqEjqosHcnRMQv13fOkA1rMr0n+E9q5NF2kvkMzAb67Cs
	 w6YLaRasPPFrg==
Date: Thu, 26 Mar 2026 16:04:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	open list <linux-kernel@vger.kernel.org>,
	Hans Zhang <18255117159@163.com>, Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v2 RESEND 1/1] PCI: pcie_bus_config can be set at build
 time
Message-ID: <20260326210454.GA1346957@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <143704d7-2126-4191-bb86-7d6784e3c848@broadcom.com>

On Thu, Mar 05, 2026 at 01:38:43PM -0800, Florian Fainelli wrote:
> On 3/5/26 13:36, Jim Quinlan wrote:
> > On Mon, Mar 2, 2026 at 7:03 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Tue, Feb 24, 2026 at 04:10:17PM -0500, Jim Quinlan wrote:
> > > > On Fri, Feb 20, 2026 at 5:11 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > On Mon, Sep 28, 2020 at 03:46:51PM -0400, Jim Quinlan wrote:
> > > > > > The Kconfig is modified so that the pcie_bus_config setting can be done at
> > > > > > build time in the same manner as the CONFIG_PCIEASPM_XXXX choice.  The
> > > > > > pci_bus_config setting may still be overridden by the bootline param.
> > > > > > 
> > > > > > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > > > > 
> > > > > We merged this as b0e85c3c8554 ("PCI: Add Kconfig options for MPS/MRRS
> > > > > strategy"), which appeared in v5.10.
> > > > > 
> > > > > In retrospect, I think this might have been a mistake because it
> > > > > forces a build-time configuration for something that may not be known
> > > > > at build time and can be set via command-line parameter.
> > > > ...
> > > 
> > > > > But I can't find any discussion about it.  Did you have a use case
> > > > > where command line parameters weren't usable?
> > > > 
> > > > Yes.  We have a Cable Modem (CM) customer who can update their Linux
> > > > version but cannot update their boot loader or its default bootline.
> > > > FWIW, they only want the option to set pcie_bus_config to
> > > > PCIE_BUS_SAFE via the .config.
> > > > ...
> > > 
> > > > It's a CM product which uses a particular Wifi chip.  Recognizing this
> > > > scenario would have the RC trying to grab the EP's vendor-id (and
> > > > possibly more info), and that seems awkward at best.
> > > 
> > > This is actually kind of weird.  I don't know why a particular device
> > > would have any special MPS or MRRS requirements.
> > > 
> > > Do you have any more details about this?  Does the WiFi chip actually
> > > not *work* with other MPS settings?  Or is this a performance thing
> > > where other settings don't give acceptable performance?
> > 
> > Hi Bjorn,
> > I looked up the original request mail thread on this -- it appears
> > that the device defaulted to an MPS value of 128, and that value is
> > what it was assigned. Unfortunately, this device has an occasional HW
> > bug when MPS=128.  Rather than fix the HW bug, they wanted a SW change
> > in Linux, and somehow that request morphed into a request for
> > PCIE_BUS_XXX config settings.  So the reason for the original
> > submission is weak and we should have done something different, but
> > here we are.
> 
> Late to the party and probably could have suggested back then, but this
> seems like a prime candidate for using a PCI quirk fixup?

Definitely.  The WiFi devices is likely used in platforms other than
the Cable Modem in question.  The CM avoids the hardware bug by
building with PCIE_BUS_SAFE, which probably sets MPS larger than 128.

But other platforms may use the same device and trip over this
hardware issue if they use different PCIE_BUS_* config or kernel
parameters that result in MPS=128.

What is the WiFi device in question?  Maybe we can look for reports of
problems or try to reproduce the issue if we know where to look.  Then
maybe we can figure out a solution that helps everybody.

Bjorn
