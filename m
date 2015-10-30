Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36065 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752320AbbJ3QD4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 30 Oct 2015 12:03:56 -0400
Subject: Re: [PATCH v2 7/7] PCI: Set NumVFs before computing how many buses
 VFs require
To: Wei Yang <weiyang@linux.vnet.ibm.com>,
	Bjorn Helgaas <bhelgaas@google.com>
References: <20151029221701.11908.82718.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20151029222336.11908.66193.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20151030052249.GF5119@richards-mbp.cn.ibm.com>
Cc: Alexander Duyck <aduyck@mirantis.com>, linux-pci@vger.kernel.org,
	Ethan Zhao <ethan.zhao@oracle.com>,
	linux-kernel@vger.kernel.org
From: Alexander Duyck <alexander.duyck@gmail.com>
Message-ID: <563394EA.7050603@gmail.com>
Date: Fri, 30 Oct 2015 09:03:54 -0700
MIME-Version: 1.0
In-Reply-To: <20151030052249.GF5119@richards-mbp.cn.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/29/2015 10:22 PM, Wei Yang wrote:
> On Thu, Oct 29, 2015 at 05:23:36PM -0500, Bjorn Helgaas wrote:
>> From: Alexander Duyck <aduyck@mirantis.com>
>>
>> VF bus numbers depend on the First VF Offset and VF Stride, and per
>> sections 3.3.9 and 3.3.10 of the SR-IOV spec r1.1, these depend on the
>> NumVF value.
>>
>> Wait until after we set NumVFs to compute and validate the bus number of
>> the last VF.
>>
>> [bhelgaas: changelog, add spec reference, split to separate patch for
>> reviewability]
>> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>> ---
>> drivers/pci/iov.c |   18 ++++++++++--------
>> 1 file changed, 10 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
>> index bd1c4fa..9d29712 100644
>> --- a/drivers/pci/iov.c
>> +++ b/drivers/pci/iov.c
>> @@ -274,13 +274,6 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
>> 		return -ENOMEM;
>> 	}
>>
>> -	bus = pci_iov_virtfn_bus(dev, nr_virtfn - 1);
>> -	if (bus > dev->bus->busn_res.end) {
>> -		dev_err(&dev->dev, "can't enable %d VFs (bus %02x out of range of %pR)\n",
>> -			nr_virtfn, bus, &dev->bus->busn_res);
>> -		return -ENOMEM;
>> -	}
>> -
>> 	if (pci_enable_resources(dev, bars)) {
>> 		dev_err(&dev->dev, "SR-IOV: IOV BARS not allocated\n");
>> 		return -ENOMEM;
>> @@ -304,6 +297,15 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
>> 	}
>>
>> 	pci_iov_set_numvfs(dev, nr_virtfn);
> How about move it up?

The idea with moving the write down is to keep the pollution of the 
SR-IOV capability to a minimum.  Basically we have addressed all of the 
possible software issues at this point so all that remains is possible 
hardware complications.  In addition by moving this code down we only 
have to modify this code instead of adding "rc=X; goto foo;" in places 
where "return X;" was used.

Also this is an exception case.  There really isn't much point in 
optimizing for something that should never really happen.

>> +
>> +	bus = pci_iov_virtfn_bus(dev, nr_virtfn - 1);
>> +	if (bus > dev->bus->busn_res.end) {
>> +		dev_err(&dev->dev, "can't enable %d VFs (bus %02x out of range of %pR)\n",
>> +			nr_virtfn, bus, &dev->bus->busn_res);
>> +		rc = -ENOMEM;
>> +		goto err_bus;
>> +	}
>> +
>> 	iov->ctrl |= PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE;
>> 	pci_cfg_access_lock(dev);
>> 	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
>> @@ -342,7 +344,7 @@ err_pcibios:
>> 	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
>> 	ssleep(1);
>> 	pci_cfg_access_unlock(dev);
>> -
>> +err_bus:
>> 	if (iov->link != dev->devfn)
>> 		sysfs_remove_link(&dev->dev.kobj, "dep_link");
>>

