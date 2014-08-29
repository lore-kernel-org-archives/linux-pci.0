Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qg0-f46.google.com ([209.85.192.46]:33873 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752806AbaH2RhS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 29 Aug 2014 13:37:18 -0400
Received: by mail-qg0-f46.google.com with SMTP id q107so2552871qgd.5
        for <linux-pci@vger.kernel.org>; Fri, 29 Aug 2014 10:37:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <540091D1.1040902@canonical.com>
References: <1409303414-5196-1-git-send-email-david.henningsson@canonical.com>
 <CAErSpo5v82xeYGqsiWXpfQdr8kF9x+1K4gjYremfCh3fNQ8Unw@mail.gmail.com> <540091D1.1040902@canonical.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 29 Aug 2014 11:36:56 -0600
Message-ID: <CAErSpo6D+8KwM9LJC4VFCtGbQ65zh_2ZjNOuP-JQB1bmt5dwCw@mail.gmail.com>
Subject: Re: [PATCH] Add pci=assign-busses quirk to Dell Latitude D505
To: David Henningsson <david.henningsson@canonical.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 29, 2014 at 8:44 AM, David Henningsson
<david.henningsson@canonical.com> wrote:
>
>
> On 2014-08-29 16:22, Bjorn Helgaas wrote:
>>
>> On Fri, Aug 29, 2014 at 3:10 AM, David Henningsson
>> <david.henningsson@canonical.com> wrote:
>>>
>>> Under a 3.16 based kernel (Ubuntu 3.16.0-031600-lowlatency),
>>> CardBus is not working unless pci=assign-buses is added to the
>>> kernel boot parameters.
>>>
>>> Signed-off-by: David Henningsson <david.henningsson@canonical.com>
>>> ---
>>>   arch/x86/pci/common.c | 8 ++++++++
>>>   1 file changed, 8 insertions(+)
>>>
>>> It was working OOTB on a 3.2 based kernel (Ubuntu 3.2.0-67-generic),
>>> and I have not thoroughly bisected what made it stop working.
>>> Still I'm suggesting to just a quirk to make it work regardless of
>>> kernel - it's a ~8 year old laptop, so being a bit lazy about it is
>>> probably okay, I hope. :-)
>>
>>
>> Please open a bugzilla and attach complete "lspci -vv" output and
>> dmesg logs from the working 3.2 kernel and a non-working current
>> kernel.
>>
>> The quirk might be OK, but it would be better if we could make a
>> generic fix that would work on more machines than just this one.
>
>
> All right, you can now find the requested information in this bug:
>
> https://bugzilla.kernel.org/show_bug.cgi?id=83441

Thanks very much.

I'm going to resist adding a quirk as long as I can, because quirks
tend to paper over issues on individual systems without actually
fixing the underlying problem.  Unfortunately, I'm swamped at the
moment and won't be able to work on this for a while.  It would be
ideal if we could bisect this and pinpoint where the problem started.
Bisecting changes to drivers/pci would be sufficient.

>>> Extract from dmidecode:
>>>
>>> Handle 0x0100, DMI type 1, 25 bytes
>>> System Information
>>>          Manufacturer: Dell Inc.
>>>          Product Name: Latitude D505
>>>
>>> diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
>>> index 059a76c..1849e39 100644
>>> --- a/arch/x86/pci/common.c
>>> +++ b/arch/x86/pci/common.c
>>> @@ -262,6 +262,14 @@ static const struct dmi_system_id
>>> pciprobe_dmi_table[] = {
>>>                          DMI_MATCH(DMI_PRODUCT_NAME, "SX20S"),
>>>                  },
>>>          },
>>> +       {
>>> +               .callback = assign_all_busses,
>>> +               .ident = "Dell Latitude D505 Laptop",
>>> +               .matches = {
>>> +                       DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
>>> +                       DMI_MATCH(DMI_PRODUCT_NAME, "Latitude D505"),
>>> +               },
>>> +       },
>>>   #endif         /* __i386__ */
>>>          {
>>>                  .callback = set_bf_sort,
>>> --
>>> 1.9.1
>>>
>>
>
> --
> David Henningsson, Canonical Ltd.
> https://launchpad.net/~diwic
