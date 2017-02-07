Return-Path: <SRS0=UJwY=ZU=wunner.de=lukas@kernel.org>
Return-Path: <SRS0=UJwY=ZU=wunner.de=lukas@kernel.org>
Date: Tue, 7 Feb 2017 07:21:01 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Yinghai Lu <yinghai@kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: pciehp: Don't enable PME on runtime suspend
Message-ID: <20170207062101.GB791@wunner.de>
References: <d1ae979d256631e7c189694a6d3e1a518abf3fc8.1486359844.git.lukas@wunner.de>
 <20170206175405.GA15565@bhelgaas-glaptop.roam.corp.google.com>
 <20170206212041.GC679@wunner.de>
 <20170206221502.GA27899@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170206221502.GA27899@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 06, 2017 at 04:15:02PM -0600, Bjorn Helgaas wrote:
> On Mon, Feb 06, 2017 at 10:20:41PM +0100, Lukas Wunner wrote:
> > On Mon, Feb 06, 2017 at 11:54:05AM -0600, Bjorn Helgaas wrote:
> > > What is the hotplug event that causes generation of this wakeup event?
> > 
> > If you had read all e-mails in this thread or looked at the bugzilla
> > entry I've created, you wouldn't have to ask this question.
> 
> I'm sorry, I don't necessarily have time to sort through all the
> emails.  My idea is that the changelog should be a self-contained
> justification for the patch.  The bugzilla is for supporting details
> and future archaeologists.
> 
> > I think it's disappointing that you're asking me to jump through
> > various hoops like creating a bugzilla entry, as well as threatening
> > to revert my patch, but are unwilling to even look at the bugzilla
> > entry or read the entire thread.  It is equally disappointing that
> > the reporter of the regression was unwilling or unable to provide
> > dmesg output for both machines so that we've got no real idea what
> > we're dealing with.
> 
> I beg your pardon?  I don't think it's fair to malign Yinghai.  He's
> tested at least two machines and at least two patches, and it's only
> been two working days since he reported the problem.

I think the commercialization of Linux kernel development has put this
open source project in a sorry state if an unpaid volunteer is told off
because he expresses disappointment that a paid contributor is asking
him to debug an issue on secret hardware using secret patches and not
providing secret dmesg output.


> If you think a bugzilla is onerous

Hold on.  I didn't say a bugzilla is onerous, I said I'm disappointed
that you're asking me to create one and then don't look at it.

Lukas
