Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751874AbeB0VpK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Feb 2018 16:45:10 -0500
Date: Tue, 27 Feb 2018 15:45:07 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tyler Baicar <tbaicar@codeaurora.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI/AER: update AER status string print to match
 other AER logs
Message-ID: <20180227214507.GD127842@bhelgaas-glaptop.roam.corp.google.com>
References: <1518034285-3543-1-git-send-email-tbaicar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1518034285-3543-1-git-send-email-tbaicar@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 07, 2018 at 03:11:25PM -0500, Tyler Baicar wrote:
> Currently the AER driver uses cper_print_bits() to print the AER status
> string. This causes the status string to not include the proper PCI device
> name prefix that the other AER prints include. Also, it has a different
> print level than all the other AER prints, and there is a potential to
> have multiple status prints based on string lengths.
> 
> Update the AER driver to print the AER status string with the proper string
> prefix and proper print level, and abreviate the status strings similar to
> lspci -vv prints so they can be printed on the same line.
> 
> Previous log example:
> 
> e1000e 0003:01:00.1: aer_status: 0x00000041, aer_mask: 0x00000000
> Receiver Error, Bad TLP
> e1000e 0003:01:00.1: aer_layer=Physical Layer, aer_agent=Receiver ID
> pcieport 0003:00:00.0: aer_status: 0x00001000, aer_mask: 0x0000e000
> Replay Timer Timeout
> pcieport 0003:00:00.0: aer_layer=Data Link Layer, aer_agent=Transmitter ID
> 
> New log:
> 
> e1000e 0003:01:00.1: aer_status: 0x00000041, aer_mask: 0x00000000
> e1000e 0003:01:00.1: RxErr, BadTLP
> e1000e 0003:01:00.1: aer_layer=Physical Layer, aer_agent=Receiver ID
> pcieport 0003:00:00.0: aer_status: 0x00001000, aer_mask: 0x0000e000
> pcieport 0003:00:00.0: Timeout
> pcieport 0003:00:00.0: aer_layer=Data Link Layer, aer_agent=Transmitter ID

This is awesome, much better than before.

But it only changes the output via the APEI/GHES path.  I think errors
reported via the "native" path, i.e., aer_print_error(), should look
the same.  Since this patch changes the way cper_print_aer() decodes
the status bits, can you make the aer_print_error() status bit
decoding match it?

Both paths (cper_print_aer() and aer_print_error()) also print the
raw "status" and "mask" values.  But these can be from either the
Uncorrectable Error registers or the Correctable Errors registers.
I don't think cper_print_aer() prints any clue about which is the
source.  Can you include something like what aer_print_error() does,
e.g., with aer_error_severity_string[]?

I would suggest splitting this into a few patches:

  - abbreviate the *_error_string[] values
  - change cper_print_aer() to use dev_print_bits() instead of
    cper_print_bits()
  - change cper_print_aer() to print severity/type/id in the same
    format aer_print_error() uses
  - change aer_print_error() to use dev_print_bits() instead of
    __aer_print_error()

> Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
> ---
>  drivers/pci/pcie/aer/aerdrv_errprint.c | 71 ++++++++++++++++++++++------------
>  1 file changed, 47 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer/aerdrv_errprint.c b/drivers/pci/pcie/aer/aerdrv_errprint.c
> index 6a352e6..bb68dd4 100644
> --- a/drivers/pci/pcie/aer/aerdrv_errprint.c
> +++ b/drivers/pci/pcie/aer/aerdrv_errprint.c
> @@ -72,22 +72,22 @@
>  };
>  
>  static const char *aer_correctable_error_string[] = {
> -	"Receiver Error",		/* Bit Position 0	*/
> +	"RxErr",			/* Bit Position 0	*/
>  	NULL,
>  	NULL,
>  	NULL,
>  	NULL,
>  	NULL,
> -	"Bad TLP",			/* Bit Position 6	*/
> -	"Bad DLLP",			/* Bit Position 7	*/
> -	"RELAY_NUM Rollover",		/* Bit Position 8	*/
> +	"BadTLP",			/* Bit Position 6	*/
> +	"BadDLLP",			/* Bit Position 7	*/
> +	"Rollover",			/* Bit Position 8	*/
>  	NULL,
>  	NULL,
>  	NULL,
> -	"Replay Timer Timeout",		/* Bit Position 12	*/
> -	"Advisory Non-Fatal",		/* Bit Position 13	*/
> -	"Corrected Internal Error",	/* Bit Position 14	*/
> -	"Header Log Overflow",		/* Bit Position 15	*/
> +	"Timeout",			/* Bit Position 12	*/
> +	"NonFatalErr",			/* Bit Position 13	*/
> +	"CorrIntErr",			/* Bit Position 14	*/
> +	"HeaderOF",			/* Bit Position 15	*/
>  };
>  
>  static const char *aer_uncorrectable_error_string[] = {
> @@ -95,28 +95,28 @@
>  	NULL,
>  	NULL,
>  	NULL,
> -	"Data Link Protocol",		/* Bit Position 4	*/
> -	"Surprise Down Error",		/* Bit Position 5	*/
> +	"DLP",				/* Bit Position 4	*/
> +	"SDES",				/* Bit Position 5	*/
>  	NULL,
>  	NULL,
>  	NULL,
>  	NULL,
>  	NULL,
>  	NULL,
> -	"Poisoned TLP",			/* Bit Position 12	*/
> -	"Flow Control Protocol",	/* Bit Position 13	*/
> -	"Completion Timeout",		/* Bit Position 14	*/
> -	"Completer Abort",		/* Bit Position 15	*/
> -	"Unexpected Completion",	/* Bit Position 16	*/
> -	"Receiver Overflow",		/* Bit Position 17	*/
> -	"Malformed TLP",		/* Bit Position 18	*/
> +	"TLP",				/* Bit Position 12	*/
> +	"FCP",				/* Bit Position 13	*/
> +	"CmpltTO",			/* Bit Position 14	*/
> +	"CmpltAbrt",			/* Bit Position 15	*/
> +	"UnxCmplt",			/* Bit Position 16	*/
> +	"RxOF",				/* Bit Position 17	*/
> +	"MalfTLP",			/* Bit Position 18	*/
>  	"ECRC",				/* Bit Position 19	*/
> -	"Unsupported Request",		/* Bit Position 20	*/
> -	"ACS Violation",		/* Bit Position 21	*/
> -	"Uncorrectable Internal Error",	/* Bit Position 22	*/
> -	"MC Blocked TLP",		/* Bit Position 23	*/
> -	"AtomicOp Egress Blocked",	/* Bit Position 24	*/
> -	"TLP Prefix Blocked Error",	/* Bit Position 25	*/
> +	"UnsupReq",			/* Bit Position 20	*/
> +	"ACSViol",			/* Bit Position 21	*/
> +	"UncorrIntErr",			/* Bit Position 22	*/
> +	"BlockedTLP",			/* Bit Position 23	*/
> +	"AtomicOpBlocked",		/* Bit Position 24	*/
> +	"TLPBlockedErr",		/* Bit Position 25	*/
>  };
>  
>  static const char *aer_agent_string[] = {
> @@ -203,6 +203,29 @@ void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info)
>  }
>  
>  #ifdef CONFIG_ACPI_APEI_PCIEAER
> +
> +#define MAX_PRINT_LENGTH		120
> +
> +void dev_print_bits(struct pci_dev *dev, unsigned int bits,
> +		    const char * const strs[], unsigned int strs_size)
> +{
> +	unsigned int i;
> +	char errs[MAX_PRINT_LENGTH];
> +
> +	errs[0] = '\0';
> +
> +	for (i = 0; i < strs_size; i++) {
> +		if (!(bits & (1U << i)))
> +			continue;
> +		if (strs[i]) {
> +			if (strlen(errs))
> +				strlcat(errs, ", ", MAX_PRINT_LENGTH);
> +			strlcat(errs, strs[i], MAX_PRINT_LENGTH);
> +		}
> +	}
> +	dev_err(&dev->dev, "%s\n", errs);
> +}
> +
>  int cper_severity_to_aer(int cper_severity)
>  {
>  	switch (cper_severity) {
> @@ -240,7 +263,7 @@ void cper_print_aer(struct pci_dev *dev, int aer_severity,
>  	agent = AER_GET_AGENT(aer_severity, status);
>  
>  	pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
> -	cper_print_bits("", status, status_strs, status_strs_size);
> +	dev_print_bits(dev, status, status_strs, status_strs_size);
>  	pci_err(dev, "aer_layer=%s, aer_agent=%s\n",
>  		aer_error_layer[layer], aer_agent_string[agent]);
>  
> -- 
> Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
> Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project.
> 
