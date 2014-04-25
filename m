Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:55732 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613AbaDYUGk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 25 Apr 2014 16:06:40 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
	horms@verge.net.au, devicetree@vger.kernel.org, robh+dt@kernel.org,
	pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	linux-pci@vger.kernel.org, linux-sh@vger.kernel.org,
	magnus.damm@gmail.com, linux@arm.linux.org.uk,
	linux-arm-kernel@lists.infradead.org, ben.dooks@codethink.co.uk,
	linux-doc@vger.kernel.org, rob@landley.net, grant.likely@linaro.org
Subject: Re: [PATCH] pci-rcar-gen2: add device tree support
Date: Fri, 25 Apr 2014 22:05:50 +0200
Message-ID: <23319337.TNDCodMgFf@wuerfel>
In-Reply-To: <20140425174535.GF32246@google.com>
References: <201404080141.21605.sergei.shtylyov@cogentembedded.com> <20140425174535.GF32246@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 25 April 2014 11:45:35 Bjorn Helgaas wrote:
> > +This is the bridge used internally to connect the USB controllers to the
> > +AHB. There is one bridge instance per USB port connected to the internal
> > +OHCI and EHCI controllers.
> > +
> > +Required properties:
> > +- compatible: "renesas,pci-r8a7790" for the R8A7790 SoC;
> > +           "renesas,pci-r8a7791" for the R8A7791 SoC.
> > +- reg:       A list of physical regions to access the device: the first is
> > +     the operational registers for the OHCI/EHCI controllers and the
> > +     second is for the bridge configuration and control registers.
> > +- interrupts: interrupt for the device.
> > +- clocks: The reference to the device clock.
> > +- bus-range: The PCI bus number range; as this is a single bus, the range
> > +           should be specified as the same value twice.

Actually, this doesn't conform to the generic PCI binding, which requires
a number of additional properties.

	Arnd
