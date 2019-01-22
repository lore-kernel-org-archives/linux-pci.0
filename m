Return-Path: <SRS0=s1t5=P6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61898C282C5
	for <linux-pci@archiver.kernel.org>; Tue, 22 Jan 2019 11:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3842D21019
	for <linux-pci@archiver.kernel.org>; Tue, 22 Jan 2019 11:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbfAVLj3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 22 Jan 2019 06:39:29 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:46180 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727919AbfAVLj3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Jan 2019 06:39:29 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E9E89C100CF9AD8C03D7;
        Tue, 22 Jan 2019 19:39:26 +0800 (CST)
Received: from [127.0.0.1] (10.63.141.25) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.408.0; Tue, 22 Jan 2019
 19:39:17 +0800
Subject: Re: [PATCH] PCI/DPC: Fix print AER status in DPC event handling
To:     <helgaas@kernel.org>, Keith Busch <keith.busch@intel.com>,
        "okaya@kernel.org" <okaya@kernel.org>
References: <1546501109-42821-1-git-send-email-liudongdong3@huawei.com>
CC:     <linux-pci@vger.kernel.org>, <linuxarm@huawei.com>,
        <stable@vger.kernel.org>
From:   Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <b1d629a1-4576-4494-2ef9-1968ff632bfd@huawei.com>
Date:   Tue, 22 Jan 2019 19:39:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <1546501109-42821-1-git-send-email-liudongdong3@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.63.141.25]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Ping :)

ÔÚ 2019/1/3 15:38, Dongdong Liu Ð´µÀ:
> Current info->severity have not assigned a value before calling
> aer_get_device_error_info() and aer_get_device_error_info(),
> Fix the bug to get the severity by reading the port's AER status, mask
> and severity registers. At the same time, add code to clear the port's
> fatal errors.
>
> Fixes: 8aefa9b0d910 ("PCI/DPC: Print AER status in DPC event handling")
> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
> Cc: stable@vger.kernel.org # 4.19+
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
>

