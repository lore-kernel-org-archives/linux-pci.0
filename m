Return-Path: <SRS0=rFxE=ZB=wunner.de=lukas@kernel.org>
Return-Path: <SRS0=rFxE=ZB=wunner.de=lukas@kernel.org>
Date: Thu, 19 Jan 2017 06:35:13 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: How to improve PCI bug tracking?
Message-ID: <20170119053513.GA25889@wunner.de>
References: <20170118225332.GA22960@bhelgaas-glaptop.roam.corp.google.com>
 <88c6fcac-78d7-e2fd-e08f-62149b34e996@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <88c6fcac-78d7-e2fd-e08f-62149b34e996@codeaurora.org>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 18, 2017 at 06:29:15PM -0500, Sinan Kaya wrote:
> On 1/18/2017 5:53 PM, Bjorn Helgaas wrote:
> > I want to improve PCI bug tracking.  It feels like our bugs don't get
> > the attention they need, and I'm soliciting ideas for how to improve
> > this.
> > 
> > Current situation:
> > 
> >   - People often report bugs via email to linux-pci.  I think this
> >     is good because everybody can see it.
> > 
> >   - Even after an email report, I often request a bugzilla because
> >     (1) it helps keep things from being forgotten, (2) it's a
> >     convenient place to store bulky data, and (3) I like to have a
> >     bugzilla URL to include in the changelog of a patch that fixes the
> >     bug.
> > 
> >   - Sometimes people open a bugzilla directly.  I get email about
> >     these (along with one or two other people), but this is sort of a
> >     problem because linux-pci never sees it, sometimes I miss it, and
> >     things tend to languish.
> > 
> >   - Discussion on a bugzilla is only seen by people listed in the
> >     bugzilla, not on linux-pci.
> > 
> > I'm contemplating changing this so the bugzilla mail would also go to
> > linux-pci.
> 
> I have seen this happening on linux-scsi.
> 
> http://www.spinics.net/lists/linux-scsi/msg103272.html

Same for dri-devel@ / nouveau@lists.freedesktop.org.

Go for it.

Lukas
