Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:19260 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932346AbdGTVqq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Jul 2017 17:46:46 -0400
From: Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCH] PCI: vmd: Free up IRQs on suspend path
To: Scott Bauer <scott.bauer@intel.com>, linux-pci@vger.kernel.org
Cc: keith.busch@intel.com, david.fugate@intel.com, bhelgaas@google.com
References: <20170720202858.1918-1-scott.bauer@intel.com>
Message-ID: <cfc64209-82cb-432b-8ca1-c02c50d34d68@intel.com>
Date: Tue, 25 Jul 2017 20:15:32 -0600
MIME-Version: 1.0
In-Reply-To: <20170720202858.1918-1-scott.bauer@intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/20/2017 02:28 PM, Scott Bauer wrote:
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
> ---
>  drivers/pci/host/vmd.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/pci/host/vmd.c b/drivers/pci/host/vmd.c
> index 6088c3083194..88bf0c754fb2 100644
> --- a/drivers/pci/host/vmd.c
> +++ b/drivers/pci/host/vmd.c
> @@ -755,6 +755,11 @@ static void vmd_remove(struct pci_dev *dev)
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
> @@ -763,7 +768,16 @@ static int vmd_suspend(struct device *dev)
>  static int vmd_resume(struct device *dev)
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct vmd_dev *vmd = pci_get_drvdata(pdev);
> +	int err, i;
>  
> +	for (i = 0; i < vmd->msix_count; i++) {
> +		err = devm_request_irq(dev, pci_irq_vector(pdev, i),
> +				       vmd_irq, IRQF_NO_THREAD,
The flag here looks redundant to me because the fn calls into
request_threaded_irq with no thread_fn. But since it's a bit more
verbose, can you change the other devm_request_irq to use IRQF_NO_THREAD?

> +				       "vmd", &vmd->irqs[i]);
> +		if (err)
> +			return err;
> +	}
>  	pci_restore_state(pdev);
>  	return 0;
>  }
> 
