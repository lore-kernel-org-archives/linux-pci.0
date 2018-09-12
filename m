Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 12 Sep 2018 12:32:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org, linuxarm@huawei.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] pci: Pick up the acpi numa node value if it is
 specified at the device level.
Message-ID: <20180912173258.GJ118330@bhelgaas-glaptop.roam.corp.google.com>
References: <20180912152140.3676-1-Jonathan.Cameron@huawei.com>
 <20180912152140.3676-2-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180912152140.3676-2-Jonathan.Cameron@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc ACPI folks, LKML]

On Wed, Sep 12, 2018 at 04:21:40PM +0100, Jonathan Cameron wrote:
> The ACPI specification allows you to provide _PXM entries for devices based
> on their location on a particular bus.  Let us use that if it is provided
> rather than just assuming it makes sense to put the device into the proximity
> domain of the root.
> 
> An example DSDT entry that will supply this is:
> 
>   Device (PCI2)
>   {
>     Name (_HID, "PNP0A08") // PCI Express Root Bridge
>     Name (_CID, "PNP0A03") // Compatible PCI Root Bridge
>     Name(_SEG, 2) // Segment of this Root complex
>     Name(_BBN, 0xF8) // Base Bus Number
>     Name(_CCA, 1)
>     Method (_PXM, 0, NotSerialized) {
>       Return(0x00)
>     }
> 
> ...
>     Device (BRI0) {
>       Name (_HID, "19E51610")
>       Name (_ADR, 0)
>       Name (_BBN, 0xF9)
>       Device (CAR0) {
>         Name (_HID, "97109912")
>         Name (_ADR, 0)
>         Method (_PXM, 0, NotSerialized) {
>           Return(0x02)
>         }
>       }
>     }
>   }
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Applied with subject:

  ACPI/PCI: Pay attention to device-specific _PXM node values

to pci/enumeration for v4.20, thanks!

> ---
>  drivers/pci/pci-acpi.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 738e3546abb1..f2f5f0ddd60e 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -753,10 +753,15 @@ static void pci_acpi_setup(struct device *dev)
>  {
>  	struct pci_dev *pci_dev = to_pci_dev(dev);
>  	struct acpi_device *adev = ACPI_COMPANION(dev);
> +	int node;
>  
>  	if (!adev)
>  		return;
>  
> +	node = acpi_get_node(adev->handle);
> +	if (node != NUMA_NO_NODE)
> +		set_dev_node(dev, node);
> +	
>  	pci_acpi_optimize_delay(pci_dev, adev->handle);
>  
>  	pci_acpi_add_pm_notifier(adev, pci_dev);
> -- 
> 2.18.0
> 
> 
