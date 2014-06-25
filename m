Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60733 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756043AbaFYOZZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 25 Jun 2014 10:25:25 -0400
Message-ID: <53AADBD7.4070302@ti.com>
Date: Wed, 25 Jun 2014 10:25:27 -0400
From: Murali Karicheri <m-karicheri2@ti.com>
MIME-Version: 1.0
To: Pratyush Anand <pratyush.anand@gmail.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: SATA AHCI controller detection during PCI enumeration
References: <53A98A95.2030401@ti.com> <CAHM4w1kSH0C3N3rfy9yCBNwUXZTJmzZt5rnsLBbgjG9DLY9L2A@mail.gmail.com>
In-Reply-To: <CAHM4w1kSH0C3N3rfy9yCBNwUXZTJmzZt5rnsLBbgjG9DLY9L2A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 06/25/2014 12:01 AM, Pratyush Anand wrote:
> On Tue, Jun 24, 2014 at 7:56 PM, Murali Karicheri<m-karicheri2@ti.com>  wrote:
>> All,
>>
>> I have a board with PCI controller connected to a Marvell AHCI controller,
>> 88SE9182 connected to a PCIe bus and the PCI scan doesn't show up the SATA
>> end point. My question is in order to detect the EP,
>> is it expected to have a hard drive connected to the SATA port?
>
> No
>
>> Currently with and without the SATA connected, the PCI scan doesn't
>> show up the device. Also is there any other requirements at the
>> hardware level to detect this SATA controller.
>
> Does this PCIe2SATA card work with standard PC?
>
> I do not know about this Marvell controller, but I remember one
> silicon image controller which worked with only Gen1 host port.
> You may ask card vendor if there is any such limitation.
>
Pratyush,

Thanks for the reply. I will touch base with the Vendor on this.

Murali

> ~Pratyush
>
>>
>> Thanks in advance for your reply.
>>
>> Murali
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

