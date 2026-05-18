Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428FE39183A;
	Mon, 18 May 2026 22:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779143880; cv=none; b=N6Qj3Q9PI/2898Oduix/pGfOtTN4dM0noThNxsho2RiCRifuhRpcI88Ut54OffLF06ufy2BDykWoD/U5CU2JcAH2SZJsN68zZOtbuJD+sAIX4PlITPSsDvNtYfM69z7FNIdWPhY3fSsjlY4dFXQyjyV8eiDNLyCeiNjae2I9gR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779143880; c=relaxed/simple;
	bh=yCPh+HXQRcTVsmUvu2yXJQlDcVHXXFcwMfPUyflHlTc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Bz4PI20TcS92fgR0Qq4wQvdWCO9+GIGTEULd4awQykKS4HxUU9GSYkfKw+e0/dkLuYXghMxwYuMU01tm4igXFRzxLv+TotmHffW2zRtWZt2Ee4K2DxqJp0r85V9a3s5qznY+buYNyZZ3sPGapYooUPFaCAq/BtfrkWtlpc1vf7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uIV9oMFs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uIV9oMFs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE48DC2BCB7;
	Mon, 18 May 2026 22:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779143879;
	bh=yCPh+HXQRcTVsmUvu2yXJQlDcVHXXFcwMfPUyflHlTc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=uIV9oMFsZiB2k1H5yl4LvHnzDb5kbXykJcpKi7D9HmO3wpF30Fm7LMuqdkV/3wCSx
	 OZUB0KApB6xzK86w+pr1GMGjcouh1CpiLyTubSJWy5Iizzi4Sh0lwp+iUl5vy4gPCe
	 hVUHFUGhHj/5bI5VhZ5jEFySJ7rdeKgSF+J7SO1dmKKI7ondlimEn9G0rFsSQFIxzS
	 Wuph+R9JnXLbtGU5Xvac38Cp0cMt9u0DQ5P/aqPnpoAQKMIdGejHfufT4c+eB+oPta
	 6aFZyhcUkwnug9239xE8FvofQgCMdSkFJZtUA2kDeuTuF14eScoCCQb/PcZbUrT3Wg
	 Ty4V3IdCqwS6Q==
Date: Mon, 18 May 2026 17:37:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sherry Sun <sherry.sun@nxp.com>
Cc: "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	Frank Li <frank.li@nxp.com>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	Hongxing Zhu <hongxing.zhu@nxp.com>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V14 02/12] PCI: host-generic: Add common helpers for
 parsing Root Port properties
Message-ID: <20260518223758.GA649325@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI0PR04MB1211452312EB9BC6EF1ED2E0192032@VI0PR04MB12114.eurprd04.prod.outlook.com>

On Mon, May 18, 2026 at 08:42:38AM +0000, Sherry Sun wrote:
> > Subject: Re: [PATCH V14 02/12] PCI: host-generic: Add common helpers for
> > parsing Root Port properties
> > 
> > On Wed, Apr 22, 2026 at 05:35:39PM +0800, Sherry Sun wrote:
> > > Introduce generic helper functions to parse Root Port device tree
> > > nodes and extract common properties like reset GPIOs. This allows
> > > multiple PCI host controller drivers to share the same parsing logic.
> > >
> > > Define struct pci_host_port to hold common Root Port properties
> > > (currently only list of PERST# GPIO descriptors) and add
> > > pci_host_common_parse_ports() to parse Root Port nodes from device
> > tree.
> > >
> > > Also add the 'ports' list to struct pci_host_bridge for better
> > > maintain parsed Root Port information.
> > > ...
> > 
> > > +static int pci_host_common_parse_port(struct device *dev,
> > > +				      struct pci_host_bridge *bridge,
> > > +				      struct device_node *node)
> > > +{
> > > +	struct pci_host_port *port;
> > > +	int ret;
> > > +
> > > +	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
> > > +	if (!port)
> > > +		return -ENOMEM;
> > > +
> > > +	INIT_LIST_HEAD(&port->perst);
> > > +
> > > +	ret = pci_host_common_parse_perst(dev, port, node);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	/*
> > > +	 * 1. PERST# found in RP or its child nodes - list is not empty, continue
> > > +	 * 2. PERST# not found in RP/children, but found in RC node - return -
> > ENODEV
> > > +	 *    to fallback legacy binding
> > > +	 * 3. PERST# not found anywhere - list is empty, continue (optional
> > PERST#)
> > > +	 */
> > > +	if (list_empty(&port->perst)) {
> > > +		if (of_property_present(dev->of_node, "reset-gpios") ||
> > > +		    of_property_present(dev->of_node, "reset-gpio"))
> > > +			return -ENODEV;
> > 
> > This doesn't seem right to me.  The parser of per-Root Port properties should
> > not be responsible for deciding whether legacy methods are valid, i.e.,
> > whether a property is in the Root Complex node.  I think it's up to the caller
> > to decide whether it needs to look elsewhere.
> > 
> > I don't think this even needs to return a "success/failure" value because there
> > may be more properties in the future, and not all will be required.  This
> > function can't tell which properties a specific driver requires and which are
> > optional.
> > 
> > The caller can check whether we found what it needs and fall back to a legacy
> > method as needed.
> 
> Hi Bjorn,
> The code here was suggested by Mani, https://lore.kernel.org/all/lnzprzrdwra7pn7d6m3sbj5pvjy64blwpjl6i3lmlnfbyho63b@czpyhpgz5vum/.
> I think your suggestion here is reasonable, the per-Root Port parser shouldn't
> check the RC-level binding. That's a policy decision that belongs to the caller.
> 
> Hi Mani, if you also agree, I'll rework this so that:
> 1. pci_host_common_parse_port() only parses properties from the Root Port
>     (and its children) without checking the RC node.
> 2. The function won't return failure for "property not found" - it will only return
>      errors for real failures (e.g., -ENOMEM, GPIO acquisition errors).
> 3. The legacy fallback logic will be moved to the caller, which can inspect the
>      parsed result and decide whether to fall back to the legacy binding.

This is only used for imx6 so far, so I think this is OK as-is for
v7.2.  We can file this under "possible future rework or kernel
mentee project."
