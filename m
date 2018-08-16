Return-Path: <SRS0=EhFM=K7=gmail.com=arndbergmann@kernel.org>
Return-Path: <SRS0=EhFM=K7=gmail.com=arndbergmann@kernel.org>
MIME-Version: 1.0
References: <20180801151403.20660-1-hch@lst.de> <20180801151403.20660-2-hch@lst.de>
 <20180802165430.GA13725@red-moon> <20180815195227.GG28888@bhelgaas-glaptop.roam.corp.google.com>
 <20180816205901.GA15085@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180816205901.GA15085@bhelgaas-glaptop.roam.corp.google.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 16 Aug 2018 23:04:53 +0200
Message-ID: <CAK8P3a02StKtvE+dfESGdeB_zvLbqy9jYwWWgzV6AaeAwyNu=Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] PCI: add a callback to struct pci_host_bridge for
 adding a new device
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Christoph Hellwig <hch@lst.de>,
	Bjorn Helgaas <bhelgaas@google.com>, Palmer Dabbelt <palmer@dabbelt.com>,
	"Wesley W. Terpstra" <wesley@sifive.com>, linux-pci <linux-pci@vger.kernel.org>,
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 16, 2018 at 10:59 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Wed, Aug 15, 2018 at 02:52:28PM -0500, Bjorn Helgaas wrote:
> > On Thu, Aug 02, 2018 at 05:54:30PM +0100, Lorenzo Pieralisi wrote:

> > This patch seems OK to me.
> >
> > I don't really care about the prototype.  There's only one
> > pcibios_add_device() implementation (x86) that returns anything other
> > than 0, and that's a pretty obscure error case related to f9a37be0f02a
> > ("x86: Use PCI setup data"), which lets us use ROM data from boot
> > services.  Even then the only thing that happens is a WARN_ON().  A
> > more descriptive printk would be a lot more useful.
>
> Thinking about this some more, I'm not so sure about the connection
> with removing pcibios_add_device().  This host_bridge->add_dev() hook
> would be for host bridge-specific things, while pcibios_add_device()
> is for arch-specific things.
>
> I'd still love to get rid of pcibios_add_device() (especially the
> non-arch-specific things like the pci_claim_resource() in s390); I'm
> just not sure yet whether this particular patch is the vehicle.

I think most of the arch-specific pcibios_* calls are actually
host bridge specific after all, it just so happens that they are
implemented on architectures that only have one specific
host bridge implementation, or that they are used on an
architecture that does something odd in one place and needs
to do something else in another place.

For pci_claim_resource() we seem to be doing this in a number
of different places, but there isn't strictly a reason for that.

I've started a patch series to turn all the __weak pcibios_*
functions into callbacks, which seems to be the right solution
for almost all of them.

      Arnd
