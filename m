Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-cys01nam02on0042.outbound.protection.outlook.com ([104.47.37.42]:38617
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935704AbeEXIXB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 May 2018 04:23:01 -0400
From: Alan Douglas <adouglas@cadence.com>
To: Rob Herring <robh@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.com" <linux-kernel@vger.kernel.com>,
        "cyrille.pitchen@free-electrons.com"
        <cyrille.pitchen@free-electrons.com>
Subject: RE: [RESEND PATCH 3/4] dt-bindings: PCI: cadence: Add DT bindings for
 optional PHYs
Date: Thu, 24 May 2018 08:22:57 +0000
Message-ID: <SN6PR07MB4512126062D1B934DF342713D86A0@SN6PR07MB4512.namprd07.prod.outlook.com>
References: <1526995952-22031-1-git-send-email-adouglas@cadence.com>
 <20180523185229.GA7457@rob-hp-laptop>
In-Reply-To: <20180523185229.GA7457@rob-hp-laptop>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On  23 May 2018 19:52, Rob Herring wrote:
> On Tue, May 22, 2018 at 02:32:32PM +0100, Alan Douglas wrote:
> > Update DT documentation to include optional PHYs for cadence PCIe
> > host and endpoint controllers.
> >
> > Signed-off-by: Alan Douglas <adouglas@cadence.com>
> > ---
> >  Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt   | 4 ++++
> >  Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt | 2 ++
> >  2 files changed, 6 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.tx=
t b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-
> ep.txt
> > index 9a305237..e40c635 100644
> > --- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt
> > +++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt
> > @@ -9,6 +9,8 @@ Required properties:
> >
> >  Optional properties:
> >  - max-functions: Maximum number of functions that can be configured (d=
efault 1).
> > +- phys: From PHY bindings: List of Generic PHY phandles.
> > +- phy-names:  List of names to identify the PHY.
>=20
> You need to define how many. I'd assume one, but I guess your example is
> 1 per lane.
>=20
I can update the description in v3 as follows:
 - phys: From PHY bindings: List of Generic PHY phandles. One per lane if m=
ore than one in the
  list.  If only one PHY listed it must manage all lanes.=20
 - phy-names:  List of names to identify the PHY, one for each in the list.
> >
> >  Example:
> >
> > @@ -19,4 +21,6 @@ pcie@fc000000 {
> >  	reg-names =3D "reg", "mem";
> >  	cdns,max-outbound-regions =3D <16>;
> >  	max-functions =3D /bits/ 8 <8>;
> > +	phys =3D <&ep_phy0 &ep_phy1>;
> > +	phy-names =3D "pcie-lane0","pcie-lane1";
> >  };
