Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sn1nam02on0042.outbound.protection.outlook.com ([104.47.36.42]:14720
	"EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750870AbcGOFV3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jul 2016 01:21:29 -0400
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: Arnd Bergmann <arnd@arndb.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>,
	nofooter <nofooter@xilinx.com>,
	"thomas.petazzoni@free-electrons.com"
	<thomas.petazzoni@free-electrons.com>
Subject: RE: Purpose of pci_remap_iospace
Date: Fri, 15 Jul 2016 05:21:20 +0000
Message-ID: <8520D5D51A55D047800579B094147198258B92E9@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <8520D5D51A55D047800579B094147198258B85DC@XAP-PVEXMBX01.xlnx.xilinx.com>
 <3927657.6zNCtCntSU@wuerfel>
 <8520D5D51A55D047800579B094147198258B8952@XAP-PVEXMBX01.xlnx.xilinx.com>
 <4235946.u1vYRsOpTR@wuerfel>
 <8520D5D51A55D047800579B094147198258B8B06@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20160713134642.GA29309@red-moon>
 <8520D5D51A55D047800579B094147198258B8F73@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20160714145624.GB30657@red-moon>
In-Reply-To: <20160714145624.GB30657@red-moon>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> On Thu, Jul 14, 2016 at 01:32:13PM +0000, Bharat Kumar Gogada wrote:
>
> [...]
>
> > Hi Lorenzo,
> >
> > I missed something in my device tree now I corrected it.
> >
> > ranges = <0x01000000 0x00000000 0xe0000000 0x00000000 0xe0000000 0
> 0x00010000   //io
>
> You have not missed anything, you changed the PCI bus address at which
> your host bridge responds to IO space and it must match your configuration.
> At what PCI bus address your host bridge maps IO space ?
>
Our host bridge does not have dedicted address space mapped for IO transactions.
For generation of IO transactions it requires some register read and write operations
in bridge logic.

So the above PCI address does not come in to picture also, is there alternate way to handle IO
Bars with our kind of hardware architecture.

Thanks & Regards,
Bharat


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.

