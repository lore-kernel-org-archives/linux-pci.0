Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727728AbeGTVXl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Jul 2018 17:23:41 -0400
Date: Fri, 20 Jul 2018 15:33:45 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Lukas Wunner <lukas@wunner.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Yinghai Lu <yinghai@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        linux-pci@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>
Subject: Re: [PATCH 32/32] PCI: Whitelist Thunderbolt ports for runtime D3
Message-ID: <20180720203345.GU128988@bhelgaas-glaptop.roam.corp.google.com>
References: <cover.1529173804.git.lukas@wunner.de>
 <10206fe7f3967aa73ade5b24dc729de0e94c3b7f.1529173804.git.lukas@wunner.de>
 <20180621111354.GW2558@lahna.fi.intel.com>
 <20180718193053.GA20124@wunner.de>
 <20180720152349.GG2534@lahna.fi.intel.com>
 <20180720160038.GM2534@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180720160038.GM2534@lahna.fi.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 20, 2018 at 07:00:38PM +0300, Mika Westerberg wrote:
> On Fri, Jul 20, 2018 at 06:23:49PM +0300, Mika Westerberg wrote:
> > On Wed, Jul 18, 2018 at 09:30:53PM +0200, Lukas Wunner wrote:
> > > Hi Mika,
> > > 
> > > sorry for the delay!
> > > 
> > > On Thu, Jun 21, 2018 at 02:13:54PM +0300, Mika Westerberg wrote:
> > > > On Sat, Jun 16, 2018 at 09:25:00PM +0200, Lukas Wunner wrote:
> > > > > +		/* Even the oldest 2010 Thunderbolt controller supports D3. */
> > > > > +		if (bridge->is_thunderbolt)
> > > > > +			return true;
> > > > 
> > > > I have a small concern here. In PC world native PCIe hotplug used with
> > > > Thunderbolt comes in two flavors:
> > > > 
> > > >   - Native PCI hotplug without runtime PM
> > > >   - Native PCI hotplug with runtime PM
> > > > 
> > > > The former works so that even if it uses native PCIe hotplug, the power
> > > > management is done so that the Thunderbolt host router is hot-removed
> > > > when there is nothing connected (and that brings the power savings).
> > > > With the above change we start putting all Thunderbolt PCIe hotplug
> > > > ports to D3 runtime. While this probably works (and I tested it on the
> > > > same Dell) I don't think Windows does it and it may lead to a path that
> > > > has not been tested very thoroughly by OEMs.
> > > > 
> > > > So I wonder if it makes sense to restrict this particular check to Apple
> > > > hardware at this point?
> > > 
> > > I'm not familiar at all with Windows, so this your call.  Normally I'd say,
> > > if there's no known case which forces us to constrain this to Apple, we
> > > probably shouldn't be overzealous.  OTOH I imagine you have to deal with
> > > Windows and broken BIOSes on a daily basis and can anticipate if problems
> > > are to be expected.
> > > 
> > > The "host router" is the NHI, right?  So IIUC all downstream ports and
> > > the upstream port of the TB PCIe switch may go to D3hot, same for the
> > > root port.  And your concern is that hotplug addition or removal of the
> > > NHI might not work if those ports are in D3hot?
> > 
> > Host router is the PCIe switch + NHI + xHCI. My concern is that now we
> > start putting the downstream hotplug ports of the host router (the ports
> > where TBT PCIe daisy chain is to be extented) to D3hot even when the
> > whole power management of the "Native PCI hotplug without runtime PM" is
> > done pretty much by hot-removing the whole host router if there is
> > nothing connected.
> 
> I see Bjorn already merged these so please ignore the above. We can
> add the Apple check later if this turns out causing problems.

I merged these just to try to make forward progress and dig out from
my backlog.  If you want to tweak this before the merge window, I'd be
glad to update the branch.

Bjorn
