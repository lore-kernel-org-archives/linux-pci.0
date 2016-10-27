Return-Path: <jthumshirn@suse.de>
Return-Path: <jthumshirn@suse.de>
Date: Thu, 27 Oct 2016 14:25:14 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>, Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: Don't set RCB bit in LNKCTL if the upstream bridge
 hasn't
Message-ID: <20161027121554.m4icty4rsha33mqg@linux-x5ow.site>
References: <1477490014-115917-1-git-send-email-jthumshirn@suse.de>
 <20161026194317.GC17507@bhelgaas-glaptop.roam.corp.google.com>
 <41d13b8c-98f5-af26-534e-37ceafd68eb3@suse.de>
 <20161027115152.GG17507@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20161027115152.GG17507@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 27, 2016 at 06:51:52AM -0500, Bjorn Helgaas wrote:
> On Thu, Oct 27, 2016 at 07:42:27AM +0200, Hannes Reinecke wrote:
> > On 10/26/2016 09:43 PM, Bjorn Helgaas wrote:
> > > Hi Johannes,
> > > 
> > > On Wed, Oct 26, 2016 at 03:53:34PM +0200, Johannes Thumshirn wrote:
> > >> The Read Completion Boundary bit must only be set on a device or endpoint if
> > >> it is set on the upstream bridge.
> > >>
> > >> Fixes: 7a1562d4f ("PCI: Apply _HPX Link Control settings to all devices with a link")
> > > 
> > > Can you please include a spec citation and a pointer to the bug report?
> > > 
> > PCI Express Base Specification 1.1,
> > section 2.3.1.1. Data Return for Read Requests:
> > 
> > The Read Completion Boundary (RCB) parameter determines the naturally
> > aligned address boundaries on which a Read Request may be serviced with
> > multiple Completions
> > o For a Root Complex, RCB is 64 bytes or 128 bytes
> >   o This value is reported through a configuration register
> >     (see Section 7.8)
> >   Note: Bridges and Endpoints may implement a corresponding command
> >   bit which may be set by system software to indicate the RCB value
> >   for the Root Complex, allowing the Bridge/Endpoint to optimize its
> >   behavior when the Root Complex’s RCB is 128 bytes.
> > o For all other system elements, RCB is 128 bytes
> > 
> > In this particular case the _HPX method was causing the RCB for all PCI
> > devices to be set to 128 bytes, while the root bridge remained at 64 bytes.
> > While this is arguably a BIOS bug, earlier linux version (ie without the
> > mentioned patch) were running fine, so this is actually a regression.
> 
> Thanks!  I can fold this into the changelog.
> 
> I assume you didn't mention a bugzilla or similar URL because this was
> found internally?  I'd still like a clue about what this issue looks
> like to a user, because that helps connect future problem reports with
> this fix.

Sharing the bugzilla number won't be of any help here, as it's not accessible.
The user visible issue was, that mlx4_core.ko wasn't able to issue the
MLX4_CMD_MAP_FA command to it's firmware resulting in the adapter undergoing
it's error recovery and ultimately hitting a BUG_ON() (which is subject to
another patch). Even without asserting it won't load and hence not provide any
network service. 

We haven't seen this behaviour on other drivers and it is likely a BIOS
error (the wrong setting of PCI_EXP_LNKCTL_RCB) but that wasn't an issue
before 7a1562d4f2d0 hence we do have a regression to kernels < 3.18.

> 
> And I suppose that since 7a1562d4f2d0 appeared in v3.18, we maybe
> should consider marking the fix for stable?

Yes probably, but on the other hand we haven't heard of any other cases than
this one (mlx4 NIC/HCA with a particular IBM IvyBridge Server, the next generation
didn't expose the bug).

Btw: Did you see I've sent a v2 as Alex Graf pointed out there might be a
possible NULL pointer dereference when accessing the "bridge" pointer in
pcie_get_upstream_rcb()?

Thanks,
	Johannes

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
