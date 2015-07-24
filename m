Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:60061 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753308AbbGXDHe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jul 2015 23:07:34 -0400
Message-ID: <55B1ABF3.9070201@roeck-us.net>
Date: Thu, 23 Jul 2015 20:07:31 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Yijing Wang <wangyijing@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>
CC: linux-pci@vger.kernel.org, rajatja@google.com, rjw@rjwysocki.net
Subject: Re: [PATCH v2 1/2] PCI: Use a local mutex instead of pci_bus_sem
 to avoid deadlock
References: <1437124592-2070-1-git-send-email-wangyijing@huawei.com> <1437124592-2070-2-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1437124592-2070-2-git-send-email-wangyijing@huawei.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/17/2015 02:16 AM, Yijing Wang wrote:
> Rajat Jain reported a deadlock when a hierarchical hot plug
> thread and aer recovery thread both run.
> https://lkml.org/lkml/2015/3/11/861
>
> thread 1:
> pciehp_enable_slot()
> 	pciehp_configure_device()
> 		pci_bus_add_devices()
> 			device_attach(dev)
> 				device_lock(dev) //acquire device mutex successfully
> 			...
> 			pciehp_probe(dev)
> 				__pci_hp_register()
> 					pci_create_slot()
> 						down_write(pci_bus_sem) //deadlock here
>
> thread 2:
> aer_isr_one_error()
> 	aer_process_err_device()
> 		do_recovery()
> 			broadcast_error_message()
> 				pci_walk_bus()
> 					down_read(&pci_bus_sem) //acquire pci_bus_sem successfully
> 						report_error_detected(dev)
> 							device_lock(dev) // deadlock here
>
> We use down_write(&pci_bus_sem) to protect the bus->slots list, because the
> bus->slots list is only accessed in drivers/pci/slot.c, we could introduce
> a new local mutex to protect bus->slots, and use down_read(&pci_bus_sem)
> instead of down_write(&pci_bus_sem) to protect the bus->devices list.
>
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>

I applied both patches to our system and ran a number of tests.
Works fine as far as I can see.

Tested-by: Guenter Roeck <linux@roeck-us.net>

