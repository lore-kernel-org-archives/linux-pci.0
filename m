Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.75]:51350 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809AbcGOG4h (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jul 2016 02:56:37 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>,
	nofooter <nofooter@xilinx.com>,
	"thomas.petazzoni@free-electrons.com"
	<thomas.petazzoni@free-electrons.com>,
	Rongrong Zou <zourongrong@huawei.com>,
	Rongrong Zou <zourongrong@gmail.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: Purpose of pci_remap_iospace
Date: Fri, 15 Jul 2016 08:55:46 +0200
Message-ID: <4711052.Qi2htfK0nU@wuerfel>
In-Reply-To: <8520D5D51A55D047800579B094147198258B92E9@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <8520D5D51A55D047800579B094147198258B85DC@XAP-PVEXMBX01.xlnx.xilinx.com> <20160714145624.GB30657@red-moon> <8520D5D51A55D047800579B094147198258B92E9@XAP-PVEXMBX01.xlnx.xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, July 15, 2016 5:21:20 AM CEST Bharat Kumar Gogada wrote:
> > On Thu, Jul 14, 2016 at 01:32:13PM +0000, Bharat Kumar Gogada wrote:
> >
> > [...]
> >
> > > Hi Lorenzo,
> > >
> > > I missed something in my device tree now I corrected it.
> > >
> > > ranges = <0x01000000 0x00000000 0xe0000000 0x00000000 0xe0000000 0
> > 0x00010000   //io
> >
> > You have not missed anything, you changed the PCI bus address at which
> > your host bridge responds to IO space and it must match your configuration.
> > At what PCI bus address your host bridge maps IO space ?
> >
> Our host bridge does not have dedicted address space mapped for IO transactions.
> For generation of IO transactions it requires some register read and write operations
> in bridge logic.
> 
> So the above PCI address does not come in to picture also, is there alternate way to handle IO
> Bars with our kind of hardware architecture.

Hisilicon has a similar thing on one of their LPC bridges, and
Rongrong Zou has implemented something for it in the past, but I
think it never got merged.

https://lkml.org/lkml/2015/12/29/154 has one version of his
proposal, not sure if that was the latest one or if something
newer exists.

	Arnd
