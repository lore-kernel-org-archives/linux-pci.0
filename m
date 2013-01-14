Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qa0-f44.google.com ([209.85.216.44]:44280 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756453Ab3ANR67 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 14 Jan 2013 12:58:59 -0500
Message-ID: <50F4475F.9000509@pobox.com>
Date: Mon, 14 Jan 2013 12:58:55 -0500
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Mark Lord <kernel@teksavvy.com>
CC: Tejun Heo <tj@kernel.org>, Robert Hancock <hancockrwd@gmail.com>,
	bl0 <bl0-052@playker.info>, linux-ide@vger.kernel.org,
	linux-pci@vger.kernel.org, Jeff Garzik <jeff@garzik.org>
Subject: Re: sata_sil data corruption, possible workarounds
References: <kahap3$mur$1@ger.gmane.org> <50CCF1E0.9070804@gmail.com> <kakea2$dh1$1@ger.gmane.org> <50CEB13B.9010100@gmail.com> <kaq1n6$hqa$1@ger.gmane.org> <kb9pa2$mi8$1@ger.gmane.org> <50ECF6AB.30007@gmail.com> <20130109191753.GQ3926@htj.dyndns.org> <50F01968.4030309@teksavvy.com> <50F0199D.4090502@teksavvy.com>
In-Reply-To: <50F0199D.4090502@teksavvy.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 01/11/2013 08:54 AM, Mark Lord wrote:
> On 13-01-11 08:53 AM, Mark Lord wrote:
>> On 13-01-09 02:17 PM, Tejun Heo wrote:
>>>
>>> Having a module option is easy and can be helpful for the very rare
>>> cases where the admin is aware of the issue, but, in general, it
>>> doesn't really help that much.
>>
>> How about a sysfs attribute, rather than a boot option?
>
> NAK that idea.. a boot-time module flag is the best way.

Module options appear in sysfs anyway.

If the issue continues to be seen, a knob to enable an ugly solution is 
better than nothing, from the user's perspective.

	Jeff




