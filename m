Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.135]:62062 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755432AbcA1OYd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 28 Jan 2016 09:24:33 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
	Michal Simek <michals@xilinx.com>,
	"lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
	"paul.burton@imgtec.com" <paul.burton@imgtec.com>,
	"yinghai@kernel.org" <yinghai@kernel.org>,
	"wangyijing@huawei.com" <wangyijing@huawei.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"russell.joyce@york.ac.uk" <russell.joyce@york.ac.uk>,
	Soren Brinkmann <sorenb@xilinx.com>,
	"jiang.liu@linux.intel.com" <jiang.liu@linux.intel.com>,
	"pawel.moll@arm.com" <pawel.moll@arm.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
	"galak@codeaurora.org" <galak@codeaurora.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Ravikiran Gummaluri <rgummal@xilinx.com>
Subject: Re: [PATCH V2 3/5] PCI: xilinx: Modifying AXI PCIe Host Bridge driver to  work on both  Zynq and Microblaze
Date: Thu, 28 Jan 2016 15:23:37 +0100
Message-ID: <3706176.5tvYx0gSBz@wuerfel>
In-Reply-To: <8520D5D51A55D047800579B094147198258741F5@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1452620173-4905-1-git-send-email-bharatku@xilinx.com> <1917083.LB4Ng3Y2yP@wuerfel> <8520D5D51A55D047800579B094147198258741F5@XAP-PVEXMBX01.xlnx.xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 28 January 2016 14:18:15 Bharat Kumar Gogada wrote:
> > 
> > I see. In the upstream code you seem to do it in
> > pcibios_setup_bus_devices(), while arm64 and powerpc do it in
> > pcibios_add_device().
> > 
> No that function is not getting called with generic API's, its getting called with pcibios_init flow which is tightly bound with struct pci_controller microblaze specific structure. So I added pcibios_add_device in pci-common.c.

Ok

> > > May be we can add similar on arm and test out, but we might need some
> > > cleanup in arch/arm/kernel/bios32.c
> > 
> > I think that would still just be a half-baked solution. This should really be fully
> > automatic. We could do it in the __weak
> > pcibios_add_device() for all architectures that don't override it when the bus
> > was probed from DT, or we could do it in pci_read_irq().
> When will pci_read_irq() call get invoked ?

This is called early on when a device gets created in pci_setup_device(),
so platforms can still override the value later.

The idea here is that normally a BIOS stores the interrupt number in
the PCI_INTERRUPT_LINE config space byte, and we just read it from
there. Generally speaking though, for non-PC systems we tend to not
have a BIOS that writes these values to start with, and any values
stored in here have no meaning in combination with SPARSE_IRQ
and/or IRQ_DOMAINS because the bootloader or BIOS doesn't know
what IRQ number will refer to hardware IRQ line in Linux.

	Arnd
