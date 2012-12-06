Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:26868 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752725Ab2LFAeA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 5 Dec 2012 19:34:00 -0500
Date: Wed, 5 Dec 2012 16:33:44 -0800
From: Sarah Sharp <sarah.a.sharp@linux.intel.com>
To: =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Cc: Ulrich Eckhardt <usb@uli-eckhardt.de>,
	Andrew Lutomirski <luto@mit.edu>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Ming Lei <ming.lei@canonical.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Huang Ying <ying.huang@intel.com>
Subject: Re: Unreliable USB3 with NEC uPD720200 and Delock Cardreader
Message-ID: <20121206003344.GC5324@xanatos>
References: <20121126191002.GE6504@xanatos>
 <87boekave4.fsf@nemi.mork.no>
 <20121128225406.GF8557@xanatos>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20121128225406.GF8557@xanatos>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 28, 2012 at 02:54:06PM -0800, Sarah Sharp wrote:
> On Mon, Nov 26, 2012 at 10:48:03PM +0100, Bjørn Mork wrote:
> > Sarah Sharp <sarah.a.sharp@linux.intel.com> writes:
> > 
> > > It looks like both Ulrich and Andrew have the same issue.  I also have a
> > > Lenovo x220, and I confirmed that when I turn on PCI runtime suspend,
> > > the NEC host controller does not report port status changes when a new
> > > USB device is plugged in.
> > >
> > > I'm running 3.6.7, and I'm pretty sure that runtime suspend worked for
> > > the NEC host on some older kernel.  I don't think the NEC host went into
> > > D3cold on that kernel, though.  Is there a way to disable D3cold and
> > > just use D3hot instead?
> > 
> > Yes, you have /sys/bus/pci/devices/.../d3cold_allowed
> > See Documentation/ABI/testing/sysfs-bus-pci
> > 
> > If this really is a problem with the D3cold support that went into 3.6
> > then I guess you should include Huang Ying in the discussions as well
> > (CCed).
> 
> Turning off D3 cold didn't help.  Once the PCI device is suspended,
> connect events do not generate an interrupt.
> 
> I'll go see if I can figure out which kernel this worked on and bisect.

Wakeup from D3 works fine on the 3.5.0 kernel, but fails on 3.6.2.  I
haven't fully bisected yet.

In debugging, I found that if you only enable runtime suspend for the
NEC host controller, the host successfully comes out of D3 when you plug
in a USB device.  However, if you enable runtime PM for the parent PCIe root
port, it stops working.  Disabling D3cold for both devices did not help.

It looks like a PCI issue, so what sort of debugging info do you need
from me?

Sarah Sharp
