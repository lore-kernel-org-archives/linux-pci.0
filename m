Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:49556 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751861AbbHGAcY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 6 Aug 2015 20:32:24 -0400
Message-ID: <55C3FC93.6090008@roeck-us.net>
Date: Thu, 06 Aug 2015 17:32:19 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v3] PCI: Only enable IO window if supported
References: <1438308908-12259-1-git-send-email-linux@roeck-us.net>	<CAE9FiQXuTKmXXCFsKUiMK43U+LpOzfa3oV0iNWS+Jh879EDNsw@mail.gmail.com>	<CAE9FiQVGhfbFW5-5deYcU2bDWE9k0-4+V+cepwdqZ661sLWOFA@mail.gmail.com>	<55C2C4F4.1040600@roeck-us.net>	<CAE9FiQXtSDBFy1rf4TPHwD-JjoB+5Wii1MBMBfGTaNosqnRJGg@mail.gmail.com>	<55C2E79E.3090809@roeck-us.net>	<CAE9FiQVDwX_-bX9sH2qv3thkKzOosFR3WvkUYWM=TsU-4oOSzA@mail.gmail.com>	<55C388CF.4090501@roeck-us.net> <CAE9FiQUeY-aocR=vwRUopuERJc0uUWKMwDafqLHo2baeVG7cKg@mail.gmail.com>
In-Reply-To: <CAE9FiQUeY-aocR=vwRUopuERJc0uUWKMwDafqLHo2baeVG7cKg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 08/06/2015 04:32 PM, Yinghai Lu wrote:
> On Thu, Aug 6, 2015 at 9:18 AM, Guenter Roeck <linux@roeck-us.net> wrote:
>> On 08/06/2015 08:58 AM, Yinghai Lu wrote:
>
>> Ok, I admit that I am lost. Earlier it seemed that you were concerned about
>> this case, where no io window is available or a bus doesn't support io,
>> but a non-transparent child does. Now you seem to say that the
>> non-transparent
>> child would not be able to support IO either.
>>
>> For my education, can you list the possible options, and how you suggest
>> to solve them ? I can see the following situations.
>>
>> - root supports IO, but has no io window assigned
>> - root does not support IO and has or has not an IO window assigned
>> - a bridge does not support IO
>
> should have two cases:
> 1. root bus does not have io window exposed.
> 2. pci bridge io bar is not writable.
>
>>
>> For the transparent case, each of those should result in all children
>> not even trying to assign an IO window, which is what we want,
>> and what my patc set tries to do.
>>
>> How should those cases be handled for non-transparent bridges ?
>
> for case 2: current upstream code, no warning for the bridge itself,
> but have warning for devices under the bridge.
>

That warning is what I am trying to get rid of, because it is repeated
dozens of times with zero value.

> We only need to handle case 1, aka root bus does not have io port window.
>
> What about your setup, is it case 1 or case 2?
>

Assuming case 1) includes case 3), root bridge does not support IO,
I have both case 1 and 2.

Anyway, I think I am giving up. Sorry, I just fail to understand the
use case(s) you are trying to cover.

Why don't you submit a patch, I'll test it if it works for my use
case, and if it works we ask Bjorn to apply it. My problem is quite
simple: I don't want to get flooded with useless "no IO window" messages.
How it is solved doesn't matter to me, as long as it is solved.
Since you have a strong opinion on how it should be solved, we should
go with your solution and not keep turning in circles forever.

Thanks
Guenter

