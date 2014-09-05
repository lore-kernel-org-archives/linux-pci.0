Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:57356 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744AbaIEXPs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 5 Sep 2014 19:15:48 -0400
Received: by mail-pd0-f170.google.com with SMTP id r10so16696208pdi.29
        for <linux-pci@vger.kernel.org>; Fri, 05 Sep 2014 16:15:48 -0700 (PDT)
Date: Fri, 5 Sep 2014 17:15:43 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: "Chen, Gong" <gong.chen@linux.intel.com>
Cc: rdunlap@infradead.org, bp@alien8.de, tony.luck@intel.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND 2/5] PCIe, AER: Replenish missed AER status bits for AER
 driver
Message-ID: <20140905231543.GK8080@google.com>
References: <1407910961-7798-1-git-send-email-gong.chen@linux.intel.com>
 <1407910961-7798-3-git-send-email-gong.chen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1407910961-7798-3-git-send-email-gong.chen@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 13, 2014 at 02:22:38AM -0400, Chen, Gong wrote:
> Since commit 6c2b374d is commited, the capability of PCI-e AER
> has changed a lot. This patch adds all missed CE/UC error bits
> existed in PCI-e SPEC r3.0. Meanwhile, adjust the code format
> to make it simpler to read/maintain.
> 
> Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>
> ---
>  drivers/pci/pcie/aer/aerdrv_errprint.c | 60 ++++++++++++++--------------------
>  1 file changed, 25 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer/aerdrv_errprint.c b/drivers/pci/pcie/aer/aerdrv_errprint.c
> index 35d06e177917..5c4f7e252e5e 100644
> --- a/drivers/pci/pcie/aer/aerdrv_errprint.c
> +++ b/drivers/pci/pcie/aer/aerdrv_errprint.c
> @@ -75,44 +75,34 @@ static const char *aer_error_layer[] = {
>  };
>  
>  static const char *aer_correctable_error_string[] = {
> -	"Receiver Error",		/* Bit Position 0	*/
> -	NULL,
> -	NULL,
> -	NULL,
> -	NULL,
> -	NULL,
> -	"Bad TLP",			/* Bit Position 6	*/
> -	"Bad DLLP",			/* Bit Position 7	*/
> -	"RELAY_NUM Rollover",		/* Bit Position 8	*/
> -	NULL,
> -	NULL,
> -	NULL,
> -	"Replay Timer Timeout",		/* Bit Position 12	*/
> -	"Advisory Non-Fatal",		/* Bit Position 13	*/
> +	[0] = "Receiver Error",
> +	[6] = "Bad TLP",
> +	[7] = "Bad DLLP",
> +	[8] = "RELAY_NUM Rollover",
> +	[12] = "Replay Timer Timeout",
> +	[13] = "Advisory Non-Fatal Error",
> +	[14] = "Corrected Internal Error",
> +	[15] = "Header Log Overflow",

You replaced bare numbers with the existing #defines in the previous patch
(thank you), but now we're adding them here.  I'm pretty sure you can use
the #defines here, e.g.,

    [PCI_ERR_COR_RCVR] = "Receiver Error",

In fact, it would be really nice if you could figure out a way to have only
one set of these strings.  Right now, we have the set in
include/ras/ras_event.h, and then another set here in aerdrv_errprint.c,
and they contain exactly the same information.

Bjorn

>  };
>  
>  static const char *aer_uncorrectable_error_string[] = {
> -	NULL,
> -	NULL,
> -	NULL,
> -	NULL,
> -	"Data Link Protocol",		/* Bit Position 4	*/
> -	NULL,
> -	NULL,
> -	NULL,
> -	NULL,
> -	NULL,
> -	NULL,
> -	NULL,
> -	"Poisoned TLP",			/* Bit Position 12	*/
> -	"Flow Control Protocol",	/* Bit Position 13	*/
> -	"Completion Timeout",		/* Bit Position 14	*/
> -	"Completer Abort",		/* Bit Position 15	*/
> -	"Unexpected Completion",	/* Bit Position 16	*/
> -	"Receiver Overflow",		/* Bit Position 17	*/
> -	"Malformed TLP",		/* Bit Position 18	*/
> -	"ECRC",				/* Bit Position 19	*/
> -	"Unsupported Request",		/* Bit Position 20	*/
> +	[0] = "Undefined",
> +	[4] = "Data Link Protocol Error",
> +	[5] = "Surprise Down Error",
> +	[12] = "Poisoned TLP",
> +	[13] = "Flow Control Protocol Error",
> +	[14] = "Completion Timeout",
> +	[15] = "Completer Abort",
> +	[16] = "Unexpected Completion",
> +	[17] = "Receiver Overflow",
> +	[18] = "Malformed TLP",
> +	[19] = "ECRC Error",
> +	[20] = "Unsupported Request Error",
> +	[21] = "ACS Violation",
> +	[22] = "Uncorrectable Internal Error",
> +	[23] = "MC Blocked TLP",
> +	[24] = "AtomicOp Egress Blocked",
> +	[25] = "TLP Prefix Blocked Error",
>  };
>  
>  static const char *aer_agent_string[] = {
> -- 
> 2.0.0.rc2
> 
