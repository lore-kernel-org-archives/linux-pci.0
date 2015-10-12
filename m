Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:46233 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751178AbbJLI5h (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 12 Oct 2015 04:57:37 -0400
Date: Mon, 12 Oct 2015 09:57:35 +0100
From: Liviu Dudau <Liviu.Dudau@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Jon Medhurst <tixy@linaro.org>,
	linux-pci <linux-pci@vger.kernel.org>,
	device-tree <devicetree@vger.kernel.org>,
	LAKML <linux-arm-kernel@lists.infradead.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] PCI: Add quirk for PLDA's XpressRICH3 host bridge
 class.
Message-ID: <20151012085735.GJ3394@e106497-lin.cambridge.arm.com>
References: <1444409849-5685-1-git-send-email-Liviu.Dudau@arm.com>
 <1444409849-5685-3-git-send-email-Liviu.Dudau@arm.com>
 <7335872.olmykfZgj7@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <7335872.olmykfZgj7@wuerfel>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 09, 2015 at 08:32:07PM +0200, Arnd Bergmann wrote:
> On Friday 09 October 2015 17:57:26 Liviu Dudau wrote:
> > +/*
> > + * The PLDA's XpressRICH3 doesn't describe itself as a bridge. This is required
> > + * for correct/normal enumeration.
> > + */
> > +static void xr3pci_quirk_class(struct pci_dev *pdev)
> > +{
> > +       pdev->class = PCI_CLASS_BRIDGE_PCI << 8;
> > +}
> > +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_PLDA, PCI_DEVICE_ID_XR3PCI, xr3pci_quirk_class);
> > 
> 
> Are you sure that this device ID is only used for the host bridge, not
> for related devices in endpoint mode?

I would hope so. The device ID has been assigned to ARM's implementation by PLDA,
it would be logical not to be reused for anyone else's.

> 
> While we don't support PCIe endpoint drivers at the moment, it might
> happen at some point and then things break when someone tries to
> plug a machine with this ID into a Linux host.

I'm asking for confirmation inside ARM that the IDs are uniquely allocated to Juno
and will come back when I'll get confirmation.

Best regards,
Liviu

> 
> 	Arnd
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
