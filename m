Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bmailout1.hostsharing.net ([83.223.95.100]:55445 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751210AbeFVJXU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jun 2018 05:23:20 -0400
Date: Fri, 22 Jun 2018 11:23:19 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Yinghai Lu <yinghai@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        linux-pci@vger.kernel.org, Rajat Jain <rajatja@google.com>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 23/32] PCI: pciehp: Avoid slot access during reset
Message-ID: <20180622092319.GA32281@wunner.de>
References: <cover.1529173804.git.lukas@wunner.de>
 <c91a547edf3d2de26c38a7452cabacf636891e3f.1529173804.git.lukas@wunner.de>
 <20180621120600.GY2558@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180621120600.GY2558@lahna.fi.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 21, 2018 at 03:06:00PM +0300, Mika Westerberg wrote:
> On Sat, Jun 16, 2018 at 09:25:00PM +0200, Lukas Wunner wrote:
> >  struct controller {
> >  	struct mutex ctrl_lock;
> >  	struct pcie_device *pcie;
> > +	struct rw_semaphore reset_lock;
> 
> Is there any particular reason why you can't use a regular mutex here?

It would unnecessarily serialize pciehp_probe() against pciehp_ist()
even though it's legal for the two to run in parallel.

I only want to serialize pciehp_reset_slot() with the rest of the driver,
more specifically those portions accessing the Presence Detect State bit
in the Slot Status register and the Data Link Layer Link Active bit in
the Link Status register.  And the only functions remaining that access
those bits are pciehp_probe() and pciehp_ist().  The tool to achieve that
kind of serialization is an rw_semaphore.

That said, I don't know for sure that the two above-mentioned bits flap
on performing a slot reset.  But I highly suspect it, so the code looked
unsafe.  It would be good if Rajat Jain and Alex Williamson, who
introduced pciehp_reset_slot(), could voice their opinion as to the
patch's necessity.

Thanks,

Lukas
