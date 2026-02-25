Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949E42BE65F;
	Wed, 25 Feb 2026 13:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772025368; cv=none; b=f5g2RX+scl3C4riGoH44OwHjNq/9F5Ms2NidEkbkH8SLU2Ul5g7OFnNsh5LVMnYTkCbUNRE8/by2XDoX/MlEbjYOPGCSRXwHiia6Lxx5ZAVLIgYRYBLRK8pW1z1M/F3YBtP+48L5ukfjsMKM7vj6Q4SoUaFHd2RLyWo5geF7yB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772025368; c=relaxed/simple;
	bh=zt7+EKK8NZaEPwAANQezQqB9aUD7HAT+qkkBsW29/I0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jnrvg7owBku+ylD+CdoesPN3Sv7e0uOWyrFPC7kIzwJYdC9ZrEnPWHK7Wz5Hsx2kIJ5gNltD/NN1MkScd9xUGPCUKjcLCElwi6WVR+Ya96Bw6Imcb2oGeP5alLICNo7+z7SKwt2oqUmuc2GqqHdgWuEcLFVhY6TDC6Z9FVu6N+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BvH1Q7Za; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BvH1Q7Za"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C9FC116D0;
	Wed, 25 Feb 2026 13:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772025368;
	bh=zt7+EKK8NZaEPwAANQezQqB9aUD7HAT+qkkBsW29/I0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BvH1Q7ZazzxuQcKF4MiMeSjjlK/KHi4bA/7u5CKwZRbIOPlWTxRNAt/+ZB41A7tiL
	 BRZJfFPkrEbtHFrhf15VMVhzjgB1oDMAvHK1xz8ATugOhXLq5LAbI+fRt09z5DANnI
	 RFm7wibzbb9unhz46OWkwdAqHCfXxZbM/NAXawluTbjupjmNONOf6Kf6j5u06olF8n
	 brqU/7kmRYBCdLCsHCcblfDfnj/7NHDRXzlX8zi28R1929oOzqNclZubOne+2sQKiT
	 NsmWQDkeKfq4bgKcg8TF/VeuCof0qljEF8gqIZdAEontHPc9GUCOkuo+pcMTg+wiCl
	 +qo6jjC3aiHoA==
Date: Wed, 25 Feb 2026 18:45:58 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Sherry Sun <sherry.sun@nxp.com>
Cc: Hongxing Zhu <hongxing.zhu@nxp.com>, 
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
Message-ID: <dzykdgno7cuy5pc6gcooq7s2dbdzb5p2tktuswk6uiyrnx5fzi@nv7hbkodrxce>
References: <20260213040852.3340547-1-sherry.sun@nxp.com>
 <20260213040852.3340547-3-sherry.sun@nxp.com>
 <woglgacwnhpzy3wrevjs4am4rs754tajzmhvndli4u2fycmzuf@rvbwfzcgnsrf>
 <VI0PR04MB12114C1EF27CE2314B2E789EE9274A@VI0PR04MB12114.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <VI0PR04MB12114C1EF27CE2314B2E789EE9274A@VI0PR04MB12114.eurprd04.prod.outlook.com>

On Tue, Feb 24, 2026 at 10:24:41AM +0000, Sherry Sun wrote:
> > Subject: Re: [PATCH V5 02/12] PCI: host-generic: Add common helpers for
> > parsing Root Port properties
> >
> > On Fri, Feb 13, 2026 at 12:08:42PM +0800, Sherry Sun wrote:
> > > Introduce generic helper functions to parse Root Port device tree
> > > nodes and extract common properties like reset GPIOs. This allows
> > > multiple PCI host controller drivers to share the same parsing logic.
> > >
> > > Define struct pci_host_port to hold common Root Port properties
> > > (currently only reset GPIO descriptor) and add
> > > pci_host_common_parse_ports() to parse Root Port nodes from device
> > tree.
> > >
> > > Also add the 'ports' list to struct pci_host_bridge for better
> > > maintain parsed Root Port information.
> > >
> > > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > > ---
> > >  drivers/pci/controller/pci-host-common.c | 58
> > > ++++++++++++++++++++++++  drivers/pci/controller/pci-host-common.h |
> > 15 ++++++
> > >  drivers/pci/probe.c                      |  2 +
> > >  include/linux/pci.h                      |  1 +
> > >  4 files changed, 76 insertions(+)
> > >
> > > diff --git a/drivers/pci/controller/pci-host-common.c
> > > b/drivers/pci/controller/pci-host-common.c
> > > index d6258c1cffe5..0c35907a5076 100644
> > > --- a/drivers/pci/controller/pci-host-common.c
> > > +++ b/drivers/pci/controller/pci-host-common.c
> > > @@ -9,6 +9,7 @@
> > >
> > >  #include <linux/kernel.h>
> > >  #include <linux/module.h>
> > > +#include <linux/gpio/consumer.h>
> > >  #include <linux/of.h>
> > >  #include <linux/of_address.h>
> > >  #include <linux/of_pci.h>
> > > @@ -17,6 +18,63 @@
> > >
> > >  #include "pci-host-common.h"
> > >
> > > +/**
> > > + * pci_host_common_parse_port - Parse a single Root Port node
> > > + * @bridge: PCI host bridge
> > > + * @node: Device tree node of the Root Port
> > > + *
> > > + * Returns: 0 on success, negative error code on failure  */ static
> > > +int pci_host_common_parse_port(struct pci_host_bridge *bridge,
> > > +                                 struct device_node *node)
> > > +{
> > > +   struct device *dev = &bridge->dev;
> > > +   struct pci_host_port *port;
> > > +   struct gpio_desc *reset;
> > > +
> > > +   reset = devm_fwnode_gpiod_get(dev, of_fwnode_handle(node),
> > > +                                 "reset", GPIOD_OUT_HIGH, "PERST#");
> >
> > For usecases like link retention from bootloader to kernel, this could be
> > requested as GPIOD_ASIS:
> > https://lore.ke/
> > rnel.org%2Flinux-pci%2F20260109-link_retain-v1-3-
> > 7e6782230f4b%40oss.qualcomm.com%2F&data=05%7C02%7Csherry.sun%40
> > nxp.com%7C55c78c3dde694150dd1408de6d778ccd%7C686ea1d3bc2b4c6fa9
> > 2cd99c5c301635%7C0%7C0%7C639068557422583280%7CUnknown%7CTWFp
> > bGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4z
> > MiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=zZAzwcH
> > U2y8kH4YP0OoTVN66tUlCEq6m2aAKkWCFeTM%3D&reserved=0
> >
> 
> Hi Manivannan,
> 
> I understand the concern about supporting use‑cases where the PCIe link is
> intentionally retained from bootloader to kernel. However, relying on GPIOD_ASIS
> may introduces a practical problem: it removes any guarantee about the PERST#
> level during the early power‑on window.
> 
> According to the PCIe initialization requirements, PERST# must remain asserted
> until power rails and REFCLK are valid. If we request the GPIO as GPIOD_ASIS, the
> kernel no longer controls or even knows the actual state of PERST# at probe time,
> which means the device may observe a deassert reset before power/clock stable,
> it is risky even xx_pcie_host_init() asserts/deasserts PERST# again after enable
> power rails hoping to reset the device cleanly. Once PERST# is released before
> power or clock rails are fully valid, the device may already have entered undefined
> or partially‑initialized states. Even if the driver asserts PERST# later, this does not
> guarantee that all internal domains return to a well‑defined reset state. Some
> implementations do not route PERST# to all functional blocks, or early deassert
> during unstable power/clock conditions can leave the PCIe controller or endpoint
> PHY/LTSSM in inconsistent conditions. Consequently, such a sequence can still lead
> to undefined device state, failed link training, or inconsistent enumeration behavior.
> 

I don't think this is true. Even if you request PERST# as GPIOD_ASIS, if you
explicitly assert it *before* doing the controller initialization, net result
would be the same.

Like,
	devm_fwnode_gpiod_get(GPIOD_ASIS)
	...
	assert_perst()
	(perform controller initialization and enable resources)
	deassert_perst()

So if you request PERST# as GPIOD_OUT_HIGH, the first assert_perst() becomes a
NOP, otherwise, the endpoint gets asserted right before the controller
initialization.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
