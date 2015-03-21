Return-Path: <linux-acpi-owner@vger.kernel.org>
Received: from 178.115.128.12.wireless.dyn.drei.com (HELO [172.16.0.2]) (bernhard.thaler@wvnet.at@[178.115.128.12])
          (envelope-sender <bernhard.thaler@wvnet.at>)
          by smtp.wvnet.at (qmail-ldap-1.03) with SMTP
          for <linux-pci@vger.kernel.org>; 21 Mar 2015 20:50:41 -0000
Message-ID: <550DD9A0.9030809@wvnet.at>
Date: Sat, 21 Mar 2015 21:50:40 +0100
From: Bernhard Thaler <bernhard.thaler@wvnet.at>
MIME-Version: 1.0
To: Jiang Liu <jiang.liu@linux.intel.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: lenb@kernel.org, linux-acpi@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [Debug 0/2] Fix regressions caused by commit 593669c2ac0f
References: <550A7674.6070306@wvnet.at> <4317184.19IeWuljky@vostro.rjw.lan> <550C5A08.3020302@wvnet.at> <2663880.nZ5V9XMenj@vostro.rjw.lan> <550D890C.5090900@linux.intel.com>
In-Reply-To: <550D890C.5090900@linux.intel.com>
In-Reply-To: : <550D890C.5090900@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 21.03.2015 16:06, Jiang Liu wrote:
> On 2015/3/21 8:47, Rafael J. Wysocki wrote:
>> On Friday, March 20, 2015 06:34:00 PM Bernhard Thaler wrote:
>>> This is a multi-part message in MIME format.
>>> --------------000805070501000906050700
>>> Content-Type: text/plain; charset=windows-1252
>>> Content-Transfer-Encoding: 7bit
>>>
>>>
>>> On 19.03.2015 12:27, Rafael J. Wysocki wrote:
>>>> On Thursday, March 19, 2015 08:10:44 AM Bernhard Thaler wrote:
>>>>> This is a multi-part message in MIME format.
>>>>> --------------000809080900050004000900
>>>>> Content-Type: text/plain; charset=windows-1252
>>>>> Content-Transfer-Encoding: 7bit
>>>>>
>>>>> Hi,
>>>>>
>>>>> I think this regression is not yet solved.
>>>>
>>>> First off, it is good to CC the commit author too (CCed now).
>>>>
>>>>> I encounter this or a similar problem with an PC Engines APU.1C device
>>>>> (see: http://pcengines.ch/apu.htm). It has 3 network interfaces each
>>>>> requiring the r8169 kernel module.
>>>>>
>>>>> With 4.0.0-rc4 I get this error message at boot (for each of the 3 devices):
>>>>>
>>>>> [    3.562301] r8169 0000:01:00.0 (unnamed net_device) (uninitialized):
>>>>> rtl_chipcmd_cond == 1 (loop: 100, delay: 100).
>>>>>
>>>>> "ifconfig -a" shows ff:ff:ff:ff:ff:ff as MAC address for each of the
>>>>> interfaces (see eth0 as example):
>>>>>
>>>>> eth0      Link encap:Ethernet  HWaddr ff:ff:ff:ff:ff:ff
>>>>>           BROADCAST PROMISC MULTICAST  MTU:1500  Metric:1
>>>>>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>>>>>           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>>>>>           collisions:0 txqueuelen:1000
>>>>>           RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
>>>>>
>>>>> The network interfaces cannot be brought up/used.
>>>>>
>>>>> The same device and setup did work with a previously used 3.18.0-rc5
>>>>> kernel. When I boot it with this 3.18.0-rc5 kernel everything i OK,
>>>>> interfaces come up and work.
>>>>
>>>> Second, it is not entirely clear to me that what you're seeing is actually
>>>> the same regression.  Have you tested 4.0.0-rc4 with commit 593669c2ac0f
>>>> reverted?
>>>>
>>> You are right, I was a bit quick about this conclusion. I based it on
>>> Thomas Voegtle
>>> bisect in http://www.spinics.net/lists/linux-pci/msg39014.html and my own
>>> observation of the same problem situation with 4.0.0-rc4.
>>>
>>> Test Results:
>>>
>>> * Everything works fine before 593669c2ac0f, network interfaces are
>>> available
>>>    and usable e.g. with 812dbd9.
>>>
>>> * The problem starts for me with 593669c2ac0f as, errors at boot, network
>>>    interfaces unusable as stated above.
>>
>> And it doesn't go away in 4.0-rc4 which indicates that the fixes applied
>> so far do not work for you.
>>
>> Gerry, can you please help here?
> Hi Bernhard,
> 	Thanks for providing acpi data. I have figured out the cause of
> the regression. Your platform defines PCI host bridge MMIO resources as:
>             Name (CRES, ResourceTemplate ()
>             {
>                 IO (Decode16,
>                     0x0CF8,             // Range Minimum
>                     0x0CF8,             // Range Maximum
>                     0x01,               // Alignment
>                     0x08,               // Length
>                     )
>                 WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode,
> EntireRange,
>                     0x0000,             // Granularity
>                     0x0000,             // Range Minimum
>                     0x0CF7,             // Range Maximum
>                     0x0000,             // Translation Offset
>                     0x0CF8,             // Length
>                     ,, , TypeStatic)
>                 WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode,
> EntireRange,
>                     0x0000,             // Granularity
>                     0x0D00,             // Range Minimum
>                     0xFFFF,             // Range Maximum
>                     0x0000,             // Translation Offset
>                     0xF300,             // Length
>                     ,, , TypeStatic)
>                 Memory32Fixed (ReadOnly,
>                     0x000A0000,         // Address Base
>                     0x00020000,         // Address Length
>                     )
>                 Memory32Fixed (ReadOnly,
>                     0x00000000,         // Address Base
>                     0x00000000,         // Address Length
>                     _Y00)
>             })
> 
> With commit (x86/PCI/ACPI: Ignore resources consumed by host bridge
> itself), all resources without PRODUCER flag will be ignored, so
> MMIO defined by Memory32Fixed operator gets ignored. The fix is only
> to ignore IO resources without PRODUCER flag and keeps all MMIO
> resources no matter PRODUCER is set or not.
> Could you please help to try following patch?

This patches fixes it. Applied it, tested it and can confirm that
network interfaces work again on my PC Engines APU1.C device.

Thank You!

> Regards!
> Gerry
> 
> diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
> index e4695985f9de..66d7dbe56926 100644
> --- a/arch/x86/pci/acpi.c
> +++ b/arch/x86/pci/acpi.c
> @@ -346,7 +346,7 @@ static void probe_pci_root_info(struct pci_root_info
> *info,
>                         "no IO and memory resources present in _CRS\n");
>         else
>                 resource_list_for_each_entry_safe(entry, tmp, list) {
> -                       if ((entry->res->flags & IORESOURCE_WINDOW) == 0 ||
> +                       if ((entry->res->flags & (IORESOURCE_WINDOW |
> IORESOURCE_IO)) == IORESOURCE_IO ||
>                             (entry->res->flags & IORESOURCE_DISABLED))
>                                 resource_list_destroy_entry(entry);
>                         else
> 
>>
>>
