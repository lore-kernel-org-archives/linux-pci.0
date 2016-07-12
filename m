Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-cys01nam02on0079.outbound.protection.outlook.com ([104.47.37.79]:49984
	"EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750794AbcGLIk6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jul 2016 04:40:58 -0400
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: Arnd Bergmann <arnd@arndb.de>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>,
	nofooter <nofooter@xilinx.com>,
	"thomas.petazzoni@free-electrons.com"
	<thomas.petazzoni@free-electrons.com>
Subject: RE: Purpose of pci_remap_iospace
Date: Tue, 12 Jul 2016 08:40:52 +0000
Message-ID: <8520D5D51A55D047800579B094147198258B860D@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <8520D5D51A55D047800579B094147198258B85DC@XAP-PVEXMBX01.xlnx.xilinx.com>
 <3927657.6zNCtCntSU@wuerfel>
In-Reply-To: <3927657.6zNCtCntSU@wuerfel>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> Subject: Re: Purpose of pci_remap_iospace
>
> On Tuesday, July 12, 2016 6:57:10 AM CEST Bharat Kumar Gogada wrote:
> > Hi,
> >
> > I have a query.
> >
> > Can any once explain the purpose of pci_remap_iospace function in root
> port driver.
> >
> > What is its dependency with architecture ?
> >
> > Here is my understanding, the above API takes PCIe IO resource and its
> > to be mapped CPU address from ranges property and remaps into virtual
> address space.
> >
> > So my question is who uses this virtual addresses ?
>
> The inb()/outb() functions declared in asm/io.h
>
> > When End Point requests for IO BARs doesn't it get from the above
> > resource range (first parameter of API) and do ioremap to access this
> > region ?
>
> Device drivers generally do not ioremap() the I/O BARs but they use
> inb()/outb() directly. They can also call pci_iomap() and do
> ioread8()/iowrite8() on the pointer returned from that function, but
> generally the call to pci_iomap() then returns a pointer into the virtual
> address that is already mapped.
>
> > But why root complex driver is mapping this address region ?
>
> The PCI core does not know that the I/O space is memory mapped.
> On x86 and a few others, I/O space is not memory mapped but requires the
> use of special CPU instructions.
>
Thanks Bergmann


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.

