Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2on0111.outbound.protection.outlook.com ([65.55.169.111]:47232
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754435AbbDOLmZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 15 Apr 2015 07:42:25 -0400
From: "Minghuan.Lian@freescale.com" <Minghuan.Lian@freescale.com>
To: Arnd Bergmann <arnd@arndb.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jingoo Han <jg1.han@samsung.com>,
	"Mingkai.Hu@freescale.com" <Mingkai.Hu@freescale.com>,
	Roy Zang <tie-fei.zang@freescale.com>,
	Stuart Yoder <stuart.yoder@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Scott Wood <scottwood@freescale.com>
Subject: RE: [PATCH v2 2/3] pci/designware: Add base driver for Designware
 PCIe
Date: Wed, 15 Apr 2015 11:42:22 +0000
Message-ID: <DM2PR0301MB0640C4BA8501EED83F9303F1E2E50@DM2PR0301MB0640.namprd03.prod.outlook.com>
References: <1429091315-31891-1-git-send-email-Minghuan.Lian@freescale.com>
 <1429091315-31891-3-git-send-email-Minghuan.Lian@freescale.com>
 <2123546.0rhYViPpvy@wuerfel>
In-Reply-To: <2123546.0rhYViPpvy@wuerfel>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Arnd,

I do not directly add arm64 support to pcie-designware.c, the
main reason is that it is hard to port other 5 platform PCIe
driver based on pcie-designware to the new implementation.
However, not changing those PCIe driver means the code for
arm32 must be remained.

I add a new file pcie-designware-base.c. Compared with
pcie-designware.c, there are main 3 differences.
1. It is a new implementation followed the latest PCIe
architecture-independent API without any code for specific
architecture.
2. There is no MSI chip code, which will be implemented in a 
separated file.
3. Improve ATU use - support more than 2 ATUs and use an exclusive
ATU to translate MEM transaction.

After other platform PCIe owner port the driver to pcie-designware-base.c,
The pcie-designware.c can be removed.

Thanks,
Minghuan

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd@arndb.de]
> Sent: Wednesday, April 15, 2015 6:37 PM
> To: linux-arm-kernel@lists.infradead.org
> Cc: Lian Minghuan-B31939; linux-pci@vger.kernel.org; Jingoo Han; Hu
> Mingkai-B21284; Zang Roy-R61911; Yoder Stuart-B08248; Bjorn Helgaas;
> Wood Scott-B07421
> Subject: Re: [PATCH v2 2/3] pci/designware: Add base driver for Designware
> PCIe
> 
> On Wednesday 15 April 2015 17:48:34 Minghuan Lian wrote:
> > The Synopsys Designware IP is shared with couples of platforms under
> > multiple architectures. The patch is to provide basic
> > architecture-independent Designware PCIe host driver including ATU
> > initialization and PCI OPS. Currently, which supports arm and arm64
> > simultaneously.
> >
> > Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> > ---
> > change log:
> > v1-v2:
> > 1. Get MSI chip according to dts property 'msi-parent'
> > 2. Simplify platform_get_resource_byname() failure checking
> >
> >  drivers/pci/host/Kconfig                |   3 +
> >  drivers/pci/host/Makefile               |   1 +
> >  drivers/pci/host/pcie-designware-base.c | 293
> > ++++++++++++++++++++++++++++++++
> > drivers/pci/host/pcie-designware-base.h |  63 +++++++
> >
> 
> I don't understand this patch at all. What is the relation between this driver
> and the existing pcie-designware.c? From the description above, they would
> be the same.
> 
> 	Arnd
