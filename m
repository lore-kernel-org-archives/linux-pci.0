Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:62730 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965277Ab2EWVSH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 23 May 2012 17:18:07 -0400
Date: Thu, 24 May 2012 00:18:08 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jason Baron <jbaron@redhat.com>, bhelgaas@google.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci hotplug: rescan bridge after device hotplug
Message-ID: <20120523211808.GA2034@redhat.com>
References: <201205222011.q4MKBcMo024624@int-mx02.intmail.prod.int.phx2.redhat.com>
 <CAE9FiQVkOsCpxa2WzhYguX6CxM=HF+i7h9dM2XHiaCQXSmFU6g@mail.gmail.com>
 <20120523024313.GA2888@redhat.com>
 <CAE9FiQV4hgUGqAz3jhRrjJyEGrV-=K=LwRhr7zePncKirajoSw@mail.gmail.com>
 <CAE9FiQVPyjsB=oWp80sgqzkWw8KqX0GHg+csM39juo2N67P2Tg@mail.gmail.com>
 <20120523155346.GA23940@redhat.com>
 <CAE9FiQWPpKE5vmzZqw-E_L_0Lt1QpqV=xk=Hu6Stzva5vXk1_g@mail.gmail.com>
 <20120523184449.GB23940@redhat.com>
 <20120523190841.GC32207@redhat.com>
 <CAE9FiQX8j__V+VG-by+N9zZ7GJPtiLL0qJtiji7jHWddvJnOmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQX8j__V+VG-by+N9zZ7GJPtiLL0qJtiji7jHWddvJnOmQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 23, 2012 at 01:53:10PM -0700, Yinghai Lu wrote:
> On Wed, May 23, 2012 at 12:08 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > Fundamentally BARs are under guest control.
> > So while you are handing out memory for the bridges you would have to
> > tiptoe around guest assigned BARs.
> >
> > Also what happens after reboot? bios currently
> > assigns memory to bridges that are present on boot.
> > So this makes it even messier as who assigns memory
> > depends on whether device is hotplugged.
> >
> > Cleaner to have guest do it.
> 
> assume here  "guest' mean: BIOS + kernel + (acpi dsl code from BIOS).
> 
> >
> > I think Windows even can even rebalance BARs
> > as needed. So this is just a linux bug that needs
> > to be fixed.
> 
> Now pciehp in Linux will resize the bridge.
> but not for acpiphp. reason: acpiphp could handle more complicated case.
> does not mean new add card have to been under one bridge existing.

expess has this too. It just needs a bigger hierarchy:
upsteam ports can have many downstream ports behind them.


> slot just on root bus, you could just add device or bridge in it.
> and the bridge could have other hotlpug slots.
> 
> in that case, if one of children slot already have card
> installed/driver loaded, later
> after another card is put in another child slot, we can not simple
> resize the bridge in parent slot.
> because other child devices is operating...
> 
> solution will be
> 1. add quirks to set is_hotplug_bridge for apciphp....
> 2. or probe_resource in busn_alloc patchset, that maybe still need to
> extend to support alignment.
> 
> BTW, I was thinking Linux is the ONLY one that will scratch bridge BAR
> if that is big enough for children devices.
> Do you have evidence that other os does that?
> 
> Yinghai

I saw some docs on the net but do not have them handy. Google it.

