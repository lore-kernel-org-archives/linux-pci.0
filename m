Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 26 Jun 2018 12:14:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>, n0000b.n000b@gmail.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] PCI / ACPI / PM: Resume bridges w/o drivers on
 suspend-to-RAM
Message-ID: <20180626171406.GC146680@bhelgaas-glaptop.roam.corp.google.com>
References: <35587465.8Nave9aG7d@aspire.rjw.lan>
 <20180626140115.GA146680@bhelgaas-glaptop.roam.corp.google.com>
 <CAJZ5v0jc5oJzEX6QVDVjsQLmLxXHg3PSyepbh50dLXOtnHPgrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJZ5v0jc5oJzEX6QVDVjsQLmLxXHg3PSyepbh50dLXOtnHPgrA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 26, 2018 at 04:22:00PM +0200, Rafael J. Wysocki wrote:
> On Tue, Jun 26, 2018 at 4:01 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Tue, Jun 26, 2018 at 12:06:01PM +0200, Rafael J. Wysocki wrote:
> >> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> >> +     /*
> >> +      * In some cases (eg. Samsung 305V4A) leaving a bridge in suspend
> >> +      * confuses the platform firmware, so avoid doing that, unless the
> >> +      * bridge has a driver that should take care of PM handling.
> >> +      */
> >> +     if (pci_is_bridge(dev) && !dev->driver)
> >> +             return true;
> >
> > It sounds like the question of whether leaving a bridge in D3 confuses
> > the firmware has a platform-specific answer.
> 
> Well, it may confuse the platform firmware in general.
> 
> > How does the driver PM handling know how to do the right thing?
> 
> For endpoints this is not an issue as they always have been expected
> to be in D3 before passing control to the platform firmware on S3
> entry, but we've never done that for bridges by default, except for
> PCIe ports with PM enabled (in which case the driver decides whether
> or not to enable it).

If there's any spec reference for the expected power states of devices
when entering S3, that would be useful here.  I can't tell if there's
any guidance for this or if it's just figured out experimentally.

> > Does it need to know whether
> > it's safe to put the device in D3?  Or maybe a device is never put in
> > D3 for system suspend if it has a driver?
> 
> As per the above, endpoints should be OK (or they are quirky if not),
> but bridges are sort of a gray area.  PCIe ports for which we enable
> PM should be fine, for the rest it's better to be conservative and
> resume them IMO.
