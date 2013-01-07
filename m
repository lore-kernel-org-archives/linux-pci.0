Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:34748 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753413Ab3AGEL3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 6 Jan 2013 23:11:29 -0500
Message-ID: <50EA4AEE.1050401@gmail.com>
Date: Sun, 06 Jan 2013 22:11:26 -0600
From: Robert Hancock <hancockrwd@gmail.com>
MIME-Version: 1.0
To: bl0 <bl0-052@playker.info>
CC: linux-ide@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: sata_sil data corruption, possible workarounds
References: <kahap3$mur$1@ger.gmane.org> <50CCF1E0.9070804@gmail.com> <kakea2$dh1$1@ger.gmane.org> <50CEB13B.9010100@gmail.com> <kaq1n6$hqa$1@ger.gmane.org> <50D13831.9040105@gmail.com> <kaujmk$op$1@ger.gmane.org>
In-Reply-To: <kaujmk$op$1@ger.gmane.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12/20/2012 02:54 AM, bl0 wrote:
> On Wednesday 19 December 2012 04:44, Robert Hancock wrote:
>
>> On 12/18/2012 09:23 AM, bl0 wrote:
>>> Do you think something should be done about it in the linux sata_sil
>>> driver? For a lack of a better solution, here is my suggestion. There is
>>> already one option 'slow_down' for problematic disks. Another option, for
>>> example 'cache_line_workaround', could be added for problematic
>>> motherboards. If enabled, the most straightforward way is to set cache
>>> line size to 0 and not worry about the fifo_cfg register. If someone else
>>> confirms that it solves the problem for them, this option could be
>>> enabled automatically if certain motherboard chipset is detected.
>>
>> We'd have to somehow narrow down which chipsets were involved, which
>> might be a hard task. Do you have an idea of how much the performance is
>> hurt by these workarounds? If it's not a lot, it might make sense to do
>> it by default.
>
> After setting cache line size to 0, write speed as shown by 'dd
> if=/tmpfs/testfile of=/dev/sdc9 bs=1M count=256' goes down from about
> 45 MB/s to 17 MB/s. Personally I don't care about performance, reliability
> and data safety are more important to me.

Yeah, cutting performance by 2/3rds is fairly bad though.

>
> The other workaround is to increase cache line size to 64 bytes, if
> necessary, and set fifo_cfg to 0. No difference in performance measured.
> This workaround is more of a hit or miss. It seems to contradict that code
> commit made back in 2005, which was also about data corruption. In the
> worst case, what solves data corruption problem on some motherboards might
> introduce this problem on some other motherboards.

That's possible, which is why I suspect that someone from Silicon Image 
would have to confirm a possible fix - might be hard to get their 
attention about this old chipset..
