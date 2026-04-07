Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3AE38C2C3;
	Tue,  7 Apr 2026 06:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775544772; cv=none; b=moeEZpdaIlHdujo9X6/IdPP+YrElN8i4mnWnEg9QmmvPn3oXaK6bvLKfgHyZXBZVBT1TIp/UB5IVgIMmYHlbTEu8D6EE8X1dj9bHPjEzmmxigNlZ/qfcehDj4HXkvhq7TMIccGXhydxN7wVWr5R4ZbInKwPE+qKk7Xv6SIIrS8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775544772; c=relaxed/simple;
	bh=WGsLWUaefXttIWa4xg//3ucHTQKXOeomFOP2gCuLPaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fVrUx5+hMHtMaN7TvshdmKplEc0hdh7mWZjr/zHoOx6+h3zleKbHTvTo9Vo660j6EjhDD963VP20qPFpt3MMLx1DIHRVt0VyhmmpOFS56f/qvi+r023/u8dZXW4p9PHuwOWrwRve48gfl5k9ZMEWOAmTzdKgPVwnOzjCeEhfAKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMiZJyBS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMiZJyBS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADC4FC19424;
	Tue,  7 Apr 2026 06:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775544772;
	bh=WGsLWUaefXttIWa4xg//3ucHTQKXOeomFOP2gCuLPaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JMiZJyBS4mIHsbyctppDhmAKIiEAFEcyZzWgxNdB/JZgKoP9I6U0Z0gMuyODk/+0w
	 PJkA8c2thFkCppygUqBiD3WNPgwFWMWK+hSpvwCeR2/VSIZIrTfWurnRMHwap7A/9L
	 uPnBZHFMEbz6ZdDp18rxenqpokrVLSS1txIbHpwjFBzLLTeleOsTn1pfvib8/MO9o3
	 prj50U83P8JLIE+csPT/sFsyhuw2M7qOYO0dup5/FLdVOJJA8Q9Gx6P9uLukSI/rCt
	 eRq5/GdmHiadCfIenQawy4MHHPOHHUib1ZfCgf/J+2uv/51LwA1Gqg8QW5dUgBdhVU
	 wt9wjPX0hjMSw==
Date: Tue, 7 Apr 2026 12:22:42 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Sherry Sun <sherry.sun@nxp.com>
Cc: "robh@kernel.org" <robh@kernel.org>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	Frank Li <frank.li@nxp.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, 
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, 
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>, 
	"bhelgaas@google.com" <bhelgaas@google.com>, Hongxing Zhu <hongxing.zhu@nxp.com>, 
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>, "imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V10 03/13] PCI: dwc: Parse Root Port nodes in
 dw_pcie_host_init()
Message-ID: <gxqcmujdzlzcoawn4rkttasftuyusqtvycu7oagogxaw4yggeo@ww6rjdwbyj2w>
References: <20260402095107.205439-1-sherry.sun@nxp.com>
 <20260402095107.205439-4-sherry.sun@nxp.com>
 <xlsfwtcy3wl6nasmx2w2oys6u4bbnvh24qiwr4pf3v5uz523gz@qvhzqfcs5q2c>
 <VI0PR04MB121147E4D3F9FDC95391C1153925AA@VI0PR04MB12114.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <VI0PR04MB121147E4D3F9FDC95391C1153925AA@VI0PR04MB12114.eurprd04.prod.outlook.com>

On Tue, Apr 07, 2026 at 03:21:30AM +0000, Sherry Sun wrote:
> > On Thu, Apr 02, 2026 at 05:50:57PM +0800, Sherry Sun wrote:
> > > Add support for parsing Root Port child nodes in dw_pcie_host_init()
> > > using pci_host_common_parse_ports(). This allows DWC-based drivers to
> > > specify Root Port properties (like reset GPIOs) in individual Root
> > > Port nodes rather than in the host bridge node.
> > >
> > > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-designware-host.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > index da152c31bb2e..f6fca984fb34 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > @@ -20,6 +20,7 @@
> > >  #include <linux/platform_device.h>
> > >
> > >  #include "../../pci.h"
> > > +#include "../pci-host-common.h"
> > >  #include "pcie-designware.h"
> > >
> > >  static struct pci_ops dw_pcie_ops;
> > > @@ -581,6 +582,13 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
> > >
> > >  	pp->bridge = bridge;
> > >
> > > +	/* Parse Root Port nodes if present */
> > > +	ret = pci_host_common_parse_ports(dev, bridge);
> > > +	if (ret && ret != -ENOENT) {
> > > +		dev_err(dev, "Failed to parse Root Port nodes: %d\n", ret);
> > > +		return ret;
> > 
> > Won't this change break drivers that parse Root Ports on their own? Either
> > you need to modify them also in this change or call this API from imx6 driver
> > and let other drivers switch to it in a phased manner.
> > 
> > I perfer the latter.
> 
> Hi Mani, sorry I didn't fully get your point here, there are no changes to this part
> V10, for drivers that parse Root Ports on their own, here pci_host_common_parse_ports()
> will return -ENOENT, so nothing break as we discussed this in V8
> https://lore.kernel.org/all/dcl3bdljrdzgeaybrg3dc5uaxkebkjns7pajix6mxxftao5g4m@vm3ywyyp4ujh/.
> 

So if this API gets called first, it will acquire PERST# from the Root Port node
and if the controller drivers try to do the same in their own parsing code,
PERST# request will return -EBUSY and the probe will fail.

On the other hand, if the controller drivers parse PERST# first, this API will
return -EBUSY and will result in probe failure.

Only way to fix this issue would be to call this API from imx6 driver for now
and start migrating other drivers later.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
