Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:36024 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751416AbeBBNii (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Feb 2018 08:38:38 -0500
Subject: Re: [RFC PATCH] PCI: pciehp: Add module parameter to enable
 debouncing of HP link events
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
References: <20180130084121.18653-1-sr@denx.de>
 <20180130102840.GF27654@lahna.fi.intel.com>
From: Stefan Roese <sr@denx.de>
Message-ID: <a91f095b-87d3-d1ab-7dea-e9a0bcfd9e01@denx.de>
Date: Fri, 2 Feb 2018 14:38:34 +0100
MIME-Version: 1.0
In-Reply-To: <20180130102840.GF27654@lahna.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Mika,

sorry for the late reply.

On 30.01.2018 11:28, Mika Westerberg wrote:
> On Tue, Jan 30, 2018 at 09:41:21AM +0100, Stefan Roese wrote:
>> Hotplugging of some PCIe devices on our platform sometimes leads to a
>> bounce of link-up and link-down events, resulting in problems in the
>> corresponding PCI drivers.
>>
>> Here an example of such a hotplug event bounce for a AHCI PCIe card:
>> ...
>> pciehp 0000:00:1c.1:pcie004: Slot(1): Card present
>> pciehp 0000:00:1c.1:pcie004: Slot(1): Link Up
>> pciehp 0000:00:1c.1:pcie004: Slot(1): Link Up event ignored; already powering on
>> pciehp 0000:00:1c.1:pcie004: Slot(1): Link Down
>> pciehp 0000:00:1c.1:pcie004: Slot(1): Card present
>> pciehp 0000:00:1c.1:pcie004: Slot(1): Link Up
> 
> It would be good to find out why this happens in the first place.
> Perhaps there is some environmental interference or something causing
> this?

I'm seeing these link bounces in the following environments:

a) Using a BayTrail SoC and hotplugging a standard Desktop PCIe SATA /
   AHCI Controller (Marvell chip)
b) Hotplugging (booting via SPI) an Altera / Intel FPGA which is connected
   via PCIe to a PCIe switch

In both cases, this link bouncing happens infrequently, approx. once out
of 5 - 10 tries.

Out of curiosity, has nobody else ever experienced such "link bouncing"
with PCIe cards / devices getting hot-plugged?

>> pci 0000:02:00.0: [1b4b:9215] type 00 class 0x010601
>> pci 0000:02:00.0: reg 0x10: [io  0x8000-0x8007]
>> ...
>> ata3: SATA max UDMA/133 abar m2048@0x80910000 port 0x80910100 irq 100
>> ata4: SATA max UDMA/133 abar m2048@0x80910000 port 0x80910180 irq 100
>> ata5: SATA max UDMA/133 abar m2048@0x80910000 port 0x80910200 irq 100
>> ata6: SATA max UDMA/133 abar m2048@0x80910000 port 0x80910280 irq 100
>> pciehp 0000:00:1c.1:pcie004: Slot(1): Link Up event ignored; already powering on
>> ahci 0000:02:00.0: PME# disabled
>> ata3: SATA link down (SStatus 0 SControl 300)
>> ata5: SATA link down (SStatus 0 SControl 300)
>> ata4: SATA link down (SStatus 0 SControl 300)
>> WARNING: CPU: 2 PID: 1162 at drivers/ata/libata-core.c:6620 ata_host_detach+0x125/0x130
> 
> I think the AHCI driver should be fixed to cope with this.

Yes, this can be discussed. But still the root-cause should be fixed,
IMHO. Either in our environment (HW issue?) or by adding this de-bouncing
feature.
 
>> ata6: SATA link down (SStatus 0 SControl 300)
>> Modules linked in:
>> CPU: 2 PID: 1162 Comm: kworker/u8:5 Not tainted 4.15.0+ #26
>> Hardware name: congatec conga-qeval20-qa3-e3845/conga-qeval20-qa3-e3845, BIOS 2018.01-00033-g0125f37185-dirty 01/18/2018
>> Workqueue: pciehp-1 pciehp_power_thread
>> ...
>>
>> This patch now adds the 'pciehp_debounce_time' module parameter, which
>> can be used to drop all events for the specified time (in milliseconds)
>> after a link-up event occurred. A value of ~100ms works fine in my tests
>> to debounce all the link-up / link-down events in my tests.
> 
> This sounds a bit "hackish". I would rather make sure we can handle
> situations like this properly without passing additional parameters.

I'm open for other / better ideas on how to solve this situation, we
are seeing on our systems.

Thanks,
Stefan
