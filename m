Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:62638 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738AbaBHBui (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 7 Feb 2014 20:50:38 -0500
Message-ID: <52F58D5D.40503@huawei.com>
Date: Sat, 8 Feb 2014 09:50:21 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH] PCI,pciehp: Don't set slot off when found device already
 exists.
References: <1389600168-23228-1-git-send-email-wangyijing@huawei.com> <20140129223850.GH16825@google.com>
In-Reply-To: <20140129223850.GH16825@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2014/1/30 6:38, Bjorn Helgaas wrote:
> On Mon, Jan 13, 2014 at 04:02:48PM +0800, Yijing Wang wrote:
>> If we found device already exists during hot add device, we should
>> leave it, not to set slot off.
> 
> Does this fix a defect?  What's the scenario where this fixes a problem
> in the current code?  I think this change makes sense, but I'd like to
> have a better description of the problem that we're fixing.
> 
> I see the following path that looks like it might be a problem with the
> current code if slot power is off when we resume after a suspend:
> 
>     pciehp_resume
>       pciehp_enable_slot
>         board_added
>           pciehp_configure_device
> 
> Is this the scenario you're addressing?

Yes, it is.

I found this case by reviewing the code. But I have no platform
supports pciehp resume. So I can not test it in real.

Thanks!
Yijing.

> 
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>> ---
>>  drivers/pci/hotplug/pciehp_ctrl.c |    3 ++-
>>  drivers/pci/hotplug/pciehp_pci.c  |    2 +-
>>  2 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
>> index 38f0186..f27b0ff 100644
>> --- a/drivers/pci/hotplug/pciehp_ctrl.c
>> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
>> @@ -224,7 +224,8 @@ static int board_added(struct slot *p_slot)
>>  	if (retval) {
>>  		ctrl_err(ctrl, "Cannot add device at %04x:%02x:00\n",
>>  			 pci_domain_nr(parent), parent->number);
>> -		goto err_exit;
>> +		if (retval != -EEXIST)
>> +			goto err_exit;
>>  	}
>>  
>>  	if (PWR_LED(ctrl))
>> diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
>> index aac7a40..9b87b49 100644
>> --- a/drivers/pci/hotplug/pciehp_pci.c
>> +++ b/drivers/pci/hotplug/pciehp_pci.c
>> @@ -48,7 +48,7 @@ int pciehp_configure_device(struct slot *p_slot)
>>  			 "at %04x:%02x:00, cannot hot-add\n", pci_name(dev),
>>  			 pci_domain_nr(parent), parent->number);
>>  		pci_dev_put(dev);
>> -		return -EINVAL;
>> +		return -EEXIST;
>>  	}
>>  
>>  	num = pci_scan_slot(parent, PCI_DEVFN(0, 0));
>> -- 
>> 1.7.1
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 


-- 
Thanks!
Yijing

