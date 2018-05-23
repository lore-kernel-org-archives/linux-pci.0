Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:20767 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932564AbeEWOYP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 May 2018 10:24:15 -0400
Subject: Re: [PATCH 1/5] PCI/AER: Define and allocate aer_stats structure for
 AER capable devices
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
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Thomas Tai <thomas.tai@oracle.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Kyle McMartin <jkkm@fb.com>
CC: <rajatxjain@gmail.com>
References: <20180522222805.80314-1-rajatja@google.com>
 <20180522222805.80314-2-rajatja@google.com>
From: Jes Sorensen <jsorensen@fb.com>
Message-ID: <62fae8eb-aaed-65b2-19ad-7c57b3a9bfdc@fb.com>
Date: Wed, 23 May 2018 10:20:10 -0400
MIME-Version: 1.0
In-Reply-To: <20180522222805.80314-2-rajatja@google.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/22/2018 06:28 PM, Rajat Jain wrote:
> Define a structure to hold the AER statistics. There are 2 groups
> of statistics: dev_* counters that are to be collected for all AER
> capable devices and rootport_* counters that are collected for all
> (AER capable) rootports only. Allocate and free this structure when
> device is added or released (thus counters survive the lifetime of the
> device).
> 
> Add a new file aerdrv_stats.c to hold the AER stats collection logic.
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
>  drivers/pci/pcie/aer/Makefile       |  2 +-
>  drivers/pci/pcie/aer/aerdrv.h       |  6 +++
>  drivers/pci/pcie/aer/aerdrv_core.c  |  9 ++++
>  drivers/pci/pcie/aer/aerdrv_stats.c | 64 +++++++++++++++++++++++++++++
>  drivers/pci/probe.c                 |  1 +
>  include/linux/pci.h                 |  3 ++
>  6 files changed, 84 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/pci/pcie/aer/aerdrv_stats.c
> 
> diff --git a/drivers/pci/pcie/aer/Makefile b/drivers/pci/pcie/aer/Makefile
>  
> -aerdriver-objs := aerdrv_errprint.o aerdrv_core.o aerdrv.o
> +aerdriver-objs := aerdrv_errprint.o aerdrv_core.o aerdrv.o aerdrv_stats.o
>  aerdriver-$(CONFIG_ACPI) += aerdrv_acpi.o
>  
>  obj-$(CONFIG_PCIEAER_INJECT) += aer_inject.o
> diff --git a/drivers/pci/pcie/aer/aerdrv.h b/drivers/pci/pcie/aer/aerdrv.h
> index b4c950683cc7..d8b9fba536ed 100644
> --- a/drivers/pci/pcie/aer/aerdrv.h
> +++ b/drivers/pci/pcie/aer/aerdrv.h
> @@ -33,6 +33,10 @@
>  					PCI_ERR_UNC_MALF_TLP)
>  
>  #define AER_MAX_MULTI_ERR_DEVICES	5	/* Not likely to have more */
> +
> +#define AER_MAX_TYPEOF_CORRECTABLE_ERRS 16	/* as per PCI_ERR_COR_STATUS */
> +#define AER_MAX_TYPEOF_UNCORRECTABLE_ERRS 26	/* as per PCI_ERR_UNCOR_STATUS*/
> +
>  struct aer_err_info {
>  	struct pci_dev *dev[AER_MAX_MULTI_ERR_DEVICES];
>  	int error_dev_num;
> @@ -81,6 +85,8 @@ void aer_isr(struct work_struct *work);
>  void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
>  void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info);
>  irqreturn_t aer_irq(int irq, void *context);
> +int pci_aer_stats_init(struct pci_dev *pdev);
> +void pci_aer_stats_exit(struct pci_dev *pdev);
>  
>  #ifdef CONFIG_ACPI_APEI
>  int pcie_aer_get_firmware_first(struct pci_dev *pci_dev);
> diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
> index 36e622d35c48..42a6f913069a 100644
> --- a/drivers/pci/pcie/aer/aerdrv_core.c
> +++ b/drivers/pci/pcie/aer/aerdrv_core.c
> @@ -95,9 +95,18 @@ int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
>  int pci_aer_init(struct pci_dev *dev)
>  {
>  	dev->aer_cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
> +
> +	if (!dev->aer_cap || pci_aer_stats_init(dev))
> +		return -EIO;
> +
>  	return pci_cleanup_aer_error_status_regs(dev);
>  }
>  
> +void pci_aer_exit(struct pci_dev *dev)
> +{
> +	pci_aer_stats_exit(dev);
> +}
> +
>  /**
>   * add_error_device - list device to be handled
>   * @e_info: pointer to error info
> diff --git a/drivers/pci/pcie/aer/aerdrv_stats.c b/drivers/pci/pcie/aer/aerdrv_stats.c
> new file mode 100644
> index 000000000000..b9f251992209
> --- /dev/null
> +++ b/drivers/pci/pcie/aer/aerdrv_stats.c
> @@ -0,0 +1,64 @@
> +// SPDX-License-Identifier: GPL-2.0

Fix the formatting please - that gross // gibberish doesn't belong there.

Jes
