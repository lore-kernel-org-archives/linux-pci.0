Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896B34F3EA9;
	Mon, 19 Oct 2026 12:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792412733; cv=none; b=A3pLODyHI/C4z7YHGFf6K9VqaDeazTz6+SnsAcpMzFB8U9JQAUSgosve6TOwvQ2mgG4dtBLY1D5bKSaOQ1+RlOkIjQwIoYGe4bDTNL4i5HoDScdw+89gtExykdDTrVNHwmYzx0ttq4A6ZFhwtukllb8oVxNA3GoGw/z8SGuMuEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792412733; c=relaxed/simple;
	bh=YJTDbI527Tf1zT2UjCxJU0HY3Pbd/rLRXmaQlQSaYnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NB5kRACqpNkht/1MHCfEIKIP8iry0RpFLWE7BfoSa0D6bqzOHI/p5sgjeq9F3a2qNaxwZDP63hI3l/gppy6FJoyEZdLI92P+p71TVVROpBRAtJcPPHz5SHyizW5G7OAZip9QMTE5ZWQHqX/XOvfwdV96nSetKXNpjBEbHgLpOJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8CDF41A000D;
	Mon, 19 Oct 2026 14:25:18 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 73FE11A0167;
	Mon, 19 Oct 2026 14:25:18 +0200 (CEST)
Received: from lsv051416.swis.nl-cdc01.nxp.com (lsv051416.swis.nl-cdc01.nxp.com [10.168.48.122])
	by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 271C8202B7;
	Mon, 19 Oct 2026 14:25:18 +0200 (CEST)
Date: Mon, 19 Oct 2026 14:25:18 +0200
From: Jan Petrous <jan.petrous@oss.nxp.com>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>,
	NXP S32 Linux Team <s32@nxp.com>, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bogdan Hamciuc <bogdan.hamciuc@nxp.com>,
	Ionut Vicovan <ionut.vicovan@nxp.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Chester Lin <chester62515@gmail.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	imx@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH RFC v3 01/12] dt-bindings: phy: Add NXP S32G SerDes
 subsystem
Message-ID: <atYMLsu64znUJkpl@lsv051416.swis.nl-cdc01.nxp.com>
References: <20260919-s32g_serdes-v3-0-9d68868c1e89@oss.nxp.com>
 <20260919-s32g_serdes-v3-1-9d68868c1e89@oss.nxp.com>
 <as0tiQwquNkdlF2i@SMW015318>
 <as5C7o1joORcdesQ@lsv051416.swis.nl-cdc01.nxp.com>
 <as-ON6s8sNjQC9NP@SMW015318>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <as-ON6s8sNjQC9NP@SMW015318>
X-Virus-Scanned: ClamAV using ClamSMTP

On Wed, Oct 14, 2026 at 09:14:15AM -0500, Frank Li wrote:
> On Tue, Oct 13, 2026 at 04:40:46PM +0200, Jan Petrous wrote:
> > On Mon, Oct 12, 2026 at 01:57:13PM -0500, Frank Li wrote:
> > > On Sat, Sep 19, 2026 at 08:54:29AM +0200, Jan Petrous via B4 Relay wrote:
> > > > [You don't often get email from devnull+jan.petrous.oss.nxp.com@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > > >
> > > > From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
> > > >
> > > > The S32G SerDes subsystem multiplexes two lanes between a PCIe PHY and
> > > > two DesignWare XPCS instances. Describe it with one node per SerDes and
> > > > one child node per lane.
> > > >
> > > > Compared to the previous revision, the vendor nxp,sys-mode property is
> > > > removed: the SS_RW_REG_0[SUBSYS_MODE] value is fully derivable from the
> > > > child-node lane mux and the XPCS instance routing (nxp,xpcs-instance).
> > > > Each working mode described here has a unique lane mux, so the mode is
> > > > a pure function of the child nodes. The reference-clock rate is
> > > > validated against the derived mode; it is not used to select it.
> > > >
> > > > The 3.125 Gbit/s working modes are deliberately not described yet.
> > > > Distinguishing them from the 1.25 Gbit/s dual-XPCS mode requires a
> > > > per-lane 2500BASE-X capability that this binding does not express, and
> > > > the reference clock does not distinguish them either - both accept 100
> > > > or 125 MHz. They are added by the 2500BASE-X follow-up.
> > > >
> > > > Only the PCIe lane child gets '#phy-cells'. An XPCS lane is not a
> > > > generic PHY provider; the Ethernet controller references it through the
> > > > standard pcs-handle property instead.
> > >
> > > Is it possible Ether controller use standard phy interface? of use standard
> > > pcs-handle to phy convertion
> > >
> > > pcs-handle = <&pcs>
> > >
> > > pcs: pcs = {
> > > 	compatible = "pcs-to-phy";
> > > 	phys = <&phy ...>;
> > > }
> > >
> >
> > The MAC needs a phylink_pcs, not a PHY: the XPCS does the C37 autoneg
> > and link state. pcs-handle is the standard property for that, and in
> > v4 the XPCS is driven by pcs-xpcs. The lane mux is fixed before the
> > SerDes reset is released, so the MAC has nothing to set on a generic
> > PHY, and a "pcs-to-phy" node would describe a block the SoC does not
> > have.
> >
> > > >
> > > > S32G2 and S32G3 use distinct compatibles without fallback because the
> > > > full reference-manual mode tables differ per SoC and per SerDes
> > > > instance.
> > > >
> > > > Co-developed-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > > Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
> > > > ---
> > > >  .../devicetree/bindings/phy/nxp,s32g-serdes.yaml   | 258 +++++++++++++++++++++
> > > >  1 file changed, 258 insertions(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/phy/nxp,s32g-serdes.yaml b/Documentation/devicetree/bindings/phy/nxp,s32g-serdes.yaml
> > > > new file mode 100644
> > > > index 000000000000..6343d01bfde4
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/phy/nxp,s32g-serdes.yaml
> > > > @@ -0,0 +1,258 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/phy/nxp,s32g-serdes.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: NXP S32G2xxx/S32G3xxx SerDes PHY subsystem
> > > > +
> > > > +maintainers:
> > > > +  - Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
> > > > +  - Jan Petrous <jan.petrous@oss.nxp.com>
> > > > +
> > > > +description: |
> > > > +  The SerDes subsystem multiplexes two SerDes lanes between one PCIe
> > > > +  controller PHY and two Synopsys DesignWare XPCS (Ethernet PCS) instances,
> > > > +  behind a shared 2-lane combo PHY. The active routing is selected by the
> > > > +  SS_RW_REG_0[SUBSYS_MODE] field.
> > > > +
> > > > +  Reference-manual working modes described by this binding:
> > > > +
> > > > +  Mode  Lane0   Lane1   PHY refclk (MHz)  Description
> > > > +  ------------------------------------------------------------
> > > > +  0     PCIe    PCIe    100               PCIe x2
> > > > +  1     PCIe    XPCS0   100               PCIe x1 + SGMII
> > > > +  2     PCIe    XPCS1   100               PCIe x1 + SGMII
> > > > +  3     XPCS0   XPCS1   100 or 125        dual SGMII, 1.25 Gbit/s
> > > > +
> > > > +  Which Ethernet MAC an XPCS instance feeds is fixed by the SoC integration
> > > > +  and differs per SoC and per SerDes instance - on S32G3 SerDes_0, XPCS0
> > > > +  feeds GMAC0 and XPCS1 feeds PFE_MAC2, while on SerDes_1 the same two
> > > > +  instances feed PFE_MAC0 and PFE_MAC1. That mapping is a property of the
> > > > +  SoC, not of this binding, and is resolved by the driver.
> > >
> > > Roughly look like use argument is little bit better
> > >
> > > <&phys PHY_MODE instance(0/1)>;
> > >
> >
> > Rob suggested that in v2 [1]. Child nodes stayed because:
> >
> > - SUBSYS_MODE is written before the reset is released, so the SerDes
> >   driver needs the whole lane mux at its own probe. With cells it would
> >   have to walk the tree for its consumers, including disabled ones, and
> >   an unconnected lane has no consumer to carry a cell.
> >
> > - The MAC uses pcs-handle, which has no argument cells, so the XPCS
> >   instance has nowhere else to go.
> >
> > - A type cell duplicates phy_set_mode_ext(PHY_MODE_PCIE) from the PCIe
> >   driver.
> >
> > - In mode 0 there is one x2 PHY, not two lane PHYs.

Hi Frank, Rob,

> >
> > I will put this in the v4 commit message. If you or Rob still prefer
> > cells, let me know.
> 
> I think Rob suggestion is better.  ethernet controller should support
> standard phy interface, more devices will share phy between PCI and
> ethernet.
> 
> Frank
> 
> >
> > [1] https://lore.kernel.org/all/CAL_Jsq+SswpTjQShfkdhVwL_k8gJ_5+NrecPCUiFR52UB5zNMA@mail.gmail.com/
> >

OK. I went back to Rob's v2 sketch [1] and to the RK3568 XPCS binding
that got his Reviewed-by last week [2], and the child nodes can go.
Walking the tree for the consumers of the SerDes at probe is what Rob
proposed in v2, and the SUBSYS_MODE write before reset release does not
care how the lane map was obtained. The x2 PCIe case is two phys entries
on the root port, one per lane.

The one thing the SoC does not let me derive is the XPCS instance. The
RK3568 binding derives the MII port from the GMAC when the PCS is
created, but the S32G mux is programmed at SerDes probe, before any MAC
exists, and "XPCS0 alone on lane 1" (mode 1 with the PCIe lane idle)
and "XPCS1 alone on lane 1" (mode 2) are different routings of the same
pins. So the instance has to be in the reference.

The same goes for the line rate. The 3.125 Gbit/s configurations of the
reference manual select a different SUBSYS_MODE value on SerDes_1, cap
PCIe at Gen2 on SerDes_0, need the 125 MHz reference when both lanes
run 3.125, and on S32G2 switch the second XPCS off. All of that is
decided at SerDes probe, and the MAC's phy-mode does not tell: an
in-band SGMII link to a 2.5G PHY is "sgmii" and moves to 2500BASE-X at
runtime. The next version therefore makes the SerDes a four-cell
provider, <lane type instance max-speed>, with the last two cells used
by PHY_TYPE_SGMII only and the speed being the highest the lane is
wired for, 1000 or 2500 Mbit/s. This series accepts 1000 only; 2500
will comes with the 3.125 Gbit/s modes follow-up. Putting the cell
in now avoids a #phy-cells change later.

	// mode 0: PCIe x2
	pcie0 { phys = <&serdes0 0 PHY_TYPE_PCIE 0 0>, <&serdes0 1 PHY_TYPE_PCIE 0 0>; };

	// mode 1: PCIe x1 on lane 0, GMAC0 via XPCS0 on lane 1
	pcie0 { phys = <&serdes0 0 PHY_TYPE_PCIE 0 0>; };
	gmac0 { phys = <&serdes0 1 PHY_TYPE_SGMII 0 1000>; pcs-handle = <&serdes0>; };

	// mode 3: GMAC0 via XPCS0 on lane 0, PFE_MAC2 via XPCS1 on lane 1
	gmac0    { phys = <&serdes0 0 PHY_TYPE_SGMII 0 1000>; pcs-handle = <&serdes0>; };
	pfe_mac2 { phys = <&serdes0 1 PHY_TYPE_SGMII 1 1000>; pcs-handle = <&serdes0>; };

The driver derives SUBSYS_MODE from the enabled consumers' references
to it; a lane nobody references takes the function it has in the first
matching mode. The reference clock is validated against the result as
today. No lane child nodes, no nxp,xpcs-instance.

This is implemented and runs on the RDB3, in both configurations the
board offers, with the numbers of the child-node form:

 - SerDes_1 mode 2 (PCIe_1 x1 on lane 0, PFE_MAC1 via XPCS1 on lane 1)
   plus SerDes_0 mode 3 (GMAC0 via XPCS0): the 82574L in the PCIe slot at
   880/928 Mbit/s, the shared-lane XPCS1 at 935/941, GMAC0 at 935/941,
   NIC and XPCS1 together 878 + 935, 10/10 XPCS1 link down/up under
   PCIe traffic, no AER events.

 - Both SerDes in mode 3: 941/941 and 935/941 Mbit/s on the two
   SerDes_1 lanes, 10/10 down/up on each, 0 failures in 36 partner
   speed changes on the in-band lane (100M/1G, then 100M/1G/2.5G with
   the 2.5G follow-up on top), GMAC0 up on SerDes_0.

The mode is derived from the references alone; the probe log says
"mode 2" and "mode 3" with no lane node in the tree.

Two questions before I post it:

1. The Ethernet side carries two references to the same node:
     * phys for the lane
     * pcs-handle for the PCS
   and I would rather have one. The one I want is pcs-handle
   with argument cells, <&serdes0 lane instance max-speed>, with the
   SerDes as a PCS provider for the MACs and a PHY provider for PCIe
   only. That needs dt-schema PR 198 [3], which is still open, so
   a binding written that way cannot be validated by anyone until
   the schema is released. phys only is the other way out, but a generic
   PHY reference meaning "PCS provider" is not something any binding does
   today.
   Rob, do you want the pair as above for now, with the phys
   reference going away once the cells exist, or should I post with
   pcs-handle cells and have the series wait for PR 198?

2. Rob, any objection to PHY_TYPE_SGMII covering both the 1.25 Gbit/s
   and, later, the 3.125 Gbit/s XPCS modes? The lane rate follows the
   MAC's phy-mode, so I do not plan a separate type for 2500BASE-X.

The DTS, the dwmac-s32 and the PCIe binding patches change accordingly.
On the pcs-xpcs side one value changes: the SGMII link timer written by
the S32G PMA hook becomes 0x2faf, the value the vendor driver programs
for 1G; the 0x7a1 of v3 is its 2500BASE-X value, copied by mistake. The
speed-change figures above are with the new value.

BR.
/Jan

[1] https://lore.kernel.org/all/CAL_Jsq+SswpTjQShfkdhVwL_k8gJ_5+NrecPCUiFR52UB5zNMA@mail.gmail.com/
[2] https://lore.kernel.org/all/20261008175225.3375274-3-coiaprant@gmail.com/
[3] https://github.com/devicetree-org/dt-schema/pull/198
