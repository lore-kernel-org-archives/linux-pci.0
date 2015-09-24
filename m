Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Ondrej Zary <linux@rainbow-software.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH] PCI: disable MSI on SiS 761
Date: Thu, 24 Sep 2015 21:21:33 +0200
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Kernel development list <linux-kernel@vger.kernel.org>
References: <1442005937-21938-1-git-send-email-linux@rainbow-software.org> <20150924182115.GB3648@localhost>
In-Reply-To: <20150924182115.GB3648@localhost>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201509242121.33509.linux@rainbow-software.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 24 September 2015 20:21:16 Bjorn Helgaas wrote:
> Hi Ondrej,
>
> On Fri, Sep 11, 2015 at 11:12:17PM +0200, Ondrej Zary wrote:
> > MSI is broken on SiS 761 chipset at least on PC Chips A31G board.
> > No interrupts are delivered once MSI is enabled for a device. This causes
> > hang on X11 start with a nVidia card installed (with nouveau driver).
> >
> > Disable MSI completely for this chipset.
> >
> > Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
>
> This is a pretty old chipset, isn't it?  Google finds a reference to
> SiS 761GX from 2005.  I wonder why we're only finding this problem
> now.  Is there a problem report?  I wonder if the problem is really
> elsewhere, and turning off MSI just avoids the real problem.

Yes, it's an old chipset and board (Socket 754) and not very common. Nouveau 
was not usable back then, MSI support was added to Nouveau in 2010 and 
enabled by default only in 2013. Maybe I'm the only one who tested MSI on 
this board/chipset...

The facts are:
 - zero interrupts in /proc/interrupts with MSI enabled and X11 hangs
 - everything works fine with MSI disabled
 - tested with two different nVidia cards (don't have any other PCIe card to 
test)

I guess that either the MSI support in the chipset is broken or the BIOS does 
not set up some secret chipset register(s) correctly.

-- 
Ondrej Zary
