Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <55871787.5080504@pr.hu>
Date: Sun, 21 Jun 2015 21:59:03 +0200
From: Boszormenyi Zoltan <zboszor@pr.hu>
MIME-Version: 1.0
To: Jiang Liu <jiang.liu@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>
CC: Andreas Mohr <andi@lisas.de>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: ACPI regression? Was Re: Ethernet chip disappeared from lspci
References: <55841815.5000701@pr.hu> <558419B2.7010703@pr.hu> <55841D48.8080809@pr.hu> <12950452.K8inU2UIYe@vostro.rjw.lan> <55869329.4040908@pr.hu> <CAErSpo4W9N+vtqNM=b24Temh16JHHT4ANk_NwUxjPysMGcJVfA@mail.gmail.com> <5586C7E2.9070902@pr.hu> <5586F371.2040100@linux.intel.com> <5586FAAB.3050303@linux.intel.com> <558708B5.5000706@pr.hu>
In-Reply-To: <558708B5.5000706@pr.hu>
Content-Type: text/plain; charset=utf-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

2015-06-21 20:55 keltezéssel, Boszormenyi Zoltan írta:
> 2015-06-21 19:55 keltezéssel, Jiang Liu írta:
>> On 2015/6/22 1:25, Jiang Liu wrote:
>> [...]
>>>>>> -       Memory behind bridge: 80000000-801fffff
>>>>>> -       Prefetchable memory behind bridge: 0000000080200000-00000000803fffff
>>>>>> +       Memory behind bridge: ff000000-ff1fffff
>>>>>> +       Prefetchable memory behind bridge: 00000000ff200000-00000000ff3fffff
>>>>>>
>>>>>> Can't this cause a problem? E.g. programming the bridge with an address range
>>>>>> that the bridge doesn't actually support?
>>>>> This worked in v3.18.16, but not in v4.0.5 or v4.1.0-rc8.  You
>>>>> attached a v4.1.0-rc8 dmesg log earlier.  Would you mind collecting a
>>>>> v3.18.16 dmesg log, so we can compare them?
>>>> I collected all 3 for you to compare them, compressed, attached.
>>>>
>>>> BTW, I browsed git log and found 2ea3d266bab3b497238113b20136f7c3f69ad9c0
>>>> as suspicious. I will try the 4.0/4.1 kernels with this one reverted.
>>>>
>>>>> These (from the v4.1.0-rc8 dmesg) look wrong, but I'll have to look at
>>>>> the code to see what might be going on:
>>>>>
>>>>>   acpi PNP0A08:00: host bridge window expanded to [mem
>>>>> 0x00000000-0xffffffff window]; [mem 0x00000000-0xffffffff window]
>>>>> ignored
>>>>>   pci 0000:00:1c.1: can't claim BAR 15 [mem 0xfdf00000-0xfdffffff
>>>>> 64bit pref]: address conflict with PCI Bus 0000:00 [mem
>>>>> 0xf0000000-0xfed8ffff window]
>>>>>
>>>>> Bjorn
>>> Hi Bjorn and Boszormenyi,
>>> 	From the 3.18 kernel, we got a message:
>>> [    0.126248] acpi PNP0A08:00: host bridge window
>>> [0x400000000-0xfffffffff] (ignored, not CPU addressable)
>>> 	And from 4.1.-rc8, we got another message:
>>> [    0.127051] acpi PNP0A08:00: host bridge window expanded to [mem
>>> 0x00000000-0xffffffff window]; [mem 0x00000000-0xffffffff window] ignored
>>>
>>> That smells like a 32bit overflow or 64bit cut-off issue.
>> Hi Bjorn and Boszormenyi,
>> 	With v3.18.6, it uses u64 to compare resource ranges. We changed to use
>> resource_size_t with recent changes, and resource_size_t
>> may be u32 or u64 depending on configuration. So resource range
>> [0x400000000-0xfffffffff] may have been cut-off as
>> [0x00000000-0xffffffff], thus cause the trouble.
>>
>> Hi Boszormenyi,
>> 	Could you please help to try following test patch?
>> against v4.1-rc8?
> I have tried it. The result (dmesg, lspci before/after modprobe) is attached.
> The "not CPU addressable" message shows up once in dmesg.
> The device shows up in lspci and the module can be loaded. The previously
> experienced sluggishness is gone now, but the network doesn't work after modprobe.
> I think it was an expected outcome, since that particular range is ignored with this patch.

Hm, I can see a very similar message in 3.18.16, so it was not
the expected outcome.

After building the "official" r8168 from Realtek for 4.1.0-rc8,
the difference in lspci from the working 3.18.16 is nil, before
and after modprobe. (r8168 was build for 3.18.16, that's why.)

However, connman (similar to NetworkManager) still sees the network
connectivity as "down". I checked that the firmware files are there in
/lib/firmware/rtl_nic.

With r8168 (the "official" Realtek driver), the kernel message about
"link up" appears immediately and connman can configure the network.

I have tried the patch on 4.0.5, too, with the same result.

So, there may be another problem with the r8169 driver itself besides
this ACPI problem but no matter what I do, I can't seem to be able
to enable debugging messages for r8169.

So, for now I can use r8168 instead of r8169 with this patch.

Thanks,
Zoltán

>
> Thanks,
> Zoltán
>
>> Thanks!
>> Gerry
>> -------------------------------------------------------------------
>> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
>> index 8244f013f210..d7b8c392c420 100644
>> --- a/drivers/acpi/resource.c
>> +++ b/drivers/acpi/resource.c
>> @@ -206,6 +206,11 @@ static bool acpi_decode_space(struct resource_win *win,
>>
>>         res->start = attr->minimum;
>>         res->end = attr->maximum;
>> +       if (res->start != attr->minimum || res->end != attr->maximum) {
>> +               pr_warn("resource window ([%#llx-%#llx] ignored, not CPU
>> addressable)\n",
>> +                       attr->minimum, attr->maximum);
>> +               return false;
>> +       }
>>
>>         /*
>>          * For bridges that translate addresses across the bridge,
>> -----------------------------------------------------------------------------
>>

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
