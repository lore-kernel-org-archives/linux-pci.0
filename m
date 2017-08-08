Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:44743 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750776AbdHHGbi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Aug 2017 02:31:38 -0400
Date: Tue, 8 Aug 2017 02:38:19 -0400
From: Keith Busch <keith.busch@intel.com>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [RFC] what should we report for the failure of pcie_set_mps?
Message-ID: <20170808063818.GA9938@localhost.localdomain>
References: <1729fb86-b9be-0ba6-4b65-33bb5a3527f9@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1729fb86-b9be-0ba6-4b65-33bb5a3527f9@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 07, 2017 at 04:53:25PM +0800, Shawn Lin wrote:
> Hi Bjorn,
> 
> I notice the log below showing the add-in NVMe failed to set MPS to 256.
> My RC could support up to 256 but the Intel 600P series NVMe could only
> support up to 128. So I am confusing now it's normal to fallback to the
> minimal MPS negotiaged but why it deserve a warning and what should I
> report a bug for?

The "report a bug message" is the text from commit 5895af79158a when it
was an indication the BIOS had done something wrong. If you booted with
the 600P inserted (the timestamp appears that you did), then it sounds
like the platform initialized the port incorrectly for the device's
capabilities. This mismatched MPS can sometimes mean you won't be able
to write to the device, even though reads may work fine.

So, if you are obseriving a problem with the kernel's default pci
settings, I think the 'report a bug' is suggesting you report it to your
platform maker rather than the kernel, and the kernel is providing a
way to work around this.

 
> [    0.694942] pci 0000:01:00.0: can't set Max Payload Size to 256; if
> necessary, use "pci=pcie_bus_safe" and report a bug
> [    0.706267] pci 0000:00:00.0: BAR 14: assigned [mem
> 0xfa000000-0xfa0fffff]
> [    0.706966] pci 0000:01:00.0: BAR 0: assigned [mem 0xfa000000-0xfa003fff
> 64bit]
> [    0.707736] pci 0000:00:00.0: PCI bridge to [bus 01]
> [    0.708238] pci 0000:00:00.0:   bridge window [mem 0xfa000000-0xfa0fffff]
> [    0.709232] pcieport 0000:00:00.0: enabling device (0000 -> 0002)
> [    0.710674] pcieport 0000:00:00.0: Signaling PME with IRQ 215
> [    0.711654] pcieport 0000:00:00.0: AER enabled with IRQ 215
> 
> 
> lspci -vvv
> 
> 00:00.0 Class 0604: Device 1d87:0100
> 	...
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
>         Capabilities: [c0] Express (v2) Root Port (Slot+), MSI 00
>                 DevCap: MaxPayload 256 bytes, PhantFunc 0
>                         ExtTag- RBE+
>                 DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+ 	
> 		Unsupported+
>                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
>                         MaxPayload 256 bytes, MaxReadReq 512 bytes
> 
> 01:00.0 Class 0108: Device 8086:f1a5 (rev 03) (prog-if 02)
> 	...
> 	Capabilities: [70] Express (v2) Endpoint, MSI 00
>                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s
> 			unlimited, L1 unlimited
> 			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
> 			SlotPowerLimit 0.000W
>                 DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+
> 			Unsupported+ RlxdOrd+ ExtTag- PhantFunc- AuxPwr-
> 			NoSnoop- FLReset-
> 			MaxPayload 128 bytes, MaxReadReq 512 bytes
> 
