Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 12 Jul 2018 10:59:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] PCI: Document patch submission hints
Message-ID: <20180712155946.GB28466@bhelgaas-glaptop.roam.corp.google.com>
References: <153030390808.57832.2200774416664543563.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <153030405971.57832.12860154795039493576.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20180701174508.GB28249@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180701174508.GB28249@wunner.de>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Jul 01, 2018 at 07:45:08PM +0200, Lukas Wunner wrote:
> On Fri, Jun 29, 2018 at 03:27:39PM -0500, Bjorn Helgaas wrote:
> > --- /dev/null
> > +++ b/Documentation/PCI/submitting-patches.txt
> > @@ -0,0 +1,153 @@
> > +Start with Documentation/process/submitting-patches.rst for general
> > +guidance.
> > +
> > +These are things I look at when reviewing patches.
> 
> For an uninitiated reader who doesn't know that you're currently the
> (sole) maintainer of the PCI subsystem, this sentence might look odd.
> Who's "I"?  What happens if you onboard co-maintainers, are you
> going to change this to "we"?

You're absolutely right.  That was appropriate for email (where I
originally posted this) but certainly not for the tree.

> > +  - Follow the existing convention  Run "git log --oneline <file>" and make
> > +    your subject line match previous changes in format, capitalization, and
> > +    sentence structure.  For example, native host bridge driver patch
> > +    titles look like this:
> > +
> > +      PCI: vmd: Remove IRQ affinity so we can allocate more IRQs
> > +      PCI: mediatek: Add MSI support for MT2712 and MT7622
> > +      PCI: rockchip: Remove IRQ domain if probe fails
> 
> A quick "git log --oneline --no-merges drivers/pci" shows that the prefixes
> in use aren't consistent at all:  Sometimes a slash is used to separate
> "PCI" from the subpart touched by the patch, sometimes a colon, e.g.
> "PCI/AER: " versus "PCI: shpchp: ".  Your own patches aren't consistent
> in that respect.  Sometimes, only "PCI: " is given as prefix, even though
> the commit only touches a subpart such as "sysfs", so could easily specify
> more precisely what it's touching.
> 
> If you value consistency, it would be good to codify the preferred form
> right here.

I was trying to make the point that whenever we're doing *anything* in
a shared project like Linux, it's better to look at existing practice
and follow it than it is to slavishly follow rules.

So I purposely didn't enumerate all the cases.  I think if you look at
logs of individual files, they're pretty consistent.  I generally use
"PCI/XXX" for things in the core (mostly capabilities like MSI, AER,
DPC, etc) and "PCI: xxx:" for drivers (shpchp, pciehp, etc).  IIRC, I
adopted this from previous practice.

Of course there are things I don't apply that are different.  And
Rafael does most of the PM stuff, so I try to follow *his* convention
for that.

> > +  - Always copy linux-pci@vger.kernel.org and linux-kernel@vger.kernel.org.
> 
> I'd drop linux-kernel here.  The volume on that list is already like
> drinking from a firehose, I doubt it adds much value to cc it.

It's useful as an archive and for people not subscribed to linux-pci
who happen to see the occasional thing they want to respond to.
Nobody expects to be able to follow everything on LKML.
get_maintainer.pl reports LKML for everything, and I'm not trying to
innovate by being different.

But on reflection, I think the overall value of this writeup is
minimal.  It's a lot of repetition of things already documented
elsewhere and most of it boils down to "pay attention to existing
practice and don't do things differently unless you're innovating and
adding value."  That *should* be obvious, and if it's not, I doubt
that adding one more thing to read is going to make it more obvious.

Bjorn
