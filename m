Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:27548 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848Ab2KLJFY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 12 Nov 2012 04:05:24 -0500
Message-ID: <50A0BBB1.8090500@huawei.com>
Date: Mon, 12 Nov 2012 17:04:49 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: "Kaneshige, Kenji" <kaneshige.kenji@jp.fujitsu.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>, Rafael <rjw@sisk.pl>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Mauro Carvalho Chehab <mchehab@redhat.com>,
	Oliver Neukum <oneukum@suse.de>,
	"jiang.liu@huawei.com" <jiang.liu@huawei.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH -v2] PCI, pciehp: make every slot have its own workqueue
 to avoid deadlock
References: <1352450600-1956-1-git-send-email-wangyijing@huawei.com> <4A338DB2991D2A44B9A44B8718AECF650A51E58D@G01JPEXMBYT03> <50A0B2FB.6000901@huawei.com> <4A338DB2991D2A44B9A44B8718AECF650A51E779@G01JPEXMBYT03>
In-Reply-To: <4A338DB2991D2A44B9A44B8718AECF650A51E779@G01JPEXMBYT03>
Content-Type: text/plain; charset="ISO-2022-JP"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2012/11/12 16:51, Kaneshige, Kenji wrote:
>> -----Original Message-----
>> From: Yijing Wang [mailto:wangyijing@huawei.com]
>> Sent: Monday, November 12, 2012 5:28 PM
>> To: Kaneshige, Kenji/金重 憲治
>> Cc: Bjorn Helgaas; Yinghai Lu; Rafael; Rusty Russell; Mauro Carvalho Chehab; Oliver Neukum; jiang.liu@huawei.com;
>> linux-pci@vger.kernel.org; Hanjun Guo
>> Subject: Re: [PATCH -v2] PCI, pciehp: make every slot have its own workqueue to avoid deadlock
>>
>> On 2012/11/12 15:17, Kaneshige, Kenji wrote:
>>>> @@ -94,6 +93,8 @@ static int init_slot(struct controller *ctrl)
>>>>  	struct hotplug_slot_info *info = NULL;
>>>>  	struct hotplug_slot_ops *ops = NULL;
>>>>  	char name[SLOT_NAME_SIZE];
>>>> +	char *buffer;
>>>> +	int len;
>>>>  	int retval = -ENOMEM;
>>>>
>>>>  	hotplug = kzalloc(sizeof(*hotplug), GFP_KERNEL);
>>>> @@ -135,6 +136,19 @@ static int init_slot(struct controller *ctrl)
>>>>  	if (retval)
>>>>  		ctrl_err(ctrl,
>>>>  			 "pci_hp_register failed with error %d\n", retval);
>>>
>>> I think it's natural to go to out: here if retval != 0.
>>> I guess you intentionally didn't do that because you might want to do
>>> workqueue cleanup in pciehp_release_ctrl() code path. But it is confusing
>>> and hard to understand.
>>
>> Hi Kaneshige,
>>
>> You are right, go to out here is better.
> 
> Just in case, my proposal is the creating workqueue in pcie_init_slot()
> as you did in your first patch.

ok, i will create workqueue in pcie_init_slot() and use pciehp-%u format as workqueue name.

I will send out the next version patch later.

Thanks!
Yijing.

> 
>>
>>> In the previous patch, you created the work queue in pcie_init_slot().
>>> I think it's better. Maybe the reason you moved it from pcie_init_slot()
>>> to init_slot() was that you needed the slot name by pci_hp_register().
>>>
>>> How about using physical slot number, which is same as pci slot name by
>>> pci_hp_register() on the normal platform, for the workqueue name instead?
>>>
>>
>> I think use physical slot number is ok, so what about workqueue name like slot(physical slot number) format ?
>>
>> root     45808  0.0  0.0      0     0 ?        S<   16:25   0:00 [slot(0)]
> 
> I think we need "pciehp" in the name. I prefer "pciehp-%u".
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

