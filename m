Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:41081 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398AbbC3KHt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 30 Mar 2015 06:07:49 -0400
Date: Mon, 30 Mar 2015 12:07:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
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
Message-ID: <20150330100744.GA16291@kroah.com>
References: <1427635734-24786-1-git-send-email-mst@redhat.com>
 <1427635734-24786-2-git-send-email-mst@redhat.com>
 <20150329204047.GA5902@kroah.com>
 <20150330083707-mutt-send-email-mst@redhat.com>
 <20150330065522.GA10105@kroah.com>
 <20150330085617-mutt-send-email-mst@redhat.com>
 <20150330075331.GA17823@kroah.com>
 <20150330101830-mutt-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150330101830-mutt-send-email-mst@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 30, 2015 at 10:31:54AM +0200, Michael S. Tsirkin wrote:
> On Mon, Mar 30, 2015 at 09:53:31AM +0200, Greg KH wrote:
> > On Mon, Mar 30, 2015 at 09:15:26AM +0200, Michael S. Tsirkin wrote:
> > > On Mon, Mar 30, 2015 at 08:55:22AM +0200, Greg KH wrote:
> > > > On Mon, Mar 30, 2015 at 08:48:44AM +0200, Michael S. Tsirkin wrote:
> > > > > On Sun, Mar 29, 2015 at 10:40:47PM +0200, Greg KH wrote:
> > > > > > On Sun, Mar 29, 2015 at 03:37:01PM +0200, Michael S. Tsirkin wrote:
> > > > > > > The macros in pci_ids.h are pretty useful for userspace
> > > > > > > using the pci sysfs interface.
> > > > > > > At the moment userspace is forced to duplicate these macros
> > > > > > > (e.g. QEMU does this), it is better to expose them in
> > > > > > > /usr/include/linux/pci_ids.h so everyone can just include
> > > > > > > this header.
> > > > > > > 
> > > > > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > > > > ---
> > > > > > >  include/linux/pci_ids.h      | 2998 +-----------------------------------------
> > > > > > >  include/uapi/linux/pci_ids.h | 2997 +++++++++++++++++++++++++++++++++++++++++
> > > > > > 
> > > > > > No, please use the pci ids file from the upstream pci id database
> > > > > > instead.
> > > > > 
> > > > > 
> > > > > >  We shouldn't be putting these all in one file,
> > > > > 
> > > > > pci.txt says:
> > > > > 	Please add PCI_VENDOR_ID_xxx for vendors
> > > > > You want to change this policy, and get rid of
> > > > > vendor ids in pci_ids.h completely?
> > > > 
> > > > Please read the top of pci_ids.h.  It hasn't had new ids added to it in
> > > > a long time.
> > > 
> > > OK, looks like pci.txt should be fixed then.
> > 
> > Please send a patch.  As the original PCI kernel maintainer, I don't
> > think I ever noticed pci.txt.  It was last "updated" in 2006...
> > 
> > > > Why would userspace need the pci id of anything?
> > > 
> > > Look at how they are used e.g. by QEMU, seabios, gpxe.
> > > People want to say e.g. "find all network class devices".
> > 
> > Then use libpci.
> > 
> > > >  Again, just use
> > > > libpci, isn't it fast enough?  Don't duplicate existing logic.
> > > 
> > > This really depends on whether you want something else that
> > > libpci provides. But if I just want e.g. standard class IDs,
> > > I don't want to depend on libpci.
> > 
> > Why not?  Don't duplicate things that already are there just for this
> > very use.
> > 
> > Don't make us do kernel changes just because you don't want to depend on
> > either of the two different userspace packages that provide this
> > information in a standard way for userspace.  Your system will have one
> > of those two packages in it, depending on it isn't a "burden" at all.
> > 
> > > > Or use the hw database that libudev exports, which is already on your
> > > > machine and exports all of the pci ids from libpci directly.
> > > 
> > > Same argument really.
> > 
> > Because you don't want to depend on existing packages, doesn't mean we
> > have to accept kernel changes and maintain them for forever, as you are
> > now creating a new api that we will have to keep up to date and correct
> > for all time.
> > 
> > Again, depend on the packages that are already doing this work please.
> > 
> 
> Maintaining correct class IDs is more or less a requirement
> for kernel to work properly, isn't it?

Yes, but maintaining them internally, not externally.

> Wouldn't the same thing apply to pci_regs.h?
> Why does it make sense to export PCI_CLASS_REVISION
> so I know where to read the class value from
> configuration, but not what the values are?

That's just due to history, we made the mistake to export those a long
time ago, I wouldn't recommend doing any more, and again, instead rely
on the programs that properly maintain that for you.

> What's the work you refer to?  This is just hardware description it
> can't change and doesn't need to be maintained.

Hardware descriptions always change over time and need to be
maintained...

thanks,

greg k-h
