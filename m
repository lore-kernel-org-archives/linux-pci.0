Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/9] PCI/PME: Log PME IRQ when claiming Root Port
Date: Mon, 21 Nov 2016 23:29:20 +0100
Message-ID: <1531291.6pVMOmFLZP@vostro.rjw.lan>
In-Reply-To: <20161121214526.21036.73271.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20161121214006.21036.11599.stgit@bhelgaas-glaptop.roam.corp.google.com> <20161121214526.21036.73271.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday, November 21, 2016 03:45:26 PM Bjorn Helgaas wrote:
> We already log a "Signaling PME" whenever the PME service driver claims a
> Root Port.  In fact, we also log the same message for every device in the
> hierarchy below the Root Port.
> 
> Log the "Signaling PME" once (only for the Root Port, since we can
> trivially find out which devices are below the Root Port), and include the
> IRQ number in the message to help connect the dots with /proc/interrupts.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pcie/pme.c |   12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
> index 9e8aa9d..7175293 100644
> --- a/drivers/pci/pcie/pme.c
> +++ b/drivers/pci/pcie/pme.c
> @@ -300,8 +300,6 @@ static irqreturn_t pcie_pme_irq(int irq, void *context)
>   */
>  static int pcie_pme_set_native(struct pci_dev *dev, void *ign)
>  {
> -	dev_info(&dev->dev, "Signaling PME through PCIe PME interrupt\n");
> -
>  	device_set_run_wake(&dev->dev, true);
>  	dev->pme_interrupt = true;
>  	return 0;
> @@ -349,12 +347,14 @@ static int pcie_pme_probe(struct pcie_device *srv)
>  	ret = request_irq(srv->irq, pcie_pme_irq, IRQF_SHARED, "PCIe PME", srv);
>  	if (ret) {
>  		kfree(data);
> -	} else {
> -		pcie_pme_mark_devices(port);
> -		pcie_pme_interrupt_enable(port, true);
> +		return ret;
>  	}
>  
> -	return ret;
> +	dev_info(&port->dev, "Signaling PME with IRQ %d\n", srv->irq);
> +
> +	pcie_pme_mark_devices(port);
> +	pcie_pme_interrupt_enable(port, true);
> +	return 0;
>  }
>  
>  static bool pcie_pme_check_wakeup(struct pci_bus *bus)
> 
> --

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
