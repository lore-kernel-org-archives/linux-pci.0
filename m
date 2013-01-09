Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:58917 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756059Ab3AIEsq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 Jan 2013 23:48:46 -0500
Message-ID: <50ECF6AB.30007@gmail.com>
Date: Tue, 08 Jan 2013 22:48:43 -0600
From: Robert Hancock <hancockrwd@gmail.com>
MIME-Version: 1.0
To: bl0 <bl0-052@playker.info>
CC: linux-ide@vger.kernel.org, linux-pci@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, Jeff Garzik <jeff@garzik.org>
Subject: Re: sata_sil data corruption, possible workarounds
References: <kahap3$mur$1@ger.gmane.org> <50CCF1E0.9070804@gmail.com> <kakea2$dh1$1@ger.gmane.org> <50CEB13B.9010100@gmail.com> <kaq1n6$hqa$1@ger.gmane.org> <kb9pa2$mi8$1@ger.gmane.org>
In-Reply-To: <kb9pa2$mi8$1@ger.gmane.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12/24/2012 08:37 AM, bl0 wrote:
> On Tuesday 18 December 2012 16:23, bl0 wrote:
>
>> On Monday 17 December 2012 06:44, Robert Hancock wrote:
>>
>>> But it seems quite likely that
>>> whatever magic numbers this code is picking don't work on your system
>>> for some reason. It appears the root cause is likely a bug in the SiI
>>> chip. There shouldn't be any region why messing around with these values
>>> should cause data corruption other than that.
>>
>> Do you think something should be done about it in the linux sata_sil
>> driver? For a lack of a better solution, here is my suggestion. There is
>> already one option 'slow_down' for problematic disks. Another option, for
>> example 'cache_line_workaround', could be added for problematic
>> motherboards. If enabled, the most straightforward way is to set cache
>> line size to 0 and not worry about the fifo_cfg register.
>
> Here is the code I currently have, attached as a diff. (This diff is not
> against the latest git tree, it's against an older linux version which I
> use.)

I wouldn't mind something like this as an option, anyway. Jeff, Tejun, 
thoughts?

