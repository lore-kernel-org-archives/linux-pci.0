Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:61244 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753438Ab3JXBlu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 23 Oct 2013 21:41:50 -0400
Received: by mail-wg0-f48.google.com with SMTP id b13so1615295wgh.3
        for <linux-pci@vger.kernel.org>; Wed, 23 Oct 2013 18:41:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo7WhZu=tvEKvxUijDafv3Hbi0qXVEDoy5F4Lmwgd7B5=Q@mail.gmail.com>
References: <CAAV3jMxpNg2+ABE5AD8cOg5ZrYc1hL0-YbtHkVYFbPnSif9eeA@mail.gmail.com>
 <CAErSpo7WhZu=tvEKvxUijDafv3Hbi0qXVEDoy5F4Lmwgd7B5=Q@mail.gmail.com>
From: wubo <wuborush@gmail.com>
Date: Thu, 24 Oct 2013 09:41:28 +0800
Message-ID: <CAAV3jMxjdQYp68t0W7j317LmcLK0O2Jm9L6=ayrgcNHgNZOqFA@mail.gmail.com>
Subject: Re: A question of msix feature
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Alexander Gordeev <agordeev@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

2013/10/24 Bjorn Helgaas <bhelgaas@google.com>:
> On Tue, Oct 22, 2013 at 8:02 PM, wubo <wuborush@gmail.com> wrote:
>> Hi, all
>>
>> Sorry for troubling you.
>> We are developing msix feature on our product, unfortunately it will
>> lead kernel to crash
>> on a server PC whose cpu is Intel(R) Xeon(R) CPU E5645, and we are
>> sure that our driver is good
>> on common personal PC.
>>
>> A piece code in our driver like that:
>> for (i = 0; i < msix_num; i++) {
>> msix = &pcie->msix_entries[i];
>> msix->entry = i;
>> }
>> ret = pci_enable_msix(XX);
>> for (i = 0; i < msix_num; i++) {
>> msix = &pcie->msix_entries[i];
>> ret = request_irq(msix->vector, XX);
>> }
>>
>> BTW, the kernel crash info is as follows:
>> [Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 32993
>> [Hardware Error]: APEI generic hardware error status
>> [Hardware Error]: severity: 1, fatal
>> [Hardware Error]: section: 0, severity: 1, fatal
>> [Hardware Error]: flags: 0x01
>> [Hardware Error]: primary
>> [Hardware Error]: section_type: PCIe error
>> [Hardware Error]: port_type: 0, PCIe end point
>> [Hardware Error]: version: 1.0
>> [Hardware Error]: command: 0x0407, status: 0x0010
>> [Hardware Error]: device_id: 0000:04:00.0
>> [Hardware Error]: slot: 2
>> [Hardware Error]: secondary_bus: 0x00
>> [Hardware Error]: vendor_id: 0x1c5f, device_id: 0x0530
>> [Hardware Error]: class_code: 008001
>>
>> Do I miss something important?? Can anybody give me some hints?
>
> It's very difficult to give any hints based on so little information.
> The error looks like a PCIe hardware issue, which should not
> necessarily cause the kernel itself to crash (and if the kernel *did*
> crash, you didn't include any information about that).

Thank you very much for your replay.
Truely the kernel crashed and the info above is from kdump.

>
> I don't know how to interpret this APEI error info.  It's possible
> that your BIOS logged it and can give more details.  The most likely
> problem is that you programmed some incorrect MSI address/data info
> into the device, and when it attempted to signal an MSI, it caused the
> error.  Or it could be a regular device DMA gone awry.

Seemd the msi address/data info sent from hardware is right enough,
I have keeping watch on the hardware sending message.
things like that:
Message address Read:fee20000 //send to cpu core 32 without irq route
Message data Read:40c9 // fixed mode

But after such as ACPI stuff transform, the irq become a illegal
number, I guess.

>
> You could compare your driver's MSI handling with other drivers in the
> tree.  You could try to figure out the difference between the "common
> personal PC" (where your driver apparently works) and the server PC
> (where it fails) -- boot the server with a reduced configuration
> (fewer CPUs, fewer other devices, etc.) to make it more like the
> personal PC.

The biggest different is APCI mode, which will effect the msi
address/data config
in pci_enable_msix. But I have so little knowledge about that APCI.
And I also sure the INT-x interrupt is good on server for my driver.

 You could try using fewer MSI-X IRQs.  You could try
> using MSI or line-based interrupts to make sure it's really an
> MSI-related problem.
>
> Since most drivers do use MSI-X successfully, the problem is likely in
> your driver, not in the Linux PCI code.  I've given you some hints
> above, but in general, people don't have time to help debug
> proprietary, out-of-tree drivers.

yeh I know, I just hope somebody just have came across about it by lucky.
Anyway thanks again for your kindness.

>
> Bjorn

-- 
Thanks,
Wubo
