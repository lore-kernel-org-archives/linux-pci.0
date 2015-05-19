Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 19 May 2015 09:45:59 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Lv Zheng <lv.zheng@intel.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, "x86 @ kernel . org" <x86@kernel.org>
Subject: Re: [RFC 1/4] PCI: Add hooks to allocate/free IRQ resources when
 binding/unbinding driver
Message-ID: <20150519144559.GO31666@google.com>
References: <1430968374-29286-1-git-send-email-jiang.liu@linux.intel.com>
 <1430968374-29286-2-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1430968374-29286-2-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 07, 2015 at 11:12:51AM +0800, Jiang Liu wrote:
> Add two hook points pcibios_{alloc|free}_irq() into PCI core, which will
> be called when binding/unbinding PCI device drivers. Then PCI arch code
> may hook into these two points to allocate IRQ resources on demand and
> free them when not used anymore.
> 
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> ---
>  drivers/pci/pci-driver.c |   33 +++++++++++++++++++++++----------
>  include/linux/pci.h      |    2 ++
>  2 files changed, 25 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 3cb2210de553..8af4a671686f 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> ...
> +static int pci_device_probe(struct device *dev)
> +{
> +	int error;
> +	struct pci_dev *pci_dev = to_pci_dev(dev);
> +	struct pci_driver *drv = to_pci_driver(dev->driver);
> +
> +	error = pcibios_alloc_irq(pci_dev);
> +	if (error >= 0) {
> +		pci_dev_get(pci_dev);
> +		error = __pci_device_probe(drv, pci_dev);
> +		if (error) {
> +			pcibios_free_irq(pci_dev);
> +			pci_dev_put(pci_dev);
> +		}
> +	}

Please structure it like this so the mainline code doesn't get buried in
the body of the "if":

    irq = pcibios_alloc_irq(pci_dev);
    if (irq < 0)
	return irq;

    pci_dev_get(pci_dev);
    ...

>  
>  	return error;
>  }
