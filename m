Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fold.natur.cuni.cz ([195.113.57.32]:38646 "HELO
	fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753479Ab2EGTUQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 7 May 2012 15:20:16 -0400
Message-ID: <4FA82123.8060406@fold.natur.cuni.cz>
Date: Mon, 07 May 2012 21:23:15 +0200
From: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
MIME-Version: 1.0
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>,
	Jiang Liu <liuj97@gmail.com>, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH v2 10/19] PCI: serialize hotplug operaitons triggered
 by the shpchp driver
References: <1335539820-11232-1-git-send-email-jiang.liu@huawei.com> <1335539820-11232-11-git-send-email-jiang.liu@huawei.com> <4FA4F3E5.5040600@fold.natur.cuni.cz> <4FA5EF97.8010306@gmail.com> <20120506152036.GA31551@kroah.com> <4FA7D882.3070903@gmail.com> <4FA7D839.9090109@fold.natur.cuni.cz> <4FA7D894.3040700@fold.natur.cuni.cz> <20120507184050.GC725@kroah.com>
In-Reply-To: <20120507184050.GC725@kroah.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Greg Kroah-Hartman wrote:
> On Mon, May 07, 2012 at 04:13:40PM +0200, Martin Mokrejs wrote:
>> Martin Mokrejs wrote:
>>> Hi Greg and Jiang,
>>>   I am confirming this issue still happens for me with my changed motherboard and express card slot
>>> of my Dell Vostro 3550 laptop. :( I trigger this when unplugging a FireWire express card. Not always
>>> but does happen. attached is a camera picture of the Oops.
>>>
>>>
>>> wq_worker_sleeping
>>> __schedule
>>> schedule
>>> do_exit
>>> oops_end
>>> no_context
>>> __bad_area_nosemaphore
>>> ? put_dec
>>> bad_area_nosemaphore
>>> do_page_fault
>>> ? pointer.clone
>>> ? vsnprintf
>>> page_fault
>>> ? sysfs_name_hash
>>> sysfs_find_dirent
>>> sysfs_hash_and_remove
>>> sysfs_remove_bin_file
>>> pci_remove_resource_files
> 
> Bjorn, the resource stuff changed recently, while pci hotplug didn't
> change at all.  Are we trying to remove files that aren't really there
> anymore?
> 
> Or could we be removing the same file twice?

If you give me some debug patch I can provide you with dozens of inserts and reinserts
of the card and corresponding output (the normal scenario). Unfortunately not the Oops case,
that will not be synced to disk and my remote ttyUSB0 works only partially, only few lines
I ever managed to record. But still you could compare the stacktrace with the correct path?

It seems to me Oops happens when I just pull out the card out of the slot. Maybe the
expected way would be to push the card into the slot to release some lock and it would
be pulled out by itself. I fear this is the intended way to unplug a card.

I played with that a bit now it seems if I just pull out the card, the mechanical lock still
stays in "inserted" position. Next insertion of the card will fail (insert+slip out).
So, every second insertion attempt will succeed and my card will really be held in.

I think I see in logs that output slightly differs on every second ... re-insert of the
card. Although the card presence detection does not work if catches up on card insertion
(some mechanical lock flips). I think removal of the by card pushing it in at least ensures
the lock is flipped as well. Just my impression why something differs on every second
insertion of the card.

I just retested with 3.4-rc6 and this Oops still happens. If I did did not screw it up it
happens even when I carefully always push in the card to get it popped out (the maybe intended
and only allowed card removal?). So the above "every second" scenario does not really help.

Thanks,
Martin
