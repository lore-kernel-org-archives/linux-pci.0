Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v4 4/5] PCI: iproc: Add iProc PCIe MSI support
To: Hauke Mehrtens <hauke@hauke-m.de>,
	Bjorn Helgaas <bhelgaas@google.com>
References: <1448645868-5730-1-git-send-email-rjui@broadcom.com>
 <1448645868-5730-5-git-send-email-rjui@broadcom.com>
 <565F006B.9010605@hauke-m.de>
CC: Marc Zyngier <marc.zyngier@arm.com>, Arnd Bergmann <arnd@arndb.de>,
	<linux-kernel@vger.kernel.org>,
	<bcm-kernel-feedback-list@broadcom.com>,
	<linux-pci@vger.kernel.org>
From: Ray Jui <rjui@broadcom.com>
Message-ID: <565F2829.2050404@broadcom.com>
Date: Wed, 2 Dec 2015 09:19:37 -0800
MIME-Version: 1.0
In-Reply-To: <565F006B.9010605@hauke-m.de>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 12/2/2015 6:30 AM, Hauke Mehrtens wrote:
> On 11/27/2015 06:37 PM, Ray Jui wrote:
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
>>   drivers/pci/host/pcie-iproc-msi.c      | 675 +++++++++++++++++++++++++++++++++
>>   drivers/pci/host/pcie-iproc-platform.c |   1 +
>>   drivers/pci/host/pcie-iproc.c          |  26 ++
>>   drivers/pci/host/pcie-iproc.h          |  23 +-
>>   7 files changed, 734 insertions(+), 2 deletions(-)
>>   create mode 100644 drivers/pci/host/pcie-iproc-msi.c
>>
>
> .....
>>
>>   int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res);
>>   int iproc_pcie_remove(struct iproc_pcie *pcie);
>>
>> +#ifdef CONFIG_PCI_MSI
>> +int iproc_msi_init(struct iproc_pcie *pcie, struct device_node *node);
>> +void iproc_msi_exit(struct iproc_pcie *pcie);
>> +#else
>> +static inline int iproc_msi_init(struct iproc_pcie *pcie,
>> +				 struct device_node *node)
>> +{
>> +	return -ENODEV;
>> +}
>> +static void iproc_msi_exit(struct iproc_pcie *pcie)
>
> Please use static inline here.
>

Right. Will fix. Thanks!

>> +{
>> +}
>> +#endif
>> +
>>   #endif /* _PCIE_IPROC_H */
>>
>
> Hauke
>

Ray
