Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:32922 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932620AbeFUJQM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jun 2018 05:16:12 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Thu, 21 Jun 2018 14:46:10 +0530
From: poza@codeaurora.org
To: Keith Busch <keith.busch@intel.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH 5/7] PCI/DPC: Print AER status in DPC event handling
In-Reply-To: <20180620213833.25072-5-keith.busch@intel.com>
References: <20180620213833.25072-1-keith.busch@intel.com>
 <20180620213833.25072-5-keith.busch@intel.com>
Message-ID: <9cc1594055f03c0e4b4d1b50384107e8@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2018-06-21 03:08, Keith Busch wrote:
> A DPC enabled device suppresses ERR_(NON)FATAL messages, preventing the
> AER handler from reporting error details. If the DPC trigger reason 
> says
> the downstream port detected the error, this patch has the DPC driver
> collect the AER uncorrectable status for logging, then clears the 
> status.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  drivers/pci/pcie/dpc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index 1b0b25ba947c..f6098dd171f3 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -6,6 +6,7 @@
>   * Copyright (C) 2016 Intel Corp.
>   */
> 
> +#include <linux/aer.h>
>  #include <linux/delay.h>
>  #include <linux/interrupt.h>
>  #include <linux/init.h>
> @@ -161,6 +162,7 @@ static void dpc_process_rp_pio_error(struct dpc_dev 
> *dpc)
> 
>  static void dpc_work(struct work_struct *work)
>  {
> +	struct aer_err_info info;
>  	struct dpc_dev *dpc = container_of(work, struct dpc_dev, work);
>  	struct pci_dev *pdev = dpc->dev->port;
>  	struct device *dev = &dpc->dev->device;
> @@ -185,6 +187,10 @@ static void dpc_work(struct work_struct *work)
>  	/* show RP PIO error detail information */
>  	if (dpc->rp_extensions && reason == 3 && ext_reason == 0)
>  		dpc_process_rp_pio_error(dpc);
> +	else if (reason == 0 && aer_get_device_error_info(pdev, &info)) {
> +		aer_print_error(pdev, &info);
> +		pci_cleanup_aer_uncorrect_error_status(pdev);

6.2.10 for Downstream Port Containment:

   When DPC is triggered due to receipt of an uncorrectable error 
Message,
   the Requester ID from the Message is recorded in the DPC Error
   Source ID register and that Message is discarded and not forwarded
   Upstream. When DPC is triggered by an unmasked uncorrectable error,
   that error will not be signaled with an uncorrectable error Message,
   even if otherwise enabled.

Inst the message is discarded and not forwarded to upstream.
which means that we should not find AER status set in RP or Switch.
in other words, at time either we will find DPC or AER triggered but not 
both at the same time.
then when DPC is triggered why do we need to 
pci_cleanup_aer_uncorrect_error_status(pdev); ?

Regards,
Oza.


> +	}
> 
>  	/* We configure DPC so it only triggers on ERR_FATAL */
>  	pcie_do_fatal_recovery(pdev, PCIE_PORT_SERVICE_DPC);
