Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <53D7725C.5010405@citrix.com>
Date: Tue, 29 Jul 2014 11:07:24 +0100
From: David Vrabel <david.vrabel@citrix.com>
MIME-Version: 1.0
To: Ethan Zhao <ethan.zhao@oracle.com>, <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<gleb@kernel.org>, <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
	<konrad.wilk@oracle.com>, <boris.ostrovsky@oracle.com>,
	<xen-devel@lists.xenproject.org>
CC: <alex.williamson@redhat.com>, <alexander.h.duyck@intel.com>,
	<ethan.kernel@gmail.com>
Subject: Re: [PATCH 3/4 v3] xen-pciback: use pci device flag operation helper
 function
References: <1406606791-8834-1-git-send-email-ethan.zhao@oracle.com> <1406606791-8834-4-git-send-email-ethan.zhao@oracle.com>
In-Reply-To: <1406606791-8834-4-git-send-email-ethan.zhao@oracle.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 29/07/14 05:06, Ethan Zhao wrote:
> Use pci device flag operation helper functions when set device
> to assigned or deassigned state.
> 
> Signed-off-by: Ethan Zhao <ethan.zhao@oracle.com>

Konrad already reviewed this but you've not included his reviewed-by tag.

I don't understand why we bother with this flag on Xen since we never
use it but:

Acked-by: David Vrabel <david.vrabel@citrix.com>

I'm expecting this to go via the PCI tree.

David

> --- a/drivers/xen/xen-pciback/pci_stub.c
> +++ b/drivers/xen/xen-pciback/pci_stub.c
> @@ -133,7 +133,7 @@ static void pcistub_device_release(struct kref *kref)
>  	xen_pcibk_config_free_dyn_fields(dev);
>  	xen_pcibk_config_free_dev(dev);
>  
> -	dev->dev_flags &= ~PCI_DEV_FLAGS_ASSIGNED;
> +	pci_clear_dev_assigned(dev);
>  	pci_dev_put(dev);
>  
>  	kfree(psdev);
> @@ -404,7 +404,7 @@ static int pcistub_init_device(struct pci_dev *dev)
>  	dev_dbg(&dev->dev, "reset device\n");
>  	xen_pcibk_reset_device(dev);
>  
> -	dev->dev_flags |= PCI_DEV_FLAGS_ASSIGNED;
> +	pci_set_dev_assigned(dev);
>  	return 0;
>  
>  config_release:
> 

