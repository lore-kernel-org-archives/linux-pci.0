Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:37734 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756322AbbFRSAY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 18 Jun 2015 14:00:24 -0400
Received: by wicgi11 with SMTP id gi11so1191965wic.0
        for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2015 11:00:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <017c1ec8e3f43f86a947eaddb30c9389e0b1053b.1434154377.git.dhdang@apm.com>
References: <CAErSpo5Oc_8ca4h7xYSkGPFE1vxWg1sy1rJRc0B=u9LrdOLY7g@mail.gmail.com>
	<017c1ec8e3f43f86a947eaddb30c9389e0b1053b.1434154377.git.dhdang@apm.com>
Date: Thu, 18 Jun 2015 11:00:22 -0700
Message-ID: <CACoXjcn89mnYqHrmQYK-PVq-YueAvv3zECCtDMnCoKF3xzmBew@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] PCI: X-Gene: Disable Configuration Request Retry
 Status for X-Gene v1 PCIe
From: Tanmay Inamdar <tinamdar@apm.com>
To: Duc Dang <dhdang@apm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Ian Campbell <ian.campbell@citrix.com>,
	Marcin Juszkiewicz <mjuszkiewicz@redhat.com>,
	patches <patches@apm.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Fri, Jun 12, 2015 at 5:35 PM, Duc Dang <dhdang@apm.com> wrote:
> X-Gene v1 PCIe controller has a bug in Configuration Request Retry
> Status (CRS) logic:
>   When CPU tries to read Vendor ID and Device ID of not-existed
>   remote device, the controller returns 0xFFFF0001 instead of
>   0xFFFFFFFF; this will add significant delay in boot time as
>   pci_bus_read_dev_vendor_id will wait for 60 seconds before
>   giving up.
>
> So for X-Gene v1 PCIe controllers, disable CRS capability
> advertisement by clearing CRS Software Visibility bit before
> returning the Root Capability value to the callers. This is done
> by implementing X-Gene PCIe specific xgene_pcie_config_read32 for
> CFG read accesses to replace the generic default pci_generic_config_read32
> function.
>
> v2 changes:
>         Use pci_generic_config_read32 to implement xgene_pcie_config_read32
>
> Signed-off-by: Duc Dang <dhdang@apm.com>
> Tested-by: Ian Campbell <ian.campbell@citrix.com>
> Tested-by: Marcin Juszkiewicz <mjuszkiewicz@redhat.com>

 Acked-by: Tanmay Inamdar <tinamdar@apm.com

> ---
>  drivers/pci/host/pci-xgene.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 42 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
> index e6c8864..7e3cf28 100644
> --- a/drivers/pci/host/pci-xgene.c
> +++ b/drivers/pci/host/pci-xgene.c
> @@ -59,6 +59,12 @@
>  #define SZ_1T                          (SZ_1G*1024ULL)
>  #define PIPE_PHY_RATE_RD(src)          ((0xc000 & (u32)(src)) >> 0xe)
>
> +#define ROOT_CAP_AND_CTRL              0x5C
> +
> +/* PCIe IP version */
> +#define XGENE_PCIE_IP_VER_UNKN         0
> +#define XGENE_PCIE_IP_VER_1            1
> +
>  struct xgene_pcie_port {
>         struct device_node      *node;
>         struct device           *dev;
> @@ -67,6 +73,7 @@ struct xgene_pcie_port {
>         void __iomem            *cfg_base;
>         unsigned long           cfg_addr;
>         bool                    link_up;
> +       u32                     version;
>  };
>
>  static inline u32 pcie_bar_low_val(u32 addr, u32 flags)
> @@ -140,9 +147,39 @@ static void __iomem *xgene_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
>         return xgene_pcie_get_cfg_base(bus) + offset;
>  }
>
> +int xgene_pcie_config_read32(struct pci_bus *bus, unsigned int devfn,
> +                             int where, int size, u32 *val)
> +{
> +       struct xgene_pcie_port *port = bus->sysdata;
> +
> +       if (pci_generic_config_read32(bus, devfn, where & ~0x3, 4, val) !=
> +           PCIBIOS_SUCCESSFUL)
> +               return PCIBIOS_DEVICE_NOT_FOUND;
> +       /*
> +        * X-Gene v1 PCIe controller has a bug in Configuration Request
> +        * Retry Status (CRS) logic:
> +        *  When CPU tries to read Vendor ID and Device ID of not-existed
> +        *  remote device, the controller returns 0xFFFF0001 instead of
> +        *  0xFFFFFFFF; this will add significant delay in boot time as
> +        *  pci_bus_read_dev_vendor_id will wait for 60 seconds before
> +        *  giving up.
> +        * So for X-Gene v1 PCIe controllers, disable CRS capability
> +        * advertisement by clearing CRS Software Visibility bit before
> +        * returning the Root Capability value to the callers.
> +        */
> +       if (pci_is_root_bus(bus) && (port->version == XGENE_PCIE_IP_VER_1) &&
> +           ((where & ~0x3) == ROOT_CAP_AND_CTRL))
> +               *val &= ~(PCI_EXP_RTCAP_CRSVIS << 16);
> +
> +       if (size <= 2)
> +               *val = (*val >> (8 * (where & 3))) & ((1 << (size * 8)) - 1);
> +
> +       return PCIBIOS_SUCCESSFUL;
> +}
> +
>  static struct pci_ops xgene_pcie_ops = {
>         .map_bus = xgene_pcie_map_bus,
> -       .read = pci_generic_config_read32,
> +       .read = xgene_pcie_config_read32,
>         .write = pci_generic_config_write32,
>  };
>
> @@ -500,6 +537,10 @@ static int xgene_pcie_probe_bridge(struct platform_device *pdev)
>         port->node = of_node_get(pdev->dev.of_node);
>         port->dev = &pdev->dev;
>
> +       port->version = XGENE_PCIE_IP_VER_UNKN;
> +       if (of_device_is_compatible(port->node, "apm,xgene-pcie"))
> +               port->version = XGENE_PCIE_IP_VER_1;
> +
>         ret = xgene_pcie_map_reg(port, pdev);
>         if (ret)
>                 return ret;
> --
> 1.9.1
>
