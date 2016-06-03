Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:57912 "EHLO mx2.mailbox.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751412AbcFCF5x (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 3 Jun 2016 01:57:53 -0400
Subject: Re: [PATCH] PCI: mvebu: Don't try to add an MBus window that already
 exists
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
References: <20160602125247.17566-1-sr@denx.de>
 <20160602151818.0989ee50@free-electrons.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	Jisheng Zhang <jszhang@marvell.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?Q?Gr=c3=a9gory_Clement?=
	<gregory.clement@free-electrons.com>, Arnd Bergmann <arnd@arndb.de>
From: Stefan Roese <sr@denx.de>
Message-ID: <57511C4E.5040501@denx.de>
Date: Fri, 3 Jun 2016 07:57:34 +0200
MIME-Version: 1.0
In-Reply-To: <20160602151818.0989ee50@free-electrons.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Thomas,

On 02.06.2016 15:18, Thomas Petazzoni wrote:
> On Thu,  2 Jun 2016 14:52:47 +0200, Stefan Roese wrote:
>> Add a check to mvebu_pcie_add_windows() to detect, if an MBus window is
>> already configured. If this is the case (base address, size, target and
>> attribute are identical), then this window is not created. This fixes
>> a problem I'm currently seeing on a custom Armada XP based board, which
>> generates this error upon PCI rescanning (in this case via sysfs):
>>
>> $ echo 1 > /sys/bus/pci/rescan
>> mvebu_mbus: cannot add window '4:e8', conflicts with another window
>> mvebu-pcie soc:pcie-controller: Could not create MBus window at [mem 0x9e000000-0x9e0fffff]: -22
>
> Thanks for the patch. I am not familiar with what happens during a PCI
> rescan, but shouldn't the MBus windows be deleted and then re-added?

It does not happen in this rescan case.

> The pci-mvebu driver deletes the MBus windows for a given PCI device
> when invalid memory base/limits are set in the emulated PCI bridge.
> Shouldn't this happen over a rescan?

I'm not sure what *should* happen upon rescan. But testing shows, that
no MBus window is removed upon rescan. I just tested what happens,
if the PCI devices are "removed" via sysfs. And this also does not
delete any of the MBus windows.

> If it doesn't, then the other question is whether the check you're
> adding should be done in the PCI driver or in the MBus driver.
>
> In commit b566e782be32145664d96ada3e389f17d32742e5, we already relaxed
> the checks done by the MBus driver, and since this commit we allow
> different windows to have the same target/attribute.
>
> Should the MBus driver also allow re-creating a	window that
> already exists, if all its properties are the same?

This sounds like a good idea to me. To move this detection / decision
one layer up. So that it will work for other drivers using this
MBus interface as well.

> Note that I am not asking you to rework your patch in this direction
> for the moment, I'm only opening the question. I haven't made up my
> mind yet on which solution is the most correct one.

Understood. Thanks for your comments. Just let me know, if you want
me to rework this patch to move this check into the MBus driver
instead. And I will try to come up with such a patch shortly.

Thanks,
Stefan
