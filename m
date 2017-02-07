Return-Path: <SRS0=XJ2G=ZU=rjwysocki.net=rjw@kernel.org>
Return-Path: <SRS0=XJ2G=ZU=rjwysocki.net=rjw@kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Yinghai Lu <yinghai@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: pciehp: Don't enable PME on runtime suspend
Date: Tue, 07 Feb 2017 17:04:45 +0100
Message-ID: <26564356.WaYtlag6jj@aspire.rjw.lan>
In-Reply-To: <20170207062101.GB791@wunner.de>
References: <d1ae979d256631e7c189694a6d3e1a518abf3fc8.1486359844.git.lukas@wunner.de> <20170206221502.GA27899@bhelgaas-glaptop.roam.corp.google.com> <20170207062101.GB791@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, February 07, 2017 07:21:01 AM Lukas Wunner wrote:
> On Mon, Feb 06, 2017 at 04:15:02PM -0600, Bjorn Helgaas wrote:
> > On Mon, Feb 06, 2017 at 10:20:41PM +0100, Lukas Wunner wrote:
> > > On Mon, Feb 06, 2017 at 11:54:05AM -0600, Bjorn Helgaas wrote:
> > > > What is the hotplug event that causes generation of this wakeup event?
> > > 
> > > If you had read all e-mails in this thread or looked at the bugzilla
> > > entry I've created, you wouldn't have to ask this question.
> > 
> > I'm sorry, I don't necessarily have time to sort through all the
> > emails.  My idea is that the changelog should be a self-contained
> > justification for the patch.  The bugzilla is for supporting details
> > and future archaeologists.
> > 
> > > I think it's disappointing that you're asking me to jump through
> > > various hoops like creating a bugzilla entry, as well as threatening
> > > to revert my patch, but are unwilling to even look at the bugzilla
> > > entry or read the entire thread.  It is equally disappointing that
> > > the reporter of the regression was unwilling or unable to provide
> > > dmesg output for both machines so that we've got no real idea what
> > > we're dealing with.
> > 
> > I beg your pardon?  I don't think it's fair to malign Yinghai.  He's
> > tested at least two machines and at least two patches, and it's only
> > been two working days since he reported the problem.
> 
> I think the commercialization of Linux kernel development has put this
> open source project in a sorry state if an unpaid volunteer is told off
> because he expresses disappointment that a paid contributor is asking
> him to debug an issue on secret hardware using secret patches and not
> providing secret dmesg output.

That's not like a lot has changed in that respect for the last 10 years and
I was in your spot at that time.

Such systems have always been there and we've had to tackle problems
with them regardless.

You seem to be disappointed that Yinghai has reported the problem at all,
given that the hardware is unreleased and so on, but problem reports,
even for systems like that, are what allows us to create code that works
for everybody, so we (the maintainers) appreciate them very much.

The bottom line, in any case, is that the current code causes problems to
happen somewhere and as a rule we don't release code that is known to
cause problems to happen to anyone.  This means something needs to be done
about that and the choice at this point is pretty much between reverting and
quirking the affected system(s).

I'm not a big fan of reverts, because they tend to reward bug reporters only
and disincentivize developers, which may be fine if those developers are paid
for their work, but really is not awesome for volunteers.  So I would add a quirk
even though more systems may be affected, but there's no evidence either
way right now.

That's a Bjorn's call, however.

Thanks,
Rafael
