Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:43073 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932088AbbJVB3o (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 21 Oct 2015 21:29:44 -0400
Message-ID: <56283BFB.8070103@oracle.com>
Date: Thu, 22 Oct 2015 09:29:31 +0800
From: ethan zhao <ethan.zhao@oracle.com>
MIME-Version: 1.0
To: Bjorn Helgaas <helgaas@kernel.org>
CC: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iov: restore NumVFs register to 0 before return from
 virtfn_max_buses()
References: <1442373593-8342-1-git-send-email-ethan.zhao@oracle.com> <20151015171600.GB17702@localhost> <20151021205452.GI1583@localhost>
In-Reply-To: <20151021205452.GI1583@localhost>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bjorn,

On 2015/10/22 4:54, Bjorn Helgaas wrote:
> On Thu, Oct 15, 2015 at 12:16:00PM -0500, Bjorn Helgaas wrote:
>> Hi Ethan,
>>
>> On Wed, Sep 16, 2015 at 12:19:53PM +0900, Ethan Zhao wrote:
>>> After commit 4449f079722c ("PCI: Calculate maximum number of buses
>>> required for VFs"),the initial value of NumVFs register was left to
>>> non-zero after sriov_init() and no VFs was enabled in device driver.
>>> this changed the behaviour of kernel exported by lspci and sysfs etc.
>>> so this patch restore the NumVFs register to zero after the
>>> calculation of max_VF_buses was done and before return from
>>> virtfn_max_buses().
>>>
>>> Tested on stable 4.1 and passed building on stable 4.3-rc1
>>>
>>> Signed-off-by: Ethan Zhao <ethan.zhao@oracle.com>
>>> Tested-by: Sriharsha Yadagudde <sriharsha.devdas@oracle.com>
>> Can you test the patch below?  I'm trying to avoid touching
>> PCI_SRIOV_NUM_VF in more than one place, and I think it's OK to set it
>> and test offset/stride at the end, instead of setting NUM_VF to zero,
>> testing offset/stride, computing max_bus, then setting NUM_VF to zero
>> again.
> I applied the patch below to pci/virtualization for v4.4.

  Sorry, seems I missed your above mail, will apply your patch to my 
local branch and ask QA test again.

  Thanks,
  Ethan
>
>> commit 8e20e89658f23b8d16b1e21810e9f63c8625129c
>> Author: Bjorn Helgaas <bhelgaas@google.com>
>> Date:   Thu Oct 15 11:31:21 2015 -0500
>>
>>      PCI: Set SR-IOV NumVFs to zero after enumeration
>>      
>>      The enumeration path should leave NumVFs set to zero.  But after
>>      4449f079722c ("PCI: Calculate maximum number of buses required for VFs"),
>>      we call virtfn_max_buses() in the enumeration path, which changes NumVFs.
>>      This NumVFs change is visible via lspci and sysfs until a driver enables
>>      SR-IOV.
>>      
>>      Set NumVFs to zero after virtfn_max_buses() computes the maximum number of
>>      buses.
>>      
>>      Fixes: 4449f079722c ("PCI: Calculate maximum number of buses required for VFs")
>>      Based-on-patch-by: Ethan Zhao <ethan.zhao@oracle.com>
>>      Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>>
>> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
>> index ee0ebff..0202ab0 100644
>> --- a/drivers/pci/iov.c
>> +++ b/drivers/pci/iov.c
>> @@ -384,7 +384,7 @@ static int sriov_init(struct pci_dev *dev, int pos)
>>   	int rc;
>>   	int nres;
>>   	u32 pgsz;
>> -	u16 ctrl, total, offset, stride;
>> +	u16 ctrl, total;
>>   	struct pci_sriov *iov;
>>   	struct resource *res;
>>   	struct pci_dev *pdev;
>> @@ -414,11 +414,6 @@ static int sriov_init(struct pci_dev *dev, int pos)
>>   
>>   found:
>>   	pci_write_config_word(dev, pos + PCI_SRIOV_CTRL, ctrl);
>> -	pci_write_config_word(dev, pos + PCI_SRIOV_NUM_VF, 0);
>> -	pci_read_config_word(dev, pos + PCI_SRIOV_VF_OFFSET, &offset);
>> -	pci_read_config_word(dev, pos + PCI_SRIOV_VF_STRIDE, &stride);
>> -	if (!offset || (total > 1 && !stride))
>> -		return -EIO;
>>   
>>   	pci_read_config_dword(dev, pos + PCI_SRIOV_SUP_PGSIZE, &pgsz);
>>   	i = PAGE_SHIFT > 12 ? PAGE_SHIFT - 12 : 0;
>> @@ -456,8 +451,6 @@ found:
>>   	iov->nres = nres;
>>   	iov->ctrl = ctrl;
>>   	iov->total_VFs = total;
>> -	iov->offset = offset;
>> -	iov->stride = stride;
>>   	iov->pgsz = pgsz;
>>   	iov->self = dev;
>>   	pci_read_config_dword(dev, pos + PCI_SRIOV_CAP, &iov->cap);
>> @@ -475,6 +468,11 @@ found:
>>   	dev->sriov = iov;
>>   	dev->is_physfn = 1;
>>   	iov->max_VF_buses = virtfn_max_buses(dev);
>> +	pci_iov_set_numvfs(dev, 0);
>> +	if (!iov->offset || (total > 1 && !iov->stride)) {
>> +		rc = -EIO;
>> +		goto failed;
>> +	}
>>   
>>   	return 0;
>>   
>> @@ -484,6 +482,7 @@ failed:
>>   		res->flags = 0;
>>   	}
>>   
>> +	dev->sriov = NULL;
>>   	kfree(iov);
>>   	return rc;
>>   }
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

