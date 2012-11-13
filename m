Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:30157 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754221Ab2KMIBk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 13 Nov 2012 03:01:40 -0500
Message-ID: <50A1FE14.5050404@huawei.com>
Date: Tue, 13 Nov 2012 16:00:20 +0800
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
Subject: Re: [PATCH -v3] PCI, pciehp: make every slot have its own workqueue
 to avoid deadlock
References: <1352711830-9772-1-git-send-email-wangyijing@huawei.com> <CAErSpo6KSkR+Rg1G4Tte99VpOM-tZxjCfPJzCuT5-iKMN4m=4w@mail.gmail.com> <4A338DB2991D2A44B9A44B8718AECF650A52062A@G01JPEXMBYT03> <50A1B634.8000402@huawei.com>
In-Reply-To: <50A1B634.8000402@huawei.com>
Content-Type: text/plain; charset="ISO-2022-JP"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2012/11/13 10:53, Yijing Wang wrote:
> On 2012/11/13 10:35, Kaneshige, Kenji wrote:
>>> -----Original Message-----
>>> From: Bjorn Helgaas [mailto:bhelgaas@google.com]
>>> Sent: Tuesday, November 13, 2012 9:18 AM
>>> To: Yijing Wang
>>> Cc: Kaneshige, Kenji/金重 憲治; Yinghai Lu; Rafael; Rusty Russell; Mauro Carvalho Chehab; Oliver Neukum;
>>> jiang.liu@huawei.com; linux-pci@vger.kernel.org; Hanjun Guo
>>> Subject: Re: [PATCH -v3] PCI, pciehp: make every slot have its own workqueue to avoid deadlock
>>>
>>> On Mon, Nov 12, 2012 at 2:17 AM, Yijing Wang <wangyijing@huawei.com> wrote:
>>>> Currently, pciehp use global pciehp_wq to handle hotplug event from hardware.
>>>> Hot remove path will be blocked if a hotplug slot connected a IO-BOX(composed of PCIe
>>>> Switch and some slots which support hotplug). The hot removed work was queued into
>>>> pciehp_wq. But in the hot-remove path, pciehp driver would flush pciehp_wq when
>>>> the pcie port(support pciehp) was removed. In this case the hot-remove path blocked.
>>>> This patch remove the global pciehp_wq and create a new workqueue for every slot to
>>>> avoid above problem.
>>>
>>> Can you include the actual call path that leads to the deadlock?  I
>>> assume it's related to a PCIe device removal that happens at about the
>>> same time as the pcie_port_service_unregister(&hpdriver_portdrv)?
>>>
>>> I just want to make sure that the new per-slot workqueue arrangement
>>> doesn't lead to any case where the slot workqueue item depends on
>>> something removed by the pcied_cleanup() as the module exits.
>>
>> Just for your information, here is my understanding of the problem.
>>
>> ====
>> - Your hardware has nested PCIe hotplug slots like below.
>>
>>     --<slot A>--<Slot B>
>>
>> - Hot-removal request (attention button event) comes to <slot A>
>> - Pciehp driver queue the hot-removal work
>> - This hot-removal work try to remove <slot B>
>> - To remove <slot B>, pciehp flush the pciehp_wq, but it never finishes
>>   because hot-removal work is in progress. ===> deadlock
>> ====
>>
> 
> Yes, the deadlock situation as Kaneshige's description above, I will add deadlock call path
> description into patch.
> 
>>>
>>>> --- a/drivers/pci/hotplug/pciehp_hpc.c
>>>> +++ b/drivers/pci/hotplug/pciehp_hpc.c
>>>> @@ -773,23 +773,32 @@ static void pcie_shutdown_notification(struct controller *ctrl)
>>>>  static int pcie_init_slot(struct controller *ctrl)
>>>>  {
>>>>         struct slot *slot;
>>>> +       char name[32];
>>>>
>>>>         slot = kzalloc(sizeof(*slot), GFP_KERNEL);
>>>>         if (!slot)
>>>>                 return -ENOMEM;
>>>> +
>>>> +       snprintf(name, sizeof(name), "pciehp-%u", PSN(ctrl));
>>>> +       slot->wq = create_singlethread_workqueue(name);
>>>
>>> You're using create_singlethread_workqueue() instead of the previous
>>> alloc_workqueue().  This is a slight change in semantics since we
>>> previously called "alloc_workqueue(name, 0, 0)" and
>>> create_singlethread_workqueue() calls "alloc_workqueue(name,
>>> WQ_UNBOUND | WQ_MEM_RECLAIM, 1)."
>>>
>>> I don't know whether this is necessary in order to have per-slot
>>> workqueues or not.  If not, please split it into a separate patch to
>>> make it more visible.
>>
>> Good catch.
>> I think we should use 0 for max_active.
>> Hot-add/remove operation take a long time. So if we use 1 for max_active,
>> we cannot handle events during hot-add/remove operation. As a result, for
>> example, push button event and cancel event that are issued during
>> hot-add/remove operation might not be handled properly, I think.
>>
>> Any comments, Yijing?
> 
> This is an issue, I will test this case in my hot-plug machine and confirm it.

Hi Kaneshige,
   I tested this v3 patch in my hot plug machine and confirmed this problem. As you said,
there were some unexpected problem when push button event and cancel event that are issued during
hot-add/remove operation.

Before applied v3 patch the new push button event will be ignored during hot-add/remove operation

pciehp 0000:47:14.0:pcie24: Button pressed on Slot(244)
pciehp 0000:47:14.0:pcie24: PCI slot #244 - powering on due to button press.
pci 0000:4e:00.0: [1077:2432] type 00 class 0x0c0400
pci 0000:4e:00.0: reg 10: [io  0x0000-0x00ff]
pci 0000:4e:00.0: reg 14: [mem 0x00000000-0x00003fff 64bit]
..........................................................
pcieport 0000:47:14.0:   bridge window [io  0x9000-0x9fff]
pcieport 0000:47:14.0:   bridge window [mem 0x80000000-0x800fffff]
qla2xxx 0000:4e:00.0: enabling device (0100 -> 0102)
qla2xxx [0000:4e:00.0]-001d: : Found an ISP2432 irq 77 iobase 0xc000000080080000.
scsi22 : qla2xxx
pciehp 0000:47:14.0:pcie24: Button pressed on Slot(244)
pciehp 0000:47:14.0:pcie24: Button ignore on Slot(244)

After applied v3 patch the new push button event will not be ignored, and another hot-add/remove operation will start.

pciehp 0000:47:14.0:pcie24: Button pressed on Slot(244)
pciehp 0000:47:14.0:pcie24: PCI slot #244 - powering on due to button press.
pci 0000:4e:00.0: [1077:2432] type 00 class 0x0c0400
............................................................
qla2xxx [0000:4e:00.0]-001d: : Found an ISP2432 irq 77 iobase 0xc000000080080000.
scsi24 : qla2xxx
pciehp 0000:47:14.0:pcie24: Button pressed on Slot(244)
qla2xxx [0000:4e:00.0]-00fb:24: QLogic QLE2462 - PCI-Express Dual Channel 4Gb Fibre Channel HBA.
qla2xxx [0000:4e:00.0]-00fc:24: ISP2432: PCIe (2.5GT/s x4) @ 0000:4e:00.0 hdma+ host#=24 fw=5.03.02 (496).
qla2xxx 0000:4e:00.1: enabling device (0100 -> 0102)
qla2xxx [0000:4e:00.1]-001d: : Found an ISP2432 irq 82 iobase 0xc000000080084000.
scsi25 : qla2xxx
qla2xxx [0000:4e:00.1]-00fb:25: QLogic QLE2462 - PCI-Express Dual Channel 4Gb Fibre Channel HBA.
qla2xxx [0000:4e:00.1]-00fc:25: ISP2432: PCIe (2.5GT/s x4) @ 0000:4e:00.1 hdma+ host#=25 fw=5.03.02 (496).
pciehp 0000:47:14.0:pcie24: PCI slot #244 - powering off due to button press.
qla2xxx [0000:4e:00.0]-8038:24: Cable is unplugged...
qla2xxx [0000:4e:00.1]-8038:25: Cable is unplugged...

So, I will use alloc_workqueue(name, 0, 0) for every slot like the original.

> 
> Thanks!
> Yijing
> 
>>
>> Regards,
>> Kenji Kaneshige
>>
>>
>> .
>>
> 
> 


-- 
Thanks!
Yijing

