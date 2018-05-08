Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751533AbeEHVHm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 May 2018 17:07:42 -0400
Date: Tue, 8 May 2018 17:07:39 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Thomas Tai <thomas.tai@oracle.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mr.nuke.me@gmail.com
Subject: Re: [PATCH V2] PCI/AER: add pcie TLP header information in the
 tracepoint
Message-ID: <20180508170739.1436c873@gandalf.local.home>
In-Reply-To: <1525809420-30576-2-git-send-email-thomas.tai@oracle.com>
References: <1525809420-30576-1-git-send-email-thomas.tai@oracle.com>
        <1525809420-30576-2-git-send-email-thomas.tai@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue,  8 May 2018 15:57:00 -0400
Thomas Tai <thomas.tai@oracle.com> wrote:

> When a PCIe AER occurs, the TLP header information is
> printed in the kernel message but it is missing from
> the tracepoint. A userspace program can use this information
> in the tracepoint to better analyze problems.
> 
> To enable the tracepoint:
> echo 1 > /sys/kernel/debug/tracing/events/ras/aer_event/enable
> 
> Example tracepoint output:
> cat /sys/kernel/debug/tracing/trace
> aer_event: 0000:01:00.0
> PCIe Bus Error: severity=Uncorrected, non-fatal, Completer Abort
> TLP Header={0x0,0x1,0x2,0x3}
> 
> Signed-off-by: Thomas Tai <thomas.tai@oracle.com>
> ---
>  drivers/pci/pcie/aer/aerdrv_errprint.c |  4 ++--
>  include/ras/ras_event.h                | 22 ++++++++++++++++++----
>  2 files changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer/aerdrv_errprint.c b/drivers/pci/pcie/aer/aerdrv_errprint.c
> index cfc89dd..fd49a8d 100644
> --- a/drivers/pci/pcie/aer/aerdrv_errprint.c
> +++ b/drivers/pci/pcie/aer/aerdrv_errprint.c
> @@ -189,7 +189,7 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>  		pci_err(dev, "  Error of this Agent(%04x) is reported first\n", id);
>  
>  	trace_aer_event(dev_name(&dev->dev), (info->status & ~info->mask),
> -			info->severity);
> +			info->severity, info->tlp_header_valid, &info->tlp);
>  }
>  
>  void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info)
> @@ -249,6 +249,6 @@ void cper_print_aer(struct pci_dev *dev, int aer_severity,
>  		__print_tlp_header(dev, &aer->header_log);
>  
>  	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
> -			aer_severity);
> +			aer_severity, tlp_header_valid, &aer->header_log);
>  }
>  #endif
> diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
> index 9c68986..f73b168 100644
> --- a/include/ras/ras_event.h
> +++ b/include/ras/ras_event.h
> @@ -298,30 +298,44 @@
>  TRACE_EVENT(aer_event,
>  	TP_PROTO(const char *dev_name,
>  		 const u32 status,
> -		 const u8 severity),
> +		 const u8 severity,
> +		 const u8 tlp_header_valid,
> +		 struct aer_header_log_regs *tlp),
>  
> -	TP_ARGS(dev_name, status, severity),
> +	TP_ARGS(dev_name, status, severity, tlp_header_valid, tlp),
>  
>  	TP_STRUCT__entry(
>  		__string(	dev_name,	dev_name	)
>  		__field(	u32,		status		)
>  		__field(	u8,		severity	)
> +		__field(	u8, 		tlp_header_valid)
> +		__array(	u32, 		tlp_header, 4	)
>  	),
>  
>  	TP_fast_assign(
>  		__assign_str(dev_name, dev_name);
>  		__entry->status		= status;
>  		__entry->severity	= severity;
> +		__entry->tlp_header_valid = tlp_header_valid;
> +		if (__entry->tlp_header_valid) {

Although the compiler will probably optimize it anyway, but you
probably should have it be:

		if (tlp_header_valid) {

because why add the extra dereference.

> +			__entry->tlp_header[0] = tlp->dw0;
> +			__entry->tlp_header[1] = tlp->dw1;
> +			__entry->tlp_header[2] = tlp->dw2;
> +			__entry->tlp_header[3] = tlp->dw3;
> +		}
>  	),
>  
> -	TP_printk("%s PCIe Bus Error: severity=%s, %s\n",
> +	TP_printk("%s PCIe Bus Error: severity=%s, %s, TLP Header=%s\n",
>  		__get_str(dev_name),
>  		__entry->severity == AER_CORRECTABLE ? "Corrected" :
>  			__entry->severity == AER_FATAL ?
>  			"Fatal" : "Uncorrected, non-fatal",
>  		__entry->severity == AER_CORRECTABLE ?
>  		__print_flags(__entry->status, "|", aer_correctable_errors) :
> -		__print_flags(__entry->status, "|", aer_uncorrectable_errors))
> +		__print_flags(__entry->status, "|", aer_uncorrectable_errors),
> +		__entry->tlp_header_valid ?
> +			__print_array(__entry->tlp_header, 4, 4) :
> +			"Not available")

The rest looks fine to me.

-- Steve

>  );
>  
>  /*
