Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:52552 "EHLO
	mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751837AbcD1OWk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 28 Apr 2016 10:22:40 -0400
Date: Thu, 28 Apr 2016 16:25:19 +0200
From: Lukas Wunner <lukas@wunner.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Qipeng Zha <qipeng.zha@intel.com>,
	Qi Zheng <qi.zheng@intel.com>, Dave Airlie <airlied@gmail.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andreas Noever <andreas.noever@gmail.com>,
	Linux PCI <linux-pci@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v4 2/4] PCI: Move PCIe ports to D3 during suspend
Message-ID: <20160428142519.GB18211@wunner.de>
References: <1461578004-129094-1-git-send-email-mika.westerberg@linux.intel.com>
 <1461578004-129094-3-git-send-email-mika.westerberg@linux.intel.com>
 <CAJZ5v0itrp_=KUo9kFHh8rSN5RYfPk0+iEgeAWZR5rrnFq-jDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJZ5v0itrp_=KUo9kFHh8rSN5RYfPk0+iEgeAWZR5rrnFq-jDA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Rafael,

On Tue, Apr 26, 2016 at 11:04:55PM +0200, Rafael J. Wysocki wrote:
> On Mon, Apr 25, 2016 at 11:53 AM, Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
[snip]
> > --- a/drivers/pci/pci-driver.c
> > +++ b/drivers/pci/pci-driver.c
> > @@ -777,7 +777,12 @@ static int pci_pm_suspend_noirq(struct device *dev)
> >
> >         if (!pci_dev->state_saved) {
> >                 pci_save_state(pci_dev);
> > -               if (!pci_has_subordinate(pci_dev))
> > +               /*
> > +                * Check if given device can go to low power state. Currently
> > +                * we allow normal PCI devices and PCI bridges if their
> > +                * bridge_d3 is set.
> > +                */
> > +               if (!pci_has_subordinate(pci_dev) || pci_dev->bridge_d3)
> 
> I'd add a helper for this, say pci_power_manageable() or similar.

He had a helper for this in a prior version and removed it on my
suggestion. Sorry Mika, guess I caused you additional work there. :-/

Best regards,

Lukas
