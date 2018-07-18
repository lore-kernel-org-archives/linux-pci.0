Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bmailout2.hostsharing.net ([83.223.90.240]:34491 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728039AbeGRUKP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Jul 2018 16:10:15 -0400
Date: Wed, 18 Jul 2018 21:30:53 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Yinghai Lu <yinghai@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        linux-pci@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>
Subject: Re: [PATCH 32/32] PCI: Whitelist Thunderbolt ports for runtime D3
Message-ID: <20180718193053.GA20124@wunner.de>
References: <cover.1529173804.git.lukas@wunner.de>
 <10206fe7f3967aa73ade5b24dc729de0e94c3b7f.1529173804.git.lukas@wunner.de>
 <20180621111354.GW2558@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180621111354.GW2558@lahna.fi.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Mika,

sorry for the delay!

On Thu, Jun 21, 2018 at 02:13:54PM +0300, Mika Westerberg wrote:
> On Sat, Jun 16, 2018 at 09:25:00PM +0200, Lukas Wunner wrote:
> > +		/* Even the oldest 2010 Thunderbolt controller supports D3. */
> > +		if (bridge->is_thunderbolt)
> > +			return true;
> 
> I have a small concern here. In PC world native PCIe hotplug used with
> Thunderbolt comes in two flavors:
> 
>   - Native PCI hotplug without runtime PM
>   - Native PCI hotplug with runtime PM
> 
> The former works so that even if it uses native PCIe hotplug, the power
> management is done so that the Thunderbolt host router is hot-removed
> when there is nothing connected (and that brings the power savings).
> With the above change we start putting all Thunderbolt PCIe hotplug
> ports to D3 runtime. While this probably works (and I tested it on the
> same Dell) I don't think Windows does it and it may lead to a path that
> has not been tested very thoroughly by OEMs.
> 
> So I wonder if it makes sense to restrict this particular check to Apple
> hardware at this point?

I'm not familiar at all with Windows, so this your call.  Normally I'd say,
if there's no known case which forces us to constrain this to Apple, we
probably shouldn't be overzealous.  OTOH I imagine you have to deal with
Windows and broken BIOSes on a daily basis and can anticipate if problems
are to be expected.

The "host router" is the NHI, right?  So IIUC all downstream ports and
the upstream port of the TB PCIe switch may go to D3hot, same for the
root port.  And your concern is that hotplug addition or removal of the
NHI might not work if those ports are in D3hot?

What I don't get is, if we constrain this to Apple, TB ports on non-Apple
systems may not runtime suspend (e.g. if the OEM botched the BIOS date
to be < 2015) and then the "Native PCI hotplug with runtime PM" case
will be broken, won't it?

Thanks,

Lukas
