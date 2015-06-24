Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail7.pr.hu ([87.242.0.7]:57583 "EHLO mail7.pr.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751698AbbFXJ2T (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 24 Jun 2015 05:28:19 -0400
Message-ID: <558A7824.3090900@pr.hu>
Date: Wed, 24 Jun 2015 11:28:04 +0200
From: Boszormenyi Zoltan <zboszor@pr.hu>
MIME-Version: 1.0
To: Ingo Molnar <mingo@kernel.org>,
	Jiang Liu <jiang.liu@linux.intel.com>
CC: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Len Brown <lenb@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, "x86 @ kernel . org" <x86@kernel.org>
Subject: Re: [Bugfix v2] PCI, ACPI: Fix regressions caused by resource_size_t
 overflow with 32bit kernel
References: <1435131817-28167-1-git-send-email-jiang.liu@linux.intel.com> <20150624083019.GA26672@gmail.com>
In-Reply-To: <20150624083019.GA26672@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

2015-06-24 10:30 keltezéssel, Ingo Molnar írta:
> * Jiang Liu <jiang.liu@linux.intel.com> wrote:
>
>> Since commit 593669c2ac0f ("x86/PCI/ACPI: Use common ACPI resource interfaces to 
>> simplify implementation"), x86 PCI ACPI host bridge driver validates ACPI 
>> resources by first converting an ACPI resource to a 'struct resource' structure 
>> and then applying checks against the converted resource structure. The 'start' 
>> and 'end' fields in 'struct resource' are defined to be type of resource_size_t, 
>> which may be 32 bits or 64 bits depending on CONFIG_PHYS_ADDR_T_64BIT.
>>
>> This may cause incorrect resource validation results with 32 bit kernels because 
>> 64bit ACPI resource descriptors may get truncated when converting to 32bit 
>> 'start' and 'end' fields in 'struct resource'. And eventually affects PCI 
>> resource allocation subsystem and causes some PCI devices unusable.
> s/causes some PCI devices unusuable.
>   makes some PCI devices unusuable.
>
> Also, this description is still pretty vague. What exactly happened? Did some PCI 
> devices not show up during bootup? Or did they hang? Or did something else happen?

There's a reference mail URL in the description, but here it is in full glory.

The machine in question started behaving like being drunk without this fix
with 4.0.5 and 4.1.0-rc8 and 4.1.0-final. 3.18.16 was good.

There's a Realtek RTL8111/8168/8411 (PCI ID 10ec:8168, Subsystem ID 1565:230e)
network chip on the mainboard. After the r8169 driver loaded, the IRQs in
the machine went berserk. Keyboard keypressed arrived with considerable
latency and duplicated, so no real work was possible. The machine responded
to the power button but didn't actually power down. It just stuck at the powering
down message. I had to press the power button for 4 seconds to power it down.

The computer is a POS machine with a big battery inside. Because of this,
either ACPI or the Realtek chip kept the bad state and after rebooting, the
network chip didn't even show up in lspci. Not even the PXE ROM announced
itself during boot. I had to disconnect the battery to beat some sense back
to the computer.

Without the patch I was able to get debugging info out of the machine in this
bad state with:

# modprobe r8169 ; sleep 10 ; dmesg >dmesg.log ; lspci -vvxxx >lspci.log ; \
    sync ; sync ; sync ; poweroff

all in the same command line. Entering commands manually after a single
"modprobe r8169" was impossible. That revealed that the #2 PCIe port
(the one that the Realtek chip is attached to) changed this way:

@@ -211,7 +211,7 @@
 
 00:1c.1 PCI bridge: Intel Corporation NM10/ICH7 Family PCI Express Port 2 (rev 02)
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR+ FastB2B- DisINTx+
-       Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort-
>SERR- <PERR- INTx-
+       Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort-
>SERR+ <PERR- INTx-
        Latency: 0, Cache Line Size: 32 bytes
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
        I/O behind bridge: 0000e000-0000efff
@@ -226,7 +226,7 @@
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
-               DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
+               DevSta: CorrErr- UncorrErr+ FatalErr- UnsuppReq- AuxPwr+ TransPend-
                LnkCap: Port #2, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s
<256ns, L1 <4us
                        ClockPM- Surprise- LLActRep+ BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+

The "uncorrectable error" seems to have pushed it or the device behind it
to a disabled state after reboot and this state was kept because of the battery.

Also, with the 32-bit wraparound caused that every device in the system
was reprogrammed to use a different memory address range.

With the fix, the behavior of the machine was restored to how 3.18.16 worked,
i.e. the memory range that is over 4GB is ignored again, and lspci -vvxxx shows
that everything is at the same memory window as they were with 3.18.16.

Unrelated to this fix, but I also had an adventure with r8168 (downloaded from
Realtek and compiled from source) vs r8169. Most likely caused by switching
between r8168 and r8169, the network chip was programmed with a bad
MAC address (ff:fc:6d:11:28:ff, the real one is 00:0c:6d:11:28:77) which made
the network started acting weirdly. While the machine was pingable and it was
able to ping others, real networking like the ssh login prompt never appeared,
traceroute took ages, etc. That was also solved by disconnecting the battery
and powering down completely and returning to r8169 with the kernel patched
with a preliminary version of this patch.

>
> This is _by far_ the most important part of the changelog and determines whether a 
> patch gets backported or not. Why does a usable regression description have to be 
> coaxed out of you like pulling teeth??

The commit description by Jiang Liu has the URL for initial mail where
I reported the symptoms I experienced. If you thing the above summary is
not too long for a commit message, then feel free to use it, edited
in any way you like.

Best regards,
Zoltán

>
>> So enhance the ACPI resource parsing interfaces to ignore ACPI resource 
>> descriptors with address/offset observe 4G when running in 32bit mode. This 
>> reverts to the behavior before commit 593669c2ac0f.
>>
>> This issue was triggered on a platform running 32bit kernel with an ACPI 
>> resource descriptor with address range [0x400000000-0xfffffffff]. Please refer 
>> to https://lkml.org/lkml/2015/6/19/277 for more information.
> s/32bit/32-bit
> s/64bit/64-bit
> s/32 bit/32-bit
> s/64 bit/64-bit
>
> Thanks,
>
>     Ingo
>
>

