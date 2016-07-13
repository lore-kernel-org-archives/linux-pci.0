Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:37586 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751212AbcGMPmo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 13 Jul 2016 11:42:44 -0400
Date: Wed, 13 Jul 2016 16:42:12 +0100
From: "Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	nofooter <nofooter@xilinx.com>,
	"thomas.petazzoni@free-electrons.com"
	<thomas.petazzoni@free-electrons.com>
Subject: Re: Purpose of pci_remap_iospace
Message-ID: <20160713154212.GN8609@e106497-lin.cambridge.arm.com>
References: <8520D5D51A55D047800579B094147198258B85DC@XAP-PVEXMBX01.xlnx.xilinx.com>
 <4264647.cRxqIJ3z77@wuerfel>
 <8520D5D51A55D047800579B094147198258B8B85@XAP-PVEXMBX01.xlnx.xilinx.com>
 <27194299.uDJcp1GxUD@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <27194299.uDJcp1GxUD@wuerfel>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 13, 2016 at 05:28:47PM +0200, Arnd Bergmann wrote:
> On Wednesday, July 13, 2016 3:16:21 PM CEST Bharat Kumar Gogada wrote:
> > 
> > > This has neither the PCI memory nor the I/O resource, it looks like you never
> > > call pci_add_resource_offset() to start with, or maybe it fails for some
> > > reason.
> > 
> > I see that above API is used in ARM drivers, do we need to do it in ARM64 also ?
> > 
> 
> Yes, all architectures need it.

of_pci_get_host_bridge_resources() calls it for him.

Liviu

> 
> 	Arnd
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
