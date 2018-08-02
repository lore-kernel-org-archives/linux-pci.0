Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp2130.oracle.com ([141.146.126.79]:46080 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732419AbeHBQIe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Aug 2018 12:08:34 -0400
Subject: Re: Possible race condition in the kernel between PCI driver and AER
 handling
From: Thomas Tai <thomas.tai@oracle.com>
To: gokul cg <gokuljnpr@gmail.com>
Cc: linux-pci@vger.kernel.org
References: <CAFP4jM9xmXHVnBPObNxTtr1kDo2kbW9G4N5q=BLU5gf5=+M0xg@mail.gmail.com>
 <c5fb4a6a-136f-99f1-104e-32c923f00a22@oracle.com>
 <CAFP4jM9VP0jQ77rQt2KzfhuFZdXQRiS54TqxcKBLy39+sR3uMw@mail.gmail.com>
 <9aece481-b03d-c30a-7911-a07e586c1db4@oracle.com>
Message-ID: <992c78ec-cc95-5868-0afc-e586c7de92b1@oracle.com>
Date: Thu, 2 Aug 2018 10:17:04 -0400
MIME-Version: 1.0
In-Reply-To: <9aece481-b03d-c30a-7911-a07e586c1db4@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


On 08/01/2018 10:24 AM, Thomas Tai wrote:
> 
> 
> On 08/01/2018 01:53 AM, gokul cg wrote:
>> Hi,
>>
>> I see there is a basic design flow. As AER and PCI drivers are 
>> independent modules ,
>> locally storing pointer to any data structure from pci linked list in 
>> AER driver will create problem as there is no synchronization between 
>> the same .
>>
>>
>> https://elixir.bootlin.com/linux/v3.10.99/source/drivers/pci/pcie/aer/aerdrv_core.c#L701 
>>
>> Here 'structaer_err_info 
>> <https://elixir.bootlin.com/linux/v3.10.99/ident/aer_err_info>*e_info 
>> <https://elixir.bootlin.com/linux/v3.10.99/ident/e_info>' has pointer 
>> to pci dev , which can be removed from pci tree at any time .
>> I think this is the basic issue.

Hi Gokul,

I am afraid that I am having hard time recreating your issue. Following 
is the normal situation and wondering did you see any hotplug message 
before the aer message?

pcieport 0000:00:02.2: AER: Corrected error received: id=1130
pciehp 0000:11:06.0:pcie204: Slot(102): Link Down
pciehp 0000:11:06.0:pcie204: Slot(102): Link Down event ignored; already 
powering off
pcieport 0000:11:06.0: PCIe Bus Error: severity=Corrected, type=Physical 
Layer, id=1130(Receiver ID)
pcieport 0000:11:06.0:   device [111d:80b5] error 
status/mask=00000001/0000e000
pcieport 0000:11:06.0:    [ 0] Receiver Error

As far as the pci_dev being corrupted, may be you can add 
"slub_debug=FZP" in your kernel boot argument and rerun your test and 
see if it find anything. I am curious that who corrupted the pci_dev in 
the first place. I am not totally convinced that the problem is in the 
AER codes.

Cheers,
Thomas
