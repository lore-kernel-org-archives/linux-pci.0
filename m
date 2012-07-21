Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from blu0-omc4-s25.blu0.hotmail.com ([65.55.111.164]:55037 "EHLO
	blu0-omc4-s25.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751807Ab2GULbg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 21 Jul 2012 07:31:36 -0400
Message-ID: <BLU0-SMTP22B0A9F65ED7FF5C20327FB7DF0@phx.gbl>
Date: Sat, 21 Jul 2012 12:31:24 +0100
From: Rob Allen <ra-kernel@hotmail.co.uk>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: linuxram@us.ibm.com, stefanr@s5r6.in-berlin.de, clemens@ladisch.de,
	linux1394-devel@lists.sourceforge.net, linux-pci@vger.kernel.org
Subject: Re: [Bug 43244] New: firewire_ohci prevents boot
References: <20120513221357.7574ae79@stein> <4FB0A6F6.9050504@ladisch.de> <CAE9FiQXA4C8hACXChokL4CZVBDhdh17Qs7tngn5q-pS0U5=bPQ@mail.gmail.com> <BLU0-SMTP12B809D527F768CCC42B18B7180@phx.gbl> <4FB3B159.2090401@ladisch.de> <BLU0-SMTP47479D78AA811CB0B224ADFB71D0@phx.gbl> <4FBAA3A5.4070200@ladisch.de> <20120524202610.5c561d99@stein> <4FBE8146.1030803@hotmail.co.uk> <BLU0-SMTP435F81F04D60963F0755BA9B70F0@phx.gbl> <20120605025422.GB6637@ram-ThinkPad-T61> <BLU0-SMTP4409FB70A51AD516797B0B1B7FF0@phx.gbl> <BAY153-W382DF41517C8EA770817E4B7EB0@phx.gbl> <CAE9FiQXbo984cn-oXOZHZ6pbH4TsxZyKCwT3Fu5g_OJxGw4UZg@mail.gmail.com> <4FF5F09C.5020507@hotmail.co.uk>
In-Reply-To: <4FF5F09C.5020507@hotmail.co.uk>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Yinghai,

Is there anything else you need to diagnose the bug? Do you have any 
further thoughts?

Thanks,
Rob

On 05/07/12 20:53, Rob Allen wrote:
> On 01/07/12 21:56, Yinghai Lu wrote:
>> working one:
>>     Region 0: Memory at d0402000 (32-bit, non-prefetchable) [size=4K]
>>     Region 1: Memory at d0403000 (32-bit, non-prefetchable) [size=2K]
>> not working one:
>>     Region 0: Memory at d0401000 (32-bit, non-prefetchable) [disabled]
>> [size=4K]
>>     Region 1: Memory at d0403000 (32-bit, non-prefetchable) [disabled]
>> [size=2K]
>>
>> can not understand why could make a difference.
>>
>> please try boot with pci=resource_alignment=13@a0:09.4
>
> I tried it with both the working and non-working kernels. No change in
> overall behaviour: working still works, non-working still hangs. I
> checked the memory layouts with lspci, and in each case they were
> identical to those quoted above.
>
> Do you need any log output from those? Is there anything else I can do?
>
> Thanks,
> Rob

