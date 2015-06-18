Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20150618175553.GF7710@google.com>
References: <CAErSpo5Oc_8ca4h7xYSkGPFE1vxWg1sy1rJRc0B=u9LrdOLY7g@mail.gmail.com>
 <017c1ec8e3f43f86a947eaddb30c9389e0b1053b.1434154377.git.dhdang@apm.com> <20150618175553.GF7710@google.com>
From: Duc Dang <dhdang@apm.com>
Date: Thu, 18 Jun 2015 11:11:39 -0700
Message-ID: <CADaLNDmPGo-xkrtx4YsyMn3+ba1hBPQ1i3fr4CmoKb_0Yk2=eg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] PCI: X-Gene: Disable Configuration Request Retry
 Status for X-Gene v1 PCIe
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	linux-kernel@vger.kernel.org,
	Ian Campbell <ian.campbell@citrix.com>,
	Marcin Juszkiewicz <mjuszkiewicz@redhat.com>,
	Tanmay Inamdar <tinamdar@apm.com>, patches@apm.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 18, 2015 at 10:55 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Fri, Jun 12, 2015 at 05:35:57PM -0700, Duc Dang wrote:
>> X-Gene v1 PCIe controller has a bug in Configuration Request Retry
>> Status (CRS) logic:
>>   When CPU tries to read Vendor ID and Device ID of not-existed
>>   remote device, the controller returns 0xFFFF0001 instead of
>>   0xFFFFFFFF; this will add significant delay in boot time as
>>   pci_bus_read_dev_vendor_id will wait for 60 seconds before
>>   giving up.
>>
>> So for X-Gene v1 PCIe controllers, disable CRS capability
>> advertisement by clearing CRS Software Visibility bit before
>> returning the Root Capability value to the callers. This is done
>> by implementing X-Gene PCIe specific xgene_pcie_config_read32 for
>> CFG read accesses to replace the generic default pci_generic_config_read32
>> function.
>>
>> v2 changes:
>>         Use pci_generic_config_read32 to implement xgene_pcie_config_read32
>>
>> Signed-off-by: Duc Dang <dhdang@apm.com>
>> Tested-by: Ian Campbell <ian.campbell@citrix.com>
>> Tested-by: Marcin Juszkiewicz <mjuszkiewicz@redhat.com>
>
> I'd like to merge this (as amended below) for v4.2.  But I'm looking for an
> ack from Tanmay, and I'm still waiting for the second patch to remove the
> link_up test.

I will send you the second patch to remove the link_up test shortly.

>
> Bjorn
>
>
> commit 49ac8c566d7a37f9f295e1fd4fbdd96517f22d55
> Author: Duc Dang <dhdang@apm.com>
> Date:   Fri Jun 12 17:35:57 2015 -0700
>
>     PCI: xgene: Disable Configuration Request Retry Status for v1 silicon
>
>     When a CPU reads the Vendor and Device ID of a non-existent device, the
>     controller should fabricate return data of 0xFFFFFFFF.  Configuration
>     Request Retry Status (CRS) is not applicable in this case because the
>     device doesn't exist at all.
>
>     The X-Gene v1 PCIe controller has a bug in the CRS logic such that when CRS
>     is enabled, it fabricates return data of 0xFFFF0001 for this case, which
>     means "the device exists but is not ready."  That causes the PCI core to
>     retry the read until it times out after 60 seconds.
>
>     Disable CRS capability advertisement by clearing the CRS Software
>     Visibility bit in the Root Capabilities Register.
>
>     [bhelgaas: changelog and comment]
>     Tested-by: Ian Campbell <ian.campbell@citrix.com>
>     Tested-by: Marcin Juszkiewicz <mjuszkiewicz@redhat.com>
>     Signed-off-by: Duc Dang <dhdang@apm.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>
> diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
> index 3e5a636..70af714 100644
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
> @@ -140,9 +147,37 @@ static void __iomem *xgene_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
>         return xgene_pcie_get_cfg_base(bus) + offset;
>  }
>
> +static int xgene_pcie_config_read32(struct pci_bus *bus, unsigned int devfn,
> +                                   int where, int size, u32 *val)
> +{
> +       struct xgene_pcie_port *port = bus->sysdata;
> +
> +       if (pci_generic_config_read32(bus, devfn, where & ~0x3, 4, val) !=
> +           PCIBIOS_SUCCESSFUL)
> +               return PCIBIOS_DEVICE_NOT_FOUND;
> +
> +       /*
> +        * The v1 controller has a bug in its Configuration Request
> +        * Retry Status (CRS) logic: when CRS is enabled and we read the
> +        * Vendor and Device ID of a non-existent device, the controller
> +        * fabricates return data of 0xFFFF0001 ("device exists but is not
> +        * ready") instead of 0xFFFFFFFF ("device does not exist").  This
> +        * causes the PCI core to retry the read until it times out.
> +        * Avoid this by not claiming to support CRS.
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
> @@ -500,6 +535,10 @@ static int xgene_pcie_probe_bridge(struct platform_device *pdev)
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



-- 
Regards,
Duc Dang.
