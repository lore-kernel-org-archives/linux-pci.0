Return-Path: <SRS0=UZLv=6R=huawei.com=dingtianhong@kernel.org>
Return-Path: <SRS0=UZLv=6R=huawei.com=dingtianhong@kernel.org>
Subject: Re: [PATCH v7 2/3] PCI: Enable PCIe Relaxed Ordering if supported
To: Sinan Kaya <okaya@codeaurora.org>, <leedom@chelsio.com>,
        <ashok.raj@intel.com>, <bhelgaas@google.com>, <helgaas@kernel.org>,
        <werner@chelsio.com>, <ganeshgr@chelsio.com>,
        <asit.k.mallick@intel.com>, <patrick.j.cramer@intel.com>,
        <Suravee.Suthikulpanit@amd.com>, <Bob.Shaw@amd.com>,
        <l.stach@pengutronix.de>, <amira@mellanox.com>,
        <gabriele.paoloni@huawei.com>, <David.Laight@aculab.com>,
        <jeffrey.t.kirsher@intel.com>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <mark.rutland@arm.com>, <robin.murphy@arm.com>,
        <davem@davemloft.net>, <alexander.duyck@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
References: <1499955692-26556-1-git-send-email-dingtianhong@huawei.com>
 <1499955692-26556-3-git-send-email-dingtianhong@huawei.com>
 <e496ff1d-b836-ebef-fdf7-76273aaaaef6@codeaurora.org>
From: Ding Tianhong <dingtianhong@huawei.com>
Message-ID: <0260e398-bd8e-6615-6d5c-1f7c07b6fc09@huawei.com>
Date: Fri, 14 Jul 2017 09:26:15 +0800
MIME-Version: 1.0
In-Reply-To: <e496ff1d-b836-ebef-fdf7-76273aaaaef6@codeaurora.org>
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-pci.vger.kernel.org>



On 2017/7/14 5:09, Sinan Kaya wrote:
> On 7/13/2017 10:21 AM, Ding Tianhong wrote:
>> static void pci_configure_relaxed_ordering(struct pci_dev *dev)
>> +{
>> +	/* We should not alter the relaxed ordering bit for the VF */
>> +	if (dev->is_virtfn)
>> +		return;
>> +
>> +	/* If the releaxed ordering enable bit is not set, do nothing. */
>> +	if (!pcie_relaxed_ordering_supported(dev))
>> +		return;
>> +
>> +	if (pci_dev_should_disable_relaxed_ordering(dev)) {
>> +		pcie_clear_relaxed_ordering(dev);
>> +		dev_info(&dev->dev, "Disable Relaxed Ordering\n");
>> +	}
>> +}
> 
> I couldn't find anywhere where you actually enable the relaxed ordering
> like the subject suggests.
> 
There is no code to enable the PCIe Relaxed Ordering bit in the configuration space,
it is only be enable by default according to the PCIe Standard Specification, what we
do is to distinguish the RC problematic platform and clear the Relaxed Ordering bit
to tell the PCIe EP don't send any TLPs with Relaxed Ordering Attributes to the Root
Complex.

Thanks
Ding
