Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Fri, 9 Feb 2018 19:05:48 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alex Hung <alex.hung@canonical.com>
Cc: rjw@rjwysocki.net, lenb@kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH] ACPI/PCI: pci_link: change log level of no _PRS messages
Message-ID: <20180210010548.GC206223@bhelgaas-glaptop.roam.corp.google.com>
References: <1518217003-19637-1-git-send-email-alex.hung@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1518217003-19637-1-git-send-email-alex.hung@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 09, 2018 at 02:56:43PM -0800, Alex Hung wrote:
> In recent Intel hardware the IRQs become non-configurable after BIOS
> initializes them in PEI phase and _PRS objects are no longer included in
> ASL.
> 
> This is the same as "static (non-configurable) devices do not
> specify a _PRS object" in ACPI spec. As a result, error messages
> saying "ACPI Exception: AE_NOT_FOUND, Evaluating _PRS" does not need to
> be in kernel messages all the time but only when debug is enabled.

I agree and would even go further: _PRS is optional and I don't think
there's a reason to log anything at all if it's absent.  A log message
like "failed to evaluate _PRS" makes people think something is wrong
when in fact nothing is wrong.

That leads to the mindset of treating a missing _PRS as an error when
it's not.  In fact, it looks like acpi_pci_link_add() *does* treat
this as an error.  If _PRS doesn't exist, it skips the _CRS
evaluation.  That seems wrong.

> Signed-off-by: Alex Hung <alex.hung@canonical.com>
> ---
>  drivers/acpi/pci_link.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> index 85ad679..9d9cf24 100644
> --- a/drivers/acpi/pci_link.c
> +++ b/drivers/acpi/pci_link.c
> @@ -173,7 +173,7 @@ static int acpi_pci_link_get_possible(struct acpi_pci_link *link)
>  	status = acpi_walk_resources(link->device->handle, METHOD_NAME__PRS,
>  				     acpi_pci_link_check_possible, link);
>  	if (ACPI_FAILURE(status)) {
> -		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _PRS"));
> +		acpi_handle_debug(link->device->handle, "failed to evaluate _PRS");
>  		return -ENODEV;
>  	}
>  
> -- 
> 2.7.4
> 
