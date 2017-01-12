Return-Path: <SRS0=lzOr=Y2=redhat.com=lyude@kernel.org>
Return-Path: <SRS0=lzOr=Y2=redhat.com=lyude@kernel.org>
Message-ID: <1484186688.25614.4.camel@redhat.com>
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"
From: Lyude Paul <lyude@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>, David Airlie <airlied@redhat.com>,
        Peter Jones <pjones@redhat.com>
Cc: Lukas Wunner <lukas@wunner.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peter Wu <peter@lekensteyn.nl>, Bjorn Helgaas <helgaas@kernel.org>,
        Mika
 Westerberg <mika.westerberg@linux.intel.com>,
        Kilian Singer
 <kilian.singer@quantumtechnology.info>,
        linux-pci
 <linux-pci@vger.kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>
Date: Wed, 11 Jan 2017 21:04:48 -0500
In-Reply-To: <1484183615.25614.3.camel@redhat.com>
References: <20161228161816.GA19653@bhelgaas-glaptop.roam.corp.google.com>
	 <20170104081639.GA21076@wunner.de> <20170104210954.GA11946@al>
	 <59349185.1aqio7kYFn@aspire.rjw.lan>
	 <1456065516.8360056.1483572074197.JavaMail.zimbra@redhat.com>
	 <20170105150646.GB21446@wunner.de>
	 <20170105181322.wnvdytpgddcdk3ry@redhat.com>
	 <1931628154.8613274.1483644995907.JavaMail.zimbra@redhat.com>
	 <1483974686.28993.3.camel@redhat.com>
	 <e16ce603-1d40-9aef-c755-5e2e0322668a@redhat.com>
	 <1484167244.25614.1.camel@redhat.com> <1484183615.25614.3.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

Finally got koji to work :). People having the runtime resume problem,
can you give this kernel RPM a try and tell me if the issue still
persists?

https://koji.fedoraproject.org/koji/taskinfo?taskID=17250338

On Wed, 2017-01-11 at 20:13 -0500, Lyude Paul wrote:
> Neat, went through one of my old kernel git repos and indeed I did
> write a patch for fixing this exact issue. I must have forgotten to
> follow up with it after sending it out to the mailing list.
> 
> Anyway, the original patch I had doesn't fix the problem entirely on
> new kernels so I added some more deadlock fixes into it, now RPM
> seems
> to work fine. I will respond with a koji build of the F25 kernel with
> the patches applied once I finish wrestling with getting kerberos to
> work with FAS…
> 
> On Wed, 2017-01-11 at 15:40 -0500, Lyude Paul wrote:
> > Alright yeah, runtime suspend definitely doesn't seem to work on
> > this
> > one either. I thought I had sent a patch for this a while back, but
> > trying my patch now it doesn't seem to fix the issue…
> > 
> > On Mon, 2017-01-09 at 16:21 +0100, Hans de Goede wrote:
> > > Hi Lyude,
> > > 
> > > On 09-01-17 16:11, Lyude Paul wrote:
> > > > fwiw, I just tried on the W541 I have 4.8.15-300.fc25.x86_64
> > > > running on
> > > > here and so far it seems to suspend/resume just fine using
> > > > firmware
> > > > version 2.19
> > > 
> > > Note this is not about normal suspend resume, but runtime
> > > suspend/resume of the nvidia discrete GPU...
> > > 
> > > Try running glxgears like this:
> > > 
> > > DRI_PRIME=1 glxgears -info | grep REND
> > > 
> > > (the grep is to check you're really running on the nvidia GPU).
> > > 
> > > Then you should see msgs in dmesg about nouveau resuming the gpu,
> > > then kill glxgears and wait for 5 seconds, now the nouveau drv
> > > should say the gpu is suspending, etc.
> > > 
> > > If it never runtime suspends, then make sure you are not using
> > > any external screens, only the built-in laptop screen.
> > > 
> > > Regards,
> > > 
> > > Hans
> > > 
> > > 
> > > > 
> > > > On Thu, 2017-01-05 at 14:36 -0500, David Airlie wrote:
> > > > > (cc'ing Lyude, who has the hw also I think).
> > > > > 
> > > > > ----- Original Message -----
> > > > > > From: "Peter Jones" <pjones@redhat.com>
> > > > > > To: "Lukas Wunner" <lukas@wunner.de>
> > > > > > Cc: "David Airlie" <airlied@redhat.com>, "Rafael J.
> > > > > > Wysocki"
> > > > > > <r
> > > > > > jw@r
> > > > > > jwysocki.net>, "Peter Wu" <peter@lekensteyn.nl>,
> > > > > > "Bjorn Helgaas" <helgaas@kernel.org>, "Mika Westerberg"
> > > > > > <mika.weste
> > > > > > rberg@linux.intel.com>, "Kilian Singer"
> > > > > > <kilian.singer@quantumtechnology.info>, "linux-pci" <linux-
> > > > > > pci@
> > > > > > vger
> > > > > > .kernel.org>, "Alex Deucher"
> > > > > > <alexander.deucher@amd.com>, "Hans de Goede" <hdegoede@redh
> > > > > > at
> > > > > > .c
> > > > > > om>
> > > > > > Sent: Friday, 6 January, 2017 4:13:23 AM
> > > > > > Subject: Re: PCI: Revert "PCI: Add runtime PM support for
> > > > > > PCIe
> > > > > > ports"
> > > > > > 
> > > > > > On Thu, Jan 05, 2017 at 04:06:46PM +0100, Lukas Wunner
> > > > > > wrote:
> > > > > > > On Wed, Jan 04, 2017 at 06:21:14PM -0500, David Airlie
> > > > > > > wrote:
> > > > > > > > > On Wednesday, January 04, 2017 10:09:54 PM Peter Wu
> > > > > > > > > wrote:
> > > > > > > > > > On Wed, Jan 04, 2017 at 09:16:39AM +0100, Lukas
> > > > > > > > > > Wunner
> > > > > > > > > > wrote:
> > > > > > > > > > > On Tue, Jan 03, 2017 at 06:05:57PM -0600, Bjorn
> > > > > > > > > > > Helgaas
> > > > > > > > > > > wrote:
> > > > > > > > > > > > I don't *want* to apply the revert.  It's on my
> > > > > > > > > > > > for-
> > > > > > > > > > > > linus branch
> > > > > > > > > > > > as a
> > > > > > > > > > > > worst-case scenario change if we can't figure
> > > > > > > > > > > > out
> > > > > > > > > > > > a
> > > > > > > > > > > > better fix.
> > > > > > > > > > > > 
> > > > > > > > > > > > The patch below is preferable, but I'd rather
> > > > > > > > > > > > not
> > > > > > > > > > > > take
> > > > > > > > > > > > even it,
> > > > > > > > > > > > because it takes away functionality and forces
> > > > > > > > > > > > people
> > > > > > > > > > > > to use a
> > > > > > > > > > > > boot
> > > > > > > > > > > > parameter to restore it.  I expect that
> > > > > > > > > > > > somebody
> > > > > > > > > > > > will
> > > > > > > > > > > > figure out
> > > > > > > > > > > > how
> > > > > > > > > > > > to fix the regression Kilian found and also
> > > > > > > > > > > > keep
> > > > > > > > > > > > the
> > > > > > > > > > > > new
> > > > > > > > > > > > functionality
> > > > > > > > > > > > (without requiring boot parameters) before
> > > > > > > > > > > > v4.10.
> > > > > > > > > > > 
> > > > > > > > > > > The issue is constrained to hybrid graphics
> > > > > > > > > > > laptops
> > > > > > > > > > > with
> > > > > > > > > > > Nvidia
> > > > > > > > > > > discrete
> > > > > > > > > > > GPU using nouveau.  Hence it needs to be fixed in
> > > > > > > > > > > nouveau, not in
> > > > > > > > > > > the
> > > > > > > > > > > PCI core.
> > > > > > > > > > 
> > > > > > > > > > The problem is not necessarily in the nouveau
> > > > > > > > > > driver,
> > > > > > > > > > the
> > > > > > > > > > same
> > > > > > > > > > problem
> > > > > > > > > > occurs when you enable RPM without loading nouveau.
> > > > > > > > > > The
> > > > > > > > > > issue is
> > > > > > > > > > limited
> > > > > > > > > > though to some newer hybrid graphics laptops with
> > > > > > > > > > Nvidia
> > > > > > > > > > GPUs. While
> > > > > > > > > > a
> > > > > > > > > > quirk can be added to nouveau, I think that a
> > > > > > > > > > (temporary)
> > > > > > > > > > quirk in
> > > > > > > > > > core
> > > > > > > > > > would also be reasonable (since it also occurs
> > > > > > > > > > without
> > > > > > > > > > nouveau).
> > > > > > > > > > 
> > > > > > > > > > > (AFAIUI, laptops with AMD discrete GPU are not
> > > > > > > > > > > affected
> > > > > > > > > > > as it is
> > > > > > > > > > > known
> > > > > > > > > > > when and how to call an ACPI method versus using
> > > > > > > > > > > PR3.)
> > > > > > > > > > > 
> > > > > > > > > > > (Neither are laptops using the Nvidia proprietary
> > > > > > > > > > > driver
> > > > > > > > > > > as it
> > > > > > > > > > > doesn't
> > > > > > > > > > > runtime suspend the card.  But battery life will
> > > > > > > > > > > be
> > > > > > > > > > > terrible then.)
> > > > > > > > > > > 
> > > > > > > > > > > We're at rc2 so the time frame for coming up with
> > > > > > > > > > > a
> > > > > > > > > > > fix
> > > > > > > > > > > is probably
> > > > > > > > > > > 4 weeks.  Peter and others have tried for months
> > > > > > > > > > > to
> > > > > > > > > > > reverse-engineer
> > > > > > > > > > > how to handle runtime PM on newer Nvidia
> > > > > > > > > > > cards.  It
> > > > > > > > > > > seems
> > > > > > > > > > > likely
> > > > > > > > > > > that
> > > > > > > > > > > we'll not find the ultimate solution to the
> > > > > > > > > > > problem
> > > > > > > > > > > within 4 weeks.
> > > > > > > > > > 
> > > > > > > > > > Yep, a quick proper fix seems unlikely.
> > > > > > > > > > [ Help/ideas are welcome, I suspect that these
> > > > > > > > > > failures
> > > > > > > > > > to
> > > > > > > > > > restore
> > > > > > > > > > power
> > > > > > > > > > on laptops designed for Win8+ all have the same
> > > > > > > > > > cause,
> > > > > > > > > > related to
> > > > > > > > > > some
> > > > > > > > > > unknown interaction between ACPI and PCI. Some
> > > > > > > > > > links:
> > > > > > > > > > https://bugzilla.kernel.org/show_bug.cgi?id=190861
> > > > > > > > > > https://bugzilla.kernel.org/show_bug.cgi?id=156341
> > > > > > > > > > ]
> > > > > > > > > > 
> > > > > > > > > > > The way it is now, i.e. defaulting to PR3 when
> > > > > > > > > > > available,
> > > > > > > > > > > regresses
> > > > > > > > > > > certain laptops such as Kilian's.  If on the
> > > > > > > > > > > other
> > > > > > > > > > > hand
> > > > > > > > > > > we default
> > > > > > > > > > > to
> > > > > > > > > > > DSM when available, we'll regress certain other
> > > > > > > > > > > laptops,
> > > > > > > > > > > as Peter
> > > > > > > > > > > has
> > > > > > > > > > > pointed out.  Whitelisting or blacklisting
> > > > > > > > > > > laptops
> > > > > > > > > > > doesn't seem a
> > > > > > > > > > > good
> > > > > > > > > > > approach either, ideally we'd want to use PR3 as
> > > > > > > > > > > Windows
> > > > > > > > > > > does.
> > > > > > > > > > > 
> > > > > > > > > > > As said, the only short-term solution I see is to
> > > > > > > > > > > add
> > > > > > > > > > > an
> > > > > > > > > > > "optimus"
> > > > > > > > > > > module_param to nouveau to allow users to select
> > > > > > > > > > > which
> > > > > > > > > > > method to
> > > > > > > > > > > use.
> > > > > > > > > > > So in Kilian's case an additional command line
> > > > > > > > > > > parameter
> > > > > > > > > > > would be
> > > > > > > > > > > necessary to fix the issue.
> > > > > > > > > > > 
> > > > > > > > > > > Does anyone see a better solution or can we agree
> > > > > > > > > > > on
> > > > > > > > > > > this
> > > > > > > > > > > one?  If
> > > > > > > > > > > so
> > > > > > > > > > > I can come up with a patch.  This could go in via
> > > > > > > > > > > Dave
> > > > > > > > > > > Airlie's
> > > > > > > > > > > tree.
> > > > > > > > > > 
> > > > > > > > > > As pcie_port_pm=off already reverts to DSM, I do
> > > > > > > > > > not
> > > > > > > > > > think
> > > > > > > > > > that an
> > > > > > > > > > additional (temporary) nouveau module parameter is
> > > > > > > > > > going to
> > > > > > > > > > help. I
> > > > > > > > > > instead propose a (hopefully temporary) quirk in
> > > > > > > > > > pci
> > > > > > > > > > core
> > > > > > > > > > that
> > > > > > > > > > disables
> > > > > > > > > > D3cold RPM for just Kilians Lenovo laptop
> > > > > > > > > > (basically
> > > > > > > > > > defaulting to
> > > > > > > > > > pcie_port_pm=off). Then the option
> > > > > > > > > > pcie_port_pm=force
> > > > > > > > > > can
> > > > > > > > > > still be
> > > > > > > > > > used
> > > > > > > > > > to test possible solutions in the future.
> > > > > > > > > 
> > > > > > > > > I would rather add a quirk to the ACPI core to
> > > > > > > > > prevent
> > > > > > > > > the
> > > > > > > > > power
> > > > > > > > > resources in
> > > > > > > > > question from being enumerated.  Or even to prevent
> > > > > > > > > ACPI
> > > > > > > > > PM
> > > > > > > > > from being
> > > > > > > > > used for the port in question.
> > > > > > > > 
> > > > > > > > I do have a W541 in a cupboard in the office somewhere,
> > > > > > > > but
> > > > > > > > I
> > > > > > > > won't be
> > > > > > > > close to
> > > > > > > > it for a couple of weeks. The W541 was the first place
> > > > > > > > I
> > > > > > > > tested
> > > > > > > > the pm
> > > > > > > > patches
> > > > > > > > so I'm kinda wondering whether it's all W541's or just
> > > > > > > > some
> > > > > > > > specific
> > > > > > > > model/bios
> > > > > > > > combo.
> > > > > > 
> > > > > > They seem to all ship with the 1.10 firmware, and 2.80 is
> > > > > > current
> > > > > > (there
> > > > > > are a bunch of intermediate 2.xx versions).  Somewhere
> > > > > > along
> > > > > > the
> > > > > > line
> > > > > > they introduced some bugs in the UEFI stuff, so it wouldn't
> > > > > > be
> > > > > > surprising if there's bugs introduced elsewhere as well.
> > > > > > 
> > > > > > > > However I'm pretty much unavailable to do anything much
> > > > > > > > until
> > > > > > > > late Jan on
> > > > > > > > this.
> > > > > > > 
> > > > > > > Is there anyone else at Red Hat who might be able to look
> > > > > > > into
> > > > > > > this?
> > > > > > > 
> > > > > > > ISTR that Hans de Goede is working on improving laptop
> > > > > > > support in
> > > > > > > Fedora,
> > > > > > > and Peter Jones recently got a patch merged for the W541
> > > > > > > with
> > > > > > > the
> > > > > > > exact
> > > > > > > same firmware Kilian is using to work around a botched
> > > > > > > EFI
> > > > > > > memory
> > > > > > > map.
> > > > > > > Adding them to cc: in the hope that they may be able to
> > > > > > > help.
> > > > > > > 
> > > > > > > @Peter, have you noticed issues with the discrete Nvidia
> > > > > > > GPU
> > > > > > > on
> > > > > > > your W541
> > > > > > > related to runtime suspend and system sleep?
> > > > > > 
> > > > > > I was using a borrowed one (I can certainly find it again,
> > > > > > but
> > > > > > I'm
> > > > > > not
> > > > > > working on graphics/pm really), but yeah - shutdown and
> > > > > > lspci
> > > > > > both
> > > > > > broke
> > > > > > sometime after pci_pm_runtime_resume().  Here's the
> > > > > > traceback
> > > > > > from
> > > > > > SYS_reboot(): https://goo.gl/photos/T1fr1bksHQb9RSU67
> > > > > > 
> > > > > > Dave, if you know who in Westford should have a look at
> > > > > > this,
> > > > > > I
> > > > > > can
> > > > > > see
> > > > > > about getting them hardware.  I am more or less surrounded
> > > > > > by
> > > > > > that
> > > > > > team.
> > > > > > 
> > > > > > --
> > > > > >         Peter
> > > > > > 
-- 
Cheers,
	Lyude
