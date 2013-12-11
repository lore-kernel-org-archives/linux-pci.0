Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58855 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751417Ab3LKPP1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Dec 2013 10:15:27 -0500
From: "Karicheri, Muralidharan" <m-karicheri2@ti.com>
To: Don Dutile <ddutile@redhat.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: AER driver - doesn't attach to EP's MSI IRQ
Date: Wed, 11 Dec 2013 15:15:24 +0000
Message-ID: <3E54258959B69E4282D79E01AB1F32B704656E2C@DFLE11.ent.ti.com>
References: <3E54258959B69E4282D79E01AB1F32B704656A53@DFLE11.ent.ti.com>
 <52A7F708.6070201@redhat.com>
In-Reply-To: <52A7F708.6070201@redhat.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>-----Original Message-----
>From: Don Dutile [mailto:ddutile@redhat.com]
>Sent: Wednesday, December 11, 2013 12:24 AM
>To: Karicheri, Muralidharan
>Cc: linux-pci@vger.kernel.org
>Subject: Re: AER driver - doesn't attach to EP's MSI IRQ
>
>On 12/10/2013 06:42 PM, Karicheri, Muralidharan wrote:
>> All,
>>
>> Trying to test AER driver on an ARM platform an RC driver. The EP is using MSI IRQ1. So
>based on a previous query on this, AER driver's IRQ handler should be attached to the MSI
>IRQ1 to listen to errors from this EP. But it is attached to MSI IRQ0. The EP has MSI IRQ
>capability. Any idea why this is not working as expected?
>>
>The AER comes from the upstream port, in this case, the RP, not from the EP.
>This is what I'd expect to see...

Thanks. But I have some questions though as I am currently debugging non reporting of error in AER on my platform.
The port driver assign MSI IRQ0 and I can see the addr Low/High and vector info in the MSI capability registers of RC. 
But then how does the error gets propagated to the RC's port. Doesn't the EP send error transaction message
addressed  to RC's MSI IRQ config register (function irq) which then trigger an interrupt on the MSI vector? If this is
true, then MSI IRQ1 is going to be raised in this case at CPU and AER is not attaching any handle to it. How does it
gets this error irq?

Also when does RC trigger the error interrupt to CPU? I thought RC will raise error when RC is the completer of a
transaction from EP and an error condition occurs. For this case, does RC writes to the MSI IRQ register of the RC's
config register to raise this interrupt to CPU? My platform has a IRQ line from RC for error interrupts, but not
sure how to hook this up to AER driver as AER driver is using MSI IRQ.

I am able to trigger an unsupported request error at EP (based on the PCIE_UNCERR register bit20). Even after
enabling the MASK, I don't receive any error at AER. I am new to PCI and any help to debug this will be
appreciated.

Thanks

Murali
>
>> Cat /proc/interrupts shows
>>
>> 576:          0          0          0          0  PCIe-MSI  aerdrv
>> 577:       1025          0          0          0  PCIe-MSI  ahci
>>
>> AHCI driver is attached to MSI iRQ1. AER driver to MSI IRQ0
>>

