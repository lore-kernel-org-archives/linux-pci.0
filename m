Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 20 Mar 2018 12:35:56 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 1/2] PCI/DPC: Disable interrupt generation during suspend
Message-ID: <20180320113556.GA24197@wunner.de>
References: <20180314114125.71132-1-mika.westerberg@linux.intel.com>
 <CAJZ5v0gOrQhXzLHDnABEYHxGbHVY89Nij9uQzqx-oyYmFwzuSg@mail.gmail.com>
 <20180314120547.GB2703@lahna.fi.intel.com>
 <20180314123332.GC19651@wunner.de>
 <20180320104508.GF2703@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180320104508.GF2703@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 20, 2018 at 12:45:08PM +0200, Mika Westerberg wrote:
> > On Wed, Mar 14, 2018 at 02:05:47PM +0200, Mika Westerberg wrote:
> > > On Wed, Mar 14, 2018 at 12:48:49PM +0100, Rafael J. Wysocki wrote:
> > > > Have you considered putting these things into the ->suspend_late and
> > > > ->resume_early callbacks, respectively?
> > > > 
> > > > That might be slightly better as runtime resume is still enabled when
> > > > the ->suspend and ->resume callbacks run.
> > > 
> > > There is no ->suspend_late or ->resume_early callbacks in struct
> > > pcie_port_service_driver so I followed what drivers/pci/pcie/pme.c is
> > > doing. I guess we could add those callbacks as well if you think they
> > > are better suited here.
> 
> I took a look and then realized that we most probably do not need the
> custom portdrv specific hooks at all. They are basically doing the same
> than what PM core is (iterate over children and call service driver PM
> hook). I don't see any reason why we could not rely on the PM core ops
> instead of these custom ones but maybe I'm missing something.

Can't think of a reason why this solution shouldn't work, I must have
been blind not to see it.

Lukas
