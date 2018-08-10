Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <307063ff7bbdcc0c3896f027b09245e542764f48.camel@perches.com>
Subject: Re: [PATCH 1/2] PCI/ACPI: correct error message for ASPM disabling
From: Joe Perches <joe@perches.com>
To: Sinan Kaya <okaya@kernel.org>, linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Date: Thu, 09 Aug 2018 17:27:18 -0700
In-Reply-To: <1533840383-7841-1-git-send-email-okaya@kernel.org>
References: <1533840383-7841-1-git-send-email-okaya@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2018-08-09 at 18:46 +0000, Sinan Kaya wrote:
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
> ---
>  drivers/acpi/pci_root.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
[]
> @@ -455,8 +455,13 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm)
>  	decode_osc_support(root, "OS supports", support);
>  	status = acpi_pci_osc_support(root, support);
>  	if (ACPI_FAILURE(status)) {
> -		dev_info(&device->dev, "_OSC failed (%s); disabling ASPM\n",
> -			 acpi_format_exception(status));
> +		char *aspm_msg = "";
> +
> +		if (pcie_aspm_support_enabled())
> +			aspm_msg = "; disabling ASPM";
> +
> +		dev_info(&device->dev, "_OSC failed (%s) %s\n",
> +				 acpi_format_exception(status), aspm_msg);

I think this would read better not using a temporary and
using a ternary instead.

		dev_info(&device->dev, "_OSC failed (%s)%s\n",
			 acpi_format_exception(status),
			 pcie_aspm_support_enabled() ? "; disabling ASPM" : "");

>  		*no_aspm = 1;
>  		return;
>  	}
