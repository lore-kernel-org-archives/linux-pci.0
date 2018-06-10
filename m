Return-Path: <SRS0=8/78=I4=h08.hostsharing.net=foo00@kernel.org>
Return-Path: <SRS0=8/78=I4=h08.hostsharing.net=foo00@kernel.org>
Date: Sun, 10 Jun 2018 18:23:29 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/9] PCI/portdrv: Squash into one file
Message-ID: <20180610162329.GA30241@wunner.de>
References: <152848853199.14051.12670957565366345798.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20180608203810.GA19717@wunner.de>
 <CAErSpo68YimHfzyLC6CqukPGb=5di6oMFth1rG3Ub3ZwVha7=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo68YimHfzyLC6CqukPGb=5di6oMFth1rG3Ub3ZwVha7=g@mail.gmail.com>
List-ID: <linux-pci.vger.kernel.org>

[cc += linux-pci, sorry, forgot to copy the list when first replying to
your message, I hope this is appropriate]

On Fri, Jun 08, 2018 at 04:06:39PM -0500, Bjorn Helgaas wrote:
> On Fri, Jun 8, 2018 at 3:38 PM Lukas Wunner <lukas@wunner.de> wrote:
> > On Fri, Jun 08, 2018 at 03:12:00PM -0500, Bjorn Helgaas wrote:
> > > The portdrv code is scattered across several files, which makes it a bit
> > > of a hassle to browse.  Consolidate it all in a single file.
> >
> > Why?  By that logic we could concatinate the whole kernel into a single
> > file.  The rationale of splitting into multiple files is to separate
> > distinct components.  In the case of portdrv, this means separating
> > the portion that interfaces with the PCI core (for the port's pci_dev)
> > from the portion that interfaces with the service drivers.
> 
> My experience with portdrv and AER and all the hotplug drivers is that
> I want to look at something but I don't know the exact name.  For
> example, I might want to look at the interrupt handling code.  One
> plausible way is to start up cscope, search for files "aer/aer", guess
> which file contains it, find it's wrong, try the next one, etc.  If I
> were smarter I suppose I would search for callers of request_irq() and
> grep out "aer".  But that all feels like a hassle.

"git grep" does a pretty good job for me to locate stuff like this, e.g.:

Locate request_irq in all of AER:
git grep request_irq drivers/pci/pcie/aer
(the aer directory can be omitted if you first cd into it)

Locate request_irq in all of AER in Linus' current tree:
git grep request_irq torvalds/master -- drivers/pci/pcie/aer
(assuming that the git remote of Linus' tree is named "torvalds")

Use -e if you grep for something prefixed with a dash, such as callback
invocations:
git grep -e '->reset_slot' drivers/pci

If you're in a subdirectory but would like to search the entire tree:
git grep -e '->reset_slot' :/

And so on...
