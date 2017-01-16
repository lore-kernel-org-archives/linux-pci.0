Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:54707 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751012AbdAPXaw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Jan 2017 18:30:52 -0500
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com [147.11.189.41])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id v0GNTRbH017241
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
        for <linux-pci@vger.kernel.org>; Mon, 16 Jan 2017 15:29:27 -0800 (PST)
From: "Richard, Joseph" <Joseph.Richard@windriver.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Hotplugging PCI device with large BAR
Date: Mon, 16 Jan 2017 23:29:26 +0000
Message-ID: <7B6A2AE64F40F245AE81F245059F0C3651381A56@ALA-MBA.corp.ad.wrs.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,
I am trying to hotplug a device with a large BAR to a KVM guest, but it is failing to map the memory for the BAR.

>From dmesg, here is the output when hotplugging the device, with the failure on BAR 2:
[  891.614017] ACPI: \_SB_.PCI0.S60_: ACPI_NOTIFY_DEVICE_CHECK event
[  891.614036] ACPI: \_SB_.PCI0.S60_: Device check in hotplug_event()
[  891.614100] pci 0000:00:0c.0: [1af4:1110] type 00 class 0x050000
[  891.614277] pci 0000:00:0c.0: reg 0x10: [mem 0x00000000-0x00000fff]
[  891.614391] pci 0000:00:0c.0: reg 0x14: [mem 0x00000000-0x00000fff]
[  891.614557] pci 0000:00:0c.0: reg 0x18: [mem 0x00000000-0x7fffffff 64bit pref]
[  891.614670] pci 0000:00:0c.0: reg 0x20: [mem 0x00000000-0x000fffff pref]
[  891.614780] pci 0000:00:0c.0: reg 0x24: [mem 0x00000000-0x000fffff pref]
[  891.615277] pci 0000:00:0c.0: BAR 2: no space for [mem size 0x80000000 64bit pref]
[  891.615279] pci 0000:00:0c.0: BAR 2: failed to assign [mem size 0x80000000 64bit pref]
[  891.615281] pci 0000:00:0c.0: BAR 4: assigned [mem 0xc0300000-0xc03fffff pref]
[  891.617759] pci 0000:00:0c.0: BAR 5: assigned [mem 0xc0400000-0xc04fffff pref]
[  891.620473] pci 0000:00:0c.0: BAR 0: assigned [mem 0xc0202000-0xc0202fff]
[  891.623148] pci 0000:00:0c.0: BAR 1: assigned [mem 0xc0203000-0xc0203fff]

When the node is rebooted, the allocation gets fixed.
Also, when a similar device has previously been removed, it can allocate the memory that has previously been used for that device to this device, so allocation will succeed
Note, this is on a guest that has 9.8GB of RAM.  The same result was also observed on guests with lower amounts of RAM.

Does anyone have any suggestions?   Do you need any additional data?

Thanks,
Joseph Richard
