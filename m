Return-Path: <SRS0=PF/i=ZZ=wunner.de=lukas@kernel.org>
Return-Path: <SRS0=PF/i=ZZ=wunner.de=lukas@kernel.org>
Date: Sun, 12 Feb 2017 15:57:27 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Yinghai Lu <yinghai@kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: pciehp: Don't enable PME on runtime suspend
Message-ID: <20170212145727.GA2593@wunner.de>
References: <d1ae979d256631e7c189694a6d3e1a518abf3fc8.1486359844.git.lukas@wunner.de>
 <20170206175405.GA15565@bhelgaas-glaptop.roam.corp.google.com>
 <20170206212041.GC679@wunner.de>
 <20170206221502.GA27899@bhelgaas-glaptop.roam.corp.google.com>
 <20170207062101.GB791@wunner.de>
 <20170208175736.GB27298@bhelgaas-glaptop.roam.corp.google.com>
 <20170209043254.GB1304@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20170209043254.GB1304@wunner.de>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 09, 2017 at 05:32:54AM +0100, Lukas Wunner wrote:
> On Wed, Feb 08, 2017 at 11:57:36AM -0600, Bjorn Helgaas wrote:
> > On Tue, Feb 07, 2017 at 07:21:01AM +0100, Lukas Wunner wrote:
> > > On Mon, Feb 06, 2017 at 04:15:02PM -0600, Bjorn Helgaas wrote:
> > > > On Mon, Feb 06, 2017 at 10:20:41PM +0100, Lukas Wunner wrote:
> > > > > On Mon, Feb 06, 2017 at 11:54:05AM -0600, Bjorn Helgaas wrote:
> > > > > > What is the hotplug event that causes generation of this wakeup event?
> > > > > 
> > > > > If you had read all e-mails in this thread or looked at the bugzilla
> > > > > entry I've created, you wouldn't have to ask this question.
> > > > 
> > > > I'm sorry, I don't necessarily have time to sort through all the
> > > > emails.  My idea is that the changelog should be a self-contained
> > > > justification for the patch.  The bugzilla is for supporting details
> > > > and future archaeologists.
> > > > 
> [...]
> > > > If you think a bugzilla is onerous
> > > 
> > > Hold on.  I didn't say a bugzilla is onerous, I said I'm disappointed
> > > that you're asking me to create one and then don't look at it.
> > 
> > I looked at it, and it had a few details, but no analysis of the
> > situation.  Ideally, I'm looking for a précis of the situation in
> > the changelog, with complete analysis and supporting details in the
> > bugzilla.
> 
> It's irrelevant whether the bugzilla contains an analysis or not.
> 
> You were asking what type of event caused the wakeup.  The information
> was in the bugzilla.  So you either didn't look at the bugzilla or
> didn't look hard enough.
> 
> Please tell me why in the future I should comply with your requests to
> create a bugzilla if you don't look at it and the bug reporter doesn't
> bother attaching any further information.  It would also have been
> possible for you to glean the information you were asking for from the
> reporter's e-mails but you didn't read those either.  And you're paid
> to do this, I'm not.  If you look at the timestamps of my e-mails you
> may notice that they're either early in the morning, late at night or
> on weekends.  Guess what, I'm doing this in my spare time, in addition
> to my day job.

My apologies Bjorn, it was clearly inappropriate for me to assume that
maintenance of the PCI subsystem is at all part of your job contract,
or talk about it on a public mailing list.

Kind regards,

Lukas
