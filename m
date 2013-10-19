Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from out03.mta.xmission.com ([166.70.13.233]:55426 "EHLO
	out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751274Ab3JSBWr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 18 Oct 2013 21:22:47 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Rajat Jain <rajatjain@juniper.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci\@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-hotplug\@vger.kernel.org" <linux-hotplug@vger.kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	Guenter Roeck <groeck@juniper.net>,
	"tom.l.nguyen\@intel.com" <tom.l.nguyen@intel.com>,
	"kristen.c.accardi\@intel.com" <kristen.c.accardi@intel.com>,
	"rajesh.shah\@intel.com" <rajesh.shah@intel.com>,
	"rajatjain.linux\@gmail.com" <rajatjain.linux@gmail.com>
References: <b13ea983a4154c7d9567b171e8316ca9@BLUPR05MB118.namprd05.prod.outlook.com>
	<CAErSpo4Yg-kUz3LHaWPVmzE1rGhdiqeJWuHwrM=-hxhP_zYH_g@mail.gmail.com>
	<c713940b329e4c6584e173cb49aaa043@BLUPR05MB118.namprd05.prod.outlook.com>
Date: Fri, 18 Oct 2013 18:22:37 -0700
In-Reply-To: <c713940b329e4c6584e173cb49aaa043@BLUPR05MB118.namprd05.prod.outlook.com>
	(Rajat Jain's message of "Sat, 19 Oct 2013 01:07:23 +0000")
Message-ID: <87eh7ikqaq.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: Enhancing pciehp
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Rajat Jain <rajatjain@juniper.net> writes:

> Hello,
>
> I'm working on enhancing the pciehp driver to allow link state changes to drive the hot-plug and un-plug. The idea was discussed here:
>
> http://www.spinics.net/lists/linux-pci/msg25733.html
>
> However, this is to invite ideas on how to handle a particular corner case I see. Let's say a PCIe link comes up and the pciehp driver calls pciehp_enable_slot() to start scanning and adding the devices on the slot. However, what to do if before that completes, the link goes down due to some reason? Can the pciehp driver call pciehp_disable_slot() before the call to pciehp_enable_slot() returns (with or without error)?
>
> Essentially even without link state to driver the hot-plug, this problem can also be thought of as a problem that exists today. For e.g. for the slots that support surprise removal, the pciehp will initiate hot-plug and unplug based on the presence detection (as soon as card is inserted or removed). Now if a user puts in a card very momentarily, long enough for the hot-add process to get started (pciehp_enable_slot()) but removes it before it can be completed, the same problem can be envisioned. As the code exists today, I believe it would call pciehp_disable_slot() even before pciehp_enable_slot() returns. Is that the designed / correct behavior? 
>
> Should I be following the same for link state change driven hot-plug?

The way I handled this problem is made the enable and disable all run
through the same single threaded work queue.

The code does need to be single threaded on a per hotplug slot basis
(aka enable and disable concurrently on the same slot is nonsense).

I think there is some locking in the device tree that you might be able
to depend on to help single thread this.  At the time I was working on
this I did not see any locking or anything else that would serialize the
access so I went for the very cheap solution of an interrupt handler
that queued work in a single threaded work queue.

The code to be correct and robuse must handle the case of where what it
thought was going on add/remove is time late information and is actually
incorrect at the time of the hotplug scan.

This all gets even more interesting when you are plugging in a tree of
hotplug devices with hotplug slots of their own.

>From an implementation point of view I have observed devices in the wild
with imperfect PCIe busses that due to bus noise would occassionally
flap their presence bit for no particularly good reason.  It is a
hardware but so you don't need to handle it beyond not letting that kind
of activity crash the kernel but it does happen.

Eric
