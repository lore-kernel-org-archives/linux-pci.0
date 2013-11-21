Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:60280 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755346Ab3KUVeK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 21 Nov 2013 16:34:10 -0500
Received: by mail-ie0-f171.google.com with SMTP id ar20so640232iec.2
        for <linux-pci@vger.kernel.org>; Thu, 21 Nov 2013 13:34:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CA+55aFyM5o39pmFtPOc1VVE5y_SYp1WXtz773cBp3fHrvnzOLQ@mail.gmail.com>
References: <1384912317-3721-1-git-send-email-yinghai@kernel.org>
	<1384912317-3721-7-git-send-email-yinghai@kernel.org>
	<20131121103021.GA29873@yanx>
	<CAE9FiQXgvaqErd1oiHmt6G8GwbW92C490+0sYyLUMcMFMMNRAg@mail.gmail.com>
	<CA+55aFyM5o39pmFtPOc1VVE5y_SYp1WXtz773cBp3fHrvnzOLQ@mail.gmail.com>
Date: Thu, 21 Nov 2013 13:34:08 -0800
Message-ID: <CAE9FiQVY6si_3uG6ndbZVOWCY5o8RuXpSLimEo96FVtNC38Dgw@mail.gmail.com>
Subject: Re: [PATCH 6/6] PCI: Try to allocate mem64 above 4G at first
From: Yinghai Lu <yinghai@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Guo Chao <yan@linux.vnet.ibm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 21, 2013 at 1:05 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, Nov 21, 2013 at 12:18 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>>
>> 3. or more generic, treat all pci BAR 32bit prefetechable as normal
>> MMIO32 during allocation. aka mmio prefectechable will be used for pci
>> bridge that support 64bit mmio pref and leave bridge's 32bit only pref
>> bar register blank.
>>
>> Bjorn, Linus,
>> Are you happy with No 3?
>
> I don't think I understand your #3. If there's a 32-bit device behind
> the bridge, it will need to be in the low 4G, so you can't use the
> 64-bit window because it will be out of range. So that wouldn't work.
> So you'd need to have a bridge window in the low 32-bit area too if
> there are any 32-bit devices behind the bridge.

bridge should have two mmio,
mmio nonpref: it only can be 32bit
mmio pref: it could be 32bit only or 64bit.
and we are ok to put child pref range under nonpref range from bridge.

Here are suggestion is:
assume mmio pref: will be use for 64bit pref only, and if the mmio pref
does not support 64bit, we just ignore it.
If devices under that bridge need pref, we will just use range from bridge's
nonpref mmio.

>
> Also, haven't we tried the "try to allocate 64-bit devices in high
> memory" and it has always failed because there are broken devices?

In my test setups, it is always working.
--- only with Intel network devices and Mellanox Infiniband cards and storage
cards from Qlogic and Emulex.

Thanks

Yinghai
