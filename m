Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <5586FAAB.3050303@linux.intel.com>
Date: Mon, 22 Jun 2015 01:55:55 +0800
From: Jiang Liu <jiang.liu@linux.intel.com>
MIME-Version: 1.0
To: Boszormenyi Zoltan <zboszor@pr.hu>,
	Bjorn Helgaas <bhelgaas@google.com>
CC: Andreas Mohr <andi@lisas.de>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: ACPI regression? Was Re: Ethernet chip disappeared from lspci
References: <55841815.5000701@pr.hu> <558419B2.7010703@pr.hu> <55841D48.8080809@pr.hu> <12950452.K8inU2UIYe@vostro.rjw.lan> <55869329.4040908@pr.hu> <CAErSpo4W9N+vtqNM=b24Temh16JHHT4ANk_NwUxjPysMGcJVfA@mail.gmail.com> <5586C7E2.9070902@pr.hu> <5586F371.2040100@linux.intel.com>
In-Reply-To: <5586F371.2040100@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/6/22 1:25, Jiang Liu wrote:
[...]
>>>> -       Memory behind bridge: 80000000-801fffff
>>>> -       Prefetchable memory behind bridge: 0000000080200000-00000000803fffff
>>>> +       Memory behind bridge: ff000000-ff1fffff
>>>> +       Prefetchable memory behind bridge: 00000000ff200000-00000000ff3fffff
>>>>
>>>> Can't this cause a problem? E.g. programming the bridge with an address range
>>>> that the bridge doesn't actually support?
>>> This worked in v3.18.16, but not in v4.0.5 or v4.1.0-rc8.  You
>>> attached a v4.1.0-rc8 dmesg log earlier.  Would you mind collecting a
>>> v3.18.16 dmesg log, so we can compare them?
>>
>> I collected all 3 for you to compare them, compressed, attached.
>>
>> BTW, I browsed git log and found 2ea3d266bab3b497238113b20136f7c3f69ad9c0
>> as suspicious. I will try the 4.0/4.1 kernels with this one reverted.
>>
>>>
>>> These (from the v4.1.0-rc8 dmesg) look wrong, but I'll have to look at
>>> the code to see what might be going on:
>>>
>>>   acpi PNP0A08:00: host bridge window expanded to [mem
>>> 0x00000000-0xffffffff window]; [mem 0x00000000-0xffffffff window]
>>> ignored
>>>   pci 0000:00:1c.1: can't claim BAR 15 [mem 0xfdf00000-0xfdffffff
>>> 64bit pref]: address conflict with PCI Bus 0000:00 [mem
>>> 0xf0000000-0xfed8ffff window]
>>>
>>> Bjorn
> Hi Bjorn and Boszormenyi,
> 	From the 3.18 kernel, we got a message:
> [    0.126248] acpi PNP0A08:00: host bridge window
> [0x400000000-0xfffffffff] (ignored, not CPU addressable)
> 	And from 4.1.-rc8, we got another message:
> [    0.127051] acpi PNP0A08:00: host bridge window expanded to [mem
> 0x00000000-0xffffffff window]; [mem 0x00000000-0xffffffff window] ignored
> 
> That smells like a 32bit overflow or 64bit cut-off issue.
Hi Bjorn and Boszormenyi,
	With v3.18.6, it uses u64 to compare resource ranges. We changed to use
resource_size_t with recent changes, and resource_size_t
may be u32 or u64 depending on configuration. So resource range
[0x400000000-0xfffffffff] may have been cut-off as
[0x00000000-0xffffffff], thus cause the trouble.

Hi Boszormenyi,
	Could you please help to try following test patch?
against v4.1-rc8?
Thanks!
Gerry
-------------------------------------------------------------------
diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 8244f013f210..d7b8c392c420 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -206,6 +206,11 @@ static bool acpi_decode_space(struct resource_win *win,

        res->start = attr->minimum;
        res->end = attr->maximum;
+       if (res->start != attr->minimum || res->end != attr->maximum) {
+               pr_warn("resource window ([%#llx-%#llx] ignored, not CPU
addressable)\n",
+                       attr->minimum, attr->maximum);
+               return false;
+       }

        /*
         * For bridges that translate addresses across the bridge,
-----------------------------------------------------------------------------
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
