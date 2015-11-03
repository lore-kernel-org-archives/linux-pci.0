Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:63041 "EHLO
	relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752029AbbKCJAr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 3 Nov 2015 04:00:47 -0500
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Wolfram Sang <wsa@the-dreams.de>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Simon Horman <horms@verge.net.au>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/3] Fix rcar-pcie for arm64
Date: Tue, 3 Nov 2015 09:00:42 +0000
Message-ID: <PS1PR06MB118027E43C76740EC5F9F18CF52B0@PS1PR06MB1180.apcprd06.prod.outlook.com>
References: <1446482175-26507-1-git-send-email-phil.edworthy@renesas.com>
 <20151102213305.GA1158@tetsubishi>
In-Reply-To: <20151102213305.GA1158@tetsubishi>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Wolfram,

On 02 November 2015 21:33, Wolfram wrote:
> > The first patches fixes the build problem, and the second patch reverts the
> > patch that removed the driver from arm64 builds. The final patch add a compat
> > string for the r8a7795 (arm64) device.
> 
> Thanks. I will test them next week when I have access to my board again.
It's worth mentioning that I had some troubles on my Salvator-X board
with some cards not being able to link up. Since my board has a socketed chip
and the board was designed for it not to be via a socket, and this is such a low
level functionality, I think this is HW related. My Intel Gigabit CT Desktop card
always works.
Also note that this PCIe controller only supports a 32-bit AXI address range,
so you need to limit memory to within the 4GiB address space. As far as I am
aware, there is no way to limit the dma mask that card drivers use via the
controller. The plan is to add support this via IOMMU.
 
> > Apart from patches to add the PCIe clock and DT nodes, I had to revert these
> > patches to get it to work on arm64:
> >  f075915ac0b1 ("PCI/MSI: Drop domain field from msi_controller")
> >  d8a1cb757550 ("PCI/MSI: Let pci_msi_get_domain use struct
> device::msi_domain")
> 
> Does that solve the MSI problems you mentioned?
It avoids the problem, but I have a proper fix in the pipeline which just needs
more testing.

Thanks
Phil

