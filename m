Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:37333 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754269Ab3H1TTN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2013 15:19:13 -0400
Received: by mail-ie0-f173.google.com with SMTP id qa5so5372428ieb.4
        for <linux-pci@vger.kernel.org>; Wed, 28 Aug 2013 12:19:13 -0700 (PDT)
MIME-Version: 1.0
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 28 Aug 2013 13:18:52 -0600
Message-ID: <CAErSpo4rF6BUhQ98djrLpcyfQXdi7-BR0BROP1mbv+LxVV+BoA@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: correctly check availability of PCIe Link
 Cap/Status/Control registers
To: Jiang Liu <liuj97@gmail.com>
Cc: Yuval Mintz <yuvalmin@broadcom.com>,
	"jacob . e . keller @ intel . com" <jacob.e.keller@intel.com>,
	Jiang Liu <jiang.liu@huawei.com>,
	"linux-pci @ vger . kernel . org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 28, 2013 at 11:23 AM, Jiang Liu <liuj97@gmail.com> wrote:
> From: Jiang Liu <jiang.liu@huawei.com>
>
> According to PCIe Base Specification 3.0, devices are guarenteed to
> return zero for unimplemented V2 PCI Express Capability registers.
> But there's no such guarantee for unimplemented V1 PCI Express
> Capability registers, so we need to explicitly check availability of
> V1 PCI Express Capability registers and return zero for unimplemented
> registers.
>
> Changeset 1b6b8ce2ac372e "PCI: only save/restore existent registers in
> the PCIe capability" introduces pcie_cap_has_lnkctl(), which assumes that
> PCIe root port, endpoint and legacy endpoint with 1.0 PCIe Capability
> implement Link Cap/Status/Control registers.
>
> On the other hand, section 7.8 of PCIe Base Spec V1.1 and V3.0 states that
> "The Link Capabilities, Link Status, and Link Control registers are
> required for all Root Ports, Switch Ports, Bridges, and Endpoints that
> are not Root Complex Integrated Endpoints."
> That means Link Capability/Status/Control registers are also available
> for PCIe Upstream Port, Downstream Port, PCIe-to-PCI bridge and PCI-to-PCIe
> bridge. So change pcie_cap_has_lnkctl() to follow PCIe specifications.
>
> Also refine pcie_cap_has_sltctl() and pcie_cap_has_rtctl() for readability.
>
> Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
> Reported-by: Yuval Mintz <yuvalmin@broadcom.com>
> ---
>  drivers/pci/access.c | 39 ++++++++++++++++++++++++++++-----------
>  1 file changed, 28 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> index 1cc2366..b9af3d1 100644
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -470,6 +470,13 @@ void pci_cfg_access_unlock(struct pci_dev *dev)
>  }
>  EXPORT_SYMBOL_GPL(pci_cfg_access_unlock);
>
> +/*
> + * According to PCIe base spec 3.0, devices are guarenteed to return zero for
> + * unimplemented V2 PCI Express Capability registers. But there's no such
> + * guarantee for unimplemented V1 PCI Express Capability registers, so
> + * explicitly check availability of V1 PCI Express Capability registers
> + * and return zero for unimplemented registers.
> + */
>  static inline int pcie_cap_version(const struct pci_dev *dev)
>  {
>         return pcie_caps_reg(dev) & PCI_EXP_FLAGS_VERS;
> @@ -484,29 +491,39 @@ static inline bool pcie_cap_has_lnkctl(const struct pci_dev *dev)
>  {
>         int type = pci_pcie_type(dev);
>
> -       return pcie_cap_version(dev) > 1 ||
> -              type == PCI_EXP_TYPE_ROOT_PORT ||
> -              type == PCI_EXP_TYPE_ENDPOINT ||
> -              type == PCI_EXP_TYPE_LEG_END;
> +       if (pcie_cap_version(dev) == 1)
> +               return  type == PCI_EXP_TYPE_ENDPOINT ||
> +                       type == PCI_EXP_TYPE_LEG_END ||
> +                       type == PCI_EXP_TYPE_ROOT_PORT ||
> +                       type == PCI_EXP_TYPE_UPSTREAM ||
> +                       type == PCI_EXP_TYPE_DOWNSTREAM ||
> +                       type == PCI_EXP_TYPE_PCI_BRIDGE ||
> +                       type == PCI_EXP_TYPE_PCIE_BRIDGE;

I split this out into a separate patch because it's a bug fix, and I
don't want to clutter the bugfix with the readability changes.

And I think I changed my mind about the capability version checks.
You previously suggested removing the check, at least for
pcie_cap_has_lnkctl().  I think that's a good idea for all the
pcie_cap_has_*() functions because it makes the code cleaner and
easier to read.

I'll post the tweaks I have in mind as a separate series; see what you think.

Bjorn

> +
> +       return true;
>  }
>
>  static inline bool pcie_cap_has_sltctl(const struct pci_dev *dev)
>  {
>         int type = pci_pcie_type(dev);
>
> -       return pcie_cap_version(dev) > 1 ||
> -              type == PCI_EXP_TYPE_ROOT_PORT ||
> -              (type == PCI_EXP_TYPE_DOWNSTREAM &&
> -               pcie_caps_reg(dev) & PCI_EXP_FLAGS_SLOT);
> +       if (pcie_cap_version(dev) == 1)
> +               return type == PCI_EXP_TYPE_ROOT_PORT ||
> +                      (type == PCI_EXP_TYPE_DOWNSTREAM &&
> +                       pcie_caps_reg(dev) & PCI_EXP_FLAGS_SLOT);
> +
> +       return true;
>  }
>
>  static inline bool pcie_cap_has_rtctl(const struct pci_dev *dev)
>  {
>         int type = pci_pcie_type(dev);
>
> -       return pcie_cap_version(dev) > 1 ||
> -              type == PCI_EXP_TYPE_ROOT_PORT ||
> -              type == PCI_EXP_TYPE_RC_EC;
> +       if (pcie_cap_version(dev) == 1)
> +               return type == PCI_EXP_TYPE_ROOT_PORT ||
> +                      type == PCI_EXP_TYPE_RC_EC;
> +
> +       return true;
>  }
>
>  static bool pcie_capability_reg_implemented(struct pci_dev *dev, int pos)
> --
> 1.8.1.2
>
