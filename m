Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B934429E113;
	Tue, 24 Feb 2026 23:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771974352; cv=none; b=Pbfpj6B2SniU8LdaLAi98WoIhB00TmufPdaxc0bkw0SbzGGVmlJAcgyfYKun2ly6tlKq153WGUwiY1j0bF+NXqjwvfhxr7P9UozZgTPmjvivmzKdDGpFQAFmuC7BYpMPkJ0a9IaDPomqmwID7sdCtzT4UbMOJzMZL7Vvfnz7zac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771974352; c=relaxed/simple;
	bh=VQ7vYfKHggWuHlcFE3gl59XUAaQz+9wYHGGX2yl3nis=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hRoSfpQQhniJSEs+vZna9BGukq+Q9ubP64HEBWC9r0PYkdRh0F6gWqA5X5CvcCcX7n0Wc92jBDHW1t9/Y9hVvAmtS8yPjddGvriOvzu3VXQ6/ogYPnKumfVM2KnX0VQyd8HELwLKDbnKdAdPqrATy7LxLpAyHSC30tIH5ekdleA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NT4jU09q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NT4jU09q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B36DC116D0;
	Tue, 24 Feb 2026 23:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771974352;
	bh=VQ7vYfKHggWuHlcFE3gl59XUAaQz+9wYHGGX2yl3nis=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=NT4jU09q8Ck5dSl6SV+TndQsCFcHuv8q0xZErcMaSeO+pZnnJBwrP71jl2gctVQIt
	 6qdH5eWekcuv5V8Db3i8b3SyVt2twdtccwE9r0G0WQb0HhofoCc5S2BkBG8PMryJnG
	 Sr5Gyk8qY5KsxTw8l9gMiXPvn8wBexVLkgWTc37sXopHizbI7xcCcZivPdVgKZDcJY
	 3HaTFVP+QtQ5hSZJKgwTkICtjcIGw/z8foPCaoK/QoGuE3pmAJHB5Pn84Y/n5QyauF
	 8NcylfDtvdI16/JstW/7fYASVVZus3wEwIsHgJw/SwKHiBP1y9X4p6nqewUnJsUvGt
	 3giSpnVMmBVRw==
Date: Tue, 24 Feb 2026 17:05:50 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	open list <linux-kernel@vger.kernel.org>,
	Hans Zhang <18255117159@163.com>, Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v2 RESEND 1/1] PCI: pcie_bus_config can be set at build
 time
Message-ID: <20260224230550.GA3754701@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+-6iNzJM=C+Byb+wnmPYdJcYoTT7N-XwE3o2OpJzmcJrtOc8A@mail.gmail.com>

On Tue, Feb 24, 2026 at 04:10:17PM -0500, Jim Quinlan wrote:
> On Fri, Feb 20, 2026 at 5:11 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Mon, Sep 28, 2020 at 03:46:51PM -0400, Jim Quinlan wrote:
> > > The Kconfig is modified so that the pcie_bus_config setting can be done at
> > > build time in the same manner as the CONFIG_PCIEASPM_XXXX choice.  The
> > > pci_bus_config setting may still be overridden by the bootline param.
> > >
> > > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> >
> > We merged this as b0e85c3c8554 ("PCI: Add Kconfig options for MPS/MRRS
> > strategy"), which appeared in v5.10.
> >
> > In retrospect, I think this might have been a mistake because it
> > forces a build-time configuration for something that may not be known
> > at build time and can be set via command-line parameter.
> 
> I don't see much difference between setting the default at build time
> versus setting it via the boot command line --  both methods are
> performed before runtime and make assumptions.

True.  I don't like baking unnecessary decisions into the kernel
binary.  This one seems useful for a point product but at the cost of
a small burden on everybody who builds a kernel.

> > But I can't find any discussion about it.  Did you have a use case
> > where command line parameters weren't usable?
> 
> Yes.  We have a Cable Modem (CM) customer who can update their Linux
> version but cannot update their boot loader or its default bootline.
> FWIW, they only want the option to set pcie_bus_config to
> PCIE_BUS_SAFE via the .config.
> 
> > If there's a platform that requires one of these settings, maybe
> > there's a way to do that programmatically in the host bridge driver
> > rather than using a Kconfig symbol.
> 
> It's a CM product which uses a particular Wifi chip.  Recognizing this
> scenario would have the RC trying to grab the EP's vendor-id (and
> possibly more info), and that seems awkward at best.

I assume a closed product like a CM doesn't run a plain vanilla
upstream kernel, so removing the Kconfig option would mean carrying a
one-line patch to set pcie_bus_config.  There's some trade-off between
carrying a source patch and tracking Kconfig requirements, but I don't
know where that would be in your case.

Could this be decided in pcie-brcmstb.c based on DT or something
similar?  I guess you said it only applies to CMs with a particular
WiFi chip, so maybe that's not visible in DT.  But I wonder why it's
specific to the WiFi -- I would think the important thing is that it's
a closed system and every closed system would want PCIE_BUS_SAFE.

> > > ---
> > >  drivers/pci/Kconfig | 56 +++++++++++++++++++++++++++++++++++++++++++++
> > >  drivers/pci/pci.c   | 12 ++++++++++
> > >  2 files changed, 68 insertions(+)
> > >
> > > diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> > > index 4bef5c2bae9f..15ce948858fb 100644
> > > --- a/drivers/pci/Kconfig
> > > +++ b/drivers/pci/Kconfig
> > > @@ -187,6 +187,62 @@ config PCI_HYPERV
> > >         The PCI device frontend driver allows the kernel to import arbitrary
> > >         PCI devices from a PCI backend to support PCI driver domains.
> > >
> > > +choice
> > > +     prompt "PCIE default bus config setting"
> > > +     default PCIE_BUS_DEFAULT
> > > +     depends on PCI
> > > +     help
> > > +       One of the following choices will set the pci_bus_config at
> > > +       compile time.  The choices offered are the same as those offered
> > > +       for the bootline parameter 'pci'; i.e. 'pci=pcie_bus_tune_off',
> > > +       'pci=pcie_bus_safe', 'pci=pcie_bus_perf', and 'pci=pcie_bus_peer2peer'.
> > > +       This is a compile-time setting and is still be overridden by the
> > > +       above bootline parameters, if present.  If unsure, chose PCIE_BUS_DEFAULT.
> > > +
> > > +config PCIE_BUS_TUNE_OFF
> > > +     bool "Tune Off"
> > > +     depends on PCI
> > > +     help
> > > +       Use the BIOS defaults; doesn't touch MPS at all.  This is the same
> > > +       as booting with 'pci=pcie_bus_tune_off'.
> > > +
> > > +config PCIE_BUS_DEFAULT
> > > +     bool "Default"
> > > +     depends on PCI
> > > +     help
> > > +       Default choice; ensures that the MPS matches upstream bridge.
> > > +
> > > +config PCIE_BUS_SAFE
> > > +     bool "Safe"
> > > +     depends on PCI
> > > +     help
> > > +       Use largest MPS that boot-time devices support.  If you have a
> > > +       closed system with no possibility of adding new devices,
> > > +       this will use the largest MPS that's supported by all devices.
> > > +       This is the same as booting with 'pci=pcie_bus_safe'.
> > > +
> > > +config PCIE_BUS_PERFORMANCE
> > > +     bool "Performance"
> > > +     depends on PCI
> > > +     help
> > > +       Use MPS and MRRS for best performance.  This setting ensures
> > > +       that a given device's MPS is no larger than its parent MPS,
> > > +       which allows us to keep all switches/bridges to the max MPS supported
> > > +       by their parent and eventually the PHB.  This is the same as
> > > +       booting with 'pci=pcie_bus_perf'.
> > > +
> > > +config PCIE_BUS_PEER2PEER
> > > +     bool "Peer2peer"
> > > +     depends on PCI
> > > +     help
> > > +       Set MPS = 128 for all devices.  MPS configuration effected by
> > > +       the other options could cause the MPS on one root port to be
> > > +       different than that of the MPS on another.  Simply making the system
> > > +       wide MPS be set to the smallest possible value (128B) solves
> > > +       this issue.  This is the same as booting with 'pci=pcie_bus_peer2peer'.
> > > +
> > > +endchoice
> > > +
> > >  source "drivers/pci/hotplug/Kconfig"
> > >  source "drivers/pci/controller/Kconfig"
> > >  source "drivers/pci/endpoint/Kconfig"
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index e39c5499770f..dfb52ed4a931 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -101,7 +101,19 @@ unsigned long pci_hotplug_mmio_pref_size = DEFAULT_HOTPLUG_MMIO_PREF_SIZE;
> > >  #define DEFAULT_HOTPLUG_BUS_SIZE     1
> > >  unsigned long pci_hotplug_bus_size = DEFAULT_HOTPLUG_BUS_SIZE;
> > >
> > > +
> > > +/* PCIE bus config, can be overridden by bootline param */
> > > +#ifdef CONFIG_PCIE_BUS_TUNE_OFF
> > > +enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_TUNE_OFF;
> > > +#elif defined CONFIG_PCIE_BUS_SAFE
> > > +enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_SAFE;
> > > +#elif defined CONFIG_PCIE_BUS_PERFORMANCE
> > > +enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_PERFORMANCE;
> > > +#elif defined CONFIG_PCIE_BUS_PEER2PEER
> > > +enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_PEER2PEER;
> > > +#else
> > >  enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_DEFAULT;
> > > +#endif
> > >
> > >  /*
> > >   * The default CLS is used if arch didn't set CLS explicitly and not
> > > --
> > > 2.17.1
> > >
> >
> >


