Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:59256 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752260AbcGLI23 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jul 2016 04:28:29 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>,
	nofooter <nofooter@xilinx.com>,
	"thomas.petazzoni@free-electrons.com"
	<thomas.petazzoni@free-electrons.com>
Subject: Re: Purpose of pci_remap_iospace
Date: Tue, 12 Jul 2016 10:31:59 +0200
Message-ID: <3927657.6zNCtCntSU@wuerfel>
In-Reply-To: <8520D5D51A55D047800579B094147198258B85DC@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <8520D5D51A55D047800579B094147198258B85DC@XAP-PVEXMBX01.xlnx.xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, July 12, 2016 6:57:10 AM CEST Bharat Kumar Gogada wrote:
> Hi,
> 
> I have a query.
> 
> Can any once explain the purpose of pci_remap_iospace function in root port driver.
> 
> What is its dependency with architecture ?
> 
> Here is my understanding, the above API takes PCIe IO resource and its to be mapped CPU address from
> ranges property and remaps into virtual address space.
> 
> So my question is who uses this virtual addresses ?

The inb()/outb() functions declared in asm/io.h

> When End Point requests for IO BARs doesn't it get
> from the above resource range (first parameter of API) and
> do ioremap to access this region ?

Device drivers generally do not ioremap() the I/O BARs but they
use inb()/outb() directly. They can also call pci_iomap() and
do ioread8()/iowrite8() on the pointer returned from that function,
but generally the call to pci_iomap() then returns a pointer into
the virtual address that is already mapped.
 
> But why root complex driver is mapping this address region ?

The PCI core does not know that the I/O space is memory mapped.
On x86 and a few others, I/O space is not memory mapped but requires
the use of special CPU instructions.

	Arnd
