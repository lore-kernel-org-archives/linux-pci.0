Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750753AbdHNSGz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Aug 2017 14:06:55 -0400
Date: Mon, 14 Aug 2017 13:06:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Scott Bauer <scott.bauer@intel.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        keith.busch@intel.com, jonathan.derrick@intel.com
Subject: Re: [PATCH] PCI: vmd: Free up IRQs on suspend path
Message-ID: <20170814180652.GA32525@bhelgaas-glaptop.roam.corp.google.com>
References: <20170811205432.29612-1-scott.bauer@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170811205432.29612-1-scott.bauer@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 11, 2017 at 02:54:32PM -0600, Scott Bauer wrote:
> This patch frees up the IRQs we request on the suspend path,
> and reallocates them on the resume path.
> 
> Fixes:
> [  559.964386] CPU 111 disable failed: CPU has 9 vectors assigned and there are only 0 available.
> [  559.966824] Error taking CPU111 down: -34
> [  559.966825] Non-boot CPUs are not disabled
> [  559.966826] Enabling non-boot CPUs ...
> 
> Signed-off-by: Scott Bauer <scott.bauer@intel.com>

Keith acked the previous version (which contained the enable/disable),
but since this is different, I'll wait for his ack again.

> ---
>  drivers/pci/host/vmd.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/pci/host/vmd.c b/drivers/pci/host/vmd.c
> index 7e967a8784b2..4fe1756af010 100644
> --- a/drivers/pci/host/vmd.c
> +++ b/drivers/pci/host/vmd.c
> @@ -763,6 +763,11 @@ static void vmd_remove(struct pci_dev *dev)
>  static int vmd_suspend(struct device *dev)
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct vmd_dev *vmd = pci_get_drvdata(pdev);
> +	int i;
> +
> +	for (i = 0; i < vmd->msix_count; i++)
> +                devm_free_irq(dev, pci_irq_vector(pdev, i), &vmd->irqs[i]);
>  
>  	pci_save_state(pdev);
>  	return 0;
> @@ -771,6 +776,16 @@ static int vmd_suspend(struct device *dev)
>  static int vmd_resume(struct device *dev)
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct vmd_dev *vmd = pci_get_drvdata(pdev);
> +	int err, i;
> +
> +	for (i = 0; i < vmd->msix_count; i++) {
> +		err = devm_request_irq(dev, pci_irq_vector(pdev, i),
> +				       vmd_irq, IRQF_NO_THREAD,
> +				       "vmd", &vmd->irqs[i]);
> +		if (err)
> +			return err;
> +	}
>  
>  	pci_restore_state(pdev);
>  	return 0;
> -- 
> 2.11.0
> 
