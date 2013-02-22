Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:63049 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1755219Ab3BVI7Z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 22 Feb 2013 03:59:25 -0500
Message-ID: <51273349.3070400@cn.fujitsu.com>
Date: Fri, 22 Feb 2013 16:58:49 +0800
From: Gu Zheng <guz.fnst@cn.fujitsu.com>
MIME-Version: 1.0
To: Wei Yang <weiyang@linux.vnet.ibm.com>
CC: Paul Bolle <pebolle@tiscali.nl>, Oliver Neukum <oneukum@suse.de>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: pciehp: errors on resume
References: <1359377173.1345.25.camel@x61.thuisdomein> <512336fb.42d70e0a.73ed.ffffc77eSMTPIN_ADDED_BROKEN@mx.google.com> <1361266095.26423.19.camel@x61.thuisdomein> <51234EE2.6050807@cn.fujitsu.com> <20130222074942.GA2398@richard.(null)>
In-Reply-To: <20130222074942.GA2398@richard.(null)>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 02/22/2013 03:49 PM, Wei Yang wrote:

> On Tue, Feb 19, 2013 at 06:07:30PM +0800, Gu Zheng wrote:
>> On 02/19/2013 05:28 PM, Paul Bolle wrote:
>>
>>> Richard,
>>>
>>> On Tue, 2013-02-19 at 16:25 +0800, Wei Yang wrote:
>>>> Sorry for bothering, I am looking at this and try to understand the process, 
>>>> while get some confusion.
>>>>
>>>> 1. The error log will be printed every time suspend/resume, no matter whether
>>>>    the device is plug in/plug out during the suspend as discussed below?
>>>>
>>>>    If the device is always there, no one touch it, the error message still be
>>>>    printed?
>>>>
>>>> 2. In my mind, before the pcied_init is called, those pci_dev are
>>>>    already enumerated, such as the wireless card in this case. 
>>>>
>>>>    During the boot stage, if the pciehp_force is set to true, the error messge
>>>>    still be printed? Since I don't have those devices to create pcie_device, I
>>>>    can't test this.
>>>>
>>>> 3. Do you think it would be find to remove those devices at the suspend stage?
>>>>    Then they will be added again at the resume stage?
>>>
>>> Bypassing your questions, I'd like to point you at
>>> http://article.gmane.org/gmane.linux.kernel.pci/20077 , in which Rafael
>>> suggested a possible solution to this situation. (There's some extra
>>> info in other messages in this thread.)
>>
>>
>> Yes, Rafael's suggestion seems a possible solution to this situation.
>> In my mind, it's impossible to figure out a unique pci device with
>> the registers in the PCI config space, something like "vender_id + device_id"
>> can not describe a unique device.
>> The pcie device has a feature likes "series number" which could be used to figure
>> out a unique one, but this feature is optional. If it's not set, we still
>> can not detect a unique pcie device.
>> Sorry for my poor knowledge, if what I said has any mistake, please figure it out!:)
> 
> Gu,
> 
> After reading the code, there are several sets of hotplug code, for example
> pciehp, acpiphp.
> 
> For acpiphp, I found there is notification handler _handle_hotplug_event_bridge
> and _handle_hotplug_event_func to handle the hardware events. 
> 
> While for pciehp, I didn't find such handler to handle a hardware event. The
> pciehp_resume is the start point?

Look into pcie_init_slot(),pcie_init_notification(), pciehp use workqueue each slot
to handle hardware event in polling/intrupt.
Pciehp_resume() has relations to power manager. In fact, it's near the end point in the
resume routine. 
And further more, you can see documentation/power/pci.txt and follow pci_pm_resume().

Thanks,
Gu

> 
>>
>> Thanks,
>> Gu 
>>
>>
>>
>>
>>> I must confess that I'm not at all sure how to implement it and that so
>>> far I have, rather cowardly, not even drafted a solution along those
>>> lines.
>>>
>>>
>>> Paul Bolle
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
> 


