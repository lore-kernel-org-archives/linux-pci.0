Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:41250 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720Ab2KHBRE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 7 Nov 2012 20:17:04 -0500
Message-ID: <509B07D4.2030805@huawei.com>
Date: Thu, 8 Nov 2012 09:16:04 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: "Kaneshige, Kenji" <kaneshige.kenji@jp.fujitsu.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>, Rafael <rjw@sisk.pl>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Mauro Carvalho Chehab <mchehab@redhat.com>,
	Oliver Neukum <oneukum@suse.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	"jiang.liu@huawei.com" <jiang.liu@huawei.com>
Subject: Re: [RFC][PATCH] PCI, pciehp: make every slot have its own workqueue
 to avoid deadlock
References: <1351667452-9952-1-git-send-email-wangyijing@huawei.com> <4A338DB2991D2A44B9A44B8718AECF650A51AFF0@G01JPEXMBYT03>
In-Reply-To: <4A338DB2991D2A44B9A44B8718AECF650A51AFF0@G01JPEXMBYT03>
Content-Type: text/plain; charset="ISO-2022-JP"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2012/11/7 18:47, Kaneshige, Kenji wrote:
> Hi Yijing,
> 
> I have some comments. Sorry for the delay.
> 
> <snip.>
> 

Hi Kaneshige,
   Thanks for your review and comments very much!

I will update this patch and using slot name instead of device name, it's really a good suggestion.
Also I will remove the redundant flush_workqueue().

Thanks!
Yijing.

>> --- a/drivers/pci/hotplug/pciehp_hpc.c
>> +++ b/drivers/pci/hotplug/pciehp_hpc.c
>> @@ -773,23 +773,33 @@ static void pcie_shutdown_notification(struct controller *ctrl)
>>  static int pcie_init_slot(struct controller *ctrl)
>>  {
>>  	struct slot *slot;
>> +	char name[32];
>>
>>  	slot = kzalloc(sizeof(*slot), GFP_KERNEL);
>>  	if (!slot)
>>  		return -ENOMEM;
>> -
>> +
>> +	snprintf(name, sizeof(name), "pciehpd_%s",
>> +		pci_name(ctrl->pcie->port));
> 
> The name of the threads seems to be cut off.
> 
> $ ps aux | grep pciehp
> root        125  0.0  0.0      0     0 ?        S<   18:54   0:00 [pciehpd_0000:00]
> root        126  0.0  0.0      0     0 ?        S<   18:54   0:00 [pciehpd_0000:00]
> root        127  0.0  0.0      0     0 ?        S<   18:54   0:00 [pciehpd_0000:0b]
> root        128  0.0  0.0      0     0 ?        S<   18:54   0:00 [pciehpd_0000:0b]
> root        129  0.0  0.0      0     0 ?        S<   18:54   0:00 [pciehpd_0000:0b]
> root        130  0.0  0.0      0     0 ?        S<   18:54   0:00 [pciehpd_0000:0b]
> root        131  0.0  0.0      0     0 ?        S<   18:55   0:00 [pciehpd_0000:1a]
> root        132  0.0  0.0      0     0 ?        S<   18:55   0:00 [pciehpd_0000:1a]
> root        133  0.0  0.0      0     0 ?        S<   18:55   0:00 [pciehpd_0000:1a]
> root        134  0.0  0.0      0     0 ?        S<   18:55   0:00 [pciehpd_0000:1a]
> 
> How about using slot name for the thread name?
> 
> <snip.>
> 
>>
>>  static void pcie_cleanup_slot(struct controller *ctrl)
>>  {
>>  	struct slot *slot = ctrl->slot;
>>  	cancel_delayed_work(&slot->work);
>> -	flush_workqueue(pciehp_wq);
>> +	flush_workqueue(slot->wq);
>> +	destroy_workqueue(slot->wq);
>>  	kfree(slot);
>>  }
> 
> I think flush_workqueue() call is no longer required because
> it is done in destroy_workqueue() code path.
> 
> Regards,
> Kenji Kaneshige
> 
> 
> .
> 


-- 
Thanks!
Yijing

