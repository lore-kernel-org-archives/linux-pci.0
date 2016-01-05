Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43716 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751478AbcAEKfu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 5 Jan 2016 05:35:50 -0500
Date: Tue, 5 Jan 2016 12:35:45 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Alexander Duyck <aduyck@mirantis.com>, kvm@vger.kernel.org,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	x86@kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	qemu-devel@nongnu.org, Lan Tianyu <tianyu.lan@intel.com>,
	Yang Zhang <yang.zhang.wz@gmail.com>,
	Alexander Graf <agraf@suse.de>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [RFC PATCH 0/3] x86: Add support for guest DMA dirty page
 tracking
Message-ID: <20160105123243-mutt-send-email-mst@redhat.com>
References: <20151213212557.5410.48577.stgit@localhost.localdomain>
 <20160104204104.GB17427@char.us.oracle.com>
 <CAKgT0UenF-Cj2fvFPEmY0g7FOf=85HbFJ9iFUjs4KgsaXrckqA@mail.gmail.com>
 <20160105113317-mutt-send-email-mst@redhat.com>
 <20160105100104.GA2439@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160105100104.GA2439@work-vm>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 05, 2016 at 10:01:04AM +0000, Dr. David Alan Gilbert wrote:
> * Michael S. Tsirkin (mst@redhat.com) wrote:
> > On Mon, Jan 04, 2016 at 07:11:25PM -0800, Alexander Duyck wrote:
> > > >> The two mechanisms referenced above would likely require coordination with
> > > >> QEMU and as such are open to discussion.  I haven't attempted to address
> > > >> them as I am not sure there is a consensus as of yet.  My personal
> > > >> preference would be to add a vendor-specific configuration block to the
> > > >> emulated pci-bridge interfaces created by QEMU that would allow us to
> > > >> essentially extend shpc to support guest live migration with pass-through
> > > >> devices.
> > > >
> > > > shpc?
> > > 
> > > That is kind of what I was thinking.  We basically need some mechanism
> > > to allow for the host to ask the device to quiesce.  It has been
> > > proposed to possibly even look at something like an ACPI interface
> > > since I know ACPI is used by QEMU to manage hot-plug in the standard
> > > case.
> > > 
> > > - Alex
> > 
> > 
> > Start by using hot-unplug for this!
> > 
> > Really use your patch guest side, and write host side
> > to allow starting migration with the device, but
> > defer completing it.
> > 
> > So
> > 
> > 1.- host tells guest to start tracking memory writes
> > 2.- guest acks
> > 3.- migration starts
> > 4.- most memory is migrated
> > 5.- host tells guest to eject device
> > 6.- guest acks
> > 7.- stop vm and migrate rest of state
> > 
> > 
> > It will already be a win since hot unplug after migration starts and
> > most memory has been migrated is better than hot unplug before migration
> > starts.
> > 
> > Then measure downtime and profile. Then we can look at ways
> > to quiesce device faster which really means step 5 is replaced
> > with "host tells guest to quiesce device and dirty (or just unmap!)
> > all memory mapped for write by device".
> 
> 
> Doing a hot-unplug is going to upset the guests network stacks view
> of the world; that's something we don't want to change.
> 
> Dave

It might but if you store the IP and restore it quickly
after migration e.g. using guest agent, as opposed to DHCP,
then it won't.

It allows calming the device down in a generic way,
specific drivers can then implement the fast quiesce.

> > 
> > -- 
> > MST
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
