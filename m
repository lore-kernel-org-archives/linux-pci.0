Return-Path: <SRS0=ENoR=4J=gmail.com=andy.shevchenko@kernel.org>
Return-Path: <SRS0=ENoR=4J=gmail.com=andy.shevchenko@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170408190628.GB16832@bhelgaas-glaptop.roam.corp.google.com>
References: <44cada166e42007d27b4c3e3aa0744d7@molgen.mpg.de>
 <20170408154128.GA16832@bhelgaas-glaptop.roam.corp.google.com>
 <1491670819.6021.33.camel@infradead.org> <20170408190628.GB16832@bhelgaas-glaptop.roam.corp.google.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 3 May 2017 21:42:06 +0300
Message-ID: <CAHp75VcZs++L0svPq5W7gz0sH3RZvF=wMoFcjEUn8puF+mvQ-Q@mail.gmail.com>
Subject: Re: `pci_apply_final_quirks()` taking half a second
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Paul Menzel <pmenzel@molgen.mpg.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Sat, Apr 8, 2017 at 10:06 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Sat, Apr 08, 2017 at 07:00:19PM +0200, David Woodhouse wrote:
>> ...
>> I note it's also reading PCI_CACHE_LINE_SIZE From config space for each
>> device in pci_apply_final_quirks(). How long does that take?
>
> I don't know, but it's pointless on modern PCIe systems where the
> Cache Line Size has no effect.  It'd be really nice if somebody
> cleaned that up and got rid of the read itself and the useless
> messages.

What I can think of is 10ms delay for PM. The laptop might be one of
Intel BayTrails where we have it.
But it's just a guess.

-- 
With Best Regards,
Andy Shevchenko
