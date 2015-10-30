Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:39628 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219AbbJ3GA1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 30 Oct 2015 02:00:27 -0400
Message-ID: <56330771.90509@oracle.com>
Date: Fri, 30 Oct 2015 14:00:17 +0800
From: ethan zhao <ethan.zhao@oracle.com>
MIME-Version: 1.0
To: Wei Yang <weiyang@linux.vnet.ibm.com>,
	Bjorn Helgaas <bhelgaas@google.com>
CC: Alexander Duyck <aduyck@mirantis.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/7] PCI: Wait 1 second between disabling VFs and clearing
 NumVFs
References: <20151029221701.11908.82718.stgit@bhelgaas-glaptop2.roam.corp.google.com> <20151029222322.11908.13738.stgit@bhelgaas-glaptop2.roam.corp.google.com> <20151030051458.GD5119@richards-mbp.cn.ibm.com>
In-Reply-To: <20151030051458.GD5119@richards-mbp.cn.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Wei,

On 2015/10/30 13:14, Wei Yang wrote:
> On Thu, Oct 29, 2015 at 05:23:22PM -0500, Bjorn Helgaas wrote:
>> From: Alexander Duyck <aduyck@mirantis.com>
>>
>> Per sec 3.3.3.1 of the SR-IOV spec, r1.1, we must allow 1.0s after clearing
>> VF Enable before reading any field in the SR-IOV Extended Capability.
>>
>> Wait 1 second before calling pci_iov_set_numvfs(), which reads
>> PCI_SRIOV_VF_OFFSET and PCI_SRIOV_VF_STRIDE after it sets PCI_SRIOV_NUM_VF.
>>
>> [bhelgaas: split to separate patch for reviewability, add spec reference]
>> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>> ---
>> drivers/pci/iov.c |    2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
>> index fada98d..24428d5 100644
>> --- a/drivers/pci/iov.c
>> +++ b/drivers/pci/iov.c
>> @@ -339,13 +339,13 @@ failed:
>> 	iov->ctrl &= ~(PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE);
>> 	pci_cfg_access_lock(dev);
>> 	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
>> -	pci_iov_set_numvfs(dev, 0);
>> 	ssleep(1);
>> 	pci_cfg_access_unlock(dev);
>>
>> 	if (iov->link != dev->devfn)
>> 		sysfs_remove_link(&dev->dev.kobj, "dep_link");
>>
>> +	pci_iov_set_numvfs(dev, 0);
> One small question, any specific reason put it here instead of just after
> sleep()?
  Agree,  pci_iov_set_numvfs(dev, 0) should be put before 
pci_cfg_access_unlock(dev) to avoid race,  because "NumVFs may only be 
written while VF Enable is Clear"

  Thanks,
  Ethan
>> 	return rc;
>> }
>>

