Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:34498 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755889Ab1LODoQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 14 Dec 2011 22:44:16 -0500
MIME-Version: 1.0
In-Reply-To: <CAHM4w1k-uA1CpbvDAz4ZhETf9_RN1kxf6btXNbxEAvNw6M57rw@mail.gmail.com>
References: <CAHM4w1kc+5aYWH-09BPTXZdo8+iguFjORKs7mMhG7hea2UU8yQ@mail.gmail.com>
	<CAHM4w1nZ7GgutiuDiTCKu9wUuphn8qOiWgmCYVXXvwW1q8CgoA@mail.gmail.com>
	<20111122150613.GA322@google.com>
	<CAHM4w1nsNTQmAL-0d76O9cYXjNbiq-0f60Y3emWO2yf7HyFWDg@mail.gmail.com>
	<20111123162937.GF25780@google.com>
	<20111123144735.64dc9f05@jbarnes-desktop>
	<CAOS58YPM29xi4Jq5L16fjDQDRzv-yc67tp_yqSwoiFBBbtCZkw@mail.gmail.com>
	<CAHM4w1k-uA1CpbvDAz4ZhETf9_RN1kxf6btXNbxEAvNw6M57rw@mail.gmail.com>
Date: Thu, 15 Dec 2011 09:14:15 +0530
Message-ID: <CAHM4w1kvz5BXf=7+QgibV3gY5wqOpJXSgd0_X+2_0DGhkSGgKg@mail.gmail.com>
Subject: Re: Crash with sata_sil24 driver
From: Pratyush Anand <pratyush.anand@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pci@vger.kernel.org,
	linux-ide@vger.kernel.org, Russell King <linux@arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Tejun,

Any suugestion to resolve this issue?

Regards
Pratyush

On Thu, Nov 24, 2011 at 10:06 AM, Pratyush Anand
<pratyush.anand@gmail.com> wrote:
> On Thu, Nov 24, 2011 at 7:18 AM, Tejun Heo <tj@kernel.org> wrote:
>> Hello,
>>
>> On Wed, Nov 23, 2011 at 2:47 PM, Jesse Barnes <jbarnes@virtuousgeek.org> wrote:
>>>> Weird, that basically means that somehow pci_iomap() isn't
>>>> synchronous.  ie. you need to way some time after pci_iomap() before
>>>> being able to access the mapped address.  Seems like arch / pci
>>>> weirdness.  Jesse, Russell, any ideas?
>>>
>>> As Russel said, pci_iomap shouldn't be async.  But maybe something else
>>> in the init function is doing a chip reset or causing the chip to go
>>> off into the weeds for a short time?  That's generally the cause of
>>> target timeouts for PCI devices.
>>
>> Yeah, that's much more plausible. Weird that it doesn't happen on x86
>> tho. Maybe different timeouts? Pratyush, can you look at bus trace and
>> see what's going on?
>
> It also does not happen always with ARM too.  As said earlier only
> when I run the system at increased CPU frequency.
> Do you suggest to trace PCIe bus using PCIe bus analyser. I can arange
> analyser to do that. But I do not see any kind of abort (like PCIe
> host/target abort) in this case. So will it really help?
> Is it possible to share datasheet of SIL3531?
>
> Regards
> Pratyush
>
>>
>> Thanks.
>>
>> --
>> tejun
>>
