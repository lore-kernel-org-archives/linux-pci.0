Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:51922 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752275AbbFWWdU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 23 Jun 2015 18:33:20 -0400
Message-ID: <1435098734.3996.5.camel@kernel.crashing.org>
Subject: Re: [RFC 3/4] arm64: Do not call enable PCI resources when specify
 PCI_PROBE_ONLY
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: suravee.suthikulpanit@amd.com
Cc: will.deacon@arm.com, liviu.dudau@arm.com, marc.zyngier@arm.com,
	mark.rutland@arm.com, catalin.marinas@arm.com,
	jason@lakedaemon.net, tglx@linutronix.de, robh+dt@kernel.org,
	bhelgaas@google.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org
Date: Wed, 24 Jun 2015 08:32:14 +1000
In-Reply-To: <1411937610-22125-4-git-send-email-suravee.suthikulpanit@amd.com>
References: <1411937610-22125-1-git-send-email-suravee.suthikulpanit@amd.com>
	 <1411937610-22125-4-git-send-email-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, 2014-09-28 at 15:53 -0500, suravee.suthikulpanit@amd.com wrote:
> From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> 
> When specify PCI_PROBE_ONLY, the resource parent does not get assigned.
> Therefore, pci_enable_resources() return error saying that
> "BAR x not claimed".
> 
> Note: This same logic is also used in the arch/arm/kernel/bios32.c

This looks broken. Why don't you assign the resource parent ?

> Cc: Liviu Dudau <Liviu.Dudau@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> ---
>  arch/arm64/kernel/pci.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> index ce5836c..7fd4d2b 100644
> --- a/arch/arm64/kernel/pci.c
> +++ b/arch/arm64/kernel/pci.c
> @@ -68,3 +68,11 @@ void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
>  	bus->domain_nr = domain;
>  }
>  #endif
> +
> +int pcibios_enable_device(struct pci_dev *dev, int mask)
> +{
> +	if (pci_has_flag(PCI_PROBE_ONLY))
> +		return 0;
> +
> +	return pci_enable_resources(dev, mask);
> +}


