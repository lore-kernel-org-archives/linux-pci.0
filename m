Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:56139 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751063AbbGXEJY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jul 2015 00:09:24 -0400
Subject: Re: [PATCH v2 1/2] PCI: Use a local mutex instead of pci_bus_sem to
 avoid deadlock
To: Guenter Roeck <linux@roeck-us.net>,
	Bjorn Helgaas <bhelgaas@google.com>
References: <1437124592-2070-1-git-send-email-wangyijing@huawei.com>
 <1437124592-2070-2-git-send-email-wangyijing@huawei.com>
 <55B1ABF3.9070201@roeck-us.net>
CC: <linux-pci@vger.kernel.org>, <rajatja@google.com>,
	<rjw@rjwysocki.net>
From: wangyijing <wangyijing@huawei.com>
Message-ID: <55B1BA41.4080700@huawei.com>
Date: Fri, 24 Jul 2015 12:08:33 +0800
MIME-Version: 1.0
In-Reply-To: <55B1ABF3.9070201@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



在 2015/7/24 11:07, Guenter Roeck 写道:
> On 07/17/2015 02:16 AM, Yijing Wang wrote:
>> Rajat Jain reported a deadlock when a hierarchical hot plug
>> thread and aer recovery thread both run.
>> https://lkml.org/lkml/2015/3/11/861
>>
>> thread 1:
>> pciehp_enable_slot()
>>     pciehp_configure_device()
>>         pci_bus_add_devices()
>>             device_attach(dev)
>>                 device_lock(dev) //acquire device mutex successfully
>>             ...
>>             pciehp_probe(dev)
>>                 __pci_hp_register()
>>                     pci_create_slot()
>>                         down_write(pci_bus_sem) //deadlock here
>>
>> thread 2:
>> aer_isr_one_error()
>>     aer_process_err_device()
>>         do_recovery()
>>             broadcast_error_message()
>>                 pci_walk_bus()
>>                     down_read(&pci_bus_sem) //acquire pci_bus_sem successfully
>>                         report_error_detected(dev)
>>                             device_lock(dev) // deadlock here
>>
>> We use down_write(&pci_bus_sem) to protect the bus->slots list, because the
>> bus->slots list is only accessed in drivers/pci/slot.c, we could introduce
>> a new local mutex to protect bus->slots, and use down_read(&pci_bus_sem)
>> instead of down_write(&pci_bus_sem) to protect the bus->devices list.
>>
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> 
> I applied both patches to our system and ran a number of tests.
> Works fine as far as I can see.
> 
> Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter, thanks very much!

Thanks!
Yijing.

> 
> 
> 

