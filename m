Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:15279 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965456Ab2EWTUR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 23 May 2012 15:20:17 -0400
Date: Wed, 23 May 2012 22:20:19 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Baron <jbaron@redhat.com>
Cc: Yinghai Lu <yinghai@kernel.org>, bhelgaas@google.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci hotplug: rescan bridge after device hotplug
Message-ID: <20120523192018.GA302@redhat.com>
References: <201205222011.q4MKBcMo024624@int-mx02.intmail.prod.int.phx2.redhat.com>
 <CAE9FiQVkOsCpxa2WzhYguX6CxM=HF+i7h9dM2XHiaCQXSmFU6g@mail.gmail.com>
 <20120523024313.GA2888@redhat.com>
 <CAE9FiQV4hgUGqAz3jhRrjJyEGrV-=K=LwRhr7zePncKirajoSw@mail.gmail.com>
 <CAE9FiQVPyjsB=oWp80sgqzkWw8KqX0GHg+csM39juo2N67P2Tg@mail.gmail.com>
 <20120523155346.GA23940@redhat.com>
 <CAE9FiQWPpKE5vmzZqw-E_L_0Lt1QpqV=xk=Hu6Stzva5vXk1_g@mail.gmail.com>
 <20120523184449.GB23940@redhat.com>
 <20120523190841.GC32207@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120523190841.GC32207@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 23, 2012 at 10:08:41PM +0300, Michael S. Tsirkin wrote:
> On Wed, May 23, 2012 at 02:44:49PM -0400, Jason Baron wrote:
> > On Wed, May 23, 2012 at 10:16:06AM -0700, Yinghai Lu wrote:
> > > On Wed, May 23, 2012 at 8:53 AM, Jason Baron <jbaron@redhat.com> wrote:
> > > >> > but still would prefer you to make qemu to support pciehp.
> > > >>
> > > >> another solution could be:
> > > >>
> > > >> in qemu acpi dsdt, you could set bridge size for new added bridge.
> > > >>
> > > >> current pbus_size_mem() will not shrink the old bridge resource size.
> > > >
> > > > ok, I also tried hard-wiring the bridge io/mem base and limit registers on the
> > > > qemu side. That seems to work without any guest-side hotplug code changes. And
> > > > would seem to be more flexible than putting the limits in acpi.
> > > 
> > > that should be acpi asl code or SMI work. and should make sure that
> > > range is not overlapped with resources that are used by other bridges
> > > and pci devices.
> > > 
> > 
> > Ok. So you are saying to define a 'Name (_CRS, ResourceTemplate() {
> > Memory() IO() })' block for each bridge?
> 
> We are talking about hotplugging bridges.
> This sounds strange.

However if it works it is certainly simple.

