Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:45385 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754845AbbIXWnT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 24 Sep 2015 18:43:19 -0400
Date: Thu, 24 Sep 2015 23:43:05 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jason Cooper <jason@lakedaemon.net>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/6] pci: mvebu: generate proper configuration access
 cycles
Message-ID: <20150924224305.GG21513@n2100.arm.linux.org.uk>
References: <20150923171706.GL21084@n2100.arm.linux.org.uk>
 <E1Zenfg-0004d5-Dg@rmk-PC.arm.linux.org.uk>
 <20150924222322.GF20825@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150924222322.GF20825@lunn.ch>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 25, 2015 at 12:23:22AM +0200, Andrew Lunn wrote:
> > Testing with an ASM1062 PCIe to SATA mini-PCIe card on Armada 388.
> > PCIe capability at 0x80, DevCtl at 0x88, DevSta at 0x8a.

>From this, the PCIe DevCtl register is at an offset of 8 bytes from the
start of the PCIe capability.

>         Capabilities: [e0] Express (v1) Legacy Endpoint, MSI 00

which, here, starts at 0xe0.  So...

>                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
>                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
>                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>                         RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>                         MaxPayload 128 bytes, MaxReadReq 512 bytes

This register is at 0xe8, and:

>                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-

is at 0xea.

> root@dir665:~# setpci -s 1:0.0 0x88.l
> 00000000
> 
> Nothing there, so your test does not work directly.

As is expected, because PCI configuration addresses between 0x40..0xff
are freely assignable by the vendor to place whatever they want in that
space - and the capabilities form a linked list.

> I tried
> 
> root@dir665:~# setpci -s 1:0.0 0xe8.l
> 00102000
> root@dir665:~# setpci -s 1:0.0 0xe8.w=0x2000
> root@dir665:~# setpci -s 1:0.0 0xe8.l
> 00102000
> 
> but that is not producing the FAIL you had.

The only bit you have set in your DevSta register is:

#define  PCI_EXP_DEVSTA_AUXPD   0x0010  /* AUX Power Detected */

which is not a RW1C bit.

I don't know why I get the CorrErr bit set here, but it being set is
very useful to test for correct behaviour.  I don't yet know how to
cause PCIe errors, I just know that I end up with that bit set each
time I reboot the board I have here.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
