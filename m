Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:59155 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759034Ab3GZRIn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 26 Jul 2013 13:08:43 -0400
Received: by mail-ob0-f175.google.com with SMTP id xn12so4702096obc.6
        for <linux-pci@vger.kernel.org>; Fri, 26 Jul 2013 10:08:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQUmetaXJ-=d3HV-AiaeEEh_ehdbT5E=Mrm7d7Z7y78Tng@mail.gmail.com>
References: <1374759098-6746-1-git-send-email-yinghai@kernel.org>
 <CAErSpo79rJZuEkJB+W0XGq-sKUDwTgrG5SVzJbFBqobLY2+nGQ@mail.gmail.com> <CAE9FiQUmetaXJ-=d3HV-AiaeEEh_ehdbT5E=Mrm7d7Z7y78Tng@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 26 Jul 2013 11:08:22 -0600
Message-ID: <CAErSpo5KZkxJ+rwkmEUKEPRuj1nZ=7xv8Y9m0T6yp9Jo=FXPbw@mail.gmail.com>
Subject: Re: [PATCH v6] PCI: Don't let mmio fallback to must-only, if ioport
 fails with must+optional
To: Yinghai Lu <yinghai@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 26, 2013 at 6:57 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Thu, Jul 25, 2013 at 1:35 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> On Thu, Jul 25, 2013 at 7:31 AM, Yinghai Lu <yinghai@kernel.org> wrote:
>>> BenH reported that there are assign unassigned resource problems
>>> in powerpc.
>>>
>>> It turns out after
>>> | commit 0c5be0cb0edfe3b5c4b62eac68aa2aa15ec681af
>>> | Date:   Thu Feb 23 19:23:29 2012 -0800
>>> |
>>> |    PCI: Retry on IORESOURCE_IO type allocations
>>>
>>> even for root bus that does not have io port range, it will keep retrying
>>> to realloc with mmio after mmio allocation work in first try already.
>>>
>>> Current retry logic is : try with must+optional at first, and if
>>> it fails with any ioport or mmio, it will try must then try to extend
>>> must with optional. The reassign will put extended mmio or pref mmio
>>> in the middle of parent resource range.
>>> That will prevent other sibling resources from getting must-have resources
>>> or get extended properly.
>>>
>>> We can check fail type to see if can we need fall back to must-have
>>> for it only, that will keep others type to keep resource to have
>>> must+optional allocations.
>>>
>>> Separate three resource type checking if we need to release
>>> assigned resource after requested + add_size try.
>>> 1. if there is io port assign fail, will release assigned io port.
>>> 2. if there is pref mmio assign fail, release assigned pref mmio.
>>>    if assigned pref mmio's parent is non-pref mmio and there
>>>    is non-pref mmio assign fail, will release that assigned pref mmio.
>>> 3. if there is non-pref mmio assign fail or pref mmio assigned fail,
>>>    will release assigned non-pref mmio.
>>>
>>> This will be become more often when we have x86 8 sockets or 32 sockets
>>> system, and those systems will have one root bus per socket.
>>> They will have some root buses that do not have ioport range or 32bit mmio.
>>>
>>> -v2: need to remove assigned entries from optional list too.
>>> -v3: not just checking ioport related, requested by Bjorn.
>>>
>>> Reported-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>
>> I forgot; is there a mailing list archive URL for this report?
>
> yes, should be
>
> http://marc.info/?l=linux-pci&m=136941328913610&w=1
>
> title is: Resource assignment oddities
>
>
>>
>> And did you say this should go to stable for v3.10+?  If that's the
>> case, this should probably go in my for-linus branch for v3.11 instead
>> of waiting for v3.12, right?
>
> Yes. You are right.
>
> BenH at last only hope it could backport to v3.10 for the distribution.

OK, I applied this to for-linus and marked it for stable.  Please take
a look and see if it makes sense, especially the changelog:

http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?h=for-linus&id=aa914f5
