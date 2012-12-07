Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:58113 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932627Ab2LGA2H (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 6 Dec 2012 19:28:07 -0500
Date: Thu, 6 Dec 2012 16:28:08 -0800
From: Sarah Sharp <sarah.a.sharp@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
	Ulrich Eckhardt <usb@uli-eckhardt.de>,
	Andrew Lutomirski <luto@mit.edu>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Ming Lei <ming.lei@canonical.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Huang Ying <ying.huang@intel.com>
Subject: Re: Unreliable USB3 with NEC uPD720200 and Delock Cardreader
Message-ID: <20121207002808.GG5324@xanatos>
References: <20121126191002.GE6504@xanatos>
 <20121128225406.GF8557@xanatos>
 <20121206003344.GC5324@xanatos>
 <1962497.aG1sFtYjJG@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1962497.aG1sFtYjJG@vostro.rjw.lan>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 06, 2012 at 01:43:32AM +0100, Rafael J. Wysocki wrote:
> On Wednesday, December 05, 2012 04:33:44 PM Sarah Sharp wrote:
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
> It looks like this is related to one of the following commits:

> Generally, please try to bisect changes in drivers/pci between v3.5 and v3.6.

Ok, I ran git bisect with only the drivers/pci directory as a target.

> ee85f54 ACPI/PM: specify lowest allowed state for device sleep state

git bisect ended up identifying this as the bad patch, although
reverting just that patch after the bisect finished didn't seem to help.
However, it does make sense that this would be the culprit patch, if
Huang Ying's theory about the PME polling is correct.

Sarah Sharp
