Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47627 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751367AbaANTEa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jan 2014 14:04:30 -0500
From: "Karicheri, Muralidharan" <m-karicheri2@ti.com>
To: Mohit KUMAR DCG <Mohit.KUMAR@st.com>,
	Jingoo Han <jg1.han@samsung.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: RE: pcie-designware: query on MSI IRQ handling
Date: Tue, 14 Jan 2014 19:04:16 +0000
Message-ID: <3E54258959B69E4282D79E01AB1F32B704666887@DFLE11.ent.ti.com>
References: <3E54258959B69E4282D79E01AB1F32B704662F8F@DFLE11.ent.ti.com>
 <3E54258959B69E4282D79E01AB1F32B7046639CA@DFLE11.ent.ti.com>
 <2CC2A0A4A178534D93D5159BF3BCB66189FBAF2E89@EAPEX1MAIL1.st.com>
 <201401091239.20839.arnd@arndb.de>
In-Reply-To: <201401091239.20839.arnd@arndb.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>-----Original Message-----
>From: Arnd Bergmann [mailto:arnd@arndb.de]
>Sent: Thursday, January 09, 2014 6:39 AM
>To: Mohit KUMAR DCG
>Cc: Karicheri, Muralidharan; Jingoo Han; linux-pci@vger.kernel.org
>Subject: Re: pcie-designware: query on MSI IRQ handling
>
>On Thursday 09 January 2014, Mohit KUMAR DCG wrote:
>> - To just clarify this dw PCIe driver consists 3 parts:
>> 1. Common part: Common PCIe code (host_init() etc..) this should  be
>> common to all hosts. As already discussed it should be ideally  moved
>> out from this driver. It is in todo list and will move to separate
>> file in due course of time.
>>
>> 2.  Viewport handling: ATU translation code
>>
>> 3. MSI specific code
>>
>> Synopsys controllers version 3.70+have been standardized for viewport
>> handling and msi implementation. Current dw driver covers these
>> standard  implementation for viewport and MSI.
>>
>> Now I can understand that you are using only common part of dw driver
>> And have specific viewport and msi implementation. So its getting a
>> bit  messy if you modify the driver for your specific implementation
>> as  discussed in this thread.
>>
>> So ideally I will suggest that you should move the common code (point
>> 1)  to outside this driver, and then use this along with your specific
>> viewport  and msi implementation.
>>
>> Arnd, Jingoo,
>>
>> Do you agree with above comments?
>
>I think it depends a bit on how much code ends up being shared in the first category, and
>whether it's easily separable from the second one. I assume the MSI implementation is fairly
>isolated already.
>
>I definitely agree with the general principle of layering drivers in this way, specific version of
>the driver basically uses exported functions of the more general driver like
>
>st-pcie -> dw-pcie-3.7 -> dw-pcie -> pci-common
>
>I have two comments about the specifics here:
>
>* On most architectures, the MSI controller is integrated into the primary
>  irqchip. If a dw-pcie-3.7+ is used on such a machine, I guess it will
>  just ignore the MSI part
>* On server systems, the setup of the viewport would typically be handled
>  by the firmware before the kernel is started, and the kernel does not
>  actually need to know about it.
>

I agree on this layering. For our designware IP, the Legacy IRQ
controller has 1 host irq per function where as common designware driver
uses 1 irq for this. So the irq map function has to be different as well.

Mohit, Jingoo, et all,

Is there a timeline that you have in mind for making this change to designware
core driver? I have my initial driver based on designware core driver working
using e1000e PCI Nic and want to send my patch for review. I may be able to
work with you on restructuring the code as discussed here. Please let me know
how you would like to handle this?

On a high level, I gather that we need to move all of the ATU and MSI specific
code to separate files so that appropriate drivers can pull in these files for
the driver. For keystone PCIe that I am working on, these files gets excluded
and the same implemented in keystone PCIe driver.

Thanks

Murali

>This means we might actually want to split out the MSI and viewport parts into two separate
>pieces of code that can optionally be used by any of the SoC specific host drivers.
>
>	Arnd
