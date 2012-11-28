Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:24432 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932509Ab2K1WyJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 28 Nov 2012 17:54:09 -0500
Date: Wed, 28 Nov 2012 14:54:06 -0800
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
Message-ID: <20121128225406.GF8557@xanatos>
References: <20121126191002.GE6504@xanatos>
 <87boekave4.fsf@nemi.mork.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <87boekave4.fsf@nemi.mork.no>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Nov 26, 2012 at 10:48:03PM +0100, Bjørn Mork wrote:
> Sarah Sharp <sarah.a.sharp@linux.intel.com> writes:
> 
> > It looks like both Ulrich and Andrew have the same issue.  I also have a
> > Lenovo x220, and I confirmed that when I turn on PCI runtime suspend,
> > the NEC host controller does not report port status changes when a new
> > USB device is plugged in.
> >
> > I'm running 3.6.7, and I'm pretty sure that runtime suspend worked for
> > the NEC host on some older kernel.  I don't think the NEC host went into
> > D3cold on that kernel, though.  Is there a way to disable D3cold and
> > just use D3hot instead?
> 
> Yes, you have /sys/bus/pci/devices/.../d3cold_allowed
> See Documentation/ABI/testing/sysfs-bus-pci
> 
> If this really is a problem with the D3cold support that went into 3.6
> then I guess you should include Huang Ying in the discussions as well
> (CCed).

Turning off D3 cold didn't help.  Once the PCI device is suspended,
connect events do not generate an interrupt.

I'll go see if I can figure out which kernel this worked on and bisect.

Sarah Sharp
