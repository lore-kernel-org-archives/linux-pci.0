Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:56891 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752642AbaH2Oo2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 29 Aug 2014 10:44:28 -0400
Message-ID: <540091D1.1040902@canonical.com>
Date: Fri, 29 Aug 2014 16:44:33 +0200
From: David Henningsson <david.henningsson@canonical.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] Add pci=assign-busses quirk to Dell Latitude D505
References: <1409303414-5196-1-git-send-email-david.henningsson@canonical.com> <CAErSpo5v82xeYGqsiWXpfQdr8kF9x+1K4gjYremfCh3fNQ8Unw@mail.gmail.com>
In-Reply-To: <CAErSpo5v82xeYGqsiWXpfQdr8kF9x+1K4gjYremfCh3fNQ8Unw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 2014-08-29 16:22, Bjorn Helgaas wrote:
> On Fri, Aug 29, 2014 at 3:10 AM, David Henningsson
> <david.henningsson@canonical.com> wrote:
>> Under a 3.16 based kernel (Ubuntu 3.16.0-031600-lowlatency),
>> CardBus is not working unless pci=assign-buses is added to the
>> kernel boot parameters.
>>
>> Signed-off-by: David Henningsson <david.henningsson@canonical.com>
>> ---
>>   arch/x86/pci/common.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> It was working OOTB on a 3.2 based kernel (Ubuntu 3.2.0-67-generic),
>> and I have not thoroughly bisected what made it stop working.
>> Still I'm suggesting to just a quirk to make it work regardless of
>> kernel - it's a ~8 year old laptop, so being a bit lazy about it is
>> probably okay, I hope. :-)
>
> Please open a bugzilla and attach complete "lspci -vv" output and
> dmesg logs from the working 3.2 kernel and a non-working current
> kernel.
>
> The quirk might be OK, but it would be better if we could make a
> generic fix that would work on more machines than just this one.

All right, you can now find the requested information in this bug:

https://bugzilla.kernel.org/show_bug.cgi?id=83441

>
>>
>> Extract from dmidecode:
>>
>> Handle 0x0100, DMI type 1, 25 bytes
>> System Information
>>          Manufacturer: Dell Inc.
>>          Product Name: Latitude D505
>>
>> diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
>> index 059a76c..1849e39 100644
>> --- a/arch/x86/pci/common.c
>> +++ b/arch/x86/pci/common.c
>> @@ -262,6 +262,14 @@ static const struct dmi_system_id pciprobe_dmi_table[] = {
>>                          DMI_MATCH(DMI_PRODUCT_NAME, "SX20S"),
>>                  },
>>          },
>> +       {
>> +               .callback = assign_all_busses,
>> +               .ident = "Dell Latitude D505 Laptop",
>> +               .matches = {
>> +                       DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
>> +                       DMI_MATCH(DMI_PRODUCT_NAME, "Latitude D505"),
>> +               },
>> +       },
>>   #endif         /* __i386__ */
>>          {
>>                  .callback = set_bf_sort,
>> --
>> 1.9.1
>>
>

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
