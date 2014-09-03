Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:40366 "EHLO
	mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751114AbaICEUF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 3 Sep 2014 00:20:05 -0400
From: Mohit KUMAR DCG <Mohit.KUMAR@st.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lucas Stach <l.stach@pengutronix.de>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Richard Zhu <r65037@freescale.com>,
	Jingoo Han <jg1.han@samsung.com>, Marek Vasut <marex@denx.de>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Date: Wed, 3 Sep 2014 12:19:35 +0800
Subject: RE: [PATCH 0/4] PCI: designware: init order/resource alloc fixes
Message-ID: <2CC2A0A4A178534D93D5159BF3BCB661A70E51E43D@EAPEX1MAIL1.st.com>
References: <1406137961-14684-1-git-send-email-l.stach@pengutronix.de>
 <20140902231003.GA12657@google.com>
In-Reply-To: <20140902231003.GA12657@google.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Lucas,

> -----Original Message-----
> From: Bjorn Helgaas [mailto:bhelgaas@google.com]
> Sent: Wednesday, September 03, 2014 4:40 AM
> To: Lucas Stach
> Cc: linux-pci@vger.kernel.org; Richard Zhu; Mohit KUMAR DCG; Jingoo Han;
> Marek Vasut; Kishon Vijay Abraham I; kernel@pengutronix.de
> Subject: Re: [PATCH 0/4] PCI: designware: init order/resource alloc fixes
> 
> On Wed, Jul 23, 2014 at 07:52:37PM +0200, Lucas Stach wrote:
> > This series fixes a couple of issues with the initialisation ordering
> > and ressource allocation handling in the designware driver and moves
> > its behavior much closer to other PCI host controller drivers like
> > MVEBU and Tegra.
> > For more detailed explanation see the commit messages.
> >
> > This effectively enables the i.MX6 pcie driver to be probed from
> > module initcall level, instead of relying on being probed early.
> >
> > Lucas Stach (4):
> >   PCI: designware: start parsing bus-range
> >   PCI: designware: get rid of pci_scan_root_bus
> >   PCI: designware: remove pci_assign_unassigned_resources call
> >   PCI: imx6: move to module_init
> >
> >  .../devicetree/bindings/pci/designware-pcie.txt    |  3 +++
> >  drivers/pci/host/pci-imx6.c                        |  2 +-
> >  drivers/pci/host/pcie-designware.c                 | 29 ++++++++++++++--------
> >  drivers/pci/host/pcie-designware.h                 |  1 +
> >  4 files changed, 24 insertions(+), 11 deletions(-)
> 
> I'm waiting for an ack from Mohit and/or Jingoo before applying these.
> I think Richard already acked the one that touches IMX6.
> 
> Bjorn

- I have tested patch#1,2 and3 and looks fine to me.

Sorry for my delayed response due to some problem with my platform.

Acked-by: Mohit Kumar <mohit.kumar@st.com>

Regards
Mohit
