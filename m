Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 10 Jan 2018 17:35:15 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Maximilian Heyne <mheyne@amazon.de>
Cc: linux-pci@vger.kernel.org, Alexander Duyck <aduyck@mirantis.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Liang-Min Wang <liang-min.wang@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci-stub: enable SR-IOV configuration through sysfs
Message-ID: <20180110233515.GI241460@bhelgaas-glaptop.roam.corp.google.com>
References: <1513170333-19102-1-git-send-email-mheyne@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1513170333-19102-1-git-send-email-mheyne@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Alex, Alex, Jeff, Liang-Min, kvm, LKML]

Anybody else have any thoughts on this?

On Wed, Dec 13, 2017 at 02:05:33PM +0100, Maximilian Heyne wrote:
> Currently, SR-IOV VFs can only be configured through sysfs, if a driver
> is loaded for the device. Sometimes we don't care about the PF, but only
> want to assign VFs to guests, which is now possible with this patch.
> 
> Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
> ---
>  drivers/pci/pci-stub.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pci-stub.c b/drivers/pci/pci-stub.c
> index 886fb35..aa007c3 100644
> --- a/drivers/pci/pci-stub.c
> +++ b/drivers/pci/pci-stub.c
> @@ -32,10 +32,27 @@ static int pci_stub_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  	return 0;
>  }
>  
> +static void pci_stub_remove(struct pci_dev *dev)
> +{
> +	pci_disable_sriov(dev);
> +}
> +
> +static int pci_stub_sriov_configure(struct pci_dev *dev, int num_vfs)
> +{
> +	if (!num_vfs) {
> +		pci_disable_sriov(dev);
> +		return 0;
> +	}
> +
> +	return pci_enable_sriov(dev, num_vfs);
> +}
> +
>  static struct pci_driver stub_driver = {
> -	.name		= "pci-stub",
> -	.id_table	= NULL,	/* only dynamic id's */
> -	.probe		= pci_stub_probe,
> +	.name			= "pci-stub",
> +	.id_table		= NULL,	/* only dynamic IDs */
> +	.probe			= pci_stub_probe,
> +	.remove			= pci_stub_remove,
> +	.sriov_configure	= pci_stub_sriov_configure,
>  };
>  
>  static int __init pci_stub_init(void)
> -- 
> 2.7.4
> 
