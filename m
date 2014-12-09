Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:37831 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755257AbaLIDX4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 8 Dec 2014 22:23:56 -0500
MIME-Version: 1.0
In-Reply-To: <1415907457-3147-2-git-send-email-l.stach@pengutronix.de>
References: <1415907457-3147-1-git-send-email-l.stach@pengutronix.de> <1415907457-3147-2-git-send-email-l.stach@pengutronix.de>
From: Alexandre Courbot <gnurou@gmail.com>
Date: Tue, 9 Dec 2014 12:23:36 +0900
Message-ID: <CAAVeFu+sYnhMEmDSPvinbP-BQQnqAu6rpEVgaLx25Y3UtGVUwQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: tegra: apply relaxed ordering fixup only on Tegra
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lucas,

Apologies for taking so long to come back to this. The patch looks ok
to me, just a minor comment about the Tegra PCI detection:

On Fri, Nov 14, 2014 at 4:37 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
> The fixup to enable relaxed ordering on all PCI devices was
> executed unconditionally if the Tegra PCI host driver was
> built into the kernel. This doesn't play nice with a
> multiplatform kernel executed on other platforms which
> may not need this fixup.
>
> Make sure to only apply the fixup if the root port is
> a Tegra.
>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  drivers/pci/host/pci-tegra.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> index 3d43874319be..d5a14f22ebb8 100644
> --- a/drivers/pci/host/pci-tegra.c
> +++ b/drivers/pci/host/pci-tegra.c
> @@ -647,10 +647,34 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0bf1, tegra_pcie_fixup_class);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0e1c, tegra_pcie_fixup_class);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0e1d, tegra_pcie_fixup_class);
>
> +static int tegra_pcie_root_is_tegra(struct pci_dev *dev)
> +{
> +       struct pci_bus *bus = dev->bus;
> +       struct pci_dev *root_bridge;
> +
> +       /* walk up the PCIe hierarchy to the first level below the root bus */
> +       while (bus->parent && bus->parent->self)
> +               bus = bus->parent;
> +
> +       /*
> +        * If there is no bridge on the bus the passed device is the root
> +        * bridge itself.
> +        */
> +       root_bridge = bus->self ? bus->self : dev;
> +       if (root_bridge->vendor == PCI_VENDOR_ID_NVIDIA &&
> +           (root_bridge->device == 0x0bf0 || root_bridge->device == 0x0bf1 ||
> +            root_bridge->device == 0x0e1c || root_bridge->device == 0x0e1d ||
> +            root_bridge->device == 0x0e12 || root_bridge->device == 0x0e13))
> +               return 1;

I am not very familiar with PCI so sorry if these are stupid
questions, but where do these device IDs come from? Are they needed at
all, e.g. can't you just test against root_bridge->vendor ==
PCI_VENDOR_ID_NVIDIA to detect a NVIDIA root? Is the list susceptible
to increase as new chips get released? If that's the case, how can we
make sure we won't forget to update it?

If you need to test against the device ID, it might be more legible
(and easier to update) if you use a switch case, e.g:

    if (root_bridge->vendor != PCI_VENDOR_ID_NVIDIA)
        return 0;
    switch (root_bridge->device) {
    case 0x0bf0:
    case 0x0bf1:
    case 0x0e1c:
    case 0x0e1d:
    case 0x0e12:
    case 0x0e12:
        return 1;
    default:
        return 0;
    }

Otherwise I have not noticed any problem using this patch.

Tested-by: Alexandre Courbot <acourbot@nvidia.com>
