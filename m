Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:35332 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752881AbbCWSuK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 23 Mar 2015 14:50:10 -0400
Received: by igcau2 with SMTP id au2so51173801igc.0
        for <linux-pci@vger.kernel.org>; Mon, 23 Mar 2015 11:50:10 -0700 (PDT)
Date: Mon, 23 Mar 2015 13:50:06 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	linux-pci@vger.kernel.org, Fam Zheng <famz@redhat.com>,
	Yinghai Lu <yhlu.kernel.send@gmail.com>,
	Ulrich Obergfell <uobergfe@redhat.com>,
	Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH v2 1/4] pci: disable msi/msix at probe time
Message-ID: <20150323185006.GT26935@google.com>
References: <1426786724-22241-1-git-send-email-mst@redhat.com>
 <1426786724-22241-2-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1426786724-22241-2-git-send-email-mst@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Michael,

On Thu, Mar 19, 2015 at 07:57:52PM +0100, Michael S. Tsirkin wrote:
> commit d52877c7b1afb8c37ebe17e2005040b79cb618b0
>     pci/irq: let pci_device_shutdown to call pci_msi_shutdown v2
> 
> attempted to address the problem of kexec getting
> started after linux enabled msi/msix for a device,
> and drivers being confused by msi being enabled,
> by disabling msi at shutdown.
> 
> But arguably, it's better to disable msi/msix when kexec
> starts - for example, kexec might run after a crash (kdump)
> and shutdown callbacks are not always invoked in that case.
> 
> Cc: Yinghai Lu <yhlu.kernel.send@gmail.com>
> Cc: Ulrich Obergfell <uobergfe@redhat.com>
> Cc: Fam Zheng <famz@redhat.com>
> Cc: Rusty Russell <rusty@rustcorp.com.au>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/pci/pci-driver.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 3cb2210..2ebd2a8 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -305,6 +305,12 @@ static long local_pci_probe(void *_ddi)
>  	 */
>  	pm_runtime_get_sync(dev);
>  	pci_dev->driver = pci_drv;
> +	/*
> +	 * When using kexec, msi might be left enabled by the previous kernel,
> +	 * this breaks things as some drivers assume msi/msi-x is off at boot.
> +	 * Fix this by forcing msi off at startup.
> +	 */
> +	pci_msi_off(pci_dev);

I think this makes sense, but I have a few questions.  This is a device
initialization thing, so it seems like a better fit for the enumeration
path, e.g,. pci_msi_init_pci_dev(), than for the driver binding path.

But when CONFIG_PCI_MSI=y, pci_msi_init_pci_dev() already does basically
the same thing, so we shouldn't need this change unless CONFIG_PCI_MSI is
not set in the kdump kernel.

If this is a problem just with kexeced kernels that don't have
CONFIG_PCI_MSI=y, I think I would prefer to fix this by moving
pci_msi_init_pci_dev() outside the #ifdef so it works regardless of
CONFIG_PCI_MSI.  That would also be nice because we could clean up the
duplication between pci_msi_off() and pci_msi_init_pci_dev().  It would
also make the starting machine state less dependent on the new kernel,
which seems like a good thing.

Are there any bugzillas we could reference here?

>  	rc = pci_drv->probe(pci_dev, ddi->id);
>  	if (!rc)
>  		return rc;
> -- 
> MST
> 
