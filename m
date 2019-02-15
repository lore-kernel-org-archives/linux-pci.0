Return-Path: <SRS0=N/Da=QW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2BBC10F02
	for <linux-pci@archiver.kernel.org>; Fri, 15 Feb 2019 15:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E671020675
	for <linux-pci@archiver.kernel.org>; Fri, 15 Feb 2019 15:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfBOPML (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 15 Feb 2019 10:12:11 -0500
Received: from mga01.intel.com ([192.55.52.88]:40040 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbfBOPML (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 15 Feb 2019 10:12:11 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Feb 2019 07:12:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,373,1544515200"; 
   d="scan'208";a="138914094"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga001.jf.intel.com with ESMTP; 15 Feb 2019 07:12:09 -0800
Date:   Fri, 15 Feb 2019 08:11:57 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Dongdong Liu <liudongdong3@huawei.com>
Cc:     helgaas@kernel.org, okaya@kernel.org, linux-pci@vger.kernel.org,
        linuxarm@huawei.com, stable@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH RESEND] PCI/DPC: Fix print AER status in DPC event
 handling
Message-ID: <20190215151157.GC9613@localhost.localdomain>
References: <1549868579-125090-1-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549868579-125090-1-git-send-email-liudongdong3@huawei.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
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


Looks good.

Reviewed-by: Keith Busch <keith.busch@intel.com>

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
