Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:58167 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752708AbbHaIAK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 31 Aug 2015 04:00:10 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glp-linux-pci@m.gmane.org>)
	id 1ZWK0e-0003cu-Nr
	for linux-pci@vger.kernel.org; Mon, 31 Aug 2015 10:00:08 +0200
Received: from 195.219.98.189 ([195.219.98.189])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2015 10:00:03 +0200
Received: from peio by 195.219.98.189 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2015 10:00:03 +0200
To: linux-pci@vger.kernel.org
From: Peio <peio@azkarate.eu>
Subject: PCI rescan : can't assign mem
Date: Mon, 31 Aug 2015 07:47:53 +0000 (UTC)
Message-ID: <loom.20150831T091131-859@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I have a board with an PCI Express-to-PCI Bridge (Texas Instruments 
XIO2001).
Attached to the PCI bus, there are 2 FPGA PCI Target devices needing 32MB 
memory map each.
The PCI rescan "echo 1 > /sys/bus/pci/rescan" memory assign fails.

dmesg messages:
[  150.978654] pci 0000:02:03.0: [4150:0001] type 00 class 0x068000
[  150.978684] pci 0000:02:03.0: reg 0x10: [mem 0x00000000-0x01ffffff]
[  150.978885] pci 0000:02:04.0: [4150:000a] type 00 class 0x078000
[  150.978909] pci 0000:02:04.0: reg 0x10: [mem 0x00000000-0x01ffffff]
[  150.979158] pcieport 0000:00:1c.0: bridge window [mem 0x00100000-
0x000fffff 64bit pref] to [bus 01-02] add_size 200000
[  150.979166] pcieport 0000:00:1c.0: bridge window [mem 0x02000000-
0x05ffffff] to [bus 01-02] add_size 2000000
[  150.979183] pcieport 0000:00:1c.2: bridge window [mem 0x00100000-
0x000fffff 64bit pref] to [bus 04] add_size 200000
[  150.979190] i915 0000:00:02.0: BAR 6: [??? 0x00000000 flags 0x2] has 
bogus alignment
[  150.979199] pcieport 0000:00:1c.0: res[14]=[mem 0x02000000-0x05ffffff] 
get_res_add_size add_size 2000000
[  150.979205] pcieport 0000:00:1c.0: res[15]=[mem 0x00100000-0x000fffff 
64bit pref] get_res_add_size add_size 200000
[  150.979211] pcieport 0000:00:1c.2: res[15]=[mem 0x00100000-0x000fffff 
64bit pref] get_res_add_size add_size 200000
[  150.979222] pcieport 0000:00:1c.0: BAR 14: can't assign mem (size 
0x6000000)
[  150.979230] pcieport 0000:00:1c.0: BAR 15: can't assign mem pref (size 
0x200000)
[  150.979238] pcieport 0000:00:1c.2: BAR 15: can't assign mem pref (size 
0x200000)
[  150.979245] pcieport 0000:00:1c.0: BAR 14: can't assign mem (size 
0x4000000)
[  150.979253] pcieport 0000:00:1c.2: BAR 15: can't assign mem pref (size 
0x200000)
[  150.979260] pcieport 0000:00:1c.0: BAR 15: can't assign mem pref (size 
0x200000)
[  150.979266] pci 0000:01:00.0: BAR 14: can't assign mem (size 0x4000000)
[  150.979272] pci 0000:02:03.0: BAR 0: can't assign mem (size 0x2000000)
[  150.979277] pci 0000:02:04.0: BAR 0: can't assign mem (size 0x2000000)
[  150.979281] pci 0000:01:00.0: PCI bridge to [bus 02]

lspci:
00:00.0 Host bridge: Intel Corporation ValleyView SSA-CUnit (rev 11)
00:02.0 VGA compatible controller: Intel Corporation ValleyView Gen7 (rev 
11)
00:1a.0 Encryption controller: Intel Corporation ValleyView SEC (rev 11)
00:1b.0 Audio device: Intel Corporation ValleyView High Definition Audio 
Controller (rev 11)
00:1c.0 PCI bridge: Intel Corporation ValleyView PCI Express Root Port (rev 
11)
00:1c.1 PCI bridge: Intel Corporation ValleyView PCI Express Root Port (rev 
11)
00:1c.2 PCI bridge: Intel Corporation ValleyView PCI Express Root Port (rev 
11)
00:1d.0 USB controller: Intel Corporation ValleyView USB Enhanced Host 
Controller (rev 11)
00:1f.0 ISA bridge: Intel Corporation ValleyView Power Control Unit (rev 11)
00:1f.3 SMBus: Intel Corporation ValleyView SMBus Controller (rev 11)
01:00.0 PCI bridge: Texas Instruments XIO2001 PCI Express-to-PCI Bridge
02:03.0 Bridge: ONA Electroerosion PCI32TLITE FILSTRUP1 PCI to VME Bridge 
Controller (rev 04)
02:04.0 Communication controller: ONA Electroerosion Device 000a
03:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL8101E/RTL8102E PCI Express Fast Ethernet controller (rev 05)
04:00.0 IDE interface: Marvell Technology Group Ltd. 88SE6101/6102 single-
port PATA133 interface (rev c0)

lspci -vt
-[0000:00]-+-00.0  Intel Corporation ValleyView SSA-CUnit
           +-02.0  Intel Corporation ValleyView Gen7
           +-1a.0  Intel Corporation ValleyView SEC
           +-1b.0  Intel Corporation ValleyView High Definition Audio 
Controller
           +-1c.0-[01-02]----00.0-[02]--+-03.0  ONA Electroerosion 
PCI32TLITE FILSTRUP1 PCI to VME Bridge Controller
           |                            \-04.0  ONA Electroerosion Device 
000a
           +-1c.1-[03]----00.0  Realtek Semiconductor Co., Ltd. 
RTL8101E/RTL8102E PCI Express Fast Ethernet controller
           +-1c.2-[04]----00.0  Marvell Technology Group Ltd. 88SE6101/6102 
single-port PATA133 interface
           +-1d.0  Intel Corporation ValleyView USB Enhanced Host Controller
           +-1f.0  Intel Corporation ValleyView Power Control Unit
           \-1f.3  Intel Corporation ValleyView SMBus Controller

Linux: Ubuntu 14.04
Kernel: 3.13.0-62-generic

Is possible to fix it?

 

