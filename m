Return-Path: <SRS0=2g0o=Q4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB16CC4360F
	for <linux-pci@archiver.kernel.org>; Thu, 21 Feb 2019 23:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4D2A2083B
	for <linux-pci@archiver.kernel.org>; Thu, 21 Feb 2019 23:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550790988;
	bh=emrKba6UVbU0jkwj4ci0ARtXSwnyncbHnZCLAU5PSlU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rjFDyhvhNxjnKhz/T4KHE/JeeLUxR/sEvzeZqFyNrJWZJNpSjzWkrG+ijOUAb4fOA
	 EVIGiybqMRCtuwPUKEBP8Md8qsiwiLxDr9zQS0MCD2AR9uU7eM4qIS1oMkkl7dJBI4
	 n565u9HsU4sXhQhAypSJcgaIOt/SAD+Nrygs1RRI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbfBUXQ2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 21 Feb 2019 18:16:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:49312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbfBUXQ1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Feb 2019 18:16:27 -0500
Received: from localhost (unknown [104.133.8.90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D05192077B;
        Thu, 21 Feb 2019 23:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550790986;
        bh=emrKba6UVbU0jkwj4ci0ARtXSwnyncbHnZCLAU5PSlU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rB4noCH5oCse8j2TZlEo5ugBV48/zl+xYhjFyQcvQhn8JxynZQ0cLOLlBELyC3MO4
         pA1pwrTDOlVMGX3BOfZRrMt2FXy5PG1nfP7HiliI/3Jgu/ZJazyFd2oSQ8A62Wc8fT
         yy+TUIuyg8n3MCPrC4gMzYAaG6Pdrjs0CePYZgjw=
Date:   Thu, 21 Feb 2019 17:16:26 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dongdong Liu <liudongdong3@huawei.com>
Cc:     keith.busch@intel.com, okaya@kernel.org, linux-pci@vger.kernel.org,
        linuxarm@huawei.com, stable@vger.kernel.org
Subject: Re: [PATCH RESEND] PCI/DPC: Fix print AER status in DPC event
 handling
Message-ID: <20190221231626.GA219879@google.com>
References: <1549868579-125090-1-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549868579-125090-1-git-send-email-liudongdong3@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 11, 2019 at 03:02:59PM +0800, Dongdong Liu wrote:
> Current info->severity have not assigned a value before calling
> aer_get_device_error_info() and aer_get_device_error_info(),
> Fix the bug to get the severity by reading the port's AER status, mask
> and severity registers. At the same time, add code to clear the port's
> fatal errors.
> 
> Fixes: 8aefa9b0d910 ("PCI/DPC: Print AER status in DPC event handling")
> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
> Cc: stable@vger.kernel.org
> Cc: Keith Busch <keith.busch@intel.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>

Applied to pci/dpc for v5.1, thanks!

> ---
>  drivers/pci/pcie/dpc.c | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index e435d12..7b77754 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -202,6 +202,28 @@ static void dpc_process_rp_pio_error(struct dpc_dev *dpc)
>  	pci_write_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_STATUS, status);
>  }
>  
> +static int dpc_get_aer_uncorrect_severity(struct pci_dev *dev,
> +					  struct aer_err_info *info)
> +{
> +	int pos = dev->aer_cap;
> +	u32 status, mask, sev;
> +
> +	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, &status);
> +	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_MASK, &mask);
> +	status &= ~mask;
> +	if (!status)
> +		return 0;
> +
> +	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, &sev);
> +	status &= sev;
> +	if (status)
> +		info->severity = AER_FATAL;
> +	else
> +		info->severity = AER_NONFATAL;
> +
> +	return 1;
> +}
> +
>  static irqreturn_t dpc_handler(int irq, void *context)
>  {
>  	struct aer_err_info info;
> @@ -229,9 +251,12 @@ static irqreturn_t dpc_handler(int irq, void *context)
>  	/* show RP PIO error detail information */
>  	if (dpc->rp_extensions && reason == 3 && ext_reason == 0)
>  		dpc_process_rp_pio_error(dpc);
> -	else if (reason == 0 && aer_get_device_error_info(pdev, &info)) {
> +	else if (reason == 0 &&
> +		 dpc_get_aer_uncorrect_severity(pdev, &info) &&
> +		 aer_get_device_error_info(pdev, &info)) {
>  		aer_print_error(pdev, &info);
>  		pci_cleanup_aer_uncorrect_error_status(pdev);
> +		pci_aer_clear_fatal_status(pdev);
>  	}
>  
>  	/* We configure DPC so it only triggers on ERR_FATAL */
> -- 
> 1.9.1
> 
