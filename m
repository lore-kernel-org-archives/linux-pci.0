Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:46729 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750702AbaAIFOI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jan 2014 00:14:08 -0500
Received: by mail-lb0-f177.google.com with SMTP id q8so1953805lbi.36
        for <linux-pci@vger.kernel.org>; Wed, 08 Jan 2014 21:14:07 -0800 (PST)
Message-ID: <52CE301E.60108@gmail.com>
Date: Thu, 09 Jan 2014 09:14:06 +0400
From: `VL <vl.homutov@gmail.com>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: pci->pcie bridge issue: kernel unable to find a free I/O port
 range.
References: <52CBC4D1.5080706@gmail.com>	<CAErSpo7bUchKT5WN+BBq6oKn+O62gWbH+gfaruePBAYrvP7Lmw@mail.gmail.com>	<52CD2387.2030403@gmail.com> <CAE9FiQV5r-c4ufd2SqLJk-KcoJhucmr6RszUb0LyUFtgq_a5sg@mail.gmail.com>
In-Reply-To: <CAE9FiQV5r-c4ufd2SqLJk-KcoJhucmr6RszUb0LyUFtgq_a5sg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I've put all logs here: http://inspert.ru/pci/

On 09.01.2014 00:28, Yinghai Lu wrote:
> On Wed, Jan 8, 2014 at 2:08 AM, `VL <vl.homutov@gmail.com> wrote:
>> I've enabled netconsole and got some output.
>> Here it is: http://dpaste.com/1542030/
> It does include any realloc message.
not sure I understood you.
The message I was talking about is:

Jan  8 12:51:52 10 Some PCI device resources are unassigned, try booting 
with pci=realloc

and you can see it in this log: 
http://inspert.ru/pci/netconsole-norealloc.txt

The kernel hangs if I add this option.
>
>> Note that since the hang occurs on the module load, netconsole was 
>> unable
>> to send latest messages and the log looks clear
>>
>> I've rebuilt kernel with sound driver compiled in, and the hang occured
>> during
>> kernel load, userspace was not reached (but in this case, netconsole was
>> useless at
>> all) and I've made a photo of screen (attached). Note there is ACPI 
>> warning
>> about
>> system IO conflict.
> Can you enable
>
> CONFIG_PCI_DEBUG=y
>
> and boot with "debug ignore_loglevel initcall_debug"?

Here it is: http://inspert.ru/pci/netconsole-pcidebug.txt

(problem is when snd_ice17 is loaded; this is for the card installed 
into adapter)
>
> Thanks
>
> Yinghai

