Return-Path: <rjw@rjwysocki.net>
Return-Path: <rjw@rjwysocki.net>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>, Christopher Covington <cov@codeaurora.org>, Linux PCI <linux-pci@vger.kernel.org>, ravikanth.nalla@hpe.com, Len Brown <lenb@kernel.org>, harish.k@hpe.com, ashwin.reghunandanan@hpe.com, Bjorn Helgaas <bhelgaas@google.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3 1/4] acpi,pci,irq: reduce resource requirements
Date: Fri, 06 May 2016 01:40:40 +0200
Message-ID: <6333411.fGcZIU6Ycq@vostro.rjw.lan>
In-Reply-To: <CAJZ5v0gpxk0SuiQym_0VjUWYFvDrnSYOZq7awxgsuxbCOcqPVg@mail.gmail.com>
References: <1460914617-8259-1-git-send-email-okaya@codeaurora.org> <20160427000652.GC6789@localhost> <CAJZ5v0gpxk0SuiQym_0VjUWYFvDrnSYOZq7awxgsuxbCOcqPVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, April 27, 2016 02:17:58 AM Rafael J. Wysocki wrote:
> On Wed, Apr 27, 2016 at 2:06 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Tue, Apr 26, 2016 at 01:36:11PM -0500, Bjorn Helgaas wrote:
> >> On Sun, Apr 17, 2016 at 01:36:53PM -0400, Sinan Kaya wrote:
> >> > Code has been redesigned to calculate penalty requirements on the fly. This
> >> > significantly simplifies the implementation and removes some of the init
> >> > calls from x86 architecture.
> >> >
> >> > Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> >>
> >> For all four patches:
> >>
> >> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> >
> > Rafael, I should have mentioned that I'm assuming you'll take these
> > because they're in drivers/acpi and you merged the previous ones,
> > e.g.,
> >
> >   0971686954f9 ACPI / PCI: Simplify acpi_penalize_isa_irq()
> >   37c5939136d7 ACPI, PCI, irq: remove interrupt number restriction
> >   b5bd02695471 ACPI, PCI, irq: remove interrupt count restriction
> >
> > Just let me know if you'd rather have me take them.
> 
> I can handle them.
> 
> I'll wait for the testing feedback from the HPE people though in case
> there are any problems.

All [1-4/4] applied with Bjorn's ACKs.

Thanks,
Rafael
