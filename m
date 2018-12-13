Return-Path: <SRS0=IRPw=OW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_MIXED_ES autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D95C65BAE
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 14:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 592BD20870
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 14:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Nts+cdGC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 592BD20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbeLMOpH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 13 Dec 2018 09:45:07 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:35182 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbeLMOpH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Dec 2018 09:45:07 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 92A6724E242C;
        Thu, 13 Dec 2018 06:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1544712302; bh=/WTg4gORm1Rj4fR3wnjx4gvBYVn7XEzuSwS80xkJibc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=Nts+cdGCiLOlUuL2uU1uc6hncVS+2O+rFZrR0HBfAIeQ8fmZU74dpu2xt2siOh6wT
         jucXJU7KyVR+wK8MQpCbjbfCBWfIeAFZKCoP+kVObnvjFmrEL7FNuzyXb6Y653rIn/
         3zuwU09q8DcNnvrcIsP0Nz9x2Tnk8iVRrg9qgx4fHGJYnhV+L03VSZbrI/KW09d3iP
         3A6xid51y3KAvA0LUcF3Zk4dhjHQ4hmyakp5ZvKtVMfbRnrjyiS4jc0z8OB2eqLb9X
         4Gug3yU78hnSvgiT72pvTlkhtTBZ8NTYkNLT5ZSgnbnQiO4mHOzqrLnh0sIH8o8s3M
         KFnC//DnTlzVg==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id CFC1437FA;
        Thu, 13 Dec 2018 06:45:01 -0800 (PST)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 13 Dec 2018 06:45:01 -0800
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 13 Dec 2018 15:44:58 +0100
Received: from [10.107.25.131] (10.107.25.131) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 13 Dec 2018 15:44:58 +0100
Subject: Re: [RFC 4/6] dma: Add Synopsys eDMA IP PCIe glue-logic
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        Joao Pinto <joao.pinto@synopsys.com>
References: <cover.1544610287.git.gustavo.pimentel@synopsys.com>
 <b3cf38fc1cb81f9f14df96e2332e612e23ebf918.1544610287.git.gustavo.pimentel@synopsys.com>
 <20181212132528.GT10650@smile.fi.intel.com>
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <e77540c3-0715-667a-8494-2f442b347b06@synopsys.com>
Date:   Thu, 13 Dec 2018 14:40:40 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181212132528.GT10650@smile.fi.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.107.25.131]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 12/12/2018 13:25, Andy Shevchenko wrote:
> On Wed, Dec 12, 2018 at 12:13:24PM +0100, Gustavo Pimentel wrote:
>> Synopsys eDMA IP is normally distributed along with Synopsys PCIe
>> EndPoint IP (depends of the use and licensing agreement).
>>
>> This IP requires some basic configurations, such as:
>>  - eDMA registers BAR
>>  - eDMA registers offset
>>  - eDMA linked list BAR
>>  - eDMA linked list offset
>>  - eDMA linked list size
>>  - eDMA version
>>  - eDMA mode
>>
>> As a working example, PCIe glue-logic will attach to a Synopsys PCIe
>> EndPoint IP prototype kit (Vendor ID = 0x16c3, Device ID = 0xedda),
>> which has built-in an eDMA IP with this default configuration:
>>  - eDMA registers BAR = 0
>>  - eDMA registers offset = 0x1000 (4 Kbytes)
>>  - eDMA linked list BAR = 2
>>  - eDMA linked list offset = 0x0 (0 Kbytes)
>>  - eDMA linked list size = 0x20000 (128 Kbytes)
>>  - eDMA version = 0
>>  - eDMA mode = EDMA_MODE_UNROLL
>>
>> This driver can be compile as built-in or external module in kernel.
>>
>> To enable this driver just select DW_EDMA_PCIE option in kernel
>> configuration, however it requires and selects automatically DW_EDMA
>> option too.
> 
> It seems this driver somehow written as a copy-paste of existing pieces w/o good reasons to do such.

What do you mean? It's true I relied on existing drivers to develop this
solution, but is not it supposed to be so?

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
> Why do you need this at all?

See my answer below.

> 
>> +static const struct dw_edma_pcie_data snps_edda_data = {
>> +	// eDMA registers location
>> +	.regs_bar			= BAR_0,
>> +	.regs_off			= 0x1000,	//   4 KBytes
>> +	// eDMA memory linked list location
>> +	.ll_bar				= BAR_2,
>> +	.ll_off				= 0,		//   0 KBytes
>> +	.ll_sz				= 0x20000,	// 128 KBytes
>> +	// Other
>> +	.version			= 0,
>> +	.mode				= EDMA_MODE_UNROLL,
>> +};
> 
> Huh? Isn't this 

The eDMA is a hardware block (with requires some configuration) accessible
through a PCIe EndPoint, unfortunately there isn't any way for now (at least)
through an PCIe capability for instance to detect those configurations
automatically, therefore the only way to pass that configuration is to associate
it to PCIe Vendor(0x16c3) and Device (0xedda) Id.

To interact with eDMA hardware block the driver needs to access the eDMA
registers and the only way to do it is through PCIe mapping. In this those
registers will be available on BAR 0, with a offset of 4KB from the start.

The driver also requires a memory space (RAM) to create a linked list
descriptors and pass the first descriptor address to the eDMA hardware block so
that it can start performing the transfer autonomously. Once again this memory
space is provide through PCIe on BAR 2. This linked list space is in the
beginning and it's restricted to a size of 128KB.

Since this eDMA hardware block (more specifically eDMA registers) can evolve in
the future, I choosed to put here a version in order to have a driver that can
be easily adaptable and reusable without much effort.

> 
>> +
>> +static int dw_edma_pcie_probe(struct pci_dev *pdev,
>> +			      const struct pci_device_id *pid)
>> +{
>> +	const struct dw_edma_pcie_data *pdata = (void *)pid->driver_data;
>> +	struct device *dev = &pdev->dev;
>> +	struct dw_edma_chip *chip;
>> +	struct dw_edma *dw;
>> +	void __iomem *reg;
>> +	int err, irq = -1;
>> +	u32 addr_hi, addr_lo;
>> +	u16 flags;
>> +	u8 cap_off;
>> +
>> +	if (!pdata) {
>> +		dev_err(dev, "%s missing data struture\n",
>> +			pci_name(pdev));
>> +		return -EFAULT;
>> +	}
>> +
>> +	err = pcim_enable_device(pdev);
>> +	if (err) {
>> +		dev_err(dev, "%s enabling device failed\n",
>> +			pci_name(pdev));
>> +		return err;
>> +	}
>> +
> 
>> +	err = pcim_iomap_regions(pdev, 1 << pdata->regs_bar, pci_name(pdev));
>> +	if (err) {
>> +		dev_err(dev, "%s eDMA register BAR I/O memory remapping failed\n",
>> +			pci_name(pdev));
>> +		return err;
>> +	}
>> +
>> +	err = pcim_iomap_regions(pdev, 1 << pdata->ll_bar, pci_name(pdev));
>> +	if (err) {
>> +		dev_err(dev, "%s eDMA linked list BAR I/O remapping failed\n",
>> +			pci_name(pdev));
>> +		return err;
>> +	}
> 
> This could be done in one call.

Yes, that's true. I will change that.

> 
>> +
>> +	pci_set_master(pdev);
>> +
> 
>> +	err = pci_try_set_mwi(pdev);
>> +	if (err) {
>> +		dev_err(dev, "%s DMA memory write invalidate\n",
>> +			pci_name(pdev));
>> +		return err;
>> +	}
> 
> Are you sure you need this?

I'm not sure, probably not. I saw using this being use on /dma/dw/pci.c driver.
I'll test without it.

> 
>> +
>> +	err = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
>> +	if (err) {
>> +		dev_err(dev, "%s DMA mask set failed\n",
>> +			pci_name(pdev));
>> +		return err;
>> +	}
>> +
>> +	err = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
>> +	if (err) {
>> +		dev_err(dev, "%s consistent DMA mask set failed\n",
>> +			pci_name(pdev));
>> +		return err;
>> +	}
>> +
>> +	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
>> +	if (!chip)
>> +		return -ENOMEM;
>> +
>> +	dw = devm_kzalloc(&pdev->dev, sizeof(*dw), GFP_KERNEL);
>> +	if (!dw)
>> +		return -ENOMEM;
>> +
>> +	irq = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSI | PCI_IRQ_MSIX);
>> +	if (irq < 0) {
>> +		dev_err(dev, "%s failed to alloc IRQ vector\n",
>> +			pci_name(pdev));
>> +		return -EPERM;
>> +	}
>> +
>> +	chip->dw = dw;
>> +	chip->dev = dev;
>> +	chip->id = pdev->devfn;
>> +	chip->irq = pdev->irq;
>> +
>> +	dw->regs = pcim_iomap_table(pdev)[pdata->regs_bar];
>> +	dw->regs += pdata->regs_off;
>> +
>> +	dw->va_ll = pcim_iomap_table(pdev)[pdata->ll_bar];
>> +	dw->va_ll += pdata->ll_off;
>> +	dw->pa_ll = pdev->resource[pdata->ll_bar].start;
>> +	dw->pa_ll += pdata->ll_off;
>> +	dw->ll_sz = pdata->ll_sz;
>> +
>> +	dw->msi_addr = 0;
>> +	dw->msi_data = 0;
>> +
>> +	dw->version = pdata->version;
>> +	dw->mode = pdata->mode;
>> +
>> +	dev_info(dev, "Version:\t%u\n", dw->version);
>> +
>> +	dev_info(dev, "Mode:\t%s\n",
>> +		 dw->mode == EDMA_MODE_LEGACY ? "Legacy" : "Unroll");
>> +
> 
> 
>> +	dev_info(dev, "Registers:\tBAR=%u, off=0x%.16llx B, addr=0x%.8lx\n",
>> +		 pdata->regs_bar, pdata->regs_off,
>> +		 (unsigned long) dw->regs);
> 
> Oh, no, don't do casting when printing something. In only rare cases it's needed, not here.

I've put the cast to remove the following warning:

drivers/dma/dw-edma/dw-edma-pcie.c:138:15:  warning: format ‘%lx’ expects
argument of type ‘long unsigned int’, but argument 6 has type ‘void *’

> 
>> +
>> +	dev_info(dev,
>> +		"L. List:\tBAR=%u, off=0x%.16llx B, sz=0x%.8x B, vaddr=0x%.8lx, paddr=0x%.8lx",
>> +		 pdata->ll_bar, pdata->ll_off, pdata->ll_sz,
>> +		 (unsigned long) dw->va_ll,
>> +		 (unsigned long) dw->pa_ll);
> 
> This is noise, either remove or move to dbg level.

I'll move it to debug.

> 
>> +	if (pdev->msi_cap && pdev->msi_enabled) {
>> +		cap_off = pdev->msi_cap + PCI_MSI_FLAGS;
>> +		pci_read_config_word(pdev, cap_off, &flags);
>> +		if (flags & PCI_MSI_FLAGS_ENABLE) {
>> +			cap_off = pdev->msi_cap + PCI_MSI_ADDRESS_LO;
>> +			pci_read_config_dword(pdev, cap_off, &addr_lo);
>> +
>> +			if (flags & PCI_MSI_FLAGS_64BIT) {
>> +				cap_off = pdev->msi_cap + PCI_MSI_ADDRESS_HI;
>> +				pci_read_config_dword(pdev, cap_off, &addr_hi);
>> +				cap_off = pdev->msi_cap + PCI_MSI_DATA_64;
>> +			} else {
>> +				addr_hi = 0;
>> +				cap_off = pdev->msi_cap + PCI_MSI_DATA_32;
>> +			}
>> +
>> +			dw->msi_addr = addr_hi;
>> +			dw->msi_addr <<= 32;
>> +			dw->msi_addr |= addr_lo;
>> +
>> +			pci_read_config_dword(pdev, cap_off, &(dw->msi_data));
>> +			dw->msi_data &= 0xffff;
>> +
>> +			dev_info(dev,
>> +				 "MSI:\t\taddr=0x%.16llx, data=0x%.8x, nr=%d\n",
>> +				 dw->msi_addr, dw->msi_data, pdev->irq);
>> +		}
>> +	}
>> +
>> +	if (pdev->msix_cap && pdev->msix_enabled) {
>> +		u32 offset;
>> +		u8 bir;
>> +
>> +		cap_off = pdev->msix_cap + PCI_MSIX_FLAGS;
>> +		pci_read_config_word(pdev, cap_off, &flags);
>> +
>> +		if (flags & PCI_MSIX_FLAGS_ENABLE) {
>> +			cap_off = pdev->msix_cap + PCI_MSIX_TABLE;
>> +			pci_read_config_dword(pdev, cap_off, &offset);
>> +
>> +			bir = offset & PCI_MSIX_TABLE_BIR;
>> +			offset &= PCI_MSIX_TABLE_OFFSET;
>> +
>> +			reg = pcim_iomap_table(pdev)[bir];
>> +			reg += offset;
>> +
>> +			addr_lo = readl(reg + PCI_MSIX_ENTRY_LOWER_ADDR);
>> +			addr_hi = readl(reg + PCI_MSIX_ENTRY_UPPER_ADDR);
>> +			dw->msi_addr = addr_hi;
>> +			dw->msi_addr <<= 32;
>> +			dw->msi_addr |= addr_lo;
>> +
>> +			dw->msi_data = readl(reg + PCI_MSIX_ENTRY_DATA);
>> +
>> +			dev_info(dev,
>> +				 "MSI-X:\taddr=0x%.16llx, data=0x%.8x, nr=%d\n",
>> +				 dw->msi_addr, dw->msi_data, pdev->irq);
>> +		}
>> +	}
> 
> What is this? Why?

I need to find the PCIe interrupt vector address and value (either for MSI or
MSI-X, depends what the system has selected) in order to configure eDMA later to
generate the (done or abort) interruptions.

> 
>> +
>> +	if (!pdev->msi_enabled && !pdev->msix_enabled) {

I'm not finding it. Can you tell me what it is?

Note: pci_msi_enabled() on msi.c returns if MSI has not been disabled by the
command-line option pci=nomsi

> 
> There is a helper from PCI core for this.
> 
>> +		dev_err(dev, "%s enable interrupt failed\n",
>> +			pci_name(pdev));
>> +		return -EPERM;
>> +	}
>> +
>> +	err = dw_edma_probe(chip);
>> +	if (err) {
>> +		dev_err(dev, "%s eDMA probe failed\n",
>> +			pci_name(pdev));
>> +		return err;
>> +	}
>> +
>> +	pci_set_drvdata(pdev, chip);
>> +
>> +	dev_info(dev, "DesignWare eDMA PCIe driver loaded completely\n");
>> +
>> +	return 0;
>> +}
>> +
>> +static void dw_edma_pcie_remove(struct pci_dev *pdev)
>> +{
>> +	struct dw_edma_chip *chip = pci_get_drvdata(pdev);
>> +	struct device *dev = &pdev->dev;
>> +	int err;
>> +
>> +	err = dw_edma_remove(chip);
>> +	if (err) {
>> +		dev_warn(dev, "%s can't remove device properly: %d\n",
>> +			pci_name(pdev), err);
> 
> dev_warn + dev_name ?! Have you tried to see what would be the output?

No, I didn't, lol. That would be fun at least.

> 
>> +	}
>> +
>> +	pci_free_irq_vectors(pdev);
>> +
>> +	dev_info(dev, "DesignWare eDMA PCIe driver unloaded completely\n");
>> +}
>> +
> 
>> +#ifdef CONFIG_PM_SLEEP
> 
> You can use __maybe_unused instead of this.

I agree.

> 
>> +#endif /* CONFIG_PM_SLEEP */
> 

Thanks Andy!
