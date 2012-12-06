Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:40909 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751896Ab2LFAik convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 5 Dec 2012 19:38:40 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Cc: =?ISO-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
	Ulrich Eckhardt <usb@uli-eckhardt.de>,
	Andrew Lutomirski <luto@mit.edu>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Ming Lei <ming.lei@canonical.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Huang Ying <ying.huang@intel.com>
Subject: Re: Unreliable USB3 with NEC uPD720200 and Delock Cardreader
Date: Thu, 06 Dec 2012 01:43:32 +0100
Message-ID: <1962497.aG1sFtYjJG@vostro.rjw.lan>
In-Reply-To: <20121206003344.GC5324@xanatos>
References: <20121126191002.GE6504@xanatos> <20121128225406.GF8557@xanatos> <20121206003344.GC5324@xanatos>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, December 05, 2012 04:33:44 PM Sarah Sharp wrote:
> On Wed, Nov 28, 2012 at 02:54:06PM -0800, Sarah Sharp wrote:
> > On Mon, Nov 26, 2012 at 10:48:03PM +0100, Bjørn Mork wrote:
> > > Sarah Sharp <sarah.a.sharp@linux.intel.com> writes:
> > > 
> > > > It looks like both Ulrich and Andrew have the same issue.  I also have a
> > > > Lenovo x220, and I confirmed that when I turn on PCI runtime suspend,
> > > > the NEC host controller does not report port status changes when a new
> > > > USB device is plugged in.
> > > >
> > > > I'm running 3.6.7, and I'm pretty sure that runtime suspend worked for
> > > > the NEC host on some older kernel.  I don't think the NEC host went into
> > > > D3cold on that kernel, though.  Is there a way to disable D3cold and
> > > > just use D3hot instead?
> > > 
> > > Yes, you have /sys/bus/pci/devices/.../d3cold_allowed
> > > See Documentation/ABI/testing/sysfs-bus-pci
> > > 
> > > If this really is a problem with the D3cold support that went into 3.6
> > > then I guess you should include Huang Ying in the discussions as well
> > > (CCed).
> > 
> > Turning off D3 cold didn't help.  Once the PCI device is suspended,
> > connect events do not generate an interrupt.
> > 
> > I'll go see if I can figure out which kernel this worked on and bisect.
> 
> Wakeup from D3 works fine on the 3.5.0 kernel, but fails on 3.6.2.  I
> haven't fully bisected yet.
> 
> In debugging, I found that if you only enable runtime suspend for the
> NEC host controller, the host successfully comes out of D3 when you plug
> in a USB device.  However, if you enable runtime PM for the parent PCIe root
> port, it stops working.  Disabling D3cold for both devices did not help.
> 
> It looks like a PCI issue, so what sort of debugging info do you need
> from me?

It looks like this is related to one of the following commits:

3d8387e PCI/PM: Fix config reg access for D3cold and bridge suspending
ea8c88f PCI/PM: Keep parent bridge active when probing device
4f9c139 PCI/PM: Enable D3/D3cold by default for most devices
448bd85 PCI/PM: add PCIe runtime D3cold support
71a83bd PCI/PM: add runtime PM support to PCIe port
ee85f54 ACPI/PM: specify lowest allowed state for device sleep state

Generally, please try to bisect changes in drivers/pci between v3.5 and v3.6.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
