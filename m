Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:4968 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755414AbeFYNKl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Jun 2018 09:10:41 -0400
Date: Mon, 25 Jun 2018 16:10:36 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Yinghai Lu <yinghai@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        linux-pci@vger.kernel.org, Rajat Jain <rajatja@google.com>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 23/32] PCI: pciehp: Avoid slot access during reset
Message-ID: <20180625131036.GK2558@lahna.fi.intel.com>
References: <cover.1529173804.git.lukas@wunner.de>
 <c91a547edf3d2de26c38a7452cabacf636891e3f.1529173804.git.lukas@wunner.de>
 <20180621120600.GY2558@lahna.fi.intel.com>
 <20180622092319.GA32281@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180622092319.GA32281@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 22, 2018 at 11:23:19AM +0200, Lukas Wunner wrote:
> On Thu, Jun 21, 2018 at 03:06:00PM +0300, Mika Westerberg wrote:
> > On Sat, Jun 16, 2018 at 09:25:00PM +0200, Lukas Wunner wrote:
> > >  struct controller {
> > >  	struct mutex ctrl_lock;
> > >  	struct pcie_device *pcie;
> > > +	struct rw_semaphore reset_lock;
> > 
> > Is there any particular reason why you can't use a regular mutex here?
> 
> It would unnecessarily serialize pciehp_probe() against pciehp_ist()
> even though it's legal for the two to run in parallel.
> 
> I only want to serialize pciehp_reset_slot() with the rest of the driver,
> more specifically those portions accessing the Presence Detect State bit
> in the Slot Status register and the Data Link Layer Link Active bit in
> the Link Status register.  And the only functions remaining that access
> those bits are pciehp_probe() and pciehp_ist().  The tool to achieve that
> kind of serialization is an rw_semaphore.

In that case I think it may be good idea to put the above to the
changelog so it is clear why rw_semaphore is used here.
