Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fold.natur.cuni.cz ([195.113.57.32]:33188 "HELO
	fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755287Ab3CaPEU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 31 Mar 2013 11:04:20 -0400
Message-ID: <51585071.3090600@fold.natur.cuni.cz>
Date: Sun, 31 Mar 2013 17:04:17 +0200
From: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
MIME-Version: 1.0
To: Huang Ying <ying.huang@intel.com>
CC: Yijing Wang <wangyijing@huawei.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Yinghai Lu <yinghai@kernel.org>
Subject: Re: 3.9-rc1: pciehp and eSATA card SiI 3132, no XHCI
References: <513E7E1E.80508@fold.natur.cuni.cz>    <513FE7AD.2020408@huawei.com> <5141145E.4020300@fold.natur.cuni.cz>    <51417C28.40402@huawei.com> <5141C9D7.9040706@fold.natur.cuni.cz>    <51428A72.2060602@huawei.com> <51548E13.8030308@fold.natur.cuni.cz>   <1364545211.1817.228.camel@yhuang-dev>   <5155A101.2090705@fold.natur.cuni.cz>  <1364640886.5773.5.camel@yhuang-mobile.sh.intel.com>  <51581170.30708@fold.natur.cuni.cz> <1364739160.5947.5.camel@yhuang-mobile.sh.intel.com>
In-Reply-To: <1364739160.5947.5.camel@yhuang-mobile.sh.intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Ying,
  
Huang Ying wrote:
> Hi, Martin,
> 
> Thanks for your testing!
> 
> On Sun, 2013-03-31 at 12:35 +0200, Martin Mokrejs wrote:
>> Hi Ying,
>>   I have tested 4x your last patch. Somehow nothing gets logged to "dmesg"
>> when I hotremove or hotinsert the coldbooted eSATA card. Logging works so
>> enabling wifi via Fn+F2 is being logged. Also, eventual stacktraces
>> and kmemleaks.
>>   I removed the coldbooted card, inserted it and ejected it.
>>
>>
>>   In brief, lspci reports changes but there are no changes in /proc/interrupts
>> related to
>>
>>   19:          0          0   IO-APIC-fasteoi   sata_sil24
>>
>>
>> and no changes at all in /proc/iomem which I expected to happen during
>> hotremoval and hotinsert (something broken in 3.9-rc1 with your patch).
>>
>> All the runtime_status data were same after every tested step, so again,
>> no diffs to show but here are the values confirming laptop-mode-tools
>> enabled powersaving:
>>
>> /sys/bus/pci/devices/0000:00:00.0/power/runtime_status:suspended
>> /sys/bus/pci/devices/0000:00:02.0/power/runtime_status:active
>> /sys/bus/pci/devices/0000:00:16.0/power/runtime_status:suspended
>> /sys/bus/pci/devices/0000:00:1a.0/power/runtime_status:suspended
>> /sys/bus/pci/devices/0000:00:1b.0/power/runtime_status:active
>> /sys/bus/pci/devices/0000:00:1c.0/power/runtime_status:suspended
>> /sys/bus/pci/devices/0000:00:1c.1/power/runtime_status:active
>> /sys/bus/pci/devices/0000:00:1c.3/power/runtime_status:active
>> /sys/bus/pci/devices/0000:00:1c.4/power/runtime_status:active
>> /sys/bus/pci/devices/0000:00:1c.7/power/runtime_status:active
> 
> It appears that 1c.7 is identified successfully as an hotplug-able PCIe
> port, and never put into suspended state.

Yes. Truly said, after I now went to test your previous two patches
on the 3.9-rc1 I confirm that the syslog logging is broken with all your
three patches. I fear we are hitting here, with the pciehp problems
not a powersaving issue but an upstream /proc or /sys files being outdated.
Otherwise I can't figure out why disabling in runtime laptop-mode-tools
and doing the "find /sys .... | while ... echo "on" > $f" trickery
does not help to get pciehp working. This would have fixed the acpiphp
at least on 3.8 kernel. I see that sata_sil24 is not loaded by itself
during hotinsert. It seems lspci reports at such times 0xff for the 11:00
eSATA card, /etc/iomem reports stale memory regions used by 11:00 while
/proc/interrupts says no IRQ is assigned to sata_sil24 (well, sata_sil24
is not loaded per lsmod, lspci would should report sata_sil24 also but
provided the 11:00 entry is broken and shows the 0xff it maybe cannot
report is sata_sil24 is loaded).

I will post a little more details as a proper answer to your other patch
where I managed to get yet another stacktrace, about the eSATA thought to
be D3 state. Physically the card was ejected and just a modprobe sata_sil24
caused the sata_sil24 to use some outdated data. I will dive now into
that. 



> 
> And from your description below, it appears that hot-add and hot-remove
> of the eSATA card works for you, doesn't it?

The PresDet works fine I think, yes. Sometimes I see in the lspci -vvv diffs:

-Control: I/O+ ... BusMaster+
+Control: I/O- ... BusMaster-

and sometimes 

-        Latency: 0, Cache Line Size: 64 bytes
+        Latency: 0

or even the Latency: line being gone completely from lspci -vvv output. Why is that?
I think debug checks and prints in kernel are necessary.


How do these related to /proc/interrupts not showing an IRQ for the 11:00 device?
Does that prevent automated sata_sil24 loading once the card is inserted? Would
you please add some extra debug prints and checks into the kernel?

Take also into consideration the "3.8.2: stale pci device info for a previously inserted express card"
for a list of chimeric entries reported by lspci. That could tell you which values
are being cached and invalid. Hopefully some checks could be done between values
read by lspci and those in /proc and /sys.



Do you already know why almost nothing is logged by kernel wen either of your
three patches (v1 sent on 03/29/13 08:41, v2 sent on 03/29/13 09:20, v3 sent on
03/30/13 11:54)?


I did not test the xHCI port behavior with any of your three patches because I have
disabled USB support in this kernel altogether for 3.9-rc1 tests. And I would like to stick
with that until we fix the pciehp issue. I stepped rather late into the big testing game,
I believe the pciehp bug we are facing was not working since 3.5/3.6, I don't think
the 3.9-rc1-based tests be much different from earlier kernels.

For a broader view, on the 3.8 series we will meanwhile hopefully get to a fix of the
PME# stuff. I think I reported quite a good number of potential problems yesterday.
After that, I will check how xHCI behaves on 3.9 but I believe the PME#-related fix from
3.8 will be also applicable to fixing 3.9 so the xHCI won't have problems there anymore.


Martin
