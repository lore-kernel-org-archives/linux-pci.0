Return-Path: <SRS0=Tdh4=GE=rjwysocki.net=rjw@kernel.org>
Return-Path: <SRS0=Tdh4=GE=rjwysocki.net=rjw@kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Bjorn Helgaas <helgaas@kernel.org>, Alex Hung <alex.hung@canonical.com>
Cc: lenb@kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH][V3] ACPI/PCI: pci_link: allow the absence of _PSR and change log level
Date: Wed, 14 Mar 2018 12:43:43 +0100
Message-ID: <3049002.WCqzBnTU9t@aspire.rjw.lan>
In-Reply-To: <20180223145026.GJ14632@bhelgaas-glaptop.roam.corp.google.com>
References: <1519364624-4363-1-git-send-email-alex.hung@canonical.com> <20180223145026.GJ14632@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

On Friday, February 23, 2018 3:50:26 PM CET Bjorn Helgaas wrote:
> In subject:
> 
> s/allow the/Allow the/ to match drivers/acpi capitalization convention
> s/_PSR/_PRS/ to fix typo
> 
> On Thu, Feb 22, 2018 at 09:43:44PM -0800, Alex Hung wrote:
> > In recent Intel hardware the IRQs become non-configurable after BIOS
> > initializes them in PEI phase and _PRS objects are no longer included in
> > ASL.
> > 
> > This is the same as "static (non-configurable) devices do not
> > specify a _PRS object" in ACPI spec. As a result, error messages
> > saying "ACPI Exception: AE_NOT_FOUND, Evaluating _PRS" does not need to
> > be in kernel messenges all the time but only when debug is enabled, and
> > acpi_pci_link_get_possible should not return -ENODEV when _PRS is
> > absent.
> > 
> > Signed-off-by: Alex Hung <alex.hung@canonical.com>
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> > ---
> >  drivers/acpi/pci_link.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> > index bc3d914..65f1908 100644
> > --- a/drivers/acpi/pci_link.c
> > +++ b/drivers/acpi/pci_link.c
> > @@ -173,8 +173,8 @@ static int acpi_pci_link_get_possible(struct acpi_pci_link *link)
> >  	status = acpi_walk_resources(link->device->handle, METHOD_NAME__PRS,
> >  				     acpi_pci_link_check_possible, link);
> >  	if (ACPI_FAILURE(status)) {
> > -		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _PRS"));
> > -		return -ENODEV;
> > +		acpi_handle_debug(link->device->handle, "_PRS not present or invalid");
> 
> The rest of this file uses ACPI_EXCEPTION(), ACPI_DEBUG_PRINT(), etc.
> My personal preference would be to keep the file consistent, e.g.,
> maybe use the style that matches the file in this patch, and have a
> second patch that changes all the logging in the file to use
> acpi_handle_*().
> 
> But I'm fine with whatever you and Rafael want to do about this.

I wanted it to be changed.

Using ACPI_DEBUG_PRINT() and similar outside of ACPICA code is
questionable and plain problematic with some combinations of Kconfig
options, so I'd actually prefer them to go away from the ACPI code
outside of ACPICA.

Patch applied with the subject typo fixed, thanks!
