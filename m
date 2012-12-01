Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Sat, 1 Dec 2012 16:56:40 +0100
From: Borislav Petkov <bp@alien8.de>
To: Lance Ortiz <lance.ortiz@hp.com>
Cc: bhelgaas@google.com, lance_ortiz@hotmail.com, jiang.liu@huawei.com,
	tony.luck@intel.com, rostedt@goodmis.org, mchehab@redhat.com,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] aerdrv: Cleanup log output for CPER based AER
Message-ID: <20121201155640.GB12274@liondog.tnic>
References: <20121130213330.7649.51101.stgit@grignak.americas.hpqcorp.net>
 <20121130213343.7649.49461.stgit@grignak.americas.hpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20121130213343.7649.49461.stgit@grignak.americas.hpqcorp.net>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 30, 2012 at 02:33:44PM -0700, Lance Ortiz wrote:
> These changes make cper_print_aer more consistent with aer_print_error
> which is called in the AER interrupt case. The string in the variable
> 'prefix' is printed at the beginning of each print statement in
> cper_print_aer(). The prefix is a string containing the driver name
> and the device's path.  Looking up the call path, the value of prefix
> is never assigned and is NULL, so when cper_print_aer prints data the
> initial string does not get printed.  This string is important because
> it identifies the device that the error is on. This patch adds code to
> create the prefix and print it in the cper_print_aer function. This
> patch also calculates the device's agent id so it can be printed.
> 
> v1-v2 fix some compile errors withinn the #ifdef
> 
> Signed-off-by: Lance Ortiz <lance.ortiz@hp.com>
> ---
> 
>  drivers/pci/pcie/aer/aerdrv_errprint.c |   12 +++++++++---
>  1 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer/aerdrv_errprint.c b/drivers/pci/pcie/aer/aerdrv_errprint.c
> index 34d96e4..5050891 100644
> --- a/drivers/pci/pcie/aer/aerdrv_errprint.c
> +++ b/drivers/pci/pcie/aer/aerdrv_errprint.c
> @@ -228,9 +228,15 @@ void cper_print_aer(struct pci_dev *dev, int cper_severity,
>  	int aer_severity, layer, agent, status_strs_size, tlp_header_valid = 0;
>  	u32 status, mask;
>  	const char **status_strs;
> -	char *prefix = NULL;
> +	int id = ((dev->bus->number << 8) | dev->devfn);
> +	char prefix[44];
>  
>  	aer_severity = cper_severity_to_aer(cper_severity);
> +	snprintf(prefix, sizeof(prefix), "%s%s %s: ",
> +		(aer_severity == AER_CORRECTABLE) ?
> +		KERN_WARNING : KERN_ERR,
> +		dev_driver_string(&dev->dev), dev_name(&dev->dev));
> +
>  	if (aer_severity == AER_CORRECTABLE) {
>  		status = aer->cor_status;
>  		mask = aer->cor_mask;
> @@ -248,8 +254,8 @@ void cper_print_aer(struct pci_dev *dev, int cper_severity,
>  	printk("%s""aer_status: 0x%08x, aer_mask: 0x%08x\n",
>  	       prefix, status, mask);
>  	cper_print_bits(prefix, status, status_strs, status_strs_size);
> -	printk("%s""aer_layer=%s, aer_agent=%s\n", prefix,
> -	       aer_error_layer[layer], aer_agent_string[agent]);
> +	printk("%s""aer_layer=%s, id=%04x(%s)\n", prefix,

Why change "aer_agent" to "id" here? IMO, the first is much more
descriptive and besides, aer_agent_string's members all have "ID" in the
name.

But most importantly, changing printk output like that potentially
breaks userspace scripts which parse such output.

Thanks.

-- 
Regards/Gruss,
    Boris.
