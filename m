Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:41524 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423376Ab2LFMig convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 6 Dec 2012 07:38:36 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Huang Ying <ying.huang@intel.com>
Cc: Sarah Sharp <sarah.a.sharp@linux.intel.com>,
	=?ISO-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
	Ulrich Eckhardt <usb@uli-eckhardt.de>,
	Andrew Lutomirski <luto@mit.edu>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Ming Lei <ming.lei@canonical.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Linux PM list <linux-pm@vger.kernel.org>
Subject: Re: Unreliable USB3 with NEC uPD720200 and Delock Cardreader
Date: Thu, 06 Dec 2012 13:43:28 +0100
Message-ID: <2672908.h2kiZqDT1O@vostro.rjw.lan>
In-Reply-To: <1354778234.7216.9.camel@yhuang-dev>
References: <20121126191002.GE6504@xanatos> <20121206003344.GC5324@xanatos> <1354778234.7216.9.camel@yhuang-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, December 06, 2012 03:17:14 PM Huang Ying wrote:
> On Wed, 2012-12-05 at 16:33 -0800, Sarah Sharp wrote:
> > On Wed, Nov 28, 2012 at 02:54:06PM -0800, Sarah Sharp wrote:
> > > On Mon, Nov 26, 2012 at 10:48:03PM +0100, Bjørn Mork wrote:
> > > > Sarah Sharp <sarah.a.sharp@linux.intel.com> writes:
> > > > 
> > > > > It looks like both Ulrich and Andrew have the same issue.  I also have a
> > > > > Lenovo x220, and I confirmed that when I turn on PCI runtime suspend,
> > > > > the NEC host controller does not report port status changes when a new
> > > > > USB device is plugged in.
> > > > >
> > > > > I'm running 3.6.7, and I'm pretty sure that runtime suspend worked for
> > > > > the NEC host on some older kernel.  I don't think the NEC host went into
> > > > > D3cold on that kernel, though.  Is there a way to disable D3cold and
> > > > > just use D3hot instead?
> > > > 
> > > > Yes, you have /sys/bus/pci/devices/.../d3cold_allowed
> > > > See Documentation/ABI/testing/sysfs-bus-pci
> > > > 
> > > > If this really is a problem with the D3cold support that went into 3.6
> > > > then I guess you should include Huang Ying in the discussions as well
> > > > (CCed).
> > > 
> > > Turning off D3 cold didn't help.  Once the PCI device is suspended,
> > > connect events do not generate an interrupt.
> > > 
> > > I'll go see if I can figure out which kernel this worked on and bisect.
> > 
> > Wakeup from D3 works fine on the 3.5.0 kernel, but fails on 3.6.2.  I
> > haven't fully bisected yet.
> > 
> > In debugging, I found that if you only enable runtime suspend for the
> > NEC host controller, the host successfully comes out of D3 when you plug
> > in a USB device.  However, if you enable runtime PM for the parent PCIe root
> > port, it stops working.  Disabling D3cold for both devices did not help.
> > 
> > It looks like a PCI issue, so what sort of debugging info do you need
> > from me?
> 
> I do some debug with my NEC uPD720200, the patch is attached.  I found
> that NEC uPD720200 can not generate PME interrupt, so it can be remote
> waken up only via polling.  But if the PCIe bridge connected to NEC
> uPD720200 goes into suspended, we can not poll it.  Maybe we need a way
> to disable PCIe bridge suspended if the underlying device can only be
> waken up via polling.

I think we need to be more intelligent about that.  It looks like we can
only suspend a port (or bridge in general) if all devices below it have
the pme_poll flag unset.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
