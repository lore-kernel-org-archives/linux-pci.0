Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <550CD574.7080900@linux.intel.com>
Date: Sat, 21 Mar 2015 10:20:36 +0800
From: Jiang Liu <jiang.liu@linux.intel.com>
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bernhard Thaler <bernhard.thaler@wvnet.at>
CC: lenb@kernel.org, linux-acpi@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [Debug 0/2] Fix regressions caused by commit 593669c2ac0f
References: <550A7674.6070306@wvnet.at> <4317184.19IeWuljky@vostro.rjw.lan> <550C5A08.3020302@wvnet.at> <2663880.nZ5V9XMenj@vostro.rjw.lan>
In-Reply-To: <2663880.nZ5V9XMenj@vostro.rjw.lan>
Content-Type: text/plain; charset=utf-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/3/21 8:47, Rafael J. Wysocki wrote:
> On Friday, March 20, 2015 06:34:00 PM Bernhard Thaler wrote:
>> This is a multi-part message in MIME format.
>> --------------000805070501000906050700
>> Content-Type: text/plain; charset=windows-1252
>> Content-Transfer-Encoding: 7bit
>>
>>
>> On 19.03.2015 12:27, Rafael J. Wysocki wrote:
>>> On Thursday, March 19, 2015 08:10:44 AM Bernhard Thaler wrote:
>>>> This is a multi-part message in MIME format.
>>>> --------------000809080900050004000900
>>>> Content-Type: text/plain; charset=windows-1252
>>>> Content-Transfer-Encoding: 7bit
>>>>
>>>> Hi,
>>>>
>>>> I think this regression is not yet solved.
>>>
>>> First off, it is good to CC the commit author too (CCed now).
>>>
>>>> I encounter this or a similar problem with an PC Engines APU.1C device
>>>> (see: http://pcengines.ch/apu.htm). It has 3 network interfaces each
>>>> requiring the r8169 kernel module.
>>>>
>>>> With 4.0.0-rc4 I get this error message at boot (for each of the 3 devices):
>>>>
>>>> [    3.562301] r8169 0000:01:00.0 (unnamed net_device) (uninitialized):
>>>> rtl_chipcmd_cond == 1 (loop: 100, delay: 100).
>>>>
>>>> "ifconfig -a" shows ff:ff:ff:ff:ff:ff as MAC address for each of the
>>>> interfaces (see eth0 as example):
>>>>
>>>> eth0      Link encap:Ethernet  HWaddr ff:ff:ff:ff:ff:ff
>>>>           BROADCAST PROMISC MULTICAST  MTU:1500  Metric:1
>>>>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>>>>           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>>>>           collisions:0 txqueuelen:1000
>>>>           RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
>>>>
>>>> The network interfaces cannot be brought up/used.
>>>>
>>>> The same device and setup did work with a previously used 3.18.0-rc5
>>>> kernel. When I boot it with this 3.18.0-rc5 kernel everything i OK,
>>>> interfaces come up and work.
>>>
>>> Second, it is not entirely clear to me that what you're seeing is actually
>>> the same regression.  Have you tested 4.0.0-rc4 with commit 593669c2ac0f
>>> reverted?
>>>
>> You are right, I was a bit quick about this conclusion. I based it on
>> Thomas Voegtle
>> bisect in http://www.spinics.net/lists/linux-pci/msg39014.html and my own
>> observation of the same problem situation with 4.0.0-rc4.
>>
>> Test Results:
>>
>> * Everything works fine before 593669c2ac0f, network interfaces are
>> available
>>    and usable e.g. with 812dbd9.
>>
>> * The problem starts for me with 593669c2ac0f as, errors at boot, network
>>    interfaces unusable as stated above.
> 
> And it doesn't go away in 4.0-rc4 which indicates that the fixes applied
> so far do not work for you.
> 
> Gerry, can you please help here?
Sure, but I will be out of office to handle some urgent family affair
in following two days, so response may be slow.

Hi Bernhard,
	Could you please help to send me following info?
1) /proc/iomem with 593669c2ac0f applied
2) /proc/iomem with 593669c2ac0f reverted
3) output of "acpidump > acpi.bin" or
   "cat /sys/firmware/acpi/tables/DSDT > acpi.bin"
Thanks!
Gerry
> 
> 
