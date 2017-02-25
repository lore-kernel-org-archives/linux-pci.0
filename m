Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751308AbdBYOpD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 25 Feb 2017 09:45:03 -0500
Date: Sat, 25 Feb 2017 08:44:46 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: dri-devel@lists.freedesktop.org,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        Ben Skeggs <bskeggs@redhat.com>, nouveau@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        amd-gfx@lists.freedesktop.org, Peter Wu <peter@lekensteyn.nl>
Subject: Re: [PATCH 1/5] PCI: Recognize Thunderbolt devices
Message-ID: <20170225144446.GA27943@bhelgaas-glaptop.roam.corp.google.com>
References: <cover.1487938188.git.lukas@wunner.de>
 <c42a235e126f273e9b8712a7154f813f757db507.1487938188.git.lukas@wunner.de>
 <20170224221724.GA26430@bhelgaas-glaptop.roam.corp.google.com>
 <20170225074003.GA905@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170225074003.GA905@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Feb 25, 2017 at 08:40:03AM +0100, Lukas Wunner wrote:
> On Fri, Feb 24, 2017 at 04:17:24PM -0600, Bjorn Helgaas wrote:
> > On Fri, Feb 24, 2017 at 08:19:45PM +0100, Lukas Wunner wrote:
> > > --- a/include/linux/pci.h
> > > +++ b/include/linux/pci.h
> > > @@ -358,6 +358,7 @@ struct pci_dev {
> > >  	unsigned int	is_virtfn:1;
> > >  	unsigned int	reset_fn:1;
> > >  	unsigned int    is_hotplug_bridge:1;
> > > +	unsigned int	is_thunderbolt:1; /* Thunderbolt controller */
> > 
> > I'm not really keen on having this in the PCI core because the core
> > doesn't need this or even know what it means.
> > 
> > pci_find_next_ext_capability() is available to drivers, and if
> > Thunderbolt-connectedness is useful information to apple-gmux or GPU
> > drivers, it's fine with me if you want to use it there.  I just don't
> > see the benefit to having it in the core.
> 
> The above contradicts your statement 3 days earlier:
> 
> 	"Assuming we need it, having it in struct pci_dev is fine.
> 	 There's no point in looking up the VSEC capability more than once."
> 	(http://www.spinics.net/lists/linux-pci/msg58532.html)

It's clear that none of the proposed uses is related to Thunderbolt as
a technology, which is why I would suggest we don't need the flag.
But in the interest of moving on, if you remove the changelog part
about whitelisting Thunderbolt for runtime PM (since that's not part
of this series), you can add my:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
