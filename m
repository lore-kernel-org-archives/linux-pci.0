Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:53224 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756885AbeDZR1v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Apr 2018 13:27:51 -0400
Subject: Re: [PATCH RESEND] PCI/AER: Use a common function to print AER error
 bits
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org
Cc: gregkh@linuxfoundation.org, fred@fredlawl.com,
        linux-kernel@vger.kernel.org, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, keith.busch@intel.com
References: <20180417170943.1767-1-mr.nuke.me@gmail.com>
From: Tyler Baicar <tbaicar@codeaurora.org>
Message-ID: <ab79f650-180f-24b4-f3d6-c07d10e5318c@codeaurora.org>
Date: Thu, 26 Apr 2018 13:27:47 -0400
MIME-Version: 1.0
In-Reply-To: <20180417170943.1767-1-mr.nuke.me@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 4/17/2018 1:09 PM, Alexandru Gagniuc wrote:
> On errors reported from CPER, cper_print_bits() was used to log the
> AER bits. This resulted in hard-to-understand messages, without a
> prefix. Instead use __aer_print_error() for both native AER and CPER
> to provide a more consistent log format.
>
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Tested-by: Tyler Baicar <tbaicar@codeaurora.org>

Thanks!
> ---
>   drivers/pci/pcie/aer/aerdrv_errprint.c | 16 +++++++++-------
>   1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/pci/pcie/aer/aerdrv_errprint.c b/drivers/pci/pcie/aer/aerdrv_errprint.c
> index cfc89dd57831..cfae4d52f848 100644
> --- a/drivers/pci/pcie/aer/aerdrv_errprint.c
> +++ b/drivers/pci/pcie/aer/aerdrv_errprint.c
> @@ -216,28 +216,30 @@ EXPORT_SYMBOL_GPL(cper_severity_to_aer);
>   void cper_print_aer(struct pci_dev *dev, int aer_severity,
>   		    struct aer_capability_regs *aer)
>   {
> -	int layer, agent, status_strs_size, tlp_header_valid = 0;
> +	int layer, agent, tlp_header_valid = 0;
>   	u32 status, mask;
> -	const char **status_strs;
> +	struct aer_err_info info;
>   
>   	if (aer_severity == AER_CORRECTABLE) {
>   		status = aer->cor_status;
>   		mask = aer->cor_mask;
> -		status_strs = aer_correctable_error_string;
> -		status_strs_size = ARRAY_SIZE(aer_correctable_error_string);
>   	} else {
>   		status = aer->uncor_status;
>   		mask = aer->uncor_mask;
> -		status_strs = aer_uncorrectable_error_string;
> -		status_strs_size = ARRAY_SIZE(aer_uncorrectable_error_string);
>   		tlp_header_valid = status & AER_LOG_TLP_MASKS;
>   	}
>   
>   	layer = AER_GET_LAYER_ERROR(aer_severity, status);
>   	agent = AER_GET_AGENT(aer_severity, status);
>   
> +	memset(&info, 0, sizeof(info));
> +	info.severity = aer_severity;
> +	info.status = status;
> +	info.mask = mask;
> +	info.first_error = 0x1f;
> +
>   	pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
> -	cper_print_bits("", status, status_strs, status_strs_size);
> +	__aer_print_error(dev, &info);
>   	pci_err(dev, "aer_layer=%s, aer_agent=%s\n",
>   		aer_error_layer[layer], aer_agent_string[agent]);
>   

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
