Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CB7355F49;
	Fri, 17 Apr 2026 19:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776455735; cv=none; b=tMh/gXmm+eAC/uB3M5UdtVj5hr1+0BEn9YcRilS8XtejAkkfBAw2EuhiQZpIjdjCsNpy1yzkSpfvBVtorii+LWrjJEOVfj5Gr8ZWnJdwFEdU1gA4uoxa4RDoIG56+X9j1hRM6mLDyLjN+fyPdLeAj7DxsuG8P8oJuz+c9vNjdX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776455735; c=relaxed/simple;
	bh=l+dL+bsfkqpxw8vBZ2qjjX1NYJoorXmurqTXyqgMrXM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QBcEbN06/Lw93YXFZVVZUya4BLI7zO/rMLlsSdlijAHIKk0gfWv+bTce7qNVTA+X/2OQuPJpHvwuzZi8PwG2G6BG/jDMQhMC6xE0Qh2kq6HtnGBlQszQ32ZLt0A9CFIAbNTJWzFfOTqvlQNalLrAO2WP59zpL7Rw5GOvyJQOpks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oeyODZQ7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oeyODZQ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4050C19425;
	Fri, 17 Apr 2026 19:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776455735;
	bh=l+dL+bsfkqpxw8vBZ2qjjX1NYJoorXmurqTXyqgMrXM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=oeyODZQ7mydKqug4mEFFqwgFy2wf0FKAlp7sEFJNQSbj1jDtm1VgmE/QiQPf6wMmb
	 D6zt0jL2JMD8k/PnfFAHGgbQYWawCD76DJ6c1cxShv6ZsPixx+NHg+fAHLDx6wWtSo
	 j6P1XSuE4JxbkM/JjIL41MapnGeDAPaBqhHqJ5fdrx+owkVvW5RBdGMUu8YzGH5uMv
	 rr5BQnn8via7fKYmj89e3OfqaLe0mNoiG+3E1vhRhcFZpC42zQZ4HxSVrQXPGd21h5
	 XFp0/tLX+i+3NsVPU0mCh+pOoCIROYgYzKM7j/B3RMf8AwiLoqUpuHStC6GxYRdvl/
	 RcVvpgff6WYVQ==
Date: Fri, 17 Apr 2026 14:55:33 -0500
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
Subject: Re: [PATCH V13 02/12] PCI: host-generic: Add common helpers for
 parsing Root Port properties
Message-ID: <20260417195533.GA92707@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI0PR04MB1211449884AC3BC8E3711F1AB92202@VI0PR04MB12114.eurprd04.prod.outlook.com>

On Fri, Apr 17, 2026 at 03:17:16AM +0000, Sherry Sun wrote:
> > On Thu, Apr 16, 2026 at 07:14:12PM +0800, Sherry Sun wrote:
> > > Introduce generic helper functions to parse Root Port device
> > > tree nodes and extract common properties like reset GPIOs. This
> > > allows multiple PCI host controller drivers to share the same
> > > parsing logic.
> > >
> > > Define struct pci_host_port to hold common Root Port properties
> > > (currently only reset GPIO descriptor) and add
> > > pci_host_common_parse_ports() to parse Root Port nodes from
> > > device tree.
> > 
> > Are the Root Port and the RC the only possible places for 'reset'
> > GPIO descriptions in DT?  I think PERST# routing is outside the
> > PCIe spec, so it seems like a system could provide a PERST# GPIO
> > routed to any Switch Upstream Port or Endpoint (I assume a PERST#
> > connected to a switch would apply to both the upstream port and
> > the downstream ports).
> 
> Thanks for the feedback. You're right that PERST# routing could
> theoretically be connected to any device in the hierarchy. However,
> for this patch series, I've focused on the most common use case in
> practice: use Root Port level PERST# instead of the legacy Root
> Complex level PERST#.
> 
> Root Port level PERST# - This is the primary target, where each Root
> Port has individual control over devices connected to it.  RC level
> PERST# - Legacy binding support, where a single GPIO controls all
> ports.
> 
> We can extend this framework later if real hardware emerges that
> needs Switch or EP-level PERST# control. I can add a comment
> documenting this limitation if needed.
> 
> BTW, Mani and Rob had some great discussions in dt-schema about
> PERST# and WAKE# sideband signals settings.

> You can check here:
> https://github.com/devicetree-org/dt-schema/issues/168
> https://github.com/devicetree-org/dt-schema/pull/126
> https://github.com/devicetree-org/dt-schema/pull/170

The upshot of all those conversations is that WAKE# and PERST# can be
routed to arbitrary devices independent of the PCI topology.

I think extending host-generic to look for 'reset' in Root Port nodes
is the right thing.  My concern is more about where we store it.  This
patch saves it in a new "pci_host_port" struct, but someday we'll want
a place to save the PERST# GPIOs for several slots behind a switch.
Then we'll have two different ways to save the same information.

WAKE# signals might be more pertinent -- we definitely need to support
multiple WAKE# signals below a single Root Port, and it seems like
PERST# and WAKE# GPIOs should be saved the same place.

I'm wondering if both should go in the pci_dev itself.  I guess the
implication is that a pci_dev->reset GPIO would describe a PERST#
connected to the device *below* the pci_dev, at least for Downstream
Ports.

I don't know about WAKE# signals.  When it's in a connector, there's
probably only a single possible WAKE# per Downstream Port.  But is it
possible have multiple WAKE# signals from a multi-function device
that's on the motherboard?  Saving the WAKE# GPIO in the Downstream
Port wouldn't accommodate that case.
