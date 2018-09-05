Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 5 Sep 2018 16:20:28 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] PCI/ACPI: correct error message for ASPM disabling
Message-ID: <20180905212028.GS107892@bhelgaas-glaptop.roam.corp.google.com>
References: <1533875532-24954-1-git-send-email-okaya@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1533875532-24954-1-git-send-email-okaya@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 10, 2018 at 04:32:11AM +0000, Sinan Kaya wrote:
> If _OSC execution fails today for platforms without an _OSC
> entry, code is printing a misleading message saying disabling
> ASPM as follows:
> 
> acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
> 
> We need to ensure that platform supports ASPM to begin with.
> 
> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> Reported-by: Michael Kelley <mikelley@microsoft.com>

Tentatively applied both to pci/aspm for v4.20, thanks!

Rafael, let me know if you object or would rather put these through your
tree.

> ---
>  drivers/acpi/pci_root.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 7433035..e465e72 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -455,8 +455,9 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm)
>  	decode_osc_support(root, "OS supports", support);
>  	status = acpi_pci_osc_support(root, support);
>  	if (ACPI_FAILURE(status)) {
> -		dev_info(&device->dev, "_OSC failed (%s); disabling ASPM\n",
> -			 acpi_format_exception(status));
> +		dev_info(&device->dev, "_OSC failed (%s)%s\n",
> +			 acpi_format_exception(status),
> +			 pcie_aspm_support_enabled() ? "; disabling ASPM" : "");
>  		*no_aspm = 1;
>  		return;
>  	}
> -- 
> 2.7.4
> 
