Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] ACPI: Remove unused struct acpi_pci_root.id member
Date: Thu, 20 Dec 2012 22:20:15 +0100
Message-ID: <4397899.8xnBDh90Bg@vostro.rjw.lan>
In-Reply-To: <CAErSpo5oFEa5RD1_EYLtwvwF0dZFpkUp9XqO_kJZ+c5bL-1TTw@mail.gmail.com>
References: <20121219173044.12424.11336.stgit@bhelgaas.mtv.corp.google.com> <6539457.htZABURDoR@vostro.rjw.lan> <CAErSpo5oFEa5RD1_EYLtwvwF0dZFpkUp9XqO_kJZ+c5bL-1TTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, December 20, 2012 11:37:24 AM Bjorn Helgaas wrote:
> On Wed, Dec 19, 2012 at 6:22 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Wednesday, December 19, 2012 10:30:44 AM Bjorn Helgaas wrote:
> >> This member is never initialized and never referenced, so remove it.
> >
> > Sure. :-)
> >
> > Do you want me to take this?
> 
> I assume you're going to push your namespace scan rework through your
> tree, since most of the changes are in drivers/acpi.  That series also
> touches acpi_bus.h, so probably makes the most sense for you to take
> this as well.  I don't plan any future changes to the file.

Well, I'm not planning to push the scan rework series for v3.8, I'd rather
prefer it to go into v3.9.  I'll just create a separate branch based on
v3.8-rc1 with those patches that will wait for the v3.9 merge window and
can be pulled from if necessary.

I can put the $subject patch into that branch too.

Does it sound reasonable?

> There are more PCI-centric pci_root.c changes in the pipe, but we'll
> have to sort those out later, I think.

Yup.

> Let me know if you think otherwise.

The above is fine by me.

> >> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> >> ---
> >>  include/acpi/acpi_bus.h |    1 -
> >>  1 files changed, 0 insertions(+), 1 deletions(-)
> >>
> >> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> >> index 7ced5dc..4f42c0e 100644
> >> --- a/include/acpi/acpi_bus.h
> >> +++ b/include/acpi/acpi_bus.h
> >> @@ -397,7 +397,6 @@ int unregister_acpi_bus_type(struct acpi_bus_type *);
> >>  struct acpi_pci_root {
> >>       struct list_head node;
> >>       struct acpi_device * device;
> >> -     struct acpi_pci_id id;
> >>       struct pci_bus *bus;
> >>       u16 segment;
> >>       struct resource secondary;      /* downstream bus range */
> >>
> > --
> > I speak only for myself.
> > Rafael J. Wysocki, Intel Open Source Technology Center.
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
