Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932607AbeFKNYw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Jun 2018 09:24:52 -0400
Date: Mon, 11 Jun 2018 08:24:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/9] PCI/portdrv: Squash into one file
Message-ID: <20180611132450.GA75679@bhelgaas-glaptop.roam.corp.google.com>
References: <152848853199.14051.12670957565366345798.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20180608203810.GA19717@wunner.de>
 <CAErSpo68YimHfzyLC6CqukPGb=5di6oMFth1rG3Ub3ZwVha7=g@mail.gmail.com>
 <20180610162329.GA30241@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180610162329.GA30241@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Jun 10, 2018 at 06:23:29PM +0200, Lukas Wunner wrote:
> [cc += linux-pci, sorry, forgot to copy the list when first replying to
> your message, I hope this is appropriate]

Yes, thanks.  I always prefer discussion on the list over private
emails.

> On Fri, Jun 08, 2018 at 04:06:39PM -0500, Bjorn Helgaas wrote:
> > On Fri, Jun 8, 2018 at 3:38 PM Lukas Wunner <lukas@wunner.de> wrote:
> > > On Fri, Jun 08, 2018 at 03:12:00PM -0500, Bjorn Helgaas wrote:
> > > > The portdrv code is scattered across several files, which makes it a bit
> > > > of a hassle to browse.  Consolidate it all in a single file.
> > >
> > > Why?  By that logic we could concatinate the whole kernel into a single
> > > file.  The rationale of splitting into multiple files is to separate
> > > distinct components.  In the case of portdrv, this means separating
> > > the portion that interfaces with the PCI core (for the port's pci_dev)
> > > from the portion that interfaces with the service drivers.
> > 
> > My experience with portdrv and AER and all the hotplug drivers is that
> > I want to look at something but I don't know the exact name.  For
> > example, I might want to look at the interrupt handling code.  One
> > plausible way is to start up cscope, search for files "aer/aer", guess
> > which file contains it, find it's wrong, try the next one, etc.  If I
> > were smarter I suppose I would search for callers of request_irq() and
> > grep out "aer".  But that all feels like a hassle.
> 
> "git grep" does a pretty good job for me to locate stuff like this, e.g.:
> 
> Locate request_irq in all of AER:
> git grep request_irq drivers/pci/pcie/aer
> (the aer directory can be omitted if you first cd into it)
> 
> Locate request_irq in all of AER in Linus' current tree:
> git grep request_irq torvalds/master -- drivers/pci/pcie/aer
> (assuming that the git remote of Linus' tree is named "torvalds")
> 
> Use -e if you grep for something prefixed with a dash, such as callback
> invocations:
> git grep -e '->reset_slot' drivers/pci
> 
> If you're in a subdirectory but would like to search the entire tree:
> git grep -e '->reset_slot' :/

Thanks for the grep tutorial.

No matter how much grep-fu we throw at it, the one-step
"vi drivers/pci/pcie/aer.c" is more direct.

But there's certainly not as much benefit for portdrv (with only two
files left) as there was for AER (which had six, plus a directory, a
Makefile and two Kconfig files).

Even if we did consolidate those two, this series went the wrong way
(moving portdrv_core.c into portdrv_pci.c, when it probably would have
been simpler to fold portdrv_pci.c into portdrv_core.c).

There doesn't seem to be a consensus or clear benefit about this, so I
dropped this series for now.

Bjorn
