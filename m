Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 27 Oct 2017 17:04:01 -0700
From: Brian Norris <briannorris@chromium.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>,
        linux-kernel@vger.kernel.org, bhelgaas@google.com,
        linux-pm@vger.kernel.org, tony@atomide.com,
        shawn.lin@rock-chips.com, rjw@rjwysocki.net, dianders@chromium.org,
        linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH v8 7/7] PCI / PM: Add support for the PCIe WAKE#
 signal for OF
Message-ID: <20171028000400.GE105121@google.com>
References: <20171026132840.20946-1-jeffy.chen@rock-chips.com>
 <20171026132840.20946-8-jeffy.chen@rock-chips.com>
 <334be327-543f-d379-83de-ce84799fa49a@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <334be327-543f-d379-83de-ce84799fa49a@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Sinan,

I'm not sure I understand all your suggestions below.

On Thu, Oct 26, 2017 at 11:16:55AM -0400, Sinan Kaya wrote:
> On 10/26/2017 9:28 AM, Jeffy Chen wrote:
> >  drivers/pci/Makefile |   2 +-
> >  drivers/pci/pci-of.c | 136 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 137 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/pci/pci-of.c
> > 
> > diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> > index 66a21acad952..4f76dbdb024c 100644
> > --- a/drivers/pci/Makefile
> > +++ b/drivers/pci/Makefile
> > @@ -49,7 +49,7 @@ obj-$(CONFIG_PCI_ECAM) += ecam.o
> >  
> >  obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
> >  
> > -obj-$(CONFIG_OF) += of.o
> > +obj-$(CONFIG_OF) += of.o pci-of.o
> 
> If the intention is to push this to pci directory, this code needs to be made
> platform agnostic by splitting into two pieces.
> 
> I think you can make this code common by abstracting the IRQ number and
> have some generic code like pci-wake.c in pci directory without the of prefix
> in this file.

Why would 'pci-wake' be a good name for this? We're doing basically the
same things that pci-acpi.c is doing (it also can configure the WAKE#
signal, via ACPI firmware calls).

> Then, you can have some other OF specific code in the drivers/of directory
> that reads the IRQ from OF and calls the common code in PCI directory.

Why is drivers/of/ special? I thought in general, the DT maintainers
preferred to move domain-specific stuff into the respective subsystems.

Also, the extraction is a very tiny piece of code, and the logic around
walking a PCI tree is the more important part. And in the
meantime...Jeffy has sent two more revisions of this patch set already,
and he did the latter (I like his abstraction of PCI device trees,
shared between ACPI and OF code) but not the former (it's still all
'pci-of.c').

Feel free to comment further on here or on v10, but at the moment I'm
not sure I understand yet how your suggestions would improve things.

Brian
