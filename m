Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:44445 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1424343Ab2LGUz1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 7 Dec 2012 15:55:27 -0500
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
Date: Fri, 07 Dec 2012 22:00:22 +0100
Message-ID: <7766249.mqYLvmhmrJ@vostro.rjw.lan>
In-Reply-To: <20121207002808.GG5324@xanatos>
References: <20121126191002.GE6504@xanatos> <1962497.aG1sFtYjJG@vostro.rjw.lan> <20121207002808.GG5324@xanatos>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, December 06, 2012 04:28:08 PM Sarah Sharp wrote:
> On Thu, Dec 06, 2012 at 01:43:32AM +0100, Rafael J. Wysocki wrote:
> > On Wednesday, December 05, 2012 04:33:44 PM Sarah Sharp wrote:
> > > Wakeup from D3 works fine on the 3.5.0 kernel, but fails on 3.6.2.  I
> > > haven't fully bisected yet.
> > > 
> > > In debugging, I found that if you only enable runtime suspend for the
> > > NEC host controller, the host successfully comes out of D3 when you plug
> > > in a USB device.  However, if you enable runtime PM for the parent PCIe root
> > > port, it stops working.  Disabling D3cold for both devices did not help.
> > > 
> > > It looks like a PCI issue, so what sort of debugging info do you need
> > > from me?
> > 
> > It looks like this is related to one of the following commits:
> 
> > Generally, please try to bisect changes in drivers/pci between v3.5 and v3.6.
> 
> Ok, I ran git bisect with only the drivers/pci directory as a target.
> 
> > ee85f54 ACPI/PM: specify lowest allowed state for device sleep state
> 
> git bisect ended up identifying this as the bad patch, although
> reverting just that patch after the bisect finished didn't seem to help.
> However, it does make sense that this would be the culprit patch, if
> Huang Ying's theory about the PME polling is correct.

Well, we surely don't handle this particular case correctly, and it shouldn't
be very difficult to fix, so let's hope that this is the culprit. :-)

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
