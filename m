Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754353AbeEWI0B (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 May 2018 04:26:01 -0400
Date: Wed, 23 May 2018 10:25:41 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rajat Jain <rajatja@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederick Lawler <fred@fredlawl.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Thomas Tai <thomas.tai@oracle.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jes Sorensen <jsorensen@fb.com>,
        Kyle McMartin <jkkm@fb.com>, rajatxjain@gmail.com,
        Rajat Jain <rajatj@google.com>
Subject: Re: [PATCH 3/5] PCP/AER: Add sysfs attributes to provide breakdown
 of AERs
Message-ID: <20180523082541.GF7247@kroah.com>
References: <20180522222805.80314-1-rajatja@google.com>
 <20180522222805.80314-4-rajatja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180522222805.80314-4-rajatja@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 22, 2018 at 03:28:03PM -0700, Rajat Jain wrote:
> Add sysfs attributes to provide breakdown of the AERs seen,
> into different type of correctable or uncorrectable errors:
> 
> dev_breakdown_correctable
> dev_breakdown_uncorrectable
> 
> Signed-off-by: Rajat Jain <rajatj@google.com>
> ---
>  drivers/pci/pcie/aer/aerdrv.h          |  6 ++++++
>  drivers/pci/pcie/aer/aerdrv_errprint.c |  6 ++++--
>  drivers/pci/pcie/aer/aerdrv_stats.c    | 25 +++++++++++++++++++++++++
>  3 files changed, 35 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer/aerdrv.h b/drivers/pci/pcie/aer/aerdrv.h
> index b5d5ad6f2c03..048fbd7c9633 100644
> --- a/drivers/pci/pcie/aer/aerdrv.h
> +++ b/drivers/pci/pcie/aer/aerdrv.h
> @@ -89,6 +89,12 @@ int pci_aer_stats_init(struct pci_dev *pdev);
>  void pci_aer_stats_exit(struct pci_dev *pdev);
>  void pci_dev_aer_stats_incr(struct pci_dev *pdev, struct aer_err_info *info);
>  
> +extern const char
> +*aer_correctable_error_string[AER_MAX_TYPEOF_CORRECTABLE_ERRS];
> +
> +extern const char
> +*aer_uncorrectable_error_string[AER_MAX_TYPEOF_UNCORRECTABLE_ERRS];
> +
>  #ifdef CONFIG_ACPI_APEI
>  int pcie_aer_get_firmware_first(struct pci_dev *pci_dev);
>  #else
> diff --git a/drivers/pci/pcie/aer/aerdrv_errprint.c b/drivers/pci/pcie/aer/aerdrv_errprint.c
> index 5e8b98deda08..5585f309f1a8 100644
> --- a/drivers/pci/pcie/aer/aerdrv_errprint.c
> +++ b/drivers/pci/pcie/aer/aerdrv_errprint.c
> @@ -68,7 +68,8 @@ static const char *aer_error_layer[] = {
>  	"Transaction Layer"
>  };
>  
> -static const char *aer_correctable_error_string[] = {
> +const char
> +*aer_correctable_error_string[AER_MAX_TYPEOF_CORRECTABLE_ERRS] = {
>  	"Receiver Error",		/* Bit Position 0	*/
>  	NULL,
>  	NULL,
> @@ -87,7 +88,8 @@ static const char *aer_correctable_error_string[] = {
>  	"Header Log Overflow",		/* Bit Position 15	*/
>  };
>  
> -static const char *aer_uncorrectable_error_string[] = {
> +const char
> +*aer_uncorrectable_error_string[AER_MAX_TYPEOF_UNCORRECTABLE_ERRS] = {
>  	"Undefined",			/* Bit Position 0	*/
>  	NULL,
>  	NULL,
> diff --git a/drivers/pci/pcie/aer/aerdrv_stats.c b/drivers/pci/pcie/aer/aerdrv_stats.c
> index 87b7119d0a86..5f0a6e144f56 100644
> --- a/drivers/pci/pcie/aer/aerdrv_stats.c
> +++ b/drivers/pci/pcie/aer/aerdrv_stats.c
> @@ -61,10 +61,35 @@ aer_stats_aggregate_attr(dev_total_cor_errs);
>  aer_stats_aggregate_attr(dev_total_fatal_errs);
>  aer_stats_aggregate_attr(dev_total_nonfatal_errs);
>  
> +#define aer_stats_breakdown_attr(field, stats_array, strings_array)            \
> +	static ssize_t                                                         \
> +	field##_show(struct device *dev, struct device_attribute *attr,        \
> +		     char *buf)                                                \
> +{                                                                              \
> +	unsigned int i;                                                        \
> +	char *str = buf;                                                       \
> +	struct pci_dev *pdev = to_pci_dev(dev);                                \
> +	u64 *stats = pdev->aer_stats->stats_array;                             \
> +	for (i = 0; i < ARRAY_SIZE(strings_array); i++) {                      \
> +		if (strings_array[i])                                          \
> +			str += sprintf(str, "%s = 0x%llx\n",                   \
> +				       strings_array[i], stats[i]);            \
> +	}                                                                      \
> +	return str-buf;                                                        \
> +}                                                                              \

Again with the tabs instead of spaces please.

thanks,

greg k-h
