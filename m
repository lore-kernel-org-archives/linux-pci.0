Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Mon, 14 Mar 2016 16:30:53 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Dave Airlie <airlied@gmail.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] vga_switcheroo: add power support for windows 10
 machines.
Message-ID: <20160314143053.GJ1793@lahna.fi.intel.com>
References: <1457504045-12738-1-git-send-email-airlied@gmail.com>
 <2736217.utxPzJExd5@vostro.rjw.lan>
 <20160311105815.GS1796@lahna.fi.intel.com>
 <2759763.dR5D0KopkA@vostro.rjw.lan>
 <CAPM=9txo4aOOa-CS-mnyQe+vYDtAOCm1bzAgfMzwJJS8ZuYmwQ@mail.gmail.com>
 <20160314094335.GE1796@lahna.fi.intel.com>
 <CAPM=9txx1s3ZZSaTAGDFh=hKk-Ek2Y=Wyw74CpTWu-cTDAnJ7A@mail.gmail.com>
 <20160314102357.GA1793@lahna.fi.intel.com>
 <CAJZ5v0igUCP8-uH+VUb5KmUeZv5khtMJRjUh-z=orHOgRrcmiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJZ5v0igUCP8-uH+VUb5KmUeZv5khtMJRjUh-z=orHOgRrcmiw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 14, 2016 at 01:50:41PM +0100, Rafael J. Wysocki wrote:
> On Mon, Mar 14, 2016 at 11:23 AM, Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> > On Mon, Mar 14, 2016 at 07:47:39PM +1000, Dave Airlie wrote:
> >> >
> >> >> -     if (pcie_port_runtime_suspend_allowed(dev))
> >> >> +     if (pcie_port_runtime_suspend_allowed(dev)) {
> >> >> +             pm_runtime_allow(&dev->dev);
> >> >
> >> > PCI drivers typically have left this decision up to the userspace. I'm
> >> > wondering whether it is good idea to deviate from that here? Of course
> >> > this allows immediate power savings but could potentially cause problems
> >> > as well.
> >> >
> >>
> >> No distro has ever shipped userspace to do this, I really think this
> >> is a bad design.
> >> We have wasted countless watts of power on this stupid idea that people will
> >> run powertop, only a few people in the world run powertop, lots of
> >> people use Linux.
> >
> > That is a fair point.
> >
> > I do not have anything against calling pm_runtime_allow() here. In fact
> > we already do the same in Intel LPSS drivers. I just wanted to bring
> > that up.
> >
> > Rafael, what do you think?
> 
> We can do that to start with.  If there are no problems in the field
> with it, I don't see any problems in principle.
> 
> > If we anyway are going to add cut-off date to enable runtime PM we
> > should expect that the hardware is also capable of doing so (and if not
> > we can always blacklist the exceptions).
> 
> Sounds reasonable.
> 
> >> The kernel should power stuff down not wait for the user to run powertop,
> >> At least for the GPU it's in the area of 8W of power, and I've got the
> >> GPU drivers doing this themselves,
> >>
> >> I could have the GPU driver call runtime allow for it's host bridge I suppose,
> >> if we insist on the userspace cares, but I'd prefer not doing so.
> >>
> >> > I think we need to add corresponding call to pm_runtime_forbid() in
> >> > pcie_portdrv_remove().
> >>
> >> Yes most likely.
> >
> > BTW, I can add both calls to the next version of PCIe runtime PM patches
> > if you are OK with that, and all agree this is a good idea.
> 
> That would be fine by me.

OK thanks.

I'll do these changes to the next version of the patch series then.
