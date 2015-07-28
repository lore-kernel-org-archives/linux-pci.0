Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1438036941-27210-2-git-send-email-rjui@broadcom.com>
References: <1438036941-27210-1-git-send-email-rjui@broadcom.com>
	<1438036941-27210-2-git-send-email-rjui@broadcom.com>
Date: Tue, 28 Jul 2015 15:24:00 +0200
Message-ID: <CAOesGMh2Dz2HWpAg0Yh71QYfnAyMRae929p=mqGmopGdrVWgxQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] PCI: iproc: enable arm64 support for iProc PCIe
From: Olof Johansson <olof@lixom.net>
To: Ray Jui <rjui@broadcom.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Mark Rutland <mark.rutland@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Broadcom Kernel Feedback List
	<bcm-kernel-feedback-list@broadcom.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"arm@kernel.org" <arm@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Ray,

I get the following when building an allmodconfig on arm64:

drivers/pci/host/pcie-iproc-bcma.c: In function 'iproc_pcie_bcma_map_irq':
drivers/pci/host/pcie-iproc-bcma.c:37:31: error: dereferencing pointer
to incomplete type
  struct iproc_pcie *pcie = sys->private_data;
                               ^

Should be easy for you to reproduce, please send incremental fix.


-Olof


On Tue, Jul 28, 2015 at 12:42 AM, Ray Jui <rjui@broadcom.com> wrote:
> PCI: iproc: Add arm64 support
>
> Add arm64 support to the iProc PCIe driver.
>
> Note that on arm32, bus->sysdata points to the arm32-specific
> pci_sys_data struct, and pci_sys_data.private_data contains the
> iproc_pcie pointer. For arm64, there's nothing corresponding to
> pci_sys_data, so we keep the iproc_pcie pointer directly in
> bus->sysdata.
>
> In addition, arm64 does IRQ mapping in pcibios_add_device(), so it
> doesn't need pci_fixup_irqs() as arm32 does.
>
> Signed-off-by: Ray Jui <rjui@broadcom.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Scott Branden <sbranden@broadcom.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/host/pcie-iproc.c |   27 ++++++++++++++++++++-------
>  drivers/pci/host/pcie-iproc.h |    4 +++-
>  2 files changed, 23 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
> index d77481e..ba087b5 100644
> --- a/drivers/pci/host/pcie-iproc.c
> +++ b/drivers/pci/host/pcie-iproc.c
> @@ -58,9 +58,17 @@
>  #define SYS_RC_INTX_EN               0x330
>  #define SYS_RC_INTX_MASK             0xf
>
> -static inline struct iproc_pcie *sys_to_pcie(struct pci_sys_data *sys)
> +static inline struct iproc_pcie *iproc_data(struct pci_bus *bus)
>  {
> -       return sys->private_data;
> +       struct iproc_pcie *pcie;
> +#ifdef CONFIG_ARM
> +       struct pci_sys_data *sys = bus->sysdata;
> +
> +       pcie = sys->private_data;
> +#else
> +       pcie = bus->sysdata;
> +#endif
> +       return pcie;
>  }
>
>  /**
> @@ -71,8 +79,7 @@ static void __iomem *iproc_pcie_map_cfg_bus(struct pci_bus *bus,
>                                             unsigned int devfn,
>                                             int where)
>  {
> -       struct pci_sys_data *sys = bus->sysdata;
> -       struct iproc_pcie *pcie = sys_to_pcie(sys);
> +       struct iproc_pcie *pcie = iproc_data(bus);
>         unsigned slot = PCI_SLOT(devfn);
>         unsigned fn = PCI_FUNC(devfn);
>         unsigned busno = bus->number;
> @@ -186,6 +193,7 @@ static void iproc_pcie_enable(struct iproc_pcie *pcie)
>  int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
>  {
>         int ret;
> +       void *sysdata;
>         struct pci_bus *bus;
>
>         if (!pcie || !pcie->dev || !pcie->base)
> @@ -208,10 +216,13 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
>
>         iproc_pcie_reset(pcie);
>
> +#ifdef CONFIG_ARM
>         pcie->sysdata.private_data = pcie;
> -
> -       bus = pci_create_root_bus(pcie->dev, 0, &iproc_pcie_ops,
> -                                 &pcie->sysdata, res);
> +       sysdata = &pcie->sysdata;
> +#else
> +       sysdata = pcie;
> +#endif
> +       bus = pci_create_root_bus(pcie->dev, 0, &iproc_pcie_ops, sysdata, res);
>         if (!bus) {
>                 dev_err(pcie->dev, "unable to create PCI root bus\n");
>                 ret = -ENOMEM;
> @@ -229,7 +240,9 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
>
>         pci_scan_child_bus(bus);
>         pci_assign_unassigned_bus_resources(bus);
> +#ifdef CONFIG_ARM
>         pci_fixup_irqs(pci_common_swizzle, pcie->map_irq);
> +#endif
>         pci_bus_add_devices(bus);
>
>         return 0;
> diff --git a/drivers/pci/host/pcie-iproc.h b/drivers/pci/host/pcie-iproc.h
> index ba0a108..c9e4c10 100644
> --- a/drivers/pci/host/pcie-iproc.h
> +++ b/drivers/pci/host/pcie-iproc.h
> @@ -21,7 +21,7 @@
>   * @dev: pointer to device data structure
>   * @base: PCIe host controller I/O register base
>   * @resources: linked list of all PCI resources
> - * @sysdata: Per PCI controller data
> + * @sysdata: Per PCI controller data (ARM-specific)
>   * @root_bus: pointer to root bus
>   * @phy: optional PHY device that controls the Serdes
>   * @irqs: interrupt IDs
> @@ -29,7 +29,9 @@
>  struct iproc_pcie {
>         struct device *dev;
>         void __iomem *base;
> +#ifdef CONFIG_ARM
>         struct pci_sys_data sysdata;
> +#endif
>         struct pci_bus *root_bus;
>         struct phy *phy;
>         int irqs[IPROC_PCIE_MAX_NUM_IRQS];
> --
> 1.7.9.5
>
