Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:36594 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753004AbeEVWuG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 May 2018 18:50:06 -0400
Subject: Re: [PATCH 2/5] PCI/AER: Add sysfs stats for AER capable devices
To: Rajat Jain <rajatja@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frederick Lawler <fred@fredlawl.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Thomas Tai <thomas.tai@oracle.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jes Sorensen <jsorensen@fb.com>,
        Kyle McMartin <jkkm@fb.com>
Cc: rajatxjain@gmail.com
References: <20180522222805.80314-1-rajatja@google.com>
 <20180522222805.80314-3-rajatja@google.com>
From: "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <dcbb2e92-722f-c178-efb7-8d99d4a9d99f@gmail.com>
Date: Tue, 22 May 2018 17:50:04 -0500
MIME-Version: 1.0
In-Reply-To: <20180522222805.80314-3-rajatja@google.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 05/22/2018 05:28 PM, Rajat Jain wrote:
> Add the following AER sysfs stats to represent the counters for each
> kind of error as seen by the device:
> 
> dev_total_cor_errs
> dev_total_fatal_errs
> dev_total_nonfatal_errs
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
>  drivers/pci/pci-sysfs.c                |  3 ++
>  drivers/pci/pci.h                      |  4 +-
>  drivers/pci/pcie/aer/aerdrv.h          |  1 +
>  drivers/pci/pcie/aer/aerdrv_errprint.c |  1 +
>  drivers/pci/pcie/aer/aerdrv_stats.c    | 72 ++++++++++++++++++++++++++
>  5 files changed, 80 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 366d93af051d..730f985a3dc9 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1743,6 +1743,9 @@ static const struct attribute_group *pci_dev_attr_groups[] = {
>  #endif
>  	&pci_bridge_attr_group,
>  	&pcie_dev_attr_group,
> +#ifdef CONFIG_PCIEAER
> +	&aer_stats_attr_group,
> +#endif
>  	NULL,
>  };

So if the device is removed as part of recovery, then these get reset,
right? So if the device fails intermittently, these counters would keep
getting reset. Is this the intent?

(snip)

>  /**
>   * pci_match_one_device - Tell if a PCI device structure has a matching
> diff --git a/drivers/pci/pcie/aer/aerdrv.h b/drivers/pci/pcie/aer/aerdrv.h
> index d8b9fba536ed..b5d5ad6f2c03 100644
> --- a/drivers/pci/pcie/aer/aerdrv.h
> +++ b/drivers/pci/pcie/aer/aerdrv.h
> @@ -87,6 +87,7 @@ void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info);
>  irqreturn_t aer_irq(int irq, void *context);
>  int pci_aer_stats_init(struct pci_dev *pdev);
>  void pci_aer_stats_exit(struct pci_dev *pdev);
> +void pci_dev_aer_stats_incr(struct pci_dev *pdev, struct aer_err_info *info);
>  
>  #ifdef CONFIG_ACPI_APEI
>  int pcie_aer_get_firmware_first(struct pci_dev *pci_dev);
> diff --git a/drivers/pci/pcie/aer/aerdrv_errprint.c b/drivers/pci/pcie/aer/aerdrv_errprint.c
> index 21ca5e1b0ded..5e8b98deda08 100644
> --- a/drivers/pci/pcie/aer/aerdrv_errprint.c
> +++ b/drivers/pci/pcie/aer/aerdrv_errprint.c
> @@ -155,6 +155,7 @@ static void __aer_print_error(struct pci_dev *dev,
>  			pci_err(dev, "   [%2d] Unknown Error Bit%s\n",
>  				i, info->first_error == i ? " (First)" : "");
>  	}
> +	pci_dev_aer_stats_incr(dev, info);

What about AER errors that are contained by DPC?

Alex
