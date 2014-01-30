Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:60504 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117AbaA3Fb0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jan 2014 00:31:26 -0500
Received: by mail-lb0-f181.google.com with SMTP id z5so2128827lbh.26
        for <linux-pci@vger.kernel.org>; Wed, 29 Jan 2014 21:31:25 -0800 (PST)
Message-ID: <52E9E3AB.1040805@gmail.com>
Date: Thu, 30 Jan 2014 09:31:23 +0400
From: `VL <vl.homutov@gmail.com>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: pci->pcie bridge issue: kernel unable to find a free I/O port
 range.
References: <52CBC4D1.5080706@gmail.com>	<CAErSpo7bUchKT5WN+BBq6oKn+O62gWbH+gfaruePBAYrvP7Lmw@mail.gmail.com>	<52CD2387.2030403@gmail.com>	<CAE9FiQV5r-c4ufd2SqLJk-KcoJhucmr6RszUb0LyUFtgq_a5sg@mail.gmail.com>	<52CE301E.60108@gmail.com>	<CAE9FiQWxpRMX-0vyd5hML-Hnto8H+C83dcne9FBZcN9qsmGCEw@mail.gmail.com>	<52CF7A17.60703@gmail.com>	<CAE9FiQVPtNk2LN4TVMzXX72TN8bjDTyD74y_BH05rfw=NArD3Q@mail.gmail.com>	<52D102EF.5070303@gmail.com>	<CAE9FiQU=4qABcZLJzF13aYSmzryB1=WkO+NYvs0LTj9Kt_1ajA@mail.gmail.com> <CAA__XvTqOtfqzFAdSuUBdr-YAe5SxhUg_FPXr3xvibio_CqbXg@mail.gmail.com> <52D6CEC6.2000901@gmail.com>
In-Reply-To: <52D6CEC6.2000901@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 15.01.2014 22:09, `VL wrote:
> On 15.01.2014 13:10, `VL wrote:
>>> looks like the your adapter need more time to settle down?
>>> Can you check if you can enable slow boot mode in BIOS setup?
>> yes, probably. I'll try to repeat steps with disabled fast boot.
> no, this is not the case. I've disabled all fast boot in BIOS and nothing
> changed in logs.
>
> so this is the best of what we have:
> http://inspert.ru/pci/dmesg-earlydump.txt
>
> I was also able to reproduce the issue without pci=realloc. I have 
> disabled
> all builtin devices on motherboard (unused controllers, NICs and audio).
> Looks like in this conditions kernel was able to allocate some resource
> and hang during snd_ice1712 driver load.
>
> Attached is the photo of boot with this situation.
> Unfortunately, since NICs are disabled and there is no serial onboard,
> I cannot provide full log.
>
up: any concluision/suggestions?
