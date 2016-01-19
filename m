Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from out-mta23.ai270.net ([94.126.44.34]:51713 "EHLO
	out-mta22.ai270.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932593AbcASKQV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jan 2016 05:16:21 -0500
Subject: Re: Hint HB6 - kernel doesn't see chips behind it.
To: Bjorn Helgaas <helgaas@kernel.org>
References: <5698191B.1070904@keynet-technology.com>
 <20160115172640.GC28453@localhost> <569CFB5B.7050903@keynet-technology.com>
 <20160119033839.GA3339@localhost>
Cc: linux-pci@vger.kernel.org
From: Richard F <lists@keynet-technology.com>
Message-ID: <569E0CEF.6040801@keynet-technology.com>
Date: Tue, 19 Jan 2016 10:16:15 +0000
MIME-Version: 1.0
In-Reply-To: <20160119033839.GA3339@localhost>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I'll see what I can do to capture the 4.4 crash, and post.
It was quite early in the boot cycle as I recall.

thanks
Richard

On 19/01/2016 03:38, Bjorn Helgaas wrote:
> On Mon, Jan 18, 2016 at 02:48:59PM +0000, Richard F wrote:
>> I posted a DMESG with 4.3.3 to Bugzilla now.
>> 4.4.0 crashed on boot, not sure why yet.
> 
> Thanks for all the data you collected!  I haven't had a chance to look
> at them yet, but maybe others will take a look also.
> 
> Crashing on boot is a much more serious problem than failure to find a
> card.  Any information you can collect about the v4.4.0 problem would
> be extremely useful.  A serial console log would be ideal, but even a
> photo or video of the boot might be helpful.  Boot with
> "ignore_loglevel" to make sure we see all the messages.
> 
> Bjorn
> 
>> On 15/01/2016 17:26, Bjorn Helgaas wrote:
>>> Hi Richard,
>>>
>>> On Thu, Jan 14, 2016 at 09:54:35PM +0000, Richard F wrote:
>>>> I moved a Kodicom card (http://linuxtv.org/wiki/index.php/Kodicom_4400R)
>>>> from an older machine to a new with a PCIe bridge.  Bttv modprobe can no
>>>> longer find the BT878 chips behind the PCI bridge, though the bridge is
>>>> found.
>>>>
>>>> The bridge is a PCI6140 AKA "Hint HB6".
>>>> I noticed a PCI quirk for it, tried manually adding the IO/memory spaces
>>>> that were originally logged, but doesn't help.
>>>>
>>>> This machine runs kernel 3.12.52 (x64), but it also fails on 3.0.76.
>>>> The BT878 chips were recognised on the older machine also running 3.0.76
>>>> but with a vanilla PCI bus.
>>>
>>> Thanks for your report.  I opened this bug report:
>>>
>>>   https://bugzilla.kernel.org/show_bug.cgi?id=110851
>>>
>>> Can you please attach the complete dmesg logs from the old machine
>>> running 3.0.76 and the new machine running 3.0.76 to that bugzilla?
>>> Also please attach the complete "lspci -vvv" output for all the
>>> devices in the new machine.
>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

