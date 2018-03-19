Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967564AbeCSShg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Mar 2018 14:37:36 -0400
Date: Mon, 19 Mar 2018 13:37:34 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Christoph Hellwig <hch@infradead.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Frederick Lawler <fred@fredlawl.com>
Subject: Re: [PATCH v2 08/13] PCI/portdrv: Simplify PCIe feature permission
 checking
Message-ID: <20180319183734.GA77194@bhelgaas-glaptop.roam.corp.google.com>
References: <152062141493.77693.9630397416694091342.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <152062203293.77693.8159909590216160503.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20180312080402.GE10358@infradead.org>
 <20180312140316.GB194000@bhelgaas-glaptop.roam.corp.google.com>
 <20180312142059.GA11186@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180312142059.GA11186@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 12, 2018 at 03:20:59PM +0100, Lukas Wunner wrote:
> On Mon, Mar 12, 2018 at 09:03:16AM -0500, Bjorn Helgaas wrote:
> > On Mon, Mar 12, 2018 at 01:04:02AM -0700, Christoph Hellwig wrote:
> > > > +	 * We assume we can manage these PCIe features.  Some systems may
> > > > +	 * reserve these for use by the platform itself, e.g., an ACPI BIOS
> > > > +	 * may implement its own AER handling and use _OSC to prevent the
> > > > +	 * OS from interfering.
> > > > +	 */
> > > > +	bridge->use_aer = 1;
> > > > +	bridge->use_hotplug = 1;
> > > > +	bridge->use_pme = 1;
> > > 
> > > If we start out with enabled maybe these should be disable_foo flags
> > > instead?
> > 
> > I went back and forth on that.  "disable_foo" is nice because the
> > default value is correct (zero means enabled).  But then you end up
> > with things like:
> > 
> >   if (pcie_ports_native || !host->disable_hotplug)
> > 
> > where the "!host->disable_hotplug" is a double negative, and I have a
> > really hard time reading that.
> 
> native_hotplug or, if you want it reversed, platform_hotplug
> (or firmware_hotplug?) might improve readability.

Thanks, I like that.  I renamed them to "native_aer", etc.
