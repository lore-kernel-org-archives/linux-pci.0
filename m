Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38717 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932084AbcCKV6W (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 11 Mar 2016 16:58:22 -0500
Date: Fri, 11 Mar 2016 15:58:19 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	michals@xilinx.com, sorenb@xilinx.com, bhelgaas@google.com,
	arnd@arndb.de, tinamdar@apm.com, treding@nvidia.com,
	rjui@broadcom.com, Minghuan.Lian@freescale.com,
	m-karicheri2@ti.com, hauke@hauke-m.de, marc.zyngier@arm.com,
	dhdang@apm.com, sbranden@broadcom.com, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Bharat Kumar Gogada <bharatku@xilinx.com>,
	Ravi Kiran Gummaluri <rgummal@xilinx.com>
Subject: Re: [PATCH v12] [PATCH] PCI: Xilinx-NWL-PCIe: Adding support for
 Xilinx NWL PCIe Host Controller
Message-ID: <20160311215819.GB16257@localhost>
References: <1457281934-32068-1-git-send-email-bharatku@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1457281934-32068-1-git-send-email-bharatku@xilinx.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bharat,

I forgot I still have one question here:

On Sun, Mar 06, 2016 at 10:02:14PM +0530, Bharat Kumar Gogada wrote:
> Adding PCIe Root Port driver for Xilinx PCIe NWL bridge IP.

> +static bool nwl_pcie_valid_device(struct pci_bus *bus, unsigned int devfn)
> +{
> +	struct nwl_pcie *pcie = bus->sysdata;
> +
> +	/* Check link,before accessing downstream ports */
> +	if (bus->number != pcie->root_busno) {
> +		if (!nwl_pcie_link_up(pcie))
> +			return false;
> +	}

This seems racy.  What if we check, and the link is up, but the link
goes down before we actually complete the config access?

I'm suggesting that this check for the link being up might be
superfluous.

The hardware should do something reasonable with the config access if
it can't send it down the link.

> +
> +	/* Only one device down on each root port */
> +	if (bus->number == pcie->root_busno && devfn > 0)
> +		return false;
> +
> +	return true;
> +}
