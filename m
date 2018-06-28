Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-co1nam03on0076.outbound.protection.outlook.com ([104.47.40.76]:37472
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933693AbeF1QJ7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Jun 2018 12:09:59 -0400
From: Alan Douglas <adouglas@cadence.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.com" <linux-kernel@vger.kernel.com>,
        "cyrille.pitchen@free-electrons.com"
        <cyrille.pitchen@free-electrons.com>
Subject: RE: [RESEND PATCH 0/4] PCI: cadence: Host and EP driver updates for
 PHY and power management
Date: Thu, 28 Jun 2018 16:09:57 +0000
Message-ID: <MWHPR07MB35020CDA45812192DFC1CAEAD84F0@MWHPR07MB3502.namprd07.prod.outlook.com>
References: <1526995569-5481-1-git-send-email-adouglas@cadence.com>
 <20180627104412.GA8048@red-moon>
In-Reply-To: <20180627104412.GA8048@red-moon>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 27 June 2018 11:44 Lorenzo Pieralisi wrote:
> On Tue, May 22, 2018 at 02:26:09PM +0100, Alan Douglas wrote:
> > This is a series of patches for the cadence PCIe host and EP drivers, t=
o:
> >  - Add optional list of generic PHYs to host and EP drivers
> >  - Add PHY bindings to devicetree
> >  - Add Power Management ops, which will enable/disable PHYs if present
> >  - Update cdns_pcie_writel function signature
> >
> > Changes in v2:
> >     Split commit into four patches
> >     Re-based on v4.17-rc1
> Alan,
>=20
> can I drop this series ? It looks like it has been superseded by
> a new posting:
>  https://patchwork.ozlabs.org/project/linux-pci/list/?series=3D51816
Yes.  I should have marked the latest series posting as v3.
Thanks,
Alan
>=20
> Thanks,
> Lorenzo
>=20
> > Alan Douglas (4):
> >   PCI: cadence: Update cdns_pcie_writel function signature
> >   PCI: cadence: Add generic PHY support to host and EP drivers
> >   dt-bindings: PCI: cadence: Add DT bindings for optional PHYs
> >   PCI: cadence: Add Power Management ops for host and EP
> >
> >  .../devicetree/bindings/pci/cdns,cdns-pcie-ep.txt  |   4 +
> >  .../bindings/pci/cdns,cdns-pcie-host.txt           |   2 +
> >  drivers/pci/cadence/pcie-cadence-ep.c              |  15 ++-
> >  drivers/pci/cadence/pcie-cadence-host.c            |  34 ++++++
> >  drivers/pci/cadence/pcie-cadence.c                 | 123 +++++++++++++=
++++++++
> >  drivers/pci/cadence/pcie-cadence.h                 |  13 ++-
> >  6 files changed, 189 insertions(+), 2 deletions(-)
> >
> > --
> > 2.2.2
> >
