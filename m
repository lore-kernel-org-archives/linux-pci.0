Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:1723 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933646Ab2EWTIl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 23 May 2012 15:08:41 -0400
Date: Wed, 23 May 2012 22:08:42 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Baron <jbaron@redhat.com>
Cc: Yinghai Lu <yinghai@kernel.org>, bhelgaas@google.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci hotplug: rescan bridge after device hotplug
Message-ID: <20120523190841.GC32207@redhat.com>
References: <201205222011.q4MKBcMo024624@int-mx02.intmail.prod.int.phx2.redhat.com>
 <CAE9FiQVkOsCpxa2WzhYguX6CxM=HF+i7h9dM2XHiaCQXSmFU6g@mail.gmail.com>
 <20120523024313.GA2888@redhat.com>
 <CAE9FiQV4hgUGqAz3jhRrjJyEGrV-=K=LwRhr7zePncKirajoSw@mail.gmail.com>
 <CAE9FiQVPyjsB=oWp80sgqzkWw8KqX0GHg+csM39juo2N67P2Tg@mail.gmail.com>
 <20120523155346.GA23940@redhat.com>
 <CAE9FiQWPpKE5vmzZqw-E_L_0Lt1QpqV=xk=Hu6Stzva5vXk1_g@mail.gmail.com>
 <20120523184449.GB23940@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120523184449.GB23940@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 23, 2012 at 02:44:49PM -0400, Jason Baron wrote:
> On Wed, May 23, 2012 at 10:16:06AM -0700, Yinghai Lu wrote:
> > On Wed, May 23, 2012 at 8:53 AM, Jason Baron <jbaron@redhat.com> wrote:
> > >> > but still would prefer you to make qemu to support pciehp.
> > >>
> > >> another solution could be:
> > >>
> > >> in qemu acpi dsdt, you could set bridge size for new added bridge.
> > >>
> > >> current pbus_size_mem() will not shrink the old bridge resource size.
> > >
> > > ok, I also tried hard-wiring the bridge io/mem base and limit registers on the
> > > qemu side. That seems to work without any guest-side hotplug code changes. And
> > > would seem to be more flexible than putting the limits in acpi.
> > 
> > that should be acpi asl code or SMI work. and should make sure that
> > range is not overlapped with resources that are used by other bridges
> > and pci devices.
> > 
> 
> Ok. So you are saying to define a 'Name (_CRS, ResourceTemplate() {
> Memory() IO() })' block for each bridge?

We are talking about hotplugging bridges.
This sounds strange.

> The acpi code I currently have,
> has one 'Device()' definition for each top-level hotplug slot. Would it
> be ok to have the '_CRS' apply to either one?
> 
> Also, I'm wondering where in the acpiphp code it picks up the memory/io
> ranges to configure them as bridge ranges?
> 
> I also see in ACPIspec40a.pdf, section "9.11 Module Device":
> 
> "
> If no _CRS object is present, OSPM will assume that the module device is
> a simple container object that does not produce the resources consumed by its
> child devices. In this case, OSPM will assign resources to the child devices as
> if they were direct children of the module device's parent object.
> "
> 
> So not sure if that applies to hotplug, but that is not what acpiphp is
> doing atm.
> 
> Finally, I don't see why putting the bridge window range logic into qemu is a
> bad solution. Qemu knows memory ranges consumed by various resoures,
> looking at 'info mtree', so why can't qemu hand out the bridge ranges
> dynamically? In that way, it can re-size the windows more optimally than
> something hard-coded into acpi. So to me, it seems like a better
> approach.
> 
> Thanks,
> 
> -Jason

Because this is not how real hardware behaves.

Fundamentally BARs are under guest control.
So while you are handing out memory for the bridges you would have to
tiptoe around guest assigned BARs.

Also what happens after reboot? bios currently
assigns memory to bridges that are present on boot.
So this makes it even messier as who assigns memory
depends on whether device is hotplugged.

Cleaner to have guest do it.

I think Windows even can even rebalance BARs
as needed. So this is just a linux bug that needs
to be fixed.

-- 
MST
