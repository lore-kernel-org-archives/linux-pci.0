Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <1354240427.6276.134.camel@gandalf.local.home>
Subject: Re: [PATCH 2/3] aerdrv: Enhanced AER logging
From: Steven Rostedt <rostedt@goodmis.org>
To: Lance Ortiz <lance.ortiz@hp.com>
Cc: bhelgaas@google.com, lance_ortiz@hotmail.com, jiang.liu@huawei.com,
	tony.luck@intel.com, bp@alien8.de, mchehab@redhat.com,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Date: Thu, 29 Nov 2012 20:53:47 -0500
In-Reply-To: <20121129215450.5483.26562.stgit@grignak.americas.hpqcorp.net>
References: <20121129215443.5483.43364.stgit@grignak.americas.hpqcorp.net>
	 <20121129215450.5483.26562.stgit@grignak.americas.hpqcorp.net>
Content-Type: text/plain; charset="ISO-8859-15"
Mime-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2012-11-29 at 14:54 -0700, Lance Ortiz wrote:

> --- a/drivers/pci/pcie/aer/aerdrv_errprint.c
> +++ b/drivers/pci/pcie/aer/aerdrv_errprint.c
> @@ -23,6 +23,10 @@
>  
>  #include "aerdrv.h"
>  
> +#define CREATE_TRACE_POINTS
> +#define TRACE_INCLUDE_PATH ../../../../include/ras
> +#include <ras/aer_event.h>
> +

Yuck yuck yuck!

This header should be in the same directory, and you should have in that
same header:

#undef TRACE_INCLUDE_PATH
#define TRACE_INCLUDE_PATH .

and remove the definition here.

-- Steve

>  #define AER_AGENT_RECEIVER		0
>  #define AER_AGENT_REQUESTER		1
>  #define AER_AGENT_COMPLETER		2
> @@ -194,6 +198,8 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>  	if (info->id && info->error_dev_num > 1 && info->id == id)
>  		printk("%s""  Error of this Agent(%04x) is reported first\n",
>  			prefix, id);
> +	trace_aer_event(dev_name(&dev->dev), (info->status & ~info->mask),
> +			info->severity);
>  }
>  


