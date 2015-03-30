Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39536 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750710AbbC3LTk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 30 Mar 2015 07:19:40 -0400
Date: Mon, 30 Mar 2015 13:19:14 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"David S. Miller" <davem@davemloft.net>,
	Hans Verkuil <hans.verkuil@cisco.com>,
	Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
	Alexei Starovoitov <ast@plumgrid.com>,
	stephen hemminger <stephen@networkplumber.org>,
	Masahiro Yamada <yamada.m@jp.panasonic.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andy Lutomirski <luto@amacapital.net>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Stephane Eranian <eranian@google.com>,
	Huang Rui <ray.huang@amd.com>,
	Peter Neubauer <pneubauer@bluerwhite.org>,
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: Re: [PATCH 01/86] pci: export pci_ids.h
Message-ID: <20150330130020-mutt-send-email-mst@redhat.com>
References: <1427635734-24786-2-git-send-email-mst@redhat.com>
 <20150329204047.GA5902@kroah.com>
 <20150330083707-mutt-send-email-mst@redhat.com>
 <20150330065522.GA10105@kroah.com>
 <20150330085617-mutt-send-email-mst@redhat.com>
 <20150330075331.GA17823@kroah.com>
 <20150330101830-mutt-send-email-mst@redhat.com>
 <20150330100744.GA16291@kroah.com>
 <20150330123051-mutt-send-email-mst@redhat.com>
 <20150330105707.GA17979@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150330105707.GA17979@kroah.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 30, 2015 at 12:57:07PM +0200, Greg KH wrote:
> On Mon, Mar 30, 2015 at 12:46:36PM +0200, Michael S. Tsirkin wrote:
> > Sorry about keeping this thread alive, I'm just trying
> > to wrap my head around what you consider a sane API.
> > 
> > Linux used not to export headers automatically, generally.
> > It used to be "just use libc". Why is this header different?
> 
> You are now exporting things from the kernel that were not being
> exported in the past.  When you do that, you are now guaranteeing that
> this api will be present for forever in the future.

We already guarantee this API, that's the point.

Look at this sysfs file:
	/sys/bus/pci/devices/0000\:00\:00.0/class
It's a hex number.  The values? They are in pci_ids.h

And so everyone who uses this file carries a copy
of the header.


> > These constants are required to use the interfaces
> > linux does export to userspace, including VFIO and sysfs.
> > No one maintains them really, though libpci has a copy
> > of these.
> 
> Also libudev, which takes them from the "master" copy that libpci pulls
> from.

OK, so which is the master copy for this:
#define PCI_BASE_CLASS_NETWORK          0x02


> > Some people believe headers are copyrighteable, for them, licensing is
> > also problematic: libpci is under plain GPL, Linux needs the exception
> > for user programs.  Does not this mean that we can't depend on libpci to
> > provide parts of linux/userspace interface?
> 
> This makes no sense at all.  If you have legal questions, ask a lawyer,
> not a programmer.  Would you ask me medical questions as well?
> 
> > > > Wouldn't the same thing apply to pci_regs.h?
> > > > Why does it make sense to export PCI_CLASS_REVISION
> > > > so I know where to read the class value from
> > > > configuration, but not what the values are?
> > > 
> > > That's just due to history, we made the mistake to export those a long
> > > time ago, I wouldn't recommend doing any more, and again, instead rely
> > > on the programs that properly maintain that for you.
> > 
> > So add libpci dependency just for the headers?  No one wants to do this.
> > Case in point, Linux doesn't want to depend on libpci headers either, right?
> 
> The kernel is self-contained, and has to be, don't be foolish.

I agree it is pretty contained but it's not 100%, and it does not have
to be.  kernel build depends on perl, bash, make, etc etc.
We don't want a library header dependency because it's easier not to
have dependencies, not because we can't have it.

Same applies to others really.

> > I don't think class IDs or vendor IDs ever did or can change.
> 
> Then you haven't tracked what has happened over time.  They do change,
> they are sometimes incorrect, they are extended, and stuff is modified.

Sounds like a good reason to avoid duplication, have
provider of the interface document that constants used.

> > New stuff is added, we add it as we add Linux support.
> > Isn't this a good reason to include this? Will push
> > vendors to work with the community instead of
> > around it using userspace drivers.
> 
> This has nothing to do with "pushing vendors" to do anything.
> 
> Again, if you have a userspace program that needs these headers, then
> use one of the _two_ different packages that userspace already provides
> that has them, don't make the kernel become the third provider of the
> same header information, that's major duplication of effort for no
> reason at all.
> 
> thanks,
> 
> greg k-h

Why there much more that two packages, I can find
at least 5 copies in the wild. Why? I think it's because it's part of
linux ABI that doesn't have matching headers. People are asked to build
their own, so of course they copy each other.

Once linux exports these headers everyone can stop
duplicating each other and others, and just use linux headers too.


-- 
MST
