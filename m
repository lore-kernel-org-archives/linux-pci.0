Return-Path: <SRS0=ZTcB=3B=chromium.org=briannorris@kernel.org>
Return-Path: <SRS0=ZTcB=3B=chromium.org=briannorris@kernel.org>
Date: Fri, 24 Mar 2017 10:22:19 -0700
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Jeffy Chen <jeffy.chen@rock-chips.com>,
	Wenrui Li <wenrui.li@rock-chips.com>, linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org, Ray Jui <rjui@broadcom.com>
Subject: Re: [PATCH v2 3/5] PCI: rockchip: add remove() support
Message-ID: <20170324172218.GA119093@google.com>
References: <20170310024617.67303-1-briannorris@chromium.org>
 <20170310024617.67303-3-briannorris@chromium.org>
 <20170324142541.GA25380@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170324142541.GA25380@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Fri, Mar 24, 2017 at 09:25:41AM -0500, Bjorn Helgaas wrote:
> On Thu, Mar 09, 2017 at 06:46:15PM -0800, Brian Norris wrote:
> > Currently, if we try to unbind the platform device, the remove will
> > succeed, but the removal won't undo most of the registration, leaving
> > partially-configured PCI devices in the system.
> > 
> > This allows, for example, a simple 'lspci' to crash the system, as it
> > will try to touch the freed (via devm_*) driver structures.
> > 
> > So let's implement device remove().
> 
> How exactly do you reproduce this problem?

On RK3399:

  # echo f8000000.pcie > /sys/bus/platform/drivers/rockchip-pcie/unbind
  # lspci

> There are several other drivers that are superficially similar, e.g.,
> they define a struct platform_driver without a .remove method.  Do
> they all have this problem?  Some of them do set .suppress_bind_attrs
> = true; is that relevant to this scenario?

Yes, I think .suppress_bind_attrs would be enough to prevent this,
according to my reading of the code and comments:

 * @suppress_bind_attrs: Disables bind/unbind via sysfs.

> In fact, the only other callers of pci_remove_root_bus() are
> iproc_pcie_remove(), hv_pci_remove(), and vmd_remove().

Then iProc would suffer from the same memory leak in
of_pci_get_host_bridge_resources() [1]. It *would* suffer from the same
domain allocation issues in of_pci_bus_find_domain_nr() ->
pci_get_new_domain_nr() [2], except that all iProc device trees (in
mainline at least) use the 'linux,pci-domain' property to avoid it.

HyperV and VMD drivers use ACPI, which uses neither
pci_get_new_domain_nr() nor of_pci_get_host_bridge_resources().

> These don't have .remove:
> 
>   imx6_pcie_driver
>   ls_pcie_driver
>   armada8k_pcie_driver
>   artpec6_pcie_driver
>   dw_plat_pcie_driver
>   hisi_pcie_driver
>   hisi_pcie_almost_ecam_driver
>   spear13xx_pcie_driver
>   gen_pci_driver

I think these are all technically broken.

> These don't have .remove but do set .suppress_bind_attrs = true:
> 
>   dra7xx_pcie_driver
>   qcom_pcie_driver
>   advk_pcie_driver
>   mvebu_pcie_driver
>   rcar_pci_driver
>   rcar_pcie_driver
>   tegra_pcie_driver
>   altera_pcie_driver
>   nwl_pcie_driver
>   xilinx_pcie_driver

Those are fine then, I suppose.

Brian

[1] PCI: return resource_entry in pci_add_resource helpers
    https://patchwork.kernel.org/patch/9642229/
    of/pci: Fix memory leak in of_pci_get_host_bridge_resources
    https://patchwork.kernel.org/patch/9642231/

[2] PCI: use IDA to manage domain number if not getting it from DT
    https://patchwork.kernel.org/patch/9638353/
