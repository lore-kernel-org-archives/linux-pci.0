Return-Path: <alex.williamson@redhat.com>
Return-Path: <alex.williamson@redhat.com>
Date: Mon, 14 Nov 2016 14:21:58 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] PCI: Balance ports to avoid ACS errata on Pericom
 switches
Message-ID: <20161114142158.6823fbd2@t450s.home>
In-Reply-To: <20161114210319.GC9868@bhelgaas-glaptop.roam.corp.google.com>
References: <20161026175156.23495.12980.stgit@gimli.home>
	<20161026180140.23495.27388.stgit@gimli.home>
	<20161114210319.GC9868@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

On Mon, 14 Nov 2016 15:03:19 -0600
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Wed, Oct 26, 2016 at 12:01:40PM -0600, Alex Williamson wrote:
> > As described in the included code comment, this quirk is intended to
> > work around an errata in a variety of Pericom 4-lane, 3 and 4 port
> > PCIe 2.0 switches.  The switches advertise ACS capabilities, but the
> > P2P Request Redirection support includes an errata that PCI_ACS_RR
> > effectively doesn't work and results in transactions being queued and
> > not delivered within the PCIe switch.  The errata has no planned
> > hardware fix.  
> 
> Is there a published erratum we can reference here?  It'd be really
> nice to have a URL.

Unfortunately only the product briefs seem to be public.  I was sent an
errata, but it's marked confidential, so I don't think I'll risk adding
it to the bz.  I haven't even been granted access to the datasheet.
I'm only guessing at the affected devices IDs based on my sample of one.

One thing I've thought of since I posted this series is that it's
possible to have a configuration where the downstream ports don't all
match.  If the upstream port is running at 5GT/s, the first downstream
port is also running 5GT/s, but another downstream port is running
2.5GT/s, this code will retrain the upstream port to 2.5GT/s w/o
revisiting that first port.  I should fix that, but I likely won't have
time for v4.10.  If you want to de-queue this, I'll try to look at it
again for v4.11 and take your other suggestions into account.  Thanks,

Alex
