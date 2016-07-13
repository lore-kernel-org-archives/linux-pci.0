Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:54531 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751042AbcGMPaS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jul 2016 11:30:18 -0400
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
Date: Wed, 13 Jul 2016 17:28:47 +0200
Message-ID: <27194299.uDJcp1GxUD@wuerfel>
In-Reply-To: <8520D5D51A55D047800579B094147198258B8B85@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <8520D5D51A55D047800579B094147198258B85DC@XAP-PVEXMBX01.xlnx.xilinx.com> <4264647.cRxqIJ3z77@wuerfel> <8520D5D51A55D047800579B094147198258B8B85@XAP-PVEXMBX01.xlnx.xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, July 13, 2016 3:16:21 PM CEST Bharat Kumar Gogada wrote:
> 
> > This has neither the PCI memory nor the I/O resource, it looks like you never
> > call pci_add_resource_offset() to start with, or maybe it fails for some
> > reason.
> 
> I see that above API is used in ARM drivers, do we need to do it in ARM64 also ?
> 

Yes, all architectures need it.

	Arnd

