Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:12489 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751305AbcEYN0F (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 25 May 2016 09:26:05 -0400
Date: Wed, 25 May 2016 16:25:30 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Peter Wu <peter@lekensteyn.nl>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Valdis Kletnieks <valdis.kletnieks@vt.edu>,
	Dave Airlie <airlied@gmail.com>
Subject: Re: [PATCH] PCI: Power on bridges before scanning new devices
Message-ID: <20160525132530.GM1789@lahna.fi.intel.com>
References: <20160519231234.GB1785@al>
 <1463991648-85051-1-git-send-email-mika.westerberg@linux.intel.com>
 <20160523200042.GB24375@localhost>
 <20160523215015.GA31479@localhost>
 <20160524122357.GA20453@localhost>
 <20160524125323.GE1789@lahna.fi.intel.com>
 <20160525121626.GA6339@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160525121626.GA6339@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 25, 2016 at 02:16:26PM +0200, Lukas Wunner wrote:
> Hi Mika,
> 
> On Tue, May 24, 2016 at 03:53:23PM +0300, Mika Westerberg wrote:
> > One thing I noticed, though. When a bridge is transitioned to D0 we only
> > wait for 10ms which is requirement for PCI functions. However, PCI PM
> > specification 1.2 (chapter 4.2) requires that for buses to transition
> > from B2 to B0 we need to wait minimum of 50ms before accessing a
> > function on that bus.
> > 
> > We even have PCI_PM_BUS_WAIT defined in include/linux/pci.h but it is
> > not used anywhere. Maybe it was not needed originally because we never
> > powered down bridges anyway but now when we do, I think it is good idea
> > to do what the spec requires.
> 
> The macro was introduced with
> 
>     commit aa8c6c93747f7b55fa11e1624fec8ca33763a805
>     Author: Rafael J. Wysocki <rjw@sisk.pl>
>     Date:   Fri Jan 16 21:54:43 2009 +0100
>     PCI PM: Restore standard config registers of all devices early
> 
> but the only usage of it was removed with
> 
>     commit 476e7faefc43f106a90b5c96166c59b75de19d30
>     Author: Rafael J. Wysocki <rjw@sisk.pl>
>     Date:   Thu Jan 22 23:39:57 2009 +0100
>     PCI PM: Do not wait for buses in B2 or B3 during resume
> 

Thanks for looking that up.

If I understand correctly it was removed because we do not expect BIOS
to put buses to B2/B3 so we do not need to wait the extra 50ms before
accessing the device.

However, now that we do that in the OS (and also during runtime), I
think we need to take that into account again.
