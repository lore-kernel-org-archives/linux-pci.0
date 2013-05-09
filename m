Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:41525 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751761Ab3EITge (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 9 May 2013 15:36:34 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] PCI/ACPI: Check acpi_resource_to_address64() return value
Date: Thu, 09 May 2013 21:45 +0200
Message-ID: <1880556.qeccPcvTkd@vostro.rjw.lan>
In-Reply-To: <20130509192913.17473.94947.stgit@bhelgaas-glaptop>
References: <20130509192913.17473.94947.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, May 09, 2013 01:29:13 PM Bjorn Helgaas wrote:
> We should check the acpi_resource_to_address64() return value, which
> also removes the need to validate the resource type beforehand.
> No functional change.
> 
> Found by Coverity (CID 113815).
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/pci_root.c |    7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index ac8688b..c956434 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -100,13 +100,12 @@ get_root_bridge_busnr_callback(struct acpi_resource *resource, void *data)
>  {
>  	struct resource *res = data;
>  	struct acpi_resource_address64 address;
> +	acpi_status status;
>  
> -	if (resource->type != ACPI_RESOURCE_TYPE_ADDRESS16 &&
> -	    resource->type != ACPI_RESOURCE_TYPE_ADDRESS32 &&
> -	    resource->type != ACPI_RESOURCE_TYPE_ADDRESS64)
> +	status = acpi_resource_to_address64(resource, &address);
> +	if (ACPI_FAILURE(status))
>  		return AE_OK;
>  
> -	acpi_resource_to_address64(resource, &address);
>  	if ((address.address_length > 0) &&
>  	    (address.resource_type == ACPI_BUS_NUMBER_RANGE)) {
>  		res->start = address.minimum;
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
