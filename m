Return-Path: <SRS0=T9Qg=ZV=wunner.de=lukas@kernel.org>
Return-Path: <SRS0=T9Qg=ZV=wunner.de=lukas@kernel.org>
Date: Wed, 8 Feb 2017 05:23:54 +0100
From: Lukas Wunner <lukas@wunner.de>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Yinghai Lu <yinghai@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: pciehp: Don't enable PME on runtime suspend
Message-ID: <20170208042354.GA976@wunner.de>
References: <d1ae979d256631e7c189694a6d3e1a518abf3fc8.1486359844.git.lukas@wunner.de>
 <20170206221502.GA27899@bhelgaas-glaptop.roam.corp.google.com>
 <20170207062101.GB791@wunner.de>
 <26564356.WaYtlag6jj@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <26564356.WaYtlag6jj@aspire.rjw.lan>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 07, 2017 at 05:04:45PM +0100, Rafael J. Wysocki wrote:
> On Tuesday, February 07, 2017 07:21:01 AM Lukas Wunner wrote:
> > On Mon, Feb 06, 2017 at 04:15:02PM -0600, Bjorn Helgaas wrote:
> > > On Mon, Feb 06, 2017 at 10:20:41PM +0100, Lukas Wunner wrote:
> > > > On Mon, Feb 06, 2017 at 11:54:05AM -0600, Bjorn Helgaas wrote:
> > > > > What is the hotplug event that causes generation of this wakeup event?
> > > > 
> > > > If you had read all e-mails in this thread or looked at the bugzilla
> > > > entry I've created, you wouldn't have to ask this question.
> > > 
> > > I'm sorry, I don't necessarily have time to sort through all the
> > > emails.  My idea is that the changelog should be a self-contained
> > > justification for the patch.  The bugzilla is for supporting details
> > > and future archaeologists.
> > > 
> > > > I think it's disappointing that you're asking me to jump through
> > > > various hoops like creating a bugzilla entry, as well as threatening
> > > > to revert my patch, but are unwilling to even look at the bugzilla
> > > > entry or read the entire thread.  It is equally disappointing that
> > > > the reporter of the regression was unwilling or unable to provide
> > > > dmesg output for both machines so that we've got no real idea what
> > > > we're dealing with.
> > > 
> > > I beg your pardon?  I don't think it's fair to malign Yinghai.  He's
> > > tested at least two machines and at least two patches, and it's only
> > > been two working days since he reported the problem.
> > 
> > I think the commercialization of Linux kernel development has put this
> > open source project in a sorry state if an unpaid volunteer is told off
> > because he expresses disappointment that a paid contributor is asking
> > him to debug an issue on secret hardware using secret patches and not
> > providing secret dmesg output.
> 
> That's not like a lot has changed in that respect for the last 10 years and
> I was in your spot at that time.

Thank you Rafael, means a lot.


> The bottom line, in any case, is that the current code causes problems to
> happen somewhere and as a rule we don't release code that is known to
> cause problems to happen to anyone.  This means something needs to be done
> about that and the choice at this point is pretty much between reverting and
> quirking the affected system(s).

Quirking is not an option in this case because the PCI device IDs of the
affected hotplug ports as well as DMI data are unknown.  Yinghai Lu is
refusing to publish that, for both affected systems.

To be honest I only care about runtime suspending *Thunderbolt* hotplug
ports.  I enabled it for *all* hotplug ports in 68db9bc81436 because it
seemed like the right thing to do.  However given the murkiness of the
spec and the odd quirks Yinghai Lu reported it's probably not worth the
effort.  One must bear in mind that we've only heard of systems with
2015+ BIOSes so far.  More problem reports may pile up once we push the
BIOS limit further back.

I have submitted a patch to recognize Thunderbolt ports, so what I have
in mind is to resubmit 68db9bc81436 with an additional is_thunderbolt
condition in pci_bridge_d3_possible().  The number of Thunderbolt chips
is small and I know them fairly well, so it's easy for me to judge the
potential for regressions and deal with them.

Alternatively Bjorn could apply the patch to recognize Thunderbolt
devices now and then I can submit a one-line fix which adds the
is_thunderbolt condition to pci_bridge_d3_possible().  This would
obviate the need to revert 68db9bc81436.


> You seem to be disappointed that Yinghai has reported the problem at all,
> given that the hardware is unreleased and so on, but problem reports,
> even for systems like that, are what allows us to create code that works
> for everybody, so we (the maintainers) appreciate them very much.

No problem with reporting regressions, but with denying information
required to provide a fix.  I had asked for full dmesg output for
both machines so that the PCI device IDs and DMI data are available,
but Yinghai Lu continues to withhold that.  I am thus denied the means
to provide a fix and am forced to watch reversion of 68db9bc81436
without being able to respond.

Thanks,

Lukas
