Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752039AbdI0Nz2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 Sep 2017 09:55:28 -0400
Date: Wed, 27 Sep 2017 08:55:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-pci <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/2 v4] PCI: v3: Update the device tree bindings
Message-ID: <20170927135526.GA23674@bhelgaas-glaptop.roam.corp.google.com>
References: <20170908124503.4491-1-linus.walleij@linaro.org>
 <20170926191639.GO15970@bhelgaas-glaptop.roam.corp.google.com>
 <CACRpkdYeo667tTsis-5ZLz-bK-87Ygd3ziD2qH_2KXWf+Oq=mA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACRpkdYeo667tTsis-5ZLz-bK-87Ygd3ziD2qH_2KXWf+Oq=mA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 27, 2017 at 03:25:53PM +0200, Linus Walleij wrote:
> On Tue, Sep 26, 2017 at 9:16 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Fri, Sep 08, 2017 at 02:45:02PM +0200, Linus Walleij wrote:
> >> The bindings for the V3 Semiconductor PCI bridge are a tad bit outdated
> >> and predates the more formal format we have adopted for the bindings.
> >>
> >> Update them a bit so it is easier to read, and add the Integrator AP-
> >> specific compatible so we can detect that we are running on that specific
> >> platform.
> >>
> >> Add a second register bank for the configuration memory area. The
> >> device tree specs does specify a memory range for configuration
> >> space but it is not applicable to custom accessors like this. Instead
> >> follow the pattern from the Versatile PCI adapter and simply add
> >> a second register bank for this memory.
> >>
> >> Cc: devicetree@vger.kernel.org
> >> Cc: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> >> Acked-by: Rob Herring <robh@kernel.org>
> >> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> >
> > Applied both to pci/host-v3-semi for v4.15, thanks!
> 
> Oh it fails to build right now (as the zeroday builder noticed)
> since it is using Marc Gonzalez new helper for DMA ranges
> parsing.
> 
> If Marc's patches are getting applied they will solve the issue
> so I wouldn't care in that case.

I applied Marc's patches and rebased pci/host-v3-semi on top of his
patch that adds the helper.  Sorry I didn't notice this up front!
