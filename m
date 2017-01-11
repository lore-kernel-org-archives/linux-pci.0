Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 11 Jan 2017 15:00:18 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: julia.lawall@lip6.fr, rjw@rjwysocki.net, lenb@kernel.org,
        bhelgaas@google.com, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org
Subject: Re: [PATCH] PCI: acpiphp_ibm: add __ro_after_init to
 ibm_apci_table_attr
Message-ID: <20170111210018.GJ14532@bhelgaas-glaptop.roam.corp.google.com>
References: <1482766595-12679-1-git-send-email-bhumirks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1482766595-12679-1-git-send-email-bhumirks@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 26, 2016 at 09:06:35PM +0530, Bhumika Goyal wrote:
> The object ibm_apci_table_attr of type bin_attribute structure is not
> modified after getting initialized by ibm_acpiphp_init. Apart from
> getting referenced in init it is also passed as an argument to the functions
> sysfs_{remove/create}_bin_file but both the arguments are of type const 
> struct bin_attribute *. Therefore add __ro_after_init to its declaration.
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

Applied to pci/hotplug for v4.11 with Kees' Reviewed-by and the following
changelog:

    PCI: acpiphp_ibm: Make ibm_apci_table_attr __ro_after_init
    
    ibm_apci_table_attr is not modified after being initialized by
    ibm_acpiphp_init().  It is passed as an argument to the functions
    sysfs_{remove/create}_bin_file(), but both the arguments are const.
    Add __ro_after_init to its declaration.
    
    [bhelgaas: changelog]
    Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Reviewed-by: Kees Cook <keescook@chromium.org>

> ---
>  drivers/pci/hotplug/acpiphp_ibm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/hotplug/acpiphp_ibm.c b/drivers/pci/hotplug/acpiphp_ibm.c
> index f6221d7..188cdfa 100644
> --- a/drivers/pci/hotplug/acpiphp_ibm.c
> +++ b/drivers/pci/hotplug/acpiphp_ibm.c
> @@ -107,7 +107,7 @@ static acpi_status __init ibm_find_acpi_device(acpi_handle handle,
>  
>  static acpi_handle ibm_acpi_handle;
>  static struct notification ibm_note;
> -static struct bin_attribute ibm_apci_table_attr = {
> +static struct bin_attribute ibm_apci_table_attr __ro_after_init = {
>  	    .attr = {
>  		    .name = "apci_table",
>  		    .mode = S_IRUGO,
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
