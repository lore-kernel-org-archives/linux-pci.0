Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196FF34D910;
	Tue, 19 May 2026 05:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779169956; cv=none; b=mgKogYilTUliwsMwZjgCNPjDwtYRu6oOZwbv3UzqCpERl/RSmDSV6Yf2pgRaIMzYZC623nYdEFBSnq2awO03shGs575hDuc+OGjjP1m/FPIJh6LrMQ0r0IT/9nOHWnC15gLt3Z1f92fpBAlwBiVLVBUZ7XjNQSW5ZIa4LWU/+rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779169956; c=relaxed/simple;
	bh=K7UKJ6sYP2y8DZracD2ty+9g+TETER+ES7eLcMmhpa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RmTOTzqtxttlY+ECoqnlkSD9ogc2Npa2+CnICLKAO0O+JzFKKi44N57IhA4Ae96M+IcEAF9fcuclZlJDOfE9InB6wPywo9PWXDwXJ/CdrJtxUUe/5YEt965PtmXMcIjHa8Vy3el8m/1eYDTQJGs5V8uUxtmYDwzDCKngH3fzr+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hle+rkwI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hle+rkwI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 065E6C2BCB3;
	Tue, 19 May 2026 05:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779169955;
	bh=K7UKJ6sYP2y8DZracD2ty+9g+TETER+ES7eLcMmhpa0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hle+rkwIjgCpLvvRebMQjZUD4RpHe4vaD/NMGctxBCcJgKhOh/KxmTkh1IEWPeE0o
	 HvgQadE+/aDUPAjYedw+3kXpGLh501Egr0d3XQUWNHNcZyIqtSmVCE+paU4g1TV3Yv
	 mqX0kdDhiSwhrU8Q3e5Fi/sXH0TVxvuGTvwmLtXk8la7G8uqONvLtzi2UxI5LEJ3V5
	 QK3zQ8TBGnDL3bLaILxx3Z9xPCMNObwlzppslIwRzOueLfLeqRiQf2T3Xdw2Ia2q5o
	 Vc4zt4fBuUlGStJjsL5LNl3L1MAKli7+a3rCiBXuW7D+4MmTZ4Baf+hdRTTcW1mFL4
	 fTuYlLiQaLyDA==
Date: Tue, 19 May 2026 11:22:26 +0530
From: "mani@kernel.org" <mani@kernel.org>
To: Sherry Sun <sherry.sun@nxp.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, 
	"conor+dt@kernel.org" <conor+dt@kernel.org>, Frank Li <frank.li@nxp.com>, 
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, 
	"festevam@gmail.com" <festevam@gmail.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>, 
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>, 
	Hongxing Zhu <hongxing.zhu@nxp.com>, "l.stach@pengutronix.de" <l.stach@pengutronix.de>, 
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V14 02/12] PCI: host-generic: Add common helpers for
 parsing Root Port properties
Message-ID: <xyued2adtz2fs47nnl537aef7rsjuhswivcaieh6lxhlxpohkr@gpxmdcpczik7>
References: <20260422093549.407022-3-sherry.sun@nxp.com>
 <20260513224944.GA341451@bhelgaas>
 <VI0PR04MB1211452312EB9BC6EF1ED2E0192032@VI0PR04MB12114.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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
> 

Fine with me. The reason for suggesting fallback within this API itself was to
avoid duplicating the fallback code as it will be mostly generic. But I do agree
with Bjorn on the fact that individual host controller drivers might have
optional properties in the RC node and we can't incorporate all of them here.

But no need to rework this series as it got applied for v7.2. You can send
rework patches on top of this series.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
