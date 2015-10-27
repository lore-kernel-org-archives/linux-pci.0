Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 27 Oct 2015 17:32:57 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Zhou Wang <wangzhou1@hisilicon.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, jingoohan1@gmail.com,
	pratyush.anand@gmail.com, Arnd Bergmann <arnd@arndb.de>,
	linux@arm.linux.org.uk, thomas.petazzoni@free-electrons.com,
	gabriele.paoloni@huawei.com, lorenzo.pieralisi@arm.com,
	james.morse@arm.com, Liviu.Dudau@arm.com, jason@lakedaemon.net,
	robh@kernel.org, gabriel.fernandez@linaro.org,
	Minghuan.Lian@freescale.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, zhangjukuo@huawei.com,
	qiuzhenfa@hisilicon.com, liudongdong3@huawei.com,
	qiujiang@huawei.com, xuwei5@hisilicon.com, liguozhu@hisilicon.com
Subject: Re: [PATCH v12 0/8] PCI: hisi: Add PCIe host support for HiSilicon
 SoC Hip05
Message-ID: <20151027223257.GA3786@localhost>
References: <1445859350-26375-1-git-send-email-wangzhou1@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1445859350-26375-1-git-send-email-wangzhou1@hisilicon.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Zhou,

On Mon, Oct 26, 2015 at 07:35:42PM +0800, Zhou Wang wrote:
> This patchset adds PCIe host support for HiSilicon SoC Hip05. The PCIe hosts
> use PCIe IP core from Synopsys, So this driver is based on designware PCIe driver.
> 
> Hip05 is an ARMv8 architecture SoC. It should be able to use ARM64 PCIe API in
> designware PCIe driver. So this patch also adds ARM64 support for designware
> pcie.
> 
> This patchset is based on v4.3-rc1.

OK, this is pretty close to being ready to go.  But the patch ordering is
more complicated than it needs to be.  You have:

  PCI: designware: move calculation of bus addresses to DRA7xx
  ARM/PCI: remove align_resource in pci_sys_data
  PCI: designware: Replace DT PCI ranges parse with of_pci_get_host_bridge_resources
  PCI: designware: Add ARM64 support
  PCI: designware: Remove *_mod_base
  PCI: hisi: Add PCIe host support for HiSilicon SoC Hip05
  Documentation: DT: Add HiSilicon PCIe host binding
  MAINTAINERS: Add pcie-hisi maintainer

But you should have this:

  PCI: designware: Move calculation of bus addresses to DRA7xx
  PCI: designware: Remove *_mod_base
  PCI: designware: Replace DT PCI ranges parse with of_pci_get_host_bridge_resources
  ARM/PCI: remove align_resource in pci_sys_data
  PCI: designware: Add ARM64 support
  PCI: hisi: Add HiSilicon SoC Hip05 driver

In other words,

  - capitalize the subject lines correctly (follow previous practice),
  - do all the bus address patches together,
  - then the ARM sysdata tweak,
  - then add ARM64 support,
  - then add HiSilicon,
  - and merge the hisi driver, DT update, and maintainer update into one
    patch since they're all one package.

If you do them out of order, the changes get tangled up and it makes them
harder to backport and harder to revert individually.

Bjorn

> Change from v11:
> - Split 3/6 in v11 to 3/8, 4/8, 5/8 in v12.
> - Add print in pcie-hisi.c to indicate read/write hardware defect.
> - Modify macro in 1/8 pointed by Bjorn.
> 
> Change from v10:
> - Remove MSI related setting and VMID/ASID table setting, they will be
>   implemented in BIOS.
> - Use module_platform_driver to init pcie-hisi.c
> - Add necessary comments.
> 
> Change from v9:
> - Use syscon to get subctrl base address.
> - 5/6 is based on [PATCH v3 0/2] arm64: Support Hisilicon Hip05-D02 board
>   from Ding Tianhong
> - Add hisi_pcie_cfg_read in pcie-hisi.c to match
>   [PATCH v6 0/3] PCI: designware: change dw_pcie_cfg_write() and dw_pcie_cfg_read()
>   from Gabriele.
> 
> Change from v8:
> - Rebase on v4.3-rc1.
> - Add Tested-by from Gabriel and Minghuan.
> - Remove ITS domain parsing in msi_host_init in pcie-hisi.c, no need this as PCI
>   core does related job. Add ITS base address parsing in msi_host_init.
> - Change vmid/asid table configuration, previous configuration was wrong.
> - Add wr_own_conf callback in pcie-hisi.c.
> - Use subsys_initcall to init hisi PCIe.
> 
> Change from v7:
> - Remove pp->root_bus_nr = 0 in dra7xx, exynos, imx6, keystone, layerscape,
>   spear13xx. Pass pp->busn->start to pci_create_root_bus as root bus number.
> - Remove bus-range parsing in pcie-hisi.c.
> 
> Change from v6:
> - Add Pratyush's Acked-by for 1/6 and 2/6.
> - Add James' Tested-by for 3/6.
> 
> Change from v5:
> - Merge 1/6 in this series, discussion about this can be found in [1]
> 
> Change from v4:
> - Change the author of 1/5 to Gabriele.
> - Modify problems in 3/5 pointed by Bjorn.
> - Modify spelling problems in 4/5.
> 
> Change from v3:
> - Change 1/5 to what Gabriele suggested.
> - Use win->__res.start to get *_mod_base in 2/5, this fix a bug in v3 series.
> 
> Change from v2:
> - Move struct pci_dev *dev and struct pci_sys_data *sys in
>   pcibios_align_resource in 1/5.
> - Add Gabriele's codes in 2/5 which delete unnecessary information parse and
>   use of_pci_get_host_bridge_resources for both ARM32 and ARM64.
> - Add maintainer patch 5/5.
> 
> Change from RFC v1:
> - Add 1/4 patch by Arnd which removes align_resource callback in ARM
>   pcibios_align_resource.
> - Change head file in pcie-designware from asm/hardirq.h to linux/hardirq.h.
> - Set pp->root_bus_nr = 0 in dra7xx, exynos, imx6, keystone, layerscape,
>   spear13xx.
> - Remove unnecessary parentheses of some macros in pcie-hisi.
> - Use macro to replace some magic values.
> - Merge two loops together and add some comments about it in context_config
>   function in pcie-hisi.
> - Modify some value of items in pcie node example in binding document. 
> 
> Change from RFC:
> - delete dw_pcie_setup, dw_pcie_scan_bus, dw_pcie_map_irq and struct hw_pci,
>   merge related operations into dw_pcie_host_init.
> 
> Link of v11:
> - https://lkml.org/lkml/2015/10/16/228
> Link of v10:
> - http://www.spinics.net/lists/linux-pci/msg45490.html
> Link of v9:
> - http://www.spinics.net/lists/linux-pci/msg44545.html
> Link of v8:
> - http://www.spinics.net/lists/linux-pci/msg44192.html
> Link of v7:
> - http://www.spinics.net/lists/devicetree/msg90690.html
> Link of v6:
> - http://www.spinics.net/lists/linux-pci/msg43669.html
> Link of v5:
> - http://www.spinics.net/lists/devicetree/msg87959.html
> Link of v4:
> - http://www.spinics.net/lists/arm-kernel/msg433050.html
> Link of v3:
> - http://www.spinics.net/lists/linux-pci/msg42539.html
> Link of v2:
> - http://www.spinics.net/lists/linux-pci/msg41844.html
> Link of RFC v1:
> - http://www.spinics.net/lists/linux-pci/msg41305.html
> Link of RFC:
> - http://www.spinics.net/lists/linux-pci/msg40434.html
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/359741.html
> 
> Zhou Wang (6):
>   PCI: designware: Replace DT PCI ranges parse with of_pci_get_host_bridge_resources
>   PCI: designware: Add ARM64 support
>   PCI: designware: Remove *_mod_base
>   PCI: hisi: Add PCIe host support for HiSilicon SoC Hip05
>   Documentation: DT: Add HiSilicon PCIe host binding
>   MAINTAINERS: Add pcie-hisi maintainer
> 
> gabriele paoloni (2):
>   PCI: designware: move calculation of bus addresses to DRA7xx
>   ARM/PCI: remove align_resource in pci_sys_data
> 
>  .../bindings/arm/hisilicon/hisilicon.txt           |  17 ++
>  .../devicetree/bindings/pci/hisilicon-pcie.txt     |  44 ++++
>  MAINTAINERS                                        |   7 +
>  arch/arm/include/asm/mach/pci.h                    |   6 -
>  arch/arm/kernel/bios32.c                           |  12 +-
>  drivers/pci/host/Kconfig                           |   8 +
>  drivers/pci/host/Makefile                          |   1 +
>  drivers/pci/host/pci-dra7xx.c                      |   7 +
>  drivers/pci/host/pci-keystone-dw.c                 |   2 +-
>  drivers/pci/host/pcie-designware.c                 | 248 +++++++--------------
>  drivers/pci/host/pcie-designware.h                 |  14 +-
>  drivers/pci/host/pcie-hisi.c                       | 198 ++++++++++++++++
>  12 files changed, 377 insertions(+), 187 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
>  create mode 100644 drivers/pci/host/pcie-hisi.c
> 
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
