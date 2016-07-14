Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.75]:53735 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074AbcGNPMQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2016 11:12:16 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>,
	nofooter <nofooter@xilinx.com>,
	"thomas.petazzoni@free-electrons.com"
	<thomas.petazzoni@free-electrons.com>
Subject: Re: Purpose of pci_remap_iospace
Date: Thu, 14 Jul 2016 17:12:01 +0200
Message-ID: <5073702.5KYvV2f0PW@wuerfel>
In-Reply-To: <20160714145624.GB30657@red-moon>
References: <8520D5D51A55D047800579B094147198258B85DC@XAP-PVEXMBX01.xlnx.xilinx.com> <8520D5D51A55D047800579B094147198258B8F73@XAP-PVEXMBX01.xlnx.xilinx.com> <20160714145624.GB30657@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, July 14, 2016 3:56:24 PM CEST Lorenzo Pieralisi wrote:
> On Thu, Jul 14, 2016 at 01:32:13PM +0000, Bharat Kumar Gogada wrote:
> 
> [...]
> 
> > Hi Lorenzo,
> > 
> > I missed something in my device tree now I corrected it.
> > 
> > ranges = <0x01000000 0x00000000 0xe0000000 0x00000000 0xe0000000 0 0x00010000   //io
> 
> You have not missed anything, you changed the PCI bus address at
> which your host bridge responds to IO space and it must match
> your configuration.

I'd always recommend mapping the I/O space to PCI address zero, but
evidently the hardware is not configured that way here.

	Arnd
