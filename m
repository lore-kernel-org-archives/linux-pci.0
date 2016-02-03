Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from out-mta12.ai270.net ([94.126.40.179]:37697 "EHLO
	out-mta10.ai270.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753090AbcBCNwr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 3 Feb 2016 08:52:47 -0500
Subject: Re: Hint HB6 - kernel doesn't see chips behind it.
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20160115172640.GC28453@localhost>
 <569CFB5B.7050903@keynet-technology.com> <20160119033839.GA3339@localhost>
 <56A8DA21.7060607@keynet-technology.com> <20160127215522.GA4875@localhost>
 <56A9EC07.8080509@keynet-technology.com> <20160129162400.GB12965@localhost>
 <56ACF8D4.8010607@keynet-technology.com> <20160201190611.GA4861@localhost>
 <56AFBADB.3060108@keynet-technology.com> <20160201233512.GA19585@localhost>
Cc: linux-pci@vger.kernel.org
From: Richard F <lists@keynet-technology.com>
Message-ID: <56B2062A.2030807@keynet-technology.com>
Date: Wed, 3 Feb 2016 13:52:42 +0000
MIME-Version: 1.0
In-Reply-To: <20160201233512.GA19585@localhost>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 1/02/2016 23:35, Bjorn Helgaas wrote:
---
> 
> You should be able to tell whether Windows sees the BT878 even without
> drivers.  I think there might be something in Device Manager, or you
> can use a tool like AIDA64 (there was a free trial version last I
> checked).

I ran up AIDA64. The Hint device was recognised as something slightly
different. It also didn't list anything behind the bridge - same issue.
Not sure if the Subsystem ID of 0000 is an issue.

[ HiNT HB1-SE33 PCI-PCI Bridge ]

Device Properties:
Device Description  	HiNT HB1-SE33 PCI-PCI Bridge
			Bus Type  	PCI
			Bus / Device / Function  	4 / 1 / 0
			Device ID  	3388-0021
			Subsystem ID  	0000-0000
			Device Class  	0604 (PCI/PCI Bridge)
			Revision  	11
			Fast Back-to-Back Transactions
Supported, Disabled

Device Features:
			66 MHz Operation  	Not Supported
			Bus Mastering  	Enabled

The IT8893 similarly listed:

[ ITE IT8893 PCI Bridge ]

Device Properties:
			Device Description  	ITE IT8893 PCI Bridge
			Bus Type  	PCI
			Bus / Device / Function  	3 / 0 / 0
			Device ID  	1283-8893
			Subsystem ID  	0000-0000
			Device Class  	0604 (PCI/PCI Bridge)
			Revision  	10
			Fast Back-to-Back Transactions  	Not Supported

Device Features:
			66 MHz Operation  	Not Supported


>> Is there's something needing configuring in that Hint HB6/PCI6140
>> bridge?
> 
> I can't think of anything, but that does seem like the most likely
> explanation.
> 
>> When working, it loads the shpchp module, and it does advertise
>> itself as "non transparent" mode. 
> 
> I see "Hint Corp HB6 Universal PCI-PCI bridge (non-transparent mode)"
> in both lspci outputs.  Is that what you mean, or do you see a
> difference somewhere else?  It looks like that string is just looked
> up from the device ID; it's not influenced by anything the kernel
> does.
> 
>> The other difference is a latency of
>> 64 in the working scenario, 32 when not. Not configurable on the AMI
>> BIOS unfortunately.
> 
> I did notice the shpchp and latency timer differences, but I couldn't
> figure out how they could possibly be related.  But it certainly
> wouldn't hurt to enable shpchp in your kernel and see if it makes a
> difference.
> 
> I can't figure out how the latency timer could be involved either, but
> you can try fiddling with it, e.g., set it to 64:
> 
>   # setpci -s04:01.0 0x0d.b=0x40
>   # echo 1 > /sys/bus/pci/rescan

The shpchp module was already in the kernel config, but not used.
rmmoding and modprobing again doesn't appear to help.

I tried the above setpci and rescan, but that didn't do anything new.

Must be a broken BIOS somehow masking the bridge - are we at a dead end?

Thanks
Richard


