Return-Path: <SRS0=PF/i=ZZ=wunner.de=lukas@kernel.org>
Return-Path: <SRS0=PF/i=ZZ=wunner.de=lukas@kernel.org>
Date: Sun, 12 Feb 2017 17:50:30 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Andreas Noever <andreas.noever@gmail.com>,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 1/8] PCI: Recognize Thunderbolt devices
Message-ID: <20170212165030.GA2801@wunner.de>
References: <cover.1484486499.git.lukas@wunner.de>
 <bfabf33fc63abbeb84e11e544456098dff0e4604.1484486499.git.lukas@wunner.de>
 <20170128215208.GM20550@bhelgaas-glaptop.roam.corp.google.com>
 <20170129002616.GA28225@wunner.de>
 <20170210174250.GD29169@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170210174250.GD29169@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 10, 2017 at 11:42:50AM -0600, Bjorn Helgaas wrote:
> On Sun, Jan 29, 2017 at 01:26:16AM +0100, Lukas Wunner wrote:
> > On Sat, Jan 28, 2017 at 03:52:08PM -0600, Bjorn Helgaas wrote:
> > > On Sun, Jan 15, 2017 at 09:03:45PM +0100, Lukas Wunner wrote:
> 
> > > > +static void set_pcie_vendor_specific(struct pci_dev *dev)
> > > 
> > > This is very specific to Thunderbolt, so let's name it something that
> > > conveys that information.  The fact that we use a vendor-specific
> > > capability to figure it out isn't really relevant in the caller.
> > 
> > I thought that we may have the necessity in the future to parse other
> > VSECs on device probe, so I gave the function this generic name.
> > 
> > Think about it, every VSEC that needs to be parsed needs the while loop
> > below.  It's more efficient to have only a single while loop that handles
> > *all* VSECs at once.
> > 
> > If someone needs to parse another VSEC, they just add it to this function.
> > So IMO the way I've solved it is preferable to just adding a Thunderbolt-
> > specific function.
> > 
> > Are you sure you want this renamed? (y/n)
> 
> Sorry for the delay; I missed this question.  If this has already been
> merged somewhere as-is, that's fine.

No, none of the patches in this series have been merged so far.  Greg's
tree is closed for the duration of the merge window, which is expected
to open today.  Therefore, please merge whatever patches in this series
you feel comfortable with.  It would be good if you could merge at least
patch [1/8] as it would allow me to fix the issues in apple-gmux and
vga_switcheroo that I'm mentioning in the changelog in v4.12.  Also,
patch [2/8] seems uncontroversial.

Greg has acked v5 of this series and suggested that you take it due to
all the PCI changes:
https://lkml.org/lkml/2017/1/19/177

Andreas Noever acked and tested v2 of this series:
https://www.spinics.net/lists/linux-pci/msg51274.html


> If you repost it for any reason,
> I would prefer to rename it so it reflects the functionality rather
> than the source of the information.  This isn't a performance path, so
> readability is more important than optimization.

Sure, I've renamed it.

Thanks,

Lukas
