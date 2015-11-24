Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40102 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754976AbbKXVwG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 24 Nov 2015 16:52:06 -0500
Date: Tue, 24 Nov 2015 15:52:01 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Daney <ddaney.cavm@gmail.com>
Cc: linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Marc Zyngier <marc.zyngier@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	David Daney <david.daney@cavium.com>
Subject: Re: [PATCH] arm64/pci: Add quirks for Cavium Thunder PCI bridges.
Message-ID: <20151124215200.GF17377@localhost>
References: <1442966996-13419-1-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1442966996-13419-1-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi David,

On Tue, Sep 22, 2015 at 05:09:56PM -0700, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> The Cavium ThunderX SoC needs a PCI quirk for its on-chip bridges.
> Since it is arm64, create a new quirks.c file there to contain arm64
> related quirks.  Add the ThunderX bridge quirk, gated by a new config
> variable, so that it can be disabled for kernels that aren't expected
> to be used on ThunderX.

Is this still needed?  I've seen some follow-up Cavium stuff, but
nothing further on this one.  If we still need it, we should figure
out who should take it.  It's all under arch/arm64, so ordinarily I
would leave it up to the arm64 guys.

> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>  arch/arm64/Kconfig         | 11 +++++++++++
>  arch/arm64/kernel/Makefile |  2 +-
>  arch/arm64/kernel/quirks.c | 36 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 48 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/kernel/quirks.c

> +#ifdef CONFIG_CAVIUM_THUNDER_PCI_QUIRKS
> +static void thunder_bridge_fixup(struct pci_dev *dev)
> +{
> +	/*
> +	 * This bridge is broken in that it doesn't have correct
> +	 * resource ranges for the buses behind it.
> +	 *
> +	 * The upstream bus resources are a close enough approximation
> +	 * to what is needed, that they can be used instead.  Copy
> +	 * upstream root bus resources so that resource claiming for
> +	 * downstream devices can be done.
> +	 */
> +	int resno;
> +	struct pci_bus *bus = dev->subordinate;
> +
> +	for (resno = 0; resno < PCI_BRIDGE_RESOURCE_NUM; resno++) {
> +		bus->resource[resno] =
> +			pci_bus_resource_n(bus->parent,
> +					   PCI_BRIDGE_RESOURCE_NUM + resno);

I am curious about this.  Is this a standard PCI-PCI bridge, or is it
a host bridge.  If the former, I guess it must be broken in some way
that keeps the usual bridge window reading code from working?

Copying the upstream bus resources to the downstream bus might sort of
work sometimes, but seems fragile in general.  If the bridge has any
peers, it seems like we're headed for a conflict between the peer's
resources and anything downstream of the bridge.

> +	}
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CAVIUM, 0xa002, thunder_bridge_fixup);
> +#endif /* CONFIG_CAVIUM_THUNDER_PCI_QUIRKS */
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
