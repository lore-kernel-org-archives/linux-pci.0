Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fold.natur.cuni.cz ([195.113.57.32]:54771 "HELO
	fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754069Ab3C2PD7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 29 Mar 2013 11:03:59 -0400
Message-ID: <5155924F.1070509@fold.natur.cuni.cz>
Date: Fri, 29 Mar 2013 14:08:31 +0100
From: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
MIME-Version: 1.0
To: Huang Ying <ying.huang@intel.com>
CC: Yijing Wang <wangyijing@huawei.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Yinghai Lu <yinghai@kernel.org>
Subject: Re: 3.9-rc1: pciehp and eSATA card SiI 3132, no XHCI
References: <513E7E1E.80508@fold.natur.cuni.cz>  <513FE7AD.2020408@huawei.com> <5141145E.4020300@fold.natur.cuni.cz>  <51417C28.40402@huawei.com> <5141C9D7.9040706@fold.natur.cuni.cz>  <51428A72.2060602@huawei.com> <51548E13.8030308@fold.natur.cuni.cz> <1364545211.1817.228.camel@yhuang-dev>
In-Reply-To: <1364545211.1817.228.camel@yhuang-dev>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



Huang Ying wrote:
> On Thu, 2013-03-28 at 19:38 +0100, Martin Mokrejs wrote:
>> Hi Ying,
>>   would you please tell me how this report relate to this patch?
>>
>> [PATCH] PCI / ACPI: Always resume devices on ACPI wakeup notifications
>>
>>   Could you tell me why this PME was being flipped back and forth now?
>> Actually, does that make finally some sense to you, pci/acpi devs?
>>
>>
>>   Does is help to say that on the SandyBridge chip I have the following root ports
>> hooked to the following end devices?:
>>
>> 1.c1 -> rtl8169 05:00.0
>> 1.c3 -> iwlwifi 09:00.0
>> 1.c4 -> xhci_hcd 0b:00.0
>> 1.c7 -> 00:11: express card slot
>>
>>
>>   Why didn't I see interleraved lines with 1.c7 *and* 00:11? See the interleaving
>> happening with the network card on 3.7.10 kernel (not broken kernel):
>>
>> [138268.870070] r8169 0000:05:00.0 eth0: link down
>> [138270.809811] r8169 0000:05:00.0 eth0: link up
>> [138365.599744] r8169 0000:05:00.0 eth0: link down
>> [138370.594343] r8169 0000:05:00.0: PME# enabled
>> [138370.623852] pcieport 0000:00:1c.1: PME# enabled
>> [169885.247386] pcieport 0000:00:1c.1: PME# disabled
>> [169885.267374] r8169 0000:05:00.0: PME# disabled
>> [169885.330160] r8169 0000:05:00.0 eth0: link down
>> [169886.992531] r8169 0000:05:00.0 eth0: link up
>> [169904.405769] r8169 0000:05:00.0 eth0: link down
>> [169909.401237] r8169 0000:05:00.0: PME# enabled
>> [169909.430782] pcieport 0000:00:1c.1: PME# enabled
>> [170090.538980] pcieport 0000:00:1c.1: PME# disabled
>> [170090.559088] r8169 0000:05:00.0: PME# disabled
>> [170090.640494] r8169 0000:05:00.0: PME# enabled
>> [170090.678425] pcieport 0000:00:1c.1: PME# enabled
>> [170090.829959] pcieport 0000:00:1c.1: PME# disabled
>> [170090.848479] r8169 0000:05:00.0: PME# disabled
>> [170090.892011] r8169 0000:05:00.0 eth0: link down
>> [170090.892134] r8169 0000:05:00.0 eth0: link down
>> [170090.930998] r8169 0000:05:00.0 eth0: link down
>> [170092.554553] r8169 0000:05:00.0 eth0: link up
> 
> I don't know exactly.  Can you give me the follow output?
> 
> grep . /sys/bus/pci/devices/*/power/control
> grep . /sys/bus/pci/devices/*/power/runtime_status


Hi Ying,
  here is the output from the not-broken 3.7.10 kernel:

vostro ~ # uname -a
Linux vostro 3.7.10-default #2 SMP Tue Mar 5 09:52:12 MET 2013 x86_64 Intel(R) Core(TM) i7-2640M CPU @ 2.80GHz GenuineIntel GNU/Linux
vostro ~ # grep . /sys/bus/pci/devices/*/power/control
/sys/bus/pci/devices/0000:00:00.0/power/control:auto
/sys/bus/pci/devices/0000:00:02.0/power/control:auto
/sys/bus/pci/devices/0000:00:16.0/power/control:auto
/sys/bus/pci/devices/0000:00:1a.0/power/control:auto
/sys/bus/pci/devices/0000:00:1b.0/power/control:auto
/sys/bus/pci/devices/0000:00:1c.0/power/control:auto
/sys/bus/pci/devices/0000:00:1c.1/power/control:auto
/sys/bus/pci/devices/0000:00:1c.3/power/control:auto
/sys/bus/pci/devices/0000:00:1c.4/power/control:auto
/sys/bus/pci/devices/0000:00:1c.7/power/control:auto
/sys/bus/pci/devices/0000:00:1d.0/power/control:auto
/sys/bus/pci/devices/0000:00:1f.0/power/control:auto
/sys/bus/pci/devices/0000:00:1f.2/power/control:auto
/sys/bus/pci/devices/0000:00:1f.3/power/control:auto
/sys/bus/pci/devices/0000:05:00.0/power/control:auto
/sys/bus/pci/devices/0000:09:00.0/power/control:auto
/sys/bus/pci/devices/0000:0b:00.0/power/control:auto
/sys/bus/pci/devices/0000:11:00.0/power/control:auto
vostro ~ # grep . /sys/bus/pci/devices/*/power/runtime_status
/sys/bus/pci/devices/0000:00:00.0/power/runtime_status:suspended
/sys/bus/pci/devices/0000:00:02.0/power/runtime_status:active
/sys/bus/pci/devices/0000:00:16.0/power/runtime_status:suspended
/sys/bus/pci/devices/0000:00:1a.0/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1b.0/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1c.0/power/runtime_status:suspended
/sys/bus/pci/devices/0000:00:1c.1/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1c.3/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1c.4/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1c.7/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1d.0/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1f.0/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1f.2/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1f.3/power/runtime_status:suspended
/sys/bus/pci/devices/0000:05:00.0/power/runtime_status:active
/sys/bus/pci/devices/0000:09:00.0/power/runtime_status:active
/sys/bus/pci/devices/0000:0b:00.0/power/runtime_status:active
/sys/bus/pci/devices/0000:11:00.0/power/runtime_status:active
vostro ~ # 



Now will go and test your patch for the 3.9-rc1 PME# storm when the coldplugged eSATA
is unplugged and rmmod sata_sil24 triggers the messages.

Martin
