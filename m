Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49175 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933195Ab1LFOOE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 6 Dec 2011 09:14:04 -0500
Message-ID: <4EDDDCE9.7010600@redhat.com>
Date: Tue, 06 Dec 2011 04:14:17 -0500
From: Don Dutile <ddutile@redhat.com>
MIME-Version: 1.0
To: Ram Pai <linuxram@us.ibm.com>
CC: Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pci@vger.kernel.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Nishanth Aravamudan <nacc@us.ibm.com>, prarit@redhat.com,
	brking@linux.vnet.ibm.com
Subject: Re: [RFC PATCH 1/1] PCI:delay configuration of SRIOV capability
References: <CAErSpo58okGsDW4dOK4i0g_RUejkuQa=iw2uQ5HAJJZCwFtsbw@mail.gmail.com> <20111007232516.GF2980@ram-ThinkPad-T61> <1318057168.29415.333.camel@pasglop> <20111008075353.GK2980@ram-ThinkPad-T61> <1318060793.29415.347.camel@pasglop> <20111102140325.004b9dad@jbarnes-desktop> <20111103013014.GB393@ram-ThinkPad-T61> <20111106023357.GB2383@ram-ThinkPad-T61> <20111205101756.7bccfbae@jbarnes-desktop> <4EDD36AE.8060208@redhat.com> <20111206075143.GB31480@ram-ThinkPad-T61>
In-Reply-To: <20111206075143.GB31480@ram-ThinkPad-T61>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12/06/2011 02:51 AM, Ram Pai wrote:
> On Mon, Dec 05, 2011 at 04:25:02PM -0500, Don Dutile wrote:
>> On 12/05/2011 01:17 PM, Jesse Barnes wrote:
>>> On Sun, 6 Nov 2011 10:33:57 +0800
>>> Ram Pai<linuxram@us.ibm.com>   wrote:
>>>
>>>>        The SRIOV capability, namely page size and total_vfs of a device are
>>>>        configured during enumeration phase of the device.
>>>>        This can potentially interfere with the PCI operations of the platform,
>>>>        if the IOV capability of the device is not enabled.
>>>>
>>>>        The following patch postpones the configuration of the IOV capability of the
>>>>        device to a later point, when the IOV capability is explicitly enabled
>>>>        by the device driver.
>>>>
>>>>        The patch is tested on x86 and power platform.
>>>>
>>>>        Signed-off-by: Ram Pai<linuxram@us.ibm.com>
>>>> ---
>>>>   drivers/pci/iov.c |    4 ++--
>>>>   1 files changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
>>>> index b0446dd..c1a6f5c 100644
>>>> --- a/drivers/pci/iov.c
>>>> +++ b/drivers/pci/iov.c
>>>> @@ -346,6 +346,8 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
>>>>   			return rc;
>>>>   	}
>>>>
>>>> +	pci_write_config_dword(dev, iov->pos + PCI_SRIOV_SYS_PGSIZE, iov->pgsz);
>>>> +
>>>>   	iov->ctrl |= PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE;
>>>>   	pci_block_user_cfg_access(dev);
>>>>   	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
>>>> @@ -451,7 +453,6 @@ static int sriov_init(struct pci_dev *dev, int pos)
>>>>
>>>>   found:
>>>>   	pci_write_config_word(dev, pos + PCI_SRIOV_CTRL, ctrl);
>>>> -	pci_write_config_word(dev, pos + PCI_SRIOV_NUM_VF, total);
>>>>   	pci_read_config_word(dev, pos + PCI_SRIOV_VF_OFFSET,&offset);
>>>>   	pci_read_config_word(dev, pos + PCI_SRIOV_VF_STRIDE,&stride);
>>>>   	if (!offset || (total>   1&&   !stride))
>>>> @@ -464,7 +465,6 @@ found:
>>>>   		return -EIO;
>>>>
>>>>   	pgsz&= ~(pgsz - 1);
>>>> -	pci_write_config_dword(dev, pos + PCI_SRIOV_SYS_PGSIZE, pgsz);
>>>>
>>>>   	nres = 0;
>>>>   	for (i = 0; i<   PCI_SRIOV_NUM_BARS; i++) {
>>>
>>> Anyone want to volunteer a tested-by for this one?
>>>
>>> Thanks,
>>
>> I tested this patch along with Ram's other recent patch for SRIOV:
>> [RFC PATCH 1/1]PCI: defer enablement of SRIOV BARS
>>
>> With or without this patch, device assignment to a KVM guest
>> using these patches worked for me.  I used one PF in a quad-function
>> i350, configuring 2 VFs per i350.  I did 4 assign/deassigns to make
>> sure multiple enable/disables worked.
>>
>> So, the patch doesn't correct any error I was seeing,
>> but it doesn't cause any regression either.
>
> Thanks Don for your tested-by.
>
> I recollect you had a  issue, which I thought were not related or
> addressed by my patches. If I can get a dmesg of your machine, I probably will
> be able to see the relation.
>
> RP
>

My issue was more RHEL specific.  Your patches appear to resolve the issues
in a more general manner, and one that saner (to me... delay SRIOV resource allocation
and setup until a driver is actually enabled with it, instead of always on no matter
what the system use of SRIOV is).

- Don

