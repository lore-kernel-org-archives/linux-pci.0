Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41147 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751047Ab2KAVMq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 1 Nov 2012 17:12:46 -0400
Message-ID: <5092E5C7.7030601@redhat.com>
Date: Thu, 01 Nov 2012 17:12:39 -0400
From: Don Dutile <ddutile@redhat.com>
MIME-Version: 1.0
To: Ben Hutchings <bhutchings@solarflare.com>
CC: linux-pci@vger.kernel.org, bhelgaas@google.com,
	yuvalmin@broadcom.com, gregory.v.rose@intel.com,
	yinghai@kernel.org, davem@davemloft.net
Subject: Re: [PATCH 4/4] PCI,sriov: provide method to reduce the number of
 total VFs supported
References: <1351718353-6124-1-git-send-email-ddutile@redhat.com>  <1351718353-6124-5-git-send-email-ddutile@redhat.com> <1351727591.2706.52.camel@bwh-desktop.uk.solarflarecom.com>
In-Reply-To: <1351727591.2706.52.camel@bwh-desktop.uk.solarflarecom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/31/2012 07:53 PM, Ben Hutchings wrote:
> On Wed, 2012-10-31 at 17:19 -0400, Donald Dutile wrote:
>> Some implementations of SRIOV provide a capability structure
>> value of TotalVFs that is greater than what the software can support.
>> Provide a method to reduce the capability structure reported value
>> to the value the driver can support.
>> This ensures sysfs reports the current capability of the system,
>> hardware and software.
>> Example for its use: igb&  ixgbe -- report 8&  64 as TotalVFs,
>> but drivers only support 7&  63 maximum.
>>
>> Signed-off-by: Donald Dutile<ddutile@redhat.com>
>> ---
>>   drivers/pci/iov.c       | 27 ++++++++++++++++++++++++++-
>>   drivers/pci/pci-sysfs.c | 10 ++++++++--
>>   drivers/pci/pci.h       |  1 +
>>   include/linux/pci.h     |  5 +++++
>>   4 files changed, 40 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
>> index aeccc91..98c3d37 100644
>> --- a/drivers/pci/iov.c
>> +++ b/drivers/pci/iov.c
>> @@ -682,7 +682,6 @@ int pci_enable_sriov(struct pci_dev *dev, int nr_virtfn)
>>
>>   	if (!dev->is_physfn)
>>   		return -ENODEV;
>> -
>>   	return sriov_enable(dev, nr_virtfn);
>>   }
>>   EXPORT_SYMBOL_GPL(pci_enable_sriov);
>
> This hunk doesn't belong in this patch.
>
gone in next rev.

>> @@ -735,3 +734,29 @@ int pci_num_vf(struct pci_dev *dev)
>>   		return dev->sriov->nr_virtfn;
>>   }
>>   EXPORT_SYMBOL_GPL(pci_num_vf);
>> +
>> +/**
>> + * pci_sriov_set_totalvfs -- reduce the TotalVFs available
>> + * @dev: the PCI PF device
>> + * numvfs: number that should be used for TotalVFs supported
>> + *
>> + * Should be called from PF driver's probe routine with
>> + * device's mutex held.
>> + *
>> + * Returns 0 if PF is an SRIOV-capable device and
>> + * value of numvfs valid, otherwise -EINVAL
>
> This says the only possible error is -EINVAL, but it can also return
> -EIO!  And the already-enabled case might be one that some drivers will
> need to handle specially.
>
>> + */
>> +int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs)
>> +{
>> +	if (!dev || !dev->is_physfn || (numvfs>  dev->sriov->total))
>> +		return -EINVAL;
>> +
>> +	/* Shouldn't change if VFs already enabled */
>> +	if (dev->sriov->ctrl&  PCI_SRIOV_CTRL_VFE)
>> +		return -EIO;
> [...]
>
> EBUSY seems a bit more appropriate.
>
> Ben.
>
ok. changed to -EBUSY & comment on return values.

After looking at this area more, I created a pci_sriov_get_totalvfs()
as well, and now use that in the pci-sysfs.c file as well....
much cleaner; symmetric to set.  Makes backporting to
those crazy enterprise releases w/kabi rules easier too! ;-)

