Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 15 Feb 2017 10:19:45 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Yinghai Lu <yinghai@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH] PCI/PME: Restore pcie_pme_driver.remove
Message-ID: <20170215151944.GH6993@windriver.com>
References: <20170215051748.3346-1-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20170215051748.3346-1-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[[PATCH] PCI/PME: Restore pcie_pme_driver.remove] On 14/02/2017 (Tue 21:17) Yinghai Lu wrote:

> Found 4.9 and later, removing pci device for pcie port via /sys failed:
> ------------[ cut here ]------------
> kernel BUG at drivers/pci/msi.c:370!
> 

[...]

> Bisect to commit d7def2040077 ("PCI/PME: Make explicitly non-modular").
> That commit did extra thing like remove the .remove for pcie_pme_driver.

Ah crap.  Seems I mis-interpreted the use case of the .remove.  :-/
Sorry about that.

Thanks,
Paul.
--

> 
> Put back pcie_pme_remove and restore to pcie_pme_driver fix the problem.
> 
> Fixes: d7def2040077 ("PCI/PME: Make explicitly non-modular")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> 
> diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
> index 7175293..2dd1c68 100644
> --- a/drivers/pci/pcie/pme.c
> +++ b/drivers/pci/pcie/pme.c
> @@ -433,6 +433,17 @@ static int pcie_pme_resume(struct pcie_device *srv)
>  	return 0;
>  }
>  
> +/**
> + * pcie_pme_remove - Prepare PCIe PME service device for removal.
> + * @srv - PCIe service device to remove.
> + */
> +static void pcie_pme_remove(struct pcie_device *srv)
> +{
> +	pcie_pme_suspend(srv);
> +	free_irq(srv->irq, srv);
> +	kfree(get_service_data(srv));
> +}
> +
>  static struct pcie_port_service_driver pcie_pme_driver = {
>  	.name		= "pcie_pme",
>  	.port_type	= PCI_EXP_TYPE_ROOT_PORT,
> @@ -441,6 +452,7 @@ static struct pcie_port_service_driver pcie_pme_driver = {
>  	.probe		= pcie_pme_probe,
>  	.suspend	= pcie_pme_suspend,
>  	.resume		= pcie_pme_resume,
> +	.remove		= pcie_pme_remove,
>  };
>  
>  /**
