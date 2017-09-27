Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 27 Sep 2017 17:00:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Donald Dutile <ddutile@redhat.com>,
        Alexander Duyck <alexander.h.duyck@intel.com>,
        "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
        Bodong Wang <bodong@mellanox.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH] uio/uio_pci_generic: Add SR-IOV support
Message-ID: <20170927220005.GB23674@bhelgaas-glaptop.roam.corp.google.com>
References: <1506517162.30379.2.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1506517162.30379.2.camel@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Don, Alex D, Alex W, Bryant, Bodong, Michael, kvm list]

On Wed, Sep 27, 2017 at 01:59:22PM +0100, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> Allow userspace to configure SR-IOV VFs through sysfs.
> 
> Currently, we need an in-kernel driver to permit this. But sometimes
> *all* we want to do is enable the VFs so that we can assign them to
> guests; we don't actually need to deal with the PF in any other way
> from the host kernel. So let's make it possible to use UIO for that.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
> It's not entirely clear to me why we require the driver to "enable"
> SR-IOV like this anyway — were there some which needed to do something
> special and device-specific instead of just falling through to
> pci_{en,dis}able_sriov(), such that we need to effectively whitelist
> this in the driver rather than blacklisting the "problematic" ones via
> PCI quirks?

IIUC, this question is basically "why doesn't the PCI core enable IOV
automatically when it sees an IOV-capable device?"

I think one reason is that an admin might want to control the number
of VFs we enable (e.g., via 1789382a72a5 ("PCI: SRIOV control and
status via sysfs" [1]).  But I guess you already know about that,
since this patch uses that sysfs path, so maybe I don't understand
your question.

[1] http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=1789382a72a5

>  drivers/uio/uio_pci_generic.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/uio/uio_pci_generic.c b/drivers/uio/uio_pci_generic.c
> index a56fdf9..bd196f0 100644
> --- a/drivers/uio/uio_pci_generic.c
> +++ b/drivers/uio/uio_pci_generic.c
> @@ -108,15 +108,27 @@ static void remove(struct pci_dev *pdev)
>  	struct uio_pci_generic_dev *gdev = pci_get_drvdata(pdev);
>  
>  	uio_unregister_device(&gdev->info);
> +	pci_disable_sriov(pdev);
>  	pci_disable_device(pdev);
>  	kfree(gdev);
>  }
>  
> +static int sriov_configure(struct pci_dev *pdev, int num_vfs)
> +{
> +	if (!num_vfs) {
> +		pci_disable_sriov(pdev);
> +		return 0;
> +	}
> +
> +	return pci_enable_sriov(pdev, num_vfs);
> +}
> +
>  static struct pci_driver uio_pci_driver = {
>  	.name = "uio_pci_generic",
>  	.id_table = NULL, /* only dynamic id's */
>  	.probe = probe,
>  	.remove = remove,
> +	.sriov_configure = sriov_configure,
>  };
>  
>  module_pci_driver(uio_pci_driver);
> -- 
> 2.7.4
> 
> -- 
> dwmw2
