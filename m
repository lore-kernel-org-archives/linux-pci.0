Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752709AbeEGWOA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 May 2018 18:14:00 -0400
Date: Mon, 7 May 2018 17:13:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc: bhelgaas@google.com, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com,
        Frederick Lawler <fred@fredlawl.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] PCI/AER: Use a common function to print AER error bits
Message-ID: <20180507221342.GC161390@bhelgaas-glaptop.roam.corp.google.com>
References: <20180417170943.1767-1-mr.nuke.me@gmail.com>
 <20180430195218.27654-1-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180430195218.27654-1-mr.nuke.me@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 30, 2018 at 02:52:15PM -0500, Alexandru Gagniuc wrote:
> On errors reported from CPER, cper_print_bits() was used to log the
> AER bits. This resulted in hard-to-understand messages, without a
> prefix. Instead use __aer_print_error() for both native AER and CPER
> to provide a more consistent log format.
> 
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>

Applied to pci/aer for v4.18, thanks!

> ---
> 
> Changes since v1:
>   - Parse aer regs for first error pointer instead of disabling it
> On the Dell machine where I tested this, the first error pointer is
> reported correctly by firmware.
> 
>  drivers/pci/pcie/aer/aerdrv_errprint.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer/aerdrv_errprint.c b/drivers/pci/pcie/aer/aerdrv_errprint.c
> index cfc89dd57831..b5612cc51b63 100644
> --- a/drivers/pci/pcie/aer/aerdrv_errprint.c
> +++ b/drivers/pci/pcie/aer/aerdrv_errprint.c
> @@ -216,28 +216,30 @@ EXPORT_SYMBOL_GPL(cper_severity_to_aer);
>  void cper_print_aer(struct pci_dev *dev, int aer_severity,
>  		    struct aer_capability_regs *aer)
>  {
> -	int layer, agent, status_strs_size, tlp_header_valid = 0;
> +	int layer, agent, tlp_header_valid = 0;
>  	u32 status, mask;
> -	const char **status_strs;
> +	struct aer_err_info info;
>  
>  	if (aer_severity == AER_CORRECTABLE) {
>  		status = aer->cor_status;
>  		mask = aer->cor_mask;
> -		status_strs = aer_correctable_error_string;
> -		status_strs_size = ARRAY_SIZE(aer_correctable_error_string);
>  	} else {
>  		status = aer->uncor_status;
>  		mask = aer->uncor_mask;
> -		status_strs = aer_uncorrectable_error_string;
> -		status_strs_size = ARRAY_SIZE(aer_uncorrectable_error_string);
>  		tlp_header_valid = status & AER_LOG_TLP_MASKS;
>  	}
>  
>  	layer = AER_GET_LAYER_ERROR(aer_severity, status);
>  	agent = AER_GET_AGENT(aer_severity, status);
>  
> +	memset(&info, 0, sizeof(info));
> +	info.severity = aer_severity;
> +	info.status = status;
> +	info.mask = mask;
> +	info.first_error = PCI_ERR_CAP_FEP(aer->cap_control);
> +
>  	pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
> -	cper_print_bits("", status, status_strs, status_strs_size);
> +	__aer_print_error(dev, &info);
>  	pci_err(dev, "aer_layer=%s, aer_agent=%s\n",
>  		aer_error_layer[layer], aer_agent_string[agent]);
>  
> -- 
> 2.14.3
> 
