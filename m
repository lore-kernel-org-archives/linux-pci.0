Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ee0-f41.google.com ([74.125.83.41]:43471 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752757Ab3HKVSw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 11 Aug 2013 17:18:52 -0400
Received: by mail-ee0-f41.google.com with SMTP id d17so3158140eek.0
        for <linux-pci@vger.kernel.org>; Sun, 11 Aug 2013 14:18:51 -0700 (PDT)
Message-ID: <5207FFB8.3080202@message-id.googlemail.com>
Date: Sun, 11 Aug 2013 23:18:48 +0200
From: Stefan Seyfried <stefan.seyfried@googlemail.com>
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
CC: linux-pci@vger.kernel.org, Greg KH <gregkh@linux.com>,
	Oliver Neukum <oneukum@suse.de>
Subject: Re: acpiphp and pciehp not working together on Thinkpad X200s
References: <520747B6.8010309@message-id.googlemail.com> <1880950.SYaKzZm9j7@vostro.rjw.lan>
In-Reply-To: <1880950.SYaKzZm9j7@vostro.rjw.lan>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Rafael,

Am 11.08.2013 23:25, schrieb Rafael J. Wysocki:
> On Sunday, August 11, 2013 10:13:42 AM Stefan Seyfried wrote:

>>  kernel: pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
>>  kernel: pci 0000:00:1c.1: PCI bridge to [bus 03]
>>  kernel: pci 0000:00:1c.1:   bridge window [mem 0xf2500000-0xf25fffff]
>> -kernel: acpiphp: Slot [1] registered
>>  kernel: pci 0000:00:1c.3: PCI bridge to [bus 05-0c]
>>  kernel: pci 0000:00:1c.3:   bridge window [io  0x2000-0x2fff]
>>  kernel: pci 0000:00:1c.3:   bridge window [mem 0xf0000000-0xf1ffffff]

>>  kernel: pciehp 0000:00:1c.1:pcie04: HPC vendor_id 8086 device_id 2942 ss_vid 17aa ss_did 20f3
>>  kernel: pciehp 0000:00:1c.1:pcie04: service driver pciehp loaded
>>  kernel: pciehp 0000:00:1c.3:pcie04: HPC vendor_id 8086 device_id 2946 ss_vid 17aa ss_did 20f3
>> -kernel: pciehp 0000:00:1c.3:pcie04: pci_hp_register failed with error -16
>> -kernel: pciehp 0000:00:1c.3:pcie04: Slot already registered by another hotplug driver
>> +kernel: pciehp 0000:00:1c.3:pcie04: service driver pciehp loaded

>> Greg told me to report the issue here, so I'm doing that :-)
>>
>> If you need more information (would a complete dmesg of both cases
>> be useful?), just let me know.
> 
> Which kernel is that?

That's 3.11rc4, openSUSE Kernel:HEAD repository.

Thanks,

	Stefan
-- 
Stefan Seyfried
Linux Consultant & Developer -- GPG Key: 0x731B665B

B1 Systems GmbH
Osterfeldstraße 7 / 85088 Vohburg / http://www.b1-systems.de
GF: Ralph Dehner / Unternehmenssitz: Vohburg / AG: Ingolstadt,HRB 3537
