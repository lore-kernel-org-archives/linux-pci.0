Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C02944D019;
	Sat, 28 Feb 2026 15:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772291143; cv=none; b=CF+doGGRQq7zXyaiKzjjLnlCmPgGtIuCY7cZYWRHkFw6lXI8LF6cq4rF5DJ7lEK9j4KQpGU4/aDfjmrHiGR2E8SxYE7vvlRzF4L3iJFmNzrka6yUy5gkpLckAb6/4rQl23viQjgBLlJhtCXWzzrzJm7YR0LI7pE/onivu9cZw3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772291143; c=relaxed/simple;
	bh=0OxJIGMPv76RywmKCdOMvITmwAh2+4ivhDnHMnZnzag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPuJK2ivuAPxu4pR989LFyivE1hWTRpEOua0LJ5MuOlxN12KLKZIosDFMnGfy1QgAZYsHcB6BexoVH7zi7NYtQdDN0emroQxlefwuDyDvDfn3AN8GN97qVG+YClcKEgeUJ6ZIu/akW6ne5BowBJMpaMM9j1S4j87BK0kuM+xUIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ch1Gg2yA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ch1Gg2yA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AF0AC19424;
	Sat, 28 Feb 2026 15:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772291143;
	bh=0OxJIGMPv76RywmKCdOMvITmwAh2+4ivhDnHMnZnzag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ch1Gg2yAQ1PMpheX8+vCmGY8HMEwDFC/hs8l0hqgf2x2w4fkDrBVkS26fABBzrX/b
	 tOatzn+ODy9Qfl2iFvAMrPoYNA+dETAbqE+ZlRgx1BD2n7lQss9UtXusRO8re9CrBJ
	 rHCOJrUGjqjs63PyTMZX8TYRgFZtNaIQ9nkKlmSUxlFAOVucxN28nOVrpCUvGWimnn
	 e2piRZmLR58wfKxdi4IeBlId6JdYpvNAJHF5ttgVRkGXomCi1qr0YQx16DDnr0RuLD
	 vJQmNUVaI0xEw/yJmMFtcNI0HnGHZUvrJjMj/Pqk2lvcHu9uI0mWUxMTqrHC3Fea4m
	 izPytNjE6AS7A==
Date: Sat, 28 Feb 2026 20:35:26 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Hongxing Zhu <hongxing.zhu@nxp.com>
Cc: Sherry Sun <sherry.sun@nxp.com>, 
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>, Frank Li <frank.li@nxp.com>, 
	"bhelgaas@google.com" <bhelgaas@google.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>, 
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "robh@kernel.org" <robh@kernel.org>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, 
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "kernel@pengutronix.de" <kernel@pengutronix.de>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V5 02/12] PCI: host-generic: Add common helpers for
 parsing Root Port properties
Message-ID: <2pxztu4pnngj55bqvrqjukaeatzcr6t267trfimlnctgznocsz@svgi3dyvcme2>
References: <20260213040852.3340547-1-sherry.sun@nxp.com>
 <20260213040852.3340547-3-sherry.sun@nxp.com>
 <woglgacwnhpzy3wrevjs4am4rs754tajzmhvndli4u2fycmzuf@rvbwfzcgnsrf>
 <VI0PR04MB12114C1EF27CE2314B2E789EE9274A@VI0PR04MB12114.eurprd04.prod.outlook.com>
 <dzykdgno7cuy5pc6gcooq7s2dbdzb5p2tktuswk6uiyrnx5fzi@nv7hbkodrxce>
 <VI0PR04MB12114F7059ED27ABAB51FDBE99272A@VI0PR04MB12114.eurprd04.prod.outlook.com>
 <AS8PR04MB8833F7D36FFA325DD87023308C70A@AS8PR04MB8833.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB8833F7D36FFA325DD87023308C70A@AS8PR04MB8833.eurprd04.prod.outlook.com>

On Sat, Feb 28, 2026 at 01:58:43AM +0000, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Sherry Sun <sherry.sun@nxp.com>
> > Sent: 2026年2月26日 11:40
> > To: Manivannan Sadhasivam <mani@kernel.org>
> > Cc: Hongxing Zhu <hongxing.zhu@nxp.com>; l.stach@pengutronix.de; Frank
> > Li <frank.li@nxp.com>; bhelgaas@google.com; lpieralisi@kernel.org;
> > kwilczynski@kernel.org; robh@kernel.org; krzk+dt@kernel.org;
> > conor+dt@kernel.org; s.hauer@pengutronix.de; festevam@gmail.com;
> > imx@lists.linux.dev; kernel@pengutronix.de; linux-pci@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org;
> > linux-kernel@vger.kernel.org
> > Subject: RE: [PATCH V5 02/12] PCI: host-generic: Add common helpers for
> > parsing Root Port properties
> > 
> > > Subject: Re: [PATCH V5 02/12] PCI: host-generic: Add common helpers
> > > for parsing Root Port properties
> > >
> > > On Tue, Feb 24, 2026 at 10:24:41AM +0000, Sherry Sun wrote:
> > > > > Subject: Re: [PATCH V5 02/12] PCI: host-generic: Add common
> > > > > helpers for parsing Root Port properties
> > > > >
> > > > > On Fri, Feb 13, 2026 at 12:08:42PM +0800, Sherry Sun wrote:
> > > > > > Introduce generic helper functions to parse Root Port device
> > > > > > tree nodes and extract common properties like reset GPIOs. This
> > > > > > allows multiple PCI host controller drivers to share the same parsing
> > logic.
> > > > > >
> > > > > > Define struct pci_host_port to hold common Root Port properties
> > > > > > (currently only reset GPIO descriptor) and add
> > > > > > pci_host_common_parse_ports() to parse Root Port nodes from
> > > > > > device
> > > > > tree.
> > > > > >
> > > > > > Also add the 'ports' list to struct pci_host_bridge for better
> > > > > > maintain parsed Root Port information.
> > > > > >
> > > > > > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > > > > > ---
> > > > > >  drivers/pci/controller/pci-host-common.c | 58
> > > > > > ++++++++++++++++++++++++
> > > > > > ++++++++++++++++++++++++ drivers/pci/controller/pci-host-common.
> > > > > > ++++++++++++++++++++++++ h
> > > > > > ++++++++++++++++++++++++ |
> > > > > 15 ++++++
> > > > > >  drivers/pci/probe.c                      |  2 +
> > > > > >  include/linux/pci.h                      |  1 +
> > > > > >  4 files changed, 76 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/pci/controller/pci-host-common.c
> > > > > > b/drivers/pci/controller/pci-host-common.c
> > > > > > index d6258c1cffe5..0c35907a5076 100644
> > > > > > --- a/drivers/pci/controller/pci-host-common.c
> > > > > > +++ b/drivers/pci/controller/pci-host-common.c
> > > > > > @@ -9,6 +9,7 @@
> > > > > >
> > > > > >  #include <linux/kernel.h>
> > > > > >  #include <linux/module.h>
> > > > > > +#include <linux/gpio/consumer.h>
> > > > > >  #include <linux/of.h>
> > > > > >  #include <linux/of_address.h>
> > > > > >  #include <linux/of_pci.h>
> > > > > > @@ -17,6 +18,63 @@
> > > > > >
> > > > > >  #include "pci-host-common.h"
> > > > > >
> > > > > > +/**
> > > > > > + * pci_host_common_parse_port - Parse a single Root Port node
> > > > > > + * @bridge: PCI host bridge
> > > > > > + * @node: Device tree node of the Root Port
> > > > > > + *
> > > > > > + * Returns: 0 on success, negative error code on failure  */
> > > > > > +static int pci_host_common_parse_port(struct pci_host_bridge
> > *bridge,
> > > > > > +                                 struct device_node *node) {
> > > > > > +   struct device *dev = &bridge->dev;
> > > > > > +   struct pci_host_port *port;
> > > > > > +   struct gpio_desc *reset;
> > > > > > +
> > > > > > +   reset = devm_fwnode_gpiod_get(dev, of_fwnode_handle(node),
> > > > > > +                                 "reset", GPIOD_OUT_HIGH,
> > > > > > + "PERST#");
> > > > >
> > > > > For usecases like link retention from bootloader to kernel, this
> > > > > could be requested as GPIOD_ASIS:
> > > > > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2F
> > > > > lo
> > > > >
> > > re.ke%2F&data=05%7C02%7Csherry.sun%40nxp.com%7C7957eace8620494e
> > > da250
> > > > >
> > >
> > 8de74700adc%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63907
> > > 622173
> > > > >
> > >
> > 6969266%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiO
> > > iIwLjAu
> > > > >
> > >
> > MDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%
> > > 7C%7
> > > > >
> > >
> > C&sdata=S6ME9QOAFR5OC8w5WRjFeHW46t4OAxVkVz6E3pCJWQk%3D&rese
> > > rved=0
> > > > > rnel.org%2Flinux-pci%2F20260109-link_retain-v1-3-
> > > > >
> > >
> > 7e6782230f4b%40oss.qualcomm.com%2F&data=05%7C02%7Csherry.sun%40
> > > > >
> > >
> > nxp.com%7C55c78c3dde694150dd1408de6d778ccd%7C686ea1d3bc2b4c6fa9
> > > > >
> > >
> > 2cd99c5c301635%7C0%7C0%7C639068557422583280%7CUnknown%7CTWFp
> > > > >
> > >
> > bGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4z
> > > > >
> > > MiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=zZAzwcH
> > > > > U2y8kH4YP0OoTVN66tUlCEq6m2aAKkWCFeTM%3D&reserved=0
> > > > >
> > > >
> > > > Hi Manivannan,
> > > >
> > > > I understand the concern about supporting use‑cases where the PCIe
> > > > link is intentionally retained from bootloader to kernel. However,
> > > > relying on GPIOD_ASIS may introduces a practical problem: it removes
> > > > any guarantee about the PERST# level during the early power‑on
> > window.
> > > >
> > > > According to the PCIe initialization requirements, PERST# must
> > > > remain asserted until power rails and REFCLK are valid. If we
> > > > request the GPIO as GPIOD_ASIS, the kernel no longer controls or
> > > > even knows the actual state of PERST# at probe time, which means the
> > > > device may observe a deassert reset before power/clock stable, it is
> > > > risky even
> > > > xx_pcie_host_init() asserts/deasserts PERST# again after enable
> > > > power rails hoping to reset the device cleanly. Once PERST# is
> > > > released before power or clock rails are fully valid, the device may
> > > > already have entered undefined or partially‑initialized states. Even
> > > > if the driver asserts PERST# later, this does not guarantee that all
> > > > internal domains return to a well‑defined reset state. Some
> > > > implementations do not route PERST# to all functional blocks, or
> > > > early deassert during unstable power/clock conditions can leave the
> > > > PCIe controller or endpoint
> > > PHY/LTSSM in inconsistent conditions. Consequently, such a sequence
> > > can still lead to undefined device state, failed link training, or
> > > inconsistent enumeration behavior.
> > > >
> > >
> > > I don't think this is true. Even if you request PERST# as GPIOD_ASIS,
> > > if you explicitly assert it *before* doing the controller
> > > initialization, net result would be the same.
> > >
> > > Like,
> > > 	devm_fwnode_gpiod_get(GPIOD_ASIS)
> > > 	...
> > > 	assert_perst()
> > > 	(perform controller initialization and enable resources)
> > > 	deassert_perst()
> > >
> > > So if you request PERST# as GPIOD_OUT_HIGH, the first assert_perst()
> > > becomes a NOP, otherwise, the endpoint gets asserted right before the
> > > controller initialization.
> > >
> > Hi Manivannan,
> > Got your point, seems there are some issues in the order of assert/deassert
> > and power/clk enable in pci-imx6 driver. Maybe I need to readjust the
> > sequence internal imx_pcie_host_init().
> > 
> > Thanks, will change to use GPIOD_ASIS in next version.
> If the GPIOD_ASIS is used, the PERST# should be asserted before vpcie3v3
>  or vpcie3v3aux is turned on.
> That's the reason why GPIOD_OUT_HIGH is set in the probe of pci-imx6.c
>  driver currently.

That's fine. We can add a separate PERST# assert before enabling 3.3v
regulator.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
