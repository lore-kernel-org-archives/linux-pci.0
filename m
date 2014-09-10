Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:35591 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752716AbaIJTu7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 10 Sep 2014 15:50:59 -0400
Received: by mail-ig0-f178.google.com with SMTP id hn18so6994715igb.5
        for <linux-pci@vger.kernel.org>; Wed, 10 Sep 2014 12:50:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo6DDCkrew8rwkNX8=gzc19vErY5iafPBN4oKw_Ww792=g@mail.gmail.com>
References: <1409303414-5196-1-git-send-email-david.henningsson@canonical.com>
 <CAErSpo5v82xeYGqsiWXpfQdr8kF9x+1K4gjYremfCh3fNQ8Unw@mail.gmail.com>
 <540091D1.1040902@canonical.com> <CAErSpo6D+8KwM9LJC4VFCtGbQ65zh_2ZjNOuP-JQB1bmt5dwCw@mail.gmail.com>
 <CAErSpo6DDCkrew8rwkNX8=gzc19vErY5iafPBN4oKw_Ww792=g@mail.gmail.com>
From: Andreas Noever <andreas.noever@gmail.com>
Date: Wed, 10 Sep 2014 21:50:38 +0200
Message-ID: <CAMxnaaVB47+qnC5BAbVuLJfYZ4=5Ur-Vdbi9VguNYEv4bfTt+g@mail.gmail.com>
Subject: Re: [PATCH] Add pci=assign-busses quirk to Dell Latitude D505
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: David Henningsson <david.henningsson@canonical.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 10, 2014 at 8:08 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> [+cc Andreas]
>
> On Fri, Aug 29, 2014 at 11:36 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> On Fri, Aug 29, 2014 at 8:44 AM, David Henningsson
>> <david.henningsson@canonical.com> wrote:
>>>
>>>
>>> On 2014-08-29 16:22, Bjorn Helgaas wrote:
>>>>
>>>> On Fri, Aug 29, 2014 at 3:10 AM, David Henningsson
>>>> <david.henningsson@canonical.com> wrote:
>>>>>
>>>>> Under a 3.16 based kernel (Ubuntu 3.16.0-031600-lowlatency),
>>>>> CardBus is not working unless pci=assign-buses is added to the
>>>>> kernel boot parameters.
>>>>>
>>>>> Signed-off-by: David Henningsson <david.henningsson@canonical.com>
>>>>> ---
>>>>>   arch/x86/pci/common.c | 8 ++++++++
>>>>>   1 file changed, 8 insertions(+)
>>>>>
>>>>> It was working OOTB on a 3.2 based kernel (Ubuntu 3.2.0-67-generic),
>>>>> and I have not thoroughly bisected what made it stop working.
>>>>> Still I'm suggesting to just a quirk to make it work regardless of
>>>>> kernel - it's a ~8 year old laptop, so being a bit lazy about it is
>>>>> probably okay, I hope. :-)
>>>>
>>>>
>>>> Please open a bugzilla and attach complete "lspci -vv" output and
>>>> dmesg logs from the working 3.2 kernel and a non-working current
>>>> kernel.
>>>>
>>>> The quirk might be OK, but it would be better if we could make a
>>>> generic fix that would work on more machines than just this one.
>>>
>>>
>>> All right, you can now find the requested information in this bug:
>>>
>>> https://bugzilla.kernel.org/show_bug.cgi?id=83441
>>
>> Thanks very much.
>>
>> I'm going to resist adding a quirk as long as I can, because quirks
>> tend to paper over issues on individual systems without actually
>> fixing the underlying problem.  Unfortunately, I'm swamped at the
>> moment and won't be able to work on this for a while.  It would be
>> ideal if we could bisect this and pinpoint where the problem started.
>> Bisecting changes to drivers/pci would be sufficient.
>>
>>>>> Extract from dmidecode:
>>>>>
>>>>> Handle 0x0100, DMI type 1, 25 bytes
>>>>> System Information
>>>>>          Manufacturer: Dell Inc.
>>>>>          Product Name: Latitude D505
>>>>>
>>>>> diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
>>>>> index 059a76c..1849e39 100644
>>>>> --- a/arch/x86/pci/common.c
>>>>> +++ b/arch/x86/pci/common.c
>>>>> @@ -262,6 +262,14 @@ static const struct dmi_system_id
>>>>> pciprobe_dmi_table[] = {
>>>>>                          DMI_MATCH(DMI_PRODUCT_NAME, "SX20S"),
>>>>>                  },
>>>>>          },
>>>>> +       {
>>>>> +               .callback = assign_all_busses,
>>>>> +               .ident = "Dell Latitude D505 Laptop",
>>>>> +               .matches = {
>>>>> +                       DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
>>>>> +                       DMI_MATCH(DMI_PRODUCT_NAME, "Latitude D505"),
>>>>> +               },
>>>>> +       },
>>>>>   #endif         /* __i386__ */
>>>>>          {
>>>>>                  .callback = set_bf_sort,
>
> v3.16 fails with:
>
>   pci 0000:01:01.0: can't allocate child bus 01 from [bus 01]
>
> which Andreas added with fc1b253141b3 ("PCI: Don't scan random busses
> in pci_scan_bridge()").  But I don't understand that code well enough
> to know whether this commit is actually the cause of the problem.
Looks like my commit is at fault. The parent bridge 00:1e has
secondary=subordinate=1 assigned by the BIOS. My commit then refuses
to assign a secondary bus to 01:01 because the parent's bus window has
been exhausted.

Before fc1b253141b3, we ignored the parent's bus window and simply
created a new bus #2. If bus #2 had already existed elsewhere then we
would have rescanned it, which was the (potential) problem patch was
trying to address. Much later yenta_socket fixes the parent bridge.
See http://lxr.free-electrons.com/source/drivers/pcmcia/yenta_socket.c#L1077

Could move the yenta quirk to pci_scan_bridge or trigger a rescan from
the yenta driver after the fixup is done?


> And I also haven't figured out how "pci=assign-busses" makes a difference.
I'd guess that with pci=assign-busses we set size the parent bridge correctly.


> David, would you mind turning on CONFIG_DYNAMIC_DEBUG=y in your v3.16
> kernel, adding  'dyndbg="file probe.c +p"' to your boot arguments, and
> collecting another dmesg log?
>
> Bjorn
