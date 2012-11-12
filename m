Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:65052 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751367Ab2KLI2U (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 12 Nov 2012 03:28:20 -0500
Message-ID: <50A0B2FB.6000901@huawei.com>
Date: Mon, 12 Nov 2012 16:27:39 +0800
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
References: <1352450600-1956-1-git-send-email-wangyijing@huawei.com> <4A338DB2991D2A44B9A44B8718AECF650A51E58D@G01JPEXMBYT03>
In-Reply-To: <4A338DB2991D2A44B9A44B8718AECF650A51E58D@G01JPEXMBYT03>
Content-Type: text/plain; charset="ISO-2022-JP"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2012/11/12 15:17, Kaneshige, Kenji wrote:
>> @@ -94,6 +93,8 @@ static int init_slot(struct controller *ctrl)
>>  	struct hotplug_slot_info *info = NULL;
>>  	struct hotplug_slot_ops *ops = NULL;
>>  	char name[SLOT_NAME_SIZE];
>> +	char *buffer;
>> +	int len;
>>  	int retval = -ENOMEM;
>>
>>  	hotplug = kzalloc(sizeof(*hotplug), GFP_KERNEL);
>> @@ -135,6 +136,19 @@ static int init_slot(struct controller *ctrl)
>>  	if (retval)
>>  		ctrl_err(ctrl,
>>  			 "pci_hp_register failed with error %d\n", retval);
> 
> I think it's natural to go to out: here if retval != 0.
> I guess you intentionally didn't do that because you might want to do
> workqueue cleanup in pciehp_release_ctrl() code path. But it is confusing
> and hard to understand.

Hi Kaneshige,

You are right, go to out here is better.

> In the previous patch, you created the work queue in pcie_init_slot().
> I think it's better. Maybe the reason you moved it from pcie_init_slot()
> to init_slot() was that you needed the slot name by pci_hp_register().
> 
> How about using physical slot number, which is same as pci slot name by
> pci_hp_register() on the normal platform, for the workqueue name instead?
>

I think use physical slot number is ok, so what about workqueue name like slot(physical slot number) format ?

root     45808  0.0  0.0      0     0 ?        S<   16:25   0:00 [slot(0)]
root     45815  0.0  0.0      0     0 ?        S<   16:25   0:00 [slot(4)]
root     45836  0.0  0.0      0     0 ?        S<   16:25   0:00 [slot(5)]
root     45840  0.0  0.0      0     0 ?        S<   16:25   0:00 [slot(3)]
root     45842  0.0  0.0      0     0 ?        S<   16:25   0:00 [slot(7)]
root     45844  0.0  0.0      0     0 ?        S<   16:25   0:00 [slot(228)]
root     45846  0.0  0.0      0     0 ?        S<   16:25   0:00 [slot(232)]
root     45848  0.0  0.0      0     0 ?        S<   16:25   0:00 [slot(233)]
root     45850  0.0  0.0      0     0 ?        S<   16:25   0:00 [slot(240)]
root     45852  0.0  0.0      0     0 ?        S<   16:25   0:00 [slot(241)]
root     45854  0.0  0.0      0     0 ?        S<   16:25   0:00 [slot(244)]
root     45856  0.0  0.0      0     0 ?        S<   16:25   0:00 [slot(245)]
root     45879  0.0  0.0   4416  2304 pts/0    S+   16:25   0:00 grep slot


Thanks!
Yijing

>> +
>> +	len = strlen(slot_name(slot)) + 16;
>> +	buffer = kzalloc(len, GFP_KERNEL);
>> +	if (!buffer) {
>> +		retval = -ENOMEM;
>> +		goto out;
>> +	}
>> +	snprintf(buffer, len, "pciehp_slot(%s)", slot_name(slot));
>> +	slot->wq = create_singlethread_workqueue(buffer);
>> +	if (!slot->wq)
>> +		retval = -ENOMEM;
>> +
>> +	kfree(buffer);
>>  out:
>>  	if (retval) {
>>  		kfree(ops);
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

