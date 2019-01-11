Return-Path: <SRS0=/dOL=PT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B781C43387
	for <linux-pci@archiver.kernel.org>; Fri, 11 Jan 2019 19:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E50142084C
	for <linux-pci@archiver.kernel.org>; Fri, 11 Jan 2019 19:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388024AbfAKTxN (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 11 Jan 2019 14:53:13 -0500
Received: from mga12.intel.com ([192.55.52.136]:34943 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731874AbfAKTxM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Jan 2019 14:53:12 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jan 2019 11:47:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,466,1539673200"; 
   d="scan'208";a="125223936"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Jan 2019 11:47:06 -0800
Received: from andy by smile with local (Exim 4.92-RC4)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gi2ll-0002Z9-9T; Fri, 11 Jan 2019 21:47:05 +0200
Date:   Fri, 11 Jan 2019 21:47:05 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joao Pinto <joao.pinto@synopsys.com>,
        Jose Abreu <jose.abreu@synopsys.com>,
        Luis Oliveira <luis.oliveira@synopsys.com>,
        Vitor Soares <vitor.soares@synopsys.com>,
        Nelson Costa <nelson.costa@synopsys.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>
Subject: Re: [RFC v3 5/7] dmaengine: Add Synopsys eDMA IP PCIe glue-logic
Message-ID: <20190111194705.GU9170@smile.fi.intel.com>
References: <cover.1547230339.git.gustavo.pimentel@synopsys.com>
 <a70d096e96f34cd9ea773da519965076d74d12ec.1547230339.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a70d096e96f34cd9ea773da519965076d74d12ec.1547230339.git.gustavo.pimentel@synopsys.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 11, 2019 at 07:33:41PM +0100, Gustavo Pimentel wrote:
> Synopsys eDMA IP is normally distributed along with Synopsys PCIe
> EndPoint IP (depends of the use and licensing agreement).
> 
> This IP requires some basic configurations, such as:
>  - eDMA registers BAR
>  - eDMA registers offset
>  - eDMA registers size
>  - eDMA linked list memory BAR
>  - eDMA linked list memory offset
>  - eDMA linked list memory sze
>  - eDMA data memory BAR
>  - eDMA data memory offset
>  - eDMA data memory size
>  - eDMA version
>  - eDMA mode
>  - IRQs available for eDMA
> 
> As a working example, PCIe glue-logic will attach to a Synopsys PCIe
> EndPoint IP prototype kit (Vendor ID = 0x16c3, Device ID = 0xedda),
> which has built-in an eDMA IP with this default configuration:
>  - eDMA registers BAR = 0
>  - eDMA registers offset = 0x00001000 (4 Kbytes)
>  - eDMA registers size = 0x00002000 (8 Kbytes)
>  - eDMA linked list memory BAR = 2
>  - eDMA linked list memory offset = 0x00000000 (0 Kbytes)
>  - eDMA linked list memory size = 0x00800000 (8 Mbytes)
>  - eDMA data memory BAR = 2
>  - eDMA data memory offset = 0x00800000 (8 Mbytes)
>  - eDMA data memory size = 0x03800000 (56 Mbytes)
>  - eDMA version = 0
>  - eDMA mode = EDMA_MODE_UNROLL
>  - IRQs = 1
> 
> This driver can be compile as built-in or external module in kernel.
> 
> To enable this driver just select DW_EDMA_PCIE option in kernel
> configuration, however it requires and selects automatically DW_EDMA
> option too.
> 

> Changes:
> RFC v1->RFC v2:

Changes go after '--- ' line.

>  - Replace comments // (C99 style) by /**/
>  - Merge two pcim_iomap_regions() calls into just one call
>  - Remove pci_try_set_mwi() call
>  - Replace some dev_info() by dev_dbg() to reduce *noise*
>  - Remove pci_name(pdev) call after being call dw_edma_remove()
>  - Remove all power management support
>  - Fix the headers of the .c and .h files according to the most recent
>    convention
>  - Fix errors and checks pointed out by checkpatch with --strict option
>  - Replace patch small description tag from dma by dmaengine
> RFC v2->RFC v3:
>  - Fix printk variable of phys_addr_t type
>  - Fix missing variable initialization (chan->configured)
>  - Change linked list size to 512 Kbytes
>  - Add data memory information
>  - Add register size information
>  - Add comments or improve existing ones
>  - Add possibility to work with multiple IRQs feature
>  - Replace MSI and MSI-X enable condition by pci_dev_msi_enabled()
>  - Replace code to acquire MSI(-X) address and data by
>    get_cached_msi_msg()

> +enum dw_edma_pcie_bar {
> +	BAR_0,
> +	BAR_1,
> +	BAR_2,
> +	BAR_3,
> +	BAR_4,
> +	BAR_5
> +};

pci-epf.h has this.
Why duplicate?


What else is being duplicated from PCI core?

> +static bool disable_msix;
> +module_param(disable_msix, bool, 0644);
> +MODULE_PARM_DESC(disable_msix, "Disable MSI-X interrupts");

Why?!
We are no allow new module parameters without very strong arguments.

> +
> +static int dw_edma_pcie_probe(struct pci_dev *pdev,
> +			      const struct pci_device_id *pid)
> +{
> +	const struct dw_edma_pcie_data *pdata = (void *)pid->driver_data;
> +	struct device *dev = &pdev->dev;
> +	struct dw_edma_chip *chip;
> +	struct dw_edma *dw;
> +	unsigned int irq_flags = PCI_IRQ_MSI;
> +	int err, nr_irqs, i;
> +

> +	if (!pdata) {
> +		dev_err(dev, "%s missing data structure\n", pci_name(pdev));
> +		return -EFAULT;
> +	}

Useless check.

> +
> +	/* Enable PCI device */
> +	err = pcim_enable_device(pdev);
> +	if (err) {
> +		dev_err(dev, "%s enabling device failed\n", pci_name(pdev));
> +		return err;
> +	}
> +
> +	/* Mapping PCI BAR regions */
> +	err = pcim_iomap_regions(pdev, BIT(pdata->rg_bar) |
> +				       BIT(pdata->ll_bar) |
> +				       BIT(pdata->dt_bar),
> +				 pci_name(pdev));
> +	if (err) {

> +		dev_err(dev, "%s eDMA BAR I/O remapping failed\n",
> +			pci_name(pdev));

Isn't it pci_err() ?
Same comment for the rest similar cases above and below.

> +		return err;
> +	}
> +
> +	pci_set_master(pdev);
> +
> +	nr_irqs = pci_alloc_irq_vectors(pdev, 1, pdata->irqs_cnt, irq_flags);
> +	if (nr_irqs < 1) {
> +		dev_err(dev, "%s failed to alloc IRQ vector (Number of IRQs=%u)\n",
> +			pci_name(pdev), nr_irqs);
> +		return -EPERM;
> +	}
> +
> +	/* Data structure initialization */
> +	chip->dw = dw;
> +	chip->dev = dev;
> +	chip->id = pdev->devfn;
> +	chip->irq = pdev->irq;
> +

> +	if (!pcim_iomap_table(pdev))
> +		return -EACCES;

Never happen condition. Thus useless.

> +	dev_info(dev, "DesignWare eDMA PCIe driver loaded completely\n");

Useless.

> +}
> +
> +static void dw_edma_pcie_remove(struct pci_dev *pdev)
> +{
> +	struct dw_edma_chip *chip = pci_get_drvdata(pdev);
> +	struct device *dev = &pdev->dev;
> +	int err;
> +
> +	/* Stopping eDMA driver */
> +	err = dw_edma_remove(chip);
> +	if (err)
> +		dev_warn(dev, "can't remove device properly: %d\n", err);
> +
> +	/* Freeing IRQs */
> +	pci_free_irq_vectors(pdev);
> +
> +	dev_info(dev, "DesignWare eDMA PCIe driver unloaded completely\n");

Ditto.

> +}

> +MODULE_DEVICE_TABLE(pci, dw_edma_pcie_id_table);
> +
> +static struct pci_driver dw_edma_pcie_driver = {
> +	.name		= "dw-edma-pcie",
> +	.id_table	= dw_edma_pcie_id_table,
> +	.probe		= dw_edma_pcie_probe,
> +	.remove		= dw_edma_pcie_remove,

Power management?

> +};

-- 
With Best Regards,
Andy Shevchenko


