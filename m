Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Dave Airlie <airlied@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] vga_switcheroo: add power support for windows 10 machines.
Date: Fri, 11 Mar 2016 14:45:23 +0100
Message-ID: <2759763.dR5D0KopkA@vostro.rjw.lan>
In-Reply-To: <20160311105815.GS1796@lahna.fi.intel.com>
References: <1457504045-12738-1-git-send-email-airlied@gmail.com> <2736217.utxPzJExd5@vostro.rjw.lan> <20160311105815.GS1796@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, March 11, 2016 12:58:15 PM Mika Westerberg wrote:
> On Thu, Mar 10, 2016 at 09:57:09PM +0100, Rafael J. Wysocki wrote:
> > > It doesn't seem to do any runtime PM,
> > > I do wonder if pcieport should be doing it's own runtime PM handling,
> > > but that is a
> > > larger task than I'm thinking to tackle here.
> > 
> > PCIe ports don't do PM - yet.  Mika has posted a series of patches to implement
> > that, however, that are waiting for comments now:
> > 
> > https://patchwork.kernel.org/patch/8453311/
> > https://patchwork.kernel.org/patch/8453381/
> > https://patchwork.kernel.org/patch/8453391/
> > https://patchwork.kernel.org/patch/8453411/
> > https://patchwork.kernel.org/patch/8453371/
> > https://patchwork.kernel.org/patch/8453351/
> > 
> > > Maybe I should be doing
> > > 
> > > pci_set_power_state(pdev->bus->self, PCI_D3cold) ? I'm not really sure.
> > 
> > Using pci_set_power_state() would be more appropriate IMO, but you can get
> > to the bridge via dev->parent too, can't you?
> > 
> > In any case, it looks like you and Mika need to talk. :-)
> 
> When the vga_switcheroo device gets runtime suspended (with the above
> runtime PM patchs for PCIe root ports) the root port should also be
> runtime suspended by the PM core.

Right, after your patches have been applied, the additional handling
won't be needed.

So Dave, maybe you can check if the Mika's patches help?

Thanks,
Rafael

