Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4327A36214D;
	Wed, 21 Jan 2026 18:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769019136; cv=none; b=nVCluTnUEDl6gtTfgNSDEOJrN3A6CYf/Y6WyvvQwfn9v14dGsY2luhCR0FkovbTayRiSoHGRdVGJEQI74lLIosw5N4qLH+AipQ/UM8EbyMHjyWNentvPWWAtUuWU91P+m41l5czc+BKovFpp7/lcWw2om6++Uv5TG9xHR3cxGDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769019136; c=relaxed/simple;
	bh=cHGjf5j8wEph1msNihsNnBmJ71soJ6yk44rAku7xkek=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=skJZ8IdFIsaZYF2S/KV0e8YV3eVt+SsR9JkcdB+dgxJTnzk4gD1LXf2Fv7te1GaZLZppMvJCR6LLV+E5Q1jS95jrueAErZ0mulc54eAgywMHTxh4cGGWFfLPa/cz8M/Kjx8VUgmQHjKbXN0NB8B6/g4W1kTmrrZViyGhOeOI4lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nS8LtG1n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nS8LtG1n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96582C4AF09;
	Wed, 21 Jan 2026 18:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769019135;
	bh=cHGjf5j8wEph1msNihsNnBmJ71soJ6yk44rAku7xkek=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=nS8LtG1ndyPwSJ4xq+OzTY2smzkHaViOJEzcg1JcLIE8Pv1y3PtI7mtdPhuiyq7aa
	 JNbCzZ2dIA+L48ICjVn6qy9qvcqdqfjVe1mgFwmVjeyE5x4hVUSUI342ARDdW13drI
	 /39Y5gFam3+N61CL9SgAOupsUZkbkKy0E+nJ3IwOgV1AATAQ0Krnwy6l4pmCyPCqBN
	 ahIjokeVu2cs/Nb46NTp6JqdRHEQ89rUwGGAixUxlS/eJPTNma7epoZXYZvU7ebZJZ
	 0REO/GNCvP/60X8U+X30Ujzpfg/2diZP4CfalW1PisOYqEPz9iTk9h45Cxl74IixNC
	 C3tkkqYLER4rw==
Date: Wed, 21 Jan 2026 12:12:14 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Pragnesh Patel <pragneshp@marvell.com>
Cc: gcherian@marvell.com, Suneel Garapati <sgarapati@marvell.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: octeon: Add link down handler support for PCIe MAC
 controller
Message-ID: <20260121181214.GA1202856@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121051439.1882086-1-pragneshp@marvell.com>

On Tue, Jan 20, 2026 at 09:14:29PM -0800, Pragnesh Patel wrote:
> From: Suneel Garapati <sgarapati@marvell.com>
> 
> This driver adds support for link-down interrupt in PCIe MAC (PEM)
> controller in Root complex mode to support hot-plug removal of
> endpoint devices.

PEM?

> An interrupt handler is registered for RST_INT msix vector
> which is triggered with link going down. This handler
> performs cleanup of root bridge and its children and
> re-initializes root bridge to kernel for next link-up event.

Wrap to fill 75 columns.

> +config PCI_OCTEON_PEM
> +	bool "Marvell Octeon PEM (PCIe MAC) controller"
> +	depends on ARM64 || COMPILE_TEST
> +	depends on PCI_MSI
> +	depends on HOTPLUG_PCI_PCIE
> +	help
> +	  Say Y here if you want PEM controller support for Marvell ARM64 Octeon SoCs
> +	  in root complex mode.

Wrap to fit in 80 columns like the rest of the file.

> +++ b/drivers/pci/controller/pci-octeon-pem.c

This looks like a PCIe controller, so name it "pcie-octeon-pem.c".
There are some older drivers for PCIe controllers that use "pci-", but
that was a mistake.

> +#include "../hotplug/pciehp.h"

This looks like a red flag, see below.

> +#define PCI_DEVID_OCTEON_PEM	0xA06C

Typical names are PCI_DEVICE_ID_<vendor>_<device> (see
include/linux/pci_ids.h).

In this case, I guess it would be "PCI_DEVICE_ID_CAVIUM_OCTEON" or
similar.

> +#define ID_SHIFT		36

Use GENMASK() instead of shift/mask, so you don't need #defines like
this.

> +#define DOMAIN_OFFSET		0x3
> +#define ON_OFFSET		0xE0
> +#define RST_SOFT_PERST_OFFSET	0x298
> +#define RST_INT_OFFSET		0x300
> +#define RST_INT_ENA_W1C_OFFSET	0x310
> +#define RST_INT_ENA_W1S_OFFSET	0x318
> +#define RST_INT_LINKDOWN	BIT(1)

The "_OFFSET" suffixes look unnecessarily wordy.

> +static void pem_recover_rc_link(struct work_struct *ws)
> +{

> +	/* Check if HP interrupt thread is in progress
> +	 * and wait for it to complete
> +	 */

Multi-line comment style in drivers/pci/ is:

  /*
   * Check ...
   */

Wrap to fill 78 columns or so.

> +	dev_dbg(&pem_dev->dev, "PEM%d HP ist done\n", pem->index);

s/ist/is/

> +	/* Clean-up device and RC bridge */
> +	pci_stop_and_remove_bus_device(root_port);

I'm doubtful about removing a Root Port.  I don't know of any standard
PCIe mechanism for doing that.

> +	pci_unlock_rescan_remove();
> +
> +	usleep_range(100, 200);

Where does this delay come from?  If it's something in the PCIe spec,
we should have a #define in drivers/pci/pci.h for it.  If it's in the
Octeon spec, a reference to that would be helpful.

> +	writeq(0x0, pem->base + RST_SOFT_PERST_OFFSET);
> +
> +	while (timeout--) {
> +		/* Check for PEM_OOR to be set */
> +		pem_reg = readq(pem->base + ON_OFFSET);
> +		if (pem_reg & BIT(1))

Add a #define for this BIT(1).

> +			break;
> +		usleep_range(1000, 2000);

Same delay question as above.

> +	}
> +	if (!timeout) {
> +		dev_warn(&pem_dev->dev,
> +			 "PEM failed to get out of reset\n");
> +		return;
> +	}
> +
> +	pci_lock_rescan_remove();

I haven't reviewed this in detail, but it looks like unusual knowledge
of pciehp internals that might not be appropriate for a controller
driver.

> +static int pem_register_interrupts(struct pci_dev *pdev)
> +{
> +	struct pem_ctlr *pem = pci_get_drvdata(pdev);
> +	int nvec, err;
> +
> +	nvec = pci_msix_vec_count(pdev);

Add blank line before comment, use multi-line comment style.

> +	/* Some earlier silicon versions do not support RST vector
> +	 * so check on table size before registering otherwise
> +	 * return with info message.
> +	 */

> +/* Supported devices */
> +static const struct pci_device_id pem_id_table[] = {
> +	{PCI_VDEVICE(CAVIUM, PCI_DEVID_OCTEON_PEM)},

Same question as Mani, I guess.  PCI controllers are not themselves
PCI devices; they're platform_devices normally discovered via ACPI or
DT.

Root Ports *are* PCIe devices, and normally don't need device specific
code since they are PCI-to-PCI bridges.  The device-specific code is
usually in a PCIe controller (Root Complex) driver that claims the
relevant platform_device.

It's problematic to claim Root Ports, because portdrv normally claims
them so it can support AER, pciehp, etc.
