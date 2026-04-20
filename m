Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F10277029;
	Mon, 20 Apr 2026 05:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776664792; cv=none; b=SRG/MsUHuEw65N1TYLD//PWgJlLidMH6lxrwlBiFXyv5nX+dGVLcmhm3BGYKXHM+g8cSMjbD6jW1tZoChXzZBO2cfz7kK7ukr/1qqRrcGrm+zz5jStoaW7OGFUfRpwSYMS1I0oOPIidhU4b5wTr8KcYGbeCmKOk+zrkLPBFgIEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776664792; c=relaxed/simple;
	bh=qvl88XtpdJrz8xvd3WG4vIRbwZ4m+ixBTe9tfI8jYX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sAwQsVrb/Z0GINW42mfLC18HoFiAqaUw+M1pKe11rUFzXn+yqsBto8ylAvlpw+s+0YG7sJ64i6wYt72zhLUG4UDxJurgF+iHNWIDzkihhV5Yye/8lnrEVOX6zz53feGH5faZ0zSL9/iVDSqqe/t/zTAyqMJuhM/hmYUnAkd2QqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a70U5ES6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a70U5ES6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97238C19425;
	Mon, 20 Apr 2026 05:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776664792;
	bh=qvl88XtpdJrz8xvd3WG4vIRbwZ4m+ixBTe9tfI8jYX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a70U5ES6AjDceje7rOqIc7JnQIn22gpZdzWbf3e1gVc9efcR1maz9eUKMxJq2DOOa
	 I8T4UsKNswsirAX8s3GwZtGavjXDUesSVhiMNuHkP9rk4Uw9/UySyDAbO4YjHrsVGX
	 Gz7HJ3XN9bYIA8we2iuQVq8jtLYiATvFWZSkeo+GZL3oT79t2BlJxY/vmOSaWM0Nfy
	 /nM55fF4TSFZpAi4z+X4qQ/eSRoIfa8PnfBDWS8AzFdLW5tWaHP6WIqx5MQgNdsmdn
	 uNVIivsEoINM2+IPspRN1QCp8oiE9H+MrBU/Cm6Peo4A5wyeqfbL38e/MGQ6G5LAy8
	 hXQUqEFPkmUnw==
Date: Mon, 20 Apr 2026 11:29:37 +0530
From: "mani@kernel.org" <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Sherry Sun <sherry.sun@nxp.com>, "robh@kernel.org" <robh@kernel.org>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	Frank Li <frank.li@nxp.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, 
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, 
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>, 
	"bhelgaas@google.com" <bhelgaas@google.com>, Hongxing Zhu <hongxing.zhu@nxp.com>, 
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>, "imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V13 02/12] PCI: host-generic: Add common helpers for
 parsing Root Port properties
Message-ID: <viggqsxczf5d5hok4qpqhknalwb46xapsgdxbbgbqhruhyn2hn@wtck4yajmuw7>
References: <VI0PR04MB1211449884AC3BC8E3711F1AB92202@VI0PR04MB12114.eurprd04.prod.outlook.com>
 <20260417195533.GA92707@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260417195533.GA92707@bhelgaas>

On Fri, Apr 17, 2026 at 02:55:33PM -0500, Bjorn Helgaas wrote:
> On Fri, Apr 17, 2026 at 03:17:16AM +0000, Sherry Sun wrote:
> > > On Thu, Apr 16, 2026 at 07:14:12PM +0800, Sherry Sun wrote:
> > > > Introduce generic helper functions to parse Root Port device
> > > > tree nodes and extract common properties like reset GPIOs. This
> > > > allows multiple PCI host controller drivers to share the same
> > > > parsing logic.
> > > >
> > > > Define struct pci_host_port to hold common Root Port properties
> > > > (currently only reset GPIO descriptor) and add
> > > > pci_host_common_parse_ports() to parse Root Port nodes from
> > > > device tree.
> > > 
> > > Are the Root Port and the RC the only possible places for 'reset'
> > > GPIO descriptions in DT?  I think PERST# routing is outside the
> > > PCIe spec, so it seems like a system could provide a PERST# GPIO
> > > routed to any Switch Upstream Port or Endpoint (I assume a PERST#
> > > connected to a switch would apply to both the upstream port and
> > > the downstream ports).
> > 
> > Thanks for the feedback. You're right that PERST# routing could
> > theoretically be connected to any device in the hierarchy. However,
> > for this patch series, I've focused on the most common use case in
> > practice: use Root Port level PERST# instead of the legacy Root
> > Complex level PERST#.
> > 
> > Root Port level PERST# - This is the primary target, where each Root
> > Port has individual control over devices connected to it.  RC level
> > PERST# - Legacy binding support, where a single GPIO controls all
> > ports.
> > 
> > We can extend this framework later if real hardware emerges that
> > needs Switch or EP-level PERST# control. I can add a comment
> > documenting this limitation if needed.
> > 
> > BTW, Mani and Rob had some great discussions in dt-schema about
> > PERST# and WAKE# sideband signals settings.
> 
> > You can check here:
> > https://github.com/devicetree-org/dt-schema/issues/168
> > https://github.com/devicetree-org/dt-schema/pull/126
> > https://github.com/devicetree-org/dt-schema/pull/170
> 
> The upshot of all those conversations is that WAKE# and PERST# can be
> routed to arbitrary devices independent of the PCI topology.
> 
> I think extending host-generic to look for 'reset' in Root Port nodes
> is the right thing.  My concern is more about where we store it.  This
> patch saves it in a new "pci_host_port" struct, but someday we'll want
> a place to save the PERST# GPIOs for several slots behind a switch.
> Then we'll have two different ways to save the same information.
> 

Even if there are PERST# GPIOs from the host, connected to downstream ports of a
PCIe switch, they could be stored in the Root Port's (pci_host_port) struct as a
list of PERST#. This is what pcie-qcom driver does.

It is too clumsy to handle PERST# individually for each device. We tried it
before with pwrctrl, but it always ended up biting us on who gets to control the
PERST#. We can't let pwrctrl handle PERST# for a switch port and host controller
driver handle it for RP. And we cannot let pwrctrl handle PERST# for all ports,
because, host controller drivers also need to control them for RC
initialization.

That's why it was decided to handle PERST# for all ports in the host controller
drivers. So following that pattern, this helper could also be extended to parse
the PERST# from all ports defined in DT and store them in the same Root Port
struct.

It should be trivial to implement this logic in the current helper. @Sherry:
Could you please implement this logic?

> WAKE# signals might be more pertinent -- we definitely need to support
> multiple WAKE# signals below a single Root Port, and it seems like
> PERST# and WAKE# GPIOs should be saved the same place.
> 
> I'm wondering if both should go in the pci_dev itself.  I guess the
> implication is that a pci_dev->reset GPIO would describe a PERST#
> connected to the device *below* the pci_dev, at least for Downstream
> Ports.
> 

Problem is, PERST# needs to be controlled even before 'pci_dev' gets created. We
create 'pci_dev' only when a device get's detected. But the PERST# assertion and
deassertion happens even before the pci_host_probe() call, which is the starting
point for enumeration. That's why storing it as a list in 'pci_host_bridge'
makes it accessible by the host controller drivers.

> I don't know about WAKE# signals.  When it's in a connector, there's
> probably only a single possible WAKE# per Downstream Port.  But is it
> possible have multiple WAKE# signals from a multi-function device
> that's on the motherboard?  Saving the WAKE# GPIO in the Downstream
> Port wouldn't accommodate that case.

AFAIK, a single device can have only one WAKE# irrespective of how many function
it exposes. PCIe base spec doesn't indicate whether it is per-device or
per-function, but the form factor specfications like CEM, Mini-CEM define it as
a per-device signal.

Moreover, unlike PERST#, WAKE# is not driven by the host system. Host just needs
to register an IRQ handler to service the interrupts raised by the device. So it
can be parsed *after* enumerating a device and stored in 'pci_dev' as done in
Krishna's series:
https://lore.kernel.org/linux-pci/20260403-wakeirq_support-v9-0-1cbecf3b58d7@oss.qualcomm.com/

- Mani

-- 
மணிவண்ணன் சதாசிவம்
