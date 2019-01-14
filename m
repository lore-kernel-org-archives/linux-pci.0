Return-Path: <SRS0=hqs4=PW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACBCC43387
	for <linux-pci@archiver.kernel.org>; Mon, 14 Jan 2019 11:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F0372086D
	for <linux-pci@archiver.kernel.org>; Mon, 14 Jan 2019 11:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="B5J2We1j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfANLmr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 14 Jan 2019 06:42:47 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:38684 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbfANLmr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Jan 2019 06:42:47 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 9317624E0F81;
        Mon, 14 Jan 2019 03:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1547466167; bh=tjyI30pq+gRxRfGgJFK8IsypcHtuZc1SmD/n1cUr3EQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=B5J2We1jSX1Am5t7x7p5W8TKKzg89MpIwwMSee6Ir0g7iLediHeEa+Ku5bSW8FXJM
         iDASeEpvLLm4WquoaIozi8ORkp26FFIbl8Uk6puqezadC6byDXln9oSNEvbaWXBPrT
         JK8dplSXzXIpeRWDzvl1QfVZ8XpZONOJYYUqMoLnyaXoR0jZTT1tLm+H0uwP3C3bYH
         VXVYfVLI3CzppDd9dAzK0ntzGcjMYtL798SW+xZ30B8226a/57UIzfA4YKlWWw/8fP
         bAV7YCpEozw5ppC0N+/hslcH2C+3KOp15WR+cLhv6JSTPUUXbp+yu2MJqkHDCWqllx
         Btn6qDcUbML9g==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2-vip.internal.synopsys.com [10.12.239.238])
        by mailhost.synopsys.com (Postfix) with ESMTP id D4294574E;
        Mon, 14 Jan 2019 03:42:45 -0800 (PST)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 14 Jan 2019 03:42:45 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 14 Jan 2019 12:42:43 +0100
Received: from [10.107.25.131] (10.107.25.131) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 14 Jan 2019 12:42:43 +0100
Subject: Re: [RFC v3 5/7] dmaengine: Add Synopsys eDMA IP PCIe glue-logic
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
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
References: <cover.1547230339.git.gustavo.pimentel@synopsys.com>
 <a70d096e96f34cd9ea773da519965076d74d12ec.1547230339.git.gustavo.pimentel@synopsys.com>
 <20190111194705.GU9170@smile.fi.intel.com>
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <916f319b-9e45-6d78-4ecc-850feda84bb3@synopsys.com>
Date:   Mon, 14 Jan 2019 11:38:02 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190111194705.GU9170@smile.fi.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.25.131]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/01/2019 19:47, Andy Shevchenko wrote:
> On Fri, Jan 11, 2019 at 07:33:41PM +0100, Gustavo Pimentel wrote:
>> Synopsys eDMA IP is normally distributed along with Synopsys PCIe
>> EndPoint IP (depends of the use and licensing agreement).
>>
>> This IP requires some basic configurations, such as:
>>  - eDMA registers BAR
>>  - eDMA registers offset
>>  - eDMA registers size
>>  - eDMA linked list memory BAR
>>  - eDMA linked list memory offset
>>  - eDMA linked list memory sze
>>  - eDMA data memory BAR
>>  - eDMA data memory offset
>>  - eDMA data memory size
>>  - eDMA version
>>  - eDMA mode
>>  - IRQs available for eDMA
>>
>> As a working example, PCIe glue-logic will attach to a Synopsys PCIe
>> EndPoint IP prototype kit (Vendor ID = 0x16c3, Device ID = 0xedda),
>> which has built-in an eDMA IP with this default configuration:
>>  - eDMA registers BAR = 0
>>  - eDMA registers offset = 0x00001000 (4 Kbytes)
>>  - eDMA registers size = 0x00002000 (8 Kbytes)
>>  - eDMA linked list memory BAR = 2
>>  - eDMA linked list memory offset = 0x00000000 (0 Kbytes)
>>  - eDMA linked list memory size = 0x00800000 (8 Mbytes)
>>  - eDMA data memory BAR = 2
>>  - eDMA data memory offset = 0x00800000 (8 Mbytes)
>>  - eDMA data memory size = 0x03800000 (56 Mbytes)
>>  - eDMA version = 0
>>  - eDMA mode = EDMA_MODE_UNROLL
>>  - IRQs = 1
>>
>> This driver can be compile as built-in or external module in kernel.
>>
>> To enable this driver just select DW_EDMA_PCIE option in kernel
>> configuration, however it requires and selects automatically DW_EDMA
>> option too.
>>
> 
>> Changes:
>> RFC v1->RFC v2:
> 
> Changes go after '--- ' line.

At the last Linux Plumbers Conference there were some subsystem maintainers who
asked that the track changes be included in the description as a way to not lose
the previous work done. That why I put it before the '---' line, but it's
indifferent to me, I can put it after the '---' line.

> 
>>  - Replace comments // (C99 style) by /**/
>>  - Merge two pcim_iomap_regions() calls into just one call
>>  - Remove pci_try_set_mwi() call
>>  - Replace some dev_info() by dev_dbg() to reduce *noise*
>>  - Remove pci_name(pdev) call after being call dw_edma_remove()
>>  - Remove all power management support
>>  - Fix the headers of the .c and .h files according to the most recent
>>    convention
>>  - Fix errors and checks pointed out by checkpatch with --strict option
>>  - Replace patch small description tag from dma by dmaengine
>> RFC v2->RFC v3:
>>  - Fix printk variable of phys_addr_t type
>>  - Fix missing variable initialization (chan->configured)
>>  - Change linked list size to 512 Kbytes
>>  - Add data memory information
>>  - Add register size information
>>  - Add comments or improve existing ones
>>  - Add possibility to work with multiple IRQs feature
>>  - Replace MSI and MSI-X enable condition by pci_dev_msi_enabled()
>>  - Replace code to acquire MSI(-X) address and data by
>>    get_cached_msi_msg()
> 
>> +enum dw_edma_pcie_bar {
>> +	BAR_0,
>> +	BAR_1,
>> +	BAR_2,
>> +	BAR_3,
>> +	BAR_4,
>> +	BAR_5
>> +};
> 
> pci-epf.h has this.
> Why duplicate?

I can use that header sure. Thanks.

> 
> 
> What else is being duplicated from PCI core?
> 
>> +static bool disable_msix;
>> +module_param(disable_msix, bool, 0644);
>> +MODULE_PARM_DESC(disable_msix, "Disable MSI-X interrupts");
> 
> Why?!
> We are no allow new module parameters without very strong arguments.

Since this is a reference driver and might be used to test customized HW
solutions, I added this parameter to allow the possibility to test the solution
forcing the MSI feature binding. This is required specially if who will test
this solution has a Root Complex with both features available (MSI and MSI-X),
because the Kernel will give always preference to MSI-X binding (assuming that
the EP has also both features available).

> 
>> +
>> +static int dw_edma_pcie_probe(struct pci_dev *pdev,
>> +			      const struct pci_device_id *pid)
>> +{
>> +	const struct dw_edma_pcie_data *pdata = (void *)pid->driver_data;
>> +	struct device *dev = &pdev->dev;
>> +	struct dw_edma_chip *chip;
>> +	struct dw_edma *dw;
>> +	unsigned int irq_flags = PCI_IRQ_MSI;
>> +	int err, nr_irqs, i;
>> +
> 
>> +	if (!pdata) {
>> +		dev_err(dev, "%s missing data structure\n", pci_name(pdev));
>> +		return -EFAULT;
>> +	}
> 
> Useless check.

Why? It's just a precaution, isn't it a good practice always to think of the
worst case?

> 
>> +
>> +	/* Enable PCI device */
>> +	err = pcim_enable_device(pdev);
>> +	if (err) {
>> +		dev_err(dev, "%s enabling device failed\n", pci_name(pdev));
>> +		return err;
>> +	}
>> +
>> +	/* Mapping PCI BAR regions */
>> +	err = pcim_iomap_regions(pdev, BIT(pdata->rg_bar) |
>> +				       BIT(pdata->ll_bar) |
>> +				       BIT(pdata->dt_bar),
>> +				 pci_name(pdev));
>> +	if (err) {
> 
>> +		dev_err(dev, "%s eDMA BAR I/O remapping failed\n",
>> +			pci_name(pdev));
> 
> Isn't it pci_err() ?
> Same comment for the rest similar cases above and below.

Ok, I'll replace all dev_* function in this file.
Thanks.

> 
>> +		return err;
>> +	}
>> +
>> +	pci_set_master(pdev);
>> +
>> +	nr_irqs = pci_alloc_irq_vectors(pdev, 1, pdata->irqs_cnt, irq_flags);
>> +	if (nr_irqs < 1) {
>> +		dev_err(dev, "%s failed to alloc IRQ vector (Number of IRQs=%u)\n",
>> +			pci_name(pdev), nr_irqs);
>> +		return -EPERM;
>> +	}
>> +
>> +	/* Data structure initialization */
>> +	chip->dw = dw;
>> +	chip->dev = dev;
>> +	chip->id = pdev->devfn;
>> +	chip->irq = pdev->irq;
>> +
> 
>> +	if (!pcim_iomap_table(pdev))
>> +		return -EACCES;
> 
> Never happen condition. Thus useless.

pcim_iomap_table() can return NULL in case of allocation failure. Besides that,
isn't it a good practice always to think of the worst case?

> 
>> +	dev_info(dev, "DesignWare eDMA PCIe driver loaded completely\n");
> 
> Useless.

It's helpful for bring up, I can pass it to dbg.

> 
>> +}
>> +
>> +static void dw_edma_pcie_remove(struct pci_dev *pdev)
>> +{
>> +	struct dw_edma_chip *chip = pci_get_drvdata(pdev);
>> +	struct device *dev = &pdev->dev;
>> +	int err;
>> +
>> +	/* Stopping eDMA driver */
>> +	err = dw_edma_remove(chip);
>> +	if (err)
>> +		dev_warn(dev, "can't remove device properly: %d\n", err);
>> +
>> +	/* Freeing IRQs */
>> +	pci_free_irq_vectors(pdev);
>> +
>> +	dev_info(dev, "DesignWare eDMA PCIe driver unloaded completely\n");
> 
> Ditto.

It's helpful for bring up, I can pass it to dbg.

> 
>> +}
> 
>> +MODULE_DEVICE_TABLE(pci, dw_edma_pcie_id_table);
>> +
>> +static struct pci_driver dw_edma_pcie_driver = {
>> +	.name		= "dw-edma-pcie",
>> +	.id_table	= dw_edma_pcie_id_table,
>> +	.probe		= dw_edma_pcie_probe,
>> +	.remove		= dw_edma_pcie_remove,
> 
> Power management?

I've removed the power management for now, since with my current setup I don't
have the necessary conditions to test it. I prefer not submitting that code for now.

> 
>> +};
> 

Thanks for the inputs Andy! They have been pretty good!

Regards,
Gustavo
