Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:48770 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752459AbdHGIxg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Aug 2017 04:53:36 -0400
Cc: shawn.lin@rock-chips.com
To: Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC] what should we report for the failure of pcie_set_mps?
Message-ID: <1729fb86-b9be-0ba6-4b65-33bb5a3527f9@rock-chips.com>
Date: Mon, 7 Aug 2017 16:53:25 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

I notice the log below showing the add-in NVMe failed to set MPS to 256.
My RC could support up to 256 but the Intel 600P series NVMe could only
support up to 128. So I am confusing now it's normal to fallback to the
minimal MPS negotiaged but why it deserve a warning and what should I
report a bug for?

[    0.694942] pci 0000:01:00.0: can't set Max Payload Size to 256; if 
necessary, use "pci=pcie_bus_safe" and report a bug
[    0.706267] pci 0000:00:00.0: BAR 14: assigned [mem 
0xfa000000-0xfa0fffff]
[    0.706966] pci 0000:01:00.0: BAR 0: assigned [mem 
0xfa000000-0xfa003fff 64bit]
[    0.707736] pci 0000:00:00.0: PCI bridge to [bus 01]
[    0.708238] pci 0000:00:00.0:   bridge window [mem 0xfa000000-0xfa0fffff]
[    0.709232] pcieport 0000:00:00.0: enabling device (0000 -> 0002)
[    0.710674] pcieport 0000:00:00.0: Signaling PME with IRQ 215
[    0.711654] pcieport 0000:00:00.0: AER enabled with IRQ 215


lspci -vvv

00:00.0 Class 0604: Device 1d87:0100
	...
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
         Capabilities: [c0] Express (v2) Root Port (Slot+), MSI 00
                 DevCap: MaxPayload 256 bytes, PhantFunc 0
                         ExtTag- RBE+
                 DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+ 	
		Unsupported+
                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                         MaxPayload 256 bytes, MaxReadReq 512 bytes

01:00.0 Class 0108: Device 8086:f1a5 (rev 03) (prog-if 02)
	...
	Capabilities: [70] Express (v2) Endpoint, MSI 00
                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s
			unlimited, L1 unlimited
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
			SlotPowerLimit 0.000W
                 DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+
			Unsupported+ RlxdOrd+ ExtTag- PhantFunc- AuxPwr-
			NoSnoop- FLReset-
			MaxPayload 128 bytes, MaxReadReq 512 bytes
