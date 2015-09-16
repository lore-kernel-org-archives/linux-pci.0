Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <55F8BF72.5030404@oracle.com>
Date: Wed, 16 Sep 2015 09:01:38 +0800
From: ethan zhao <ethan.zhao@oracle.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iov: initialize NumVFs register to 0 at the end of sriov_init()
References: <1440150685-6690-1-git-send-email-ethan.zhao@oracle.com> <20150915161016.GB27964@google.com>
In-Reply-To: <20150915161016.GB27964@google.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


On 2015/9/16 0:10, Bjorn Helgaas wrote:
> On Fri, Aug 21, 2015 at 06:51:25PM +0900, Ethan Zhao wrote:
>> After commit 4449f079722c ("PCI: Calculate maximum number of buses
>> required for VFs"),the initial value of NumVFs register was set to
>> non-zero after sriov_init() and no VFs was enabled in device driver.
>> this changed the behaviour of kernel exported by lspci and sysfs etc.
>> so this patch initialize the NumVFs register to zero after the
>> calculation of max_VF_buses was done.
>>
>> Tested on stable 4.1 and passed building on stable 4.2-rc7
>>
>> Signed-off-by: Ethan Zhao <ethan.zhao@oracle.com>
>> Tested-by: Sriharsha Yadagudde <sriharsha.devdas@oracle.com>
>> ---
>>   drivers/pci/iov.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
>> index ee0ebff..6969084 100644
>> --- a/drivers/pci/iov.c
>> +++ b/drivers/pci/iov.c
>> @@ -476,6 +476,7 @@ found:
>>   	dev->is_physfn = 1;
>>   	iov->max_VF_buses = virtfn_max_buses(dev);
>>   
>> +	pci_iov_set_numvfs(dev, 0);
> I think it would be better to put this in virtfn_max_buses(), where we
> clobbered numVFs in the first place.  I'd also read the original value and
> restore it, e.g.,
>
>      pci_read_config_word(dev, iov->pos + PCI_SRIOV_NUM_VF, &numvfs);
>      for (nr_virtfn = 1; nr_virtfn <= iov->total_VFs; nr_virtfn++) {
>        ...
>      }
>      pci_iov_set_numvfs(dev, numvfs);
>      return max;
>
> I know sriov_init() sets numVFs to zero before it calls virtfn_max_buses(),
> but why rely on that extra knowledge?
  Yes, I think also virtfn_max_buses() should restore the register 
before it returns.
  Will revise it and resend.

  Thanks,
  Ethan
>>   	return 0;
>>   
>>   failed:
>> -- 
>> 1.8.3.1
>>

