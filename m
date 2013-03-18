Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fold.natur.cuni.cz ([195.113.57.32]:44807 "HELO
	fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753379Ab3CRSwO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 18 Mar 2013 14:52:14 -0400
Message-ID: <5147625A.7010306@fold.natur.cuni.cz>
Date: Mon, 18 Mar 2013 19:52:10 +0100
From: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
MIME-Version: 1.0
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>
CC: USB list <linux-usb@vger.kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Lan Tianyu <tianyu.lan@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: 3.8.2: xhci port is dead until pcieport PME# goes to disabled
References: <5142094D.2070305@fold.natur.cuni.cz> <20130318170159.GF17414@xanatos> <51474CCC.3090802@fold.natur.cuni.cz> <20130318182604.GI17414@xanatos>
In-Reply-To: <20130318182604.GI17414@xanatos>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Sarah Sharp wrote:
> On Mon, Mar 18, 2013 at 06:20:12PM +0100, Martin Mokrejs wrote:
>> Hi Sarah,
>>   in this particular thread, the USB3 socket of the laptop works once
>> I plugin a device. When I unplug it and insert same or another device it appears
>> to be dead until I use 'lsusb -vvv'. After that, I see in dmesg the two lines:
> 
> Which kernel are you running on?  We had a regression that involved dead

As the subject says, 3.8.2. I really started last week several different email
threads, each independent.

> ports after a USB disconnect in 3.8.  This was was fixed in 3.8.3.  Can
> you please retest with that kernel version?

Hmm, will do. What change do you mean exactly?

BTW, how about this bugfix which just appeared at linux-pci?
[PATCH] PCI: Remove not needed check in disable aspm link


Thank you,
Martin
