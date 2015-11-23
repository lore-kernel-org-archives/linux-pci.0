Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:32792 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753857AbbKWQs6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 23 Nov 2015 11:48:58 -0500
Subject: Re: [PATCH] PCI: keystone: fix crash with deferred probe
To: Jisheng Zhang <jszhang@marvell.com>
References: <866b2f1544f9d55fa932aa9f9cb5e7d523a23d05.1448017883.git.nsekhar@ti.com>
 <20151123192209.38e2c101@xhacker> <20151123192717.4d4ddf06@xhacker>
CC: Murali Karicheri <m-karicheri2@ti.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <5653435A.2040400@ti.com>
Date: Mon, 23 Nov 2015 22:18:26 +0530
MIME-Version: 1.0
In-Reply-To: <20151123192717.4d4ddf06@xhacker>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday 23 November 2015 04:57 PM, Jisheng Zhang wrote:
> On Mon, 23 Nov 2015 19:22:09 +0800
> Jisheng Zhang <jszhang@marvell.com> wrote:
> 
>> Dear Sekhar,
>>
>> On Fri, 20 Nov 2015 16:47:02 +0530
>> Sekhar Nori wrote:
>>
>>> Drop __init annotations for functions called during
>>> probe of keystone PCIe host.
>>>
>>> This fixes kernel crashes seen because of init data
>>> reclamation if the driver defer probes because of
>>> phy unavailability.
>>>
>>> While at it, drop the useless __refdata annotation
>>> to driver structure. If its really needed, it should
>>> be added back with a comment explaining why.
>>>
>>> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
>>> ---
>>>  drivers/pci/host/pci-keystone-dw.c | 2 +-
>>>  drivers/pci/host/pci-keystone.c    | 6 +++---
>>>  2 files changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/pci/host/pci-keystone-dw.c b/drivers/pci/host/pci-keystone-dw.c
>>> index ed34c9520a02..47ddbcce53ca 100644
>>> --- a/drivers/pci/host/pci-keystone-dw.c
>>> +++ b/drivers/pci/host/pci-keystone-dw.c
>>> @@ -469,7 +469,7 @@ void ks_dw_pcie_initiate_link_train(struct keystone_pcie *ks_pcie)
>>>   * and call dw_pcie_v3_65_host_init() API to initialize the Keystone
>>>   * PCI host controller.
>>>   */
>>> -int __init ks_dw_pcie_host_init(struct keystone_pcie *ks_pcie,
>>> +int ks_dw_pcie_host_init(struct keystone_pcie *ks_pcie,
>>>  				struct device_node *msi_intc_np)  
>>
>> when trying to add berlin pcie support and came up one patch
>>
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-November/384575.html
>>
>> when build testing, I also realized this issue, but keystone relies on
> 
> I mean ks_dw_pcie_host_init() calls hook_fault_code()

Okay, at least in v4.4-rc2, it does not call it. ks_pcie_host_init()
calls it. But your comment is valid. The driver needs more changes to
support probe deferral.

> 
>> hook_fault_code() which is will be freed after boot, so your patch isn't
>> completed.
> 
> And will introduce section mismatch warnings

because the annotation on ks_pcie_host_init() is intact, I did not see
any warnings.

> 
>>
>> And from the keystone driver implementation, it seems assume the driver won't
>> be defer probed.

The reason I worked on this patch is because I am using an out-of-tree
phy driver and that can be built as module and I did see ks_pcie_probe
get deferred. But as you said, this driver is not ready for deferred
probing even with this patch and so this patch should be discarded.

Thanks for your review.

Regards,
Sekhar
