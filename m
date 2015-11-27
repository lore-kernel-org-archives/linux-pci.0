Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:5149 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754450AbbK0P5r (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 27 Nov 2015 10:57:47 -0500
Subject: Re: [PATCH v3 4/5] PCI: iproc: Add iProc PCIe MSI support
To: Marc Zyngier <marc.zyngier@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>
References: <1448577430-16428-1-git-send-email-rjui@broadcom.com>
 <1448577430-16428-5-git-send-email-rjui@broadcom.com>
 <56587410.4090004@arm.com>
CC: Arnd Bergmann <arnd@arndb.de>, Hauke Mehrtens <hauke@hauke-m.de>,
	<linux-kernel@vger.kernel.org>,
	<bcm-kernel-feedback-list@broadcom.com>,
	<linux-pci@vger.kernel.org>
From: Ray Jui <rjui@broadcom.com>
Message-ID: <56587D71.6030203@broadcom.com>
Date: Fri, 27 Nov 2015 07:57:37 -0800
MIME-Version: 1.0
In-Reply-To: <56587410.4090004@arm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Marc,

On 11/27/2015 7:17 AM, Marc Zyngier wrote:
> On 26/11/15 22:37, Ray Jui wrote:
>> This patch adds PCIe MSI support for both PAXB and PAXC interfaces on
>> all iProc based platforms
>>
>> The iProc PCIe MSI support deploys an event queue based implementation.
>> Each event queue is serviced by a GIC interrupt and can support up to 64
>> MSI vectors. Host memory is allocated for the event queues, and each event
>> queue consists of 64 word-sized entries. MSI data is written to the
>> lower 16-bit of each entry, whereas the upper 16-bit of the entry is
>> reserved for the controller for internal processing
>>
>> Each event queue is tracked by a head pointer and tail pointer. Head
>> pointer indicates the next entry in the event queue to be processed by
>> the driver and is updated by the driver after processing is done.
>> The controller uses the tail pointer as the next MSI data insertion
>> point. The controller ensures MSI data is flushed to host memory before
>> updating the tail pointer and then triggering the interrupt
>>
>> MSI IRQ affinity is supported by evenly distributing the interrupts to
>> each CPU core. MSI vector is moved from one GIC interrupt to another in
>> order to steer to the target CPU
>>
>> Therefore, the actual number of supported MSI vectors is:
>>
>> M * 64 / N
>>
>> where M denotes the number of GIC interrupts (event queues), and N
>> denotes the number of CPU cores
>>
>> This iProc event queue based MSI support should not be used with newer
>> platforms with integrated MSI support in the GIC (e.g., giv2m or
>> gicv3-its)
>>
>> Signed-off-by: Ray Jui <rjui@broadcom.com>
>> Reviewed-by: Anup Patel <anup.patel@broadcom.com>
>> Reviewed-by: Vikram Prakash <vikramp@broadcom.com>
>> Reviewed-by: Scott Branden <sbranden@broadcom.com>
>> ---
>>   drivers/pci/host/Kconfig               |   9 +
>>   drivers/pci/host/Makefile              |   1 +
>>   drivers/pci/host/pcie-iproc-bcma.c     |   1 +
>>   drivers/pci/host/pcie-iproc-msi.c      | 678 +++++++++++++++++++++++++++++++++
>>   drivers/pci/host/pcie-iproc-platform.c |   1 +
>>   drivers/pci/host/pcie-iproc.c          |  26 ++
>>   drivers/pci/host/pcie-iproc.h          |  23 +-
>>   7 files changed, 737 insertions(+), 2 deletions(-)
>>   create mode 100644 drivers/pci/host/pcie-iproc-msi.c
>>
>
> [...]
>
>> diff --git a/drivers/pci/host/pcie-iproc-msi.c b/drivers/pci/host/pcie-iproc-msi.c
>> new file mode 100644
>> index 0000000..f64399a
>> --- /dev/null
>> +++ b/drivers/pci/host/pcie-iproc-msi.c
>
> [...]
>
>> +int iproc_msi_init(struct iproc_pcie *pcie, struct device_node *node)
>> +{
>> +	struct iproc_msi *msi;
>> +	int i, ret;
>> +	unsigned int cpu;
>> +
>> +	if (!of_device_is_compatible(node, "brcm,iproc-msi"))
>> +		return -ENODEV;
>> +
>> +	if (!of_find_property(node, "msi-controller", NULL))
>> +		return -ENODEV;
>> +
>> +	if (pcie->msi)
>> +		return -EBUSY;
>> +
>> +	msi = devm_kzalloc(pcie->dev, sizeof(*msi), GFP_KERNEL);
>> +	if (!msi)
>> +		return -ENOMEM;
>> +
>> +	msi->pcie = pcie;
>> +	pcie->msi = msi;
>> +	msi->msi_addr = pcie->base_addr;
>> +	mutex_init(&msi->bitmap_lock);
>> +	msi->nr_cpus = num_online_cpus();
>
> What if some of the CPUs are offline at that time, but come back online
> later? My guess is that you need to have num_possible_cpus().
>

Okay let me change this back to num_possible_cpus().

>> +
>> +	msi->nr_irqs = of_irq_count(node);
>> +	if (!msi->nr_irqs) {
>> +		dev_err(pcie->dev, "found no MSI GIC interrupt\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	if (msi->nr_irqs > NR_HW_IRQS) {
>> +		dev_warn(pcie->dev, "too many MSI GIC interrupts defined %d\n",
>> +			 msi->nr_irqs);
>> +		msi->nr_irqs = NR_HW_IRQS;
>> +	}
>> +
>> +	if (msi->nr_irqs < msi->nr_cpus) {
>> +		dev_err(pcie->dev,
>> +			"not enough GIC interrupts for MSI affinity\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (msi->nr_irqs % msi->nr_cpus != 0) {
>> +		msi->nr_irqs -= msi->nr_irqs % msi->nr_cpus;
>> +		dev_warn(pcie->dev, "Reducing number of interrupts to %d\n",
>> +			 msi->nr_irqs);
>> +	}
>> +
>> +	switch (pcie->type) {
>> +	case IPROC_PCIE_PAXB:
>> +		msi->reg_offsets = iproc_msi_reg_paxb;
>> +		msi->nr_eq_region = 1;
>> +		msi->nr_msi_region = 1;
>> +		break;
>> +	case IPROC_PCIE_PAXC:
>> +		msi->reg_offsets = iproc_msi_reg_paxc;
>> +		msi->nr_eq_region = msi->nr_irqs;
>> +		msi->nr_msi_region = msi->nr_irqs;
>> +		break;
>> +	default:
>> +		dev_err(pcie->dev, "incompatible iProc PCIe interface\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (of_find_property(node, "brcm,pcie-msi-inten", NULL))
>> +		msi->has_inten_reg = true;
>> +
>> +	msi->nr_msi_vecs = msi->nr_irqs * EQ_LEN;
>> +	msi->bitmap = devm_kcalloc(pcie->dev, BITS_TO_LONGS(msi->nr_msi_vecs),
>> +				   sizeof(*msi->bitmap), GFP_KERNEL);
>> +	if (!msi->bitmap)
>> +		return -ENOMEM;
>> +
>> +	msi->grps = devm_kcalloc(pcie->dev, msi->nr_irqs, sizeof(*msi->grps),
>> +				 GFP_KERNEL);
>> +	if (!msi->grps)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < msi->nr_irqs; i++) {
>> +		unsigned int irq = irq_of_parse_and_map(node, i);
>> +
>> +		if (!irq) {
>> +			dev_err(pcie->dev, "unable to parse/map interrupt\n");
>> +			ret = -ENODEV;
>> +			goto free_irqs;
>> +		}
>> +		msi->grps[i].gic_irq = irq;
>> +		msi->grps[i].msi = msi;
>> +		msi->grps[i].eq = i;
>> +	}
>> +
>> +	/* reserve memory for MSI event queue */
>> +	msi->eq_cpu = dma_alloc_coherent(pcie->dev,
>> +					 msi->nr_eq_region * EQ_MEM_REGION_SIZE,
>> +					 &msi->eq_dma, GFP_KERNEL);
>> +	if (!msi->eq_cpu) {
>> +		ret = -ENOMEM;
>> +		goto free_irqs;
>> +	}
>> +
>> +	/* zero out all memory contents of the MSI event queues */
>> +	memset(msi->eq_cpu, 0, msi->nr_eq_region * EQ_MEM_REGION_SIZE);
>> +
>
> Please use dma_zalloc_coherent instead of memsetting the memory.

Definitely. Will do.

>
> Thanks,
>
> 	M.
>

Thanks, Marc!

Ray
