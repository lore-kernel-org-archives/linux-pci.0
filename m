Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:29663 "EHLO
	relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752296AbcAKLXm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 11 Jan 2016 06:23:42 -0500
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Bjorn Helgaas <helgaas@kernel.org>,
	Simon Horman <horms@verge.net.au>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
Subject: RE: [PATCH v2 1/4] PCI: rcar: remove unused pci_sys_data structure in
 pcie-rcar
Date: Mon, 11 Jan 2016 11:23:37 +0000
Message-ID: <HK2PR0601MB1393C2A62EE47AA804CFCF09F5C90@HK2PR0601MB1393.apcprd06.prod.outlook.com>
References: <1451998831-27705-1-git-send-email-phil.edworthy@renesas.com>
 <1451998831-27705-2-git-send-email-phil.edworthy@renesas.com>
 <20160108015056.GB9600@verge.net.au> <20160108210635.GL5354@localhost>
In-Reply-To: <20160108210635.GL5354@localhost>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 08 January 2016 21:07, Bjorn Helgaas wrote:
> On Fri, Jan 08, 2016 at 10:50:57AM +0900, Simon Horman wrote:
> > Hi Phil,
> >
> > On Tue, Jan 05, 2016 at 01:00:28PM +0000, Phil Edworthy wrote:
> > > Commit b3a72384fe29 ("ARM/PCI: Replace pci_sys_data->align_resource
> > > with global function pointer") removed the struct pci_sys_data
> > > dependency from the ARM pcibios functions, so remove it from this
> > > driver.
> >
> > I am a little confused by this as I still see two instances of
> > the following in bios32.c as of the commit above.
> >
> > 	struct pci_sys_data *sys = dev->sysdata;
> 
> This patch only removes a pci_sys_data struct from pcie-rcar.c.  That
> struct was previously used by pci_common_init_dev() and by the ARM
> pcibios_align_resource().
> 
> After cbce7900598c ("PCI: designware: Make driver arch-agnostic"), none of
> the DesignWare drivers use pci_common_init_dev(), and after b3a72384fe29,
> ARM doesn't need pci_sys_data for pcibios_align_resource().
> 
> Phil can correct me if I'm wrong, but I think this patch is probably OK.
You are absolutely right!

> I guess we can tell after I apply it and get a build test :)
Yes, it has been built and run on both ARM and ARM64 boards.

Thanks
Phil
