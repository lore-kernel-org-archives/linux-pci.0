Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v4 03/10] PCI: Update xxx_pcie_ep_raise_irq() and
 pci_epc_raise_irq() signatures
To: kbuild test robot <lkp@intel.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC: "kbuild-all@01.org" <kbuild-all@01.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "adouglas@cadence.com" <adouglas@cadence.com>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <5bfa0cf053878e0e859a8b97227ca03ea4d50e92.1529329262.git.gustavo.pimentel@synopsys.com>
 <201806190312.UKq0zYJ1%fengguang.wu@intel.com>
From: Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Message-ID: <e35c08f4-27ac-4979-91b1-2bf26e1e3298@synopsys.com>
Date: Wed, 20 Jun 2018 10:11:19 +0100
MIME-Version: 1.0
In-Reply-To: <201806190312.UKq0zYJ1%fengguang.wu@intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

Thanks for the suggestion.

Regards,
Gustavo

On 18/06/2018 20:31, kbuild test robot wrote:
> Hi Gustavo,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on pci/next]
> [also build test WARNING on v4.18-rc1 next-20180618]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_0day-2Dci_linux_commits_Gustavo-2DPimentel_Add-2DMSI-2DX-2Dsupport-2Don-2Dpcitest-2Dtool_20180619-2D004625&d=DwIBAg&c=DPL6_X_6JkXFx7AXWqB0tg&r=bkWxpLoW-f-E3EdiDCCa0_h0PicsViasSlvIpzZvPxs&m=IFx9JKJsE2KvE7siiXs4GRW2a3OkFpE8BFO41SbTjJA&s=vuOhITY-_4Y-jxzyQ1ddb6M8E9-OELpKXzcJZqgWqvE&e=
> base:   https://urldefense.proofpoint.com/v2/url?u=https-3A__git.kernel.org_pub_scm_linux_kernel_git_helgaas_pci.git&d=DwIBAg&c=DPL6_X_6JkXFx7AXWqB0tg&r=bkWxpLoW-f-E3EdiDCCa0_h0PicsViasSlvIpzZvPxs&m=IFx9JKJsE2KvE7siiXs4GRW2a3OkFpE8BFO41SbTjJA&s=7xs_oUDvo5HRxpqsZAqdybMJcJDO6K3hooyy-CmXwkM&e= next
> reproduce:
>         # apt-get install sparse
>         make ARCH=x86_64 allmodconfig
>         make C=1 CF=-D__CHECK_ENDIAN__
> 
> 
> sparse warnings: (new ones prefixed by >>)
> 
>    drivers/pci/controller/pcie-rockchip-ep.c:173:14: sparse: expression using sizeof(void)
>>> drivers/pci/controller/pcie-rockchip-ep.c:516:27: sparse: incorrect type in initializer (incompatible argument 4 (different type sizes)) @@    expected int ( *raise_irq )( ... ) @@    got int ( *raise_irq )( ... ) @@
>    drivers/pci/controller/pcie-rockchip-ep.c:516:27:    expected int ( *raise_irq )( ... )
>    drivers/pci/controller/pcie-rockchip-ep.c:516:27:    got int ( *<noident> )( ... )
>    drivers/pci/controller/pcie-rockchip-ep.c:516:15: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
>      .raise_irq = rockchip_pcie_ep_raise_irq,
>                   ^~~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/pci/controller/pcie-rockchip-ep.c:516:15: note: (near initialization for 'rockchip_pcie_epc_ops.raise_irq')
>    cc1: some warnings being treated as errors
> 
> vim +516 drivers/pci/controller/pcie-rockchip-ep.c
> 
> cf590b07 drivers/pci/host/pcie-rockchip-ep.c Shawn Lin 2018-05-09  507  
> cf590b07 drivers/pci/host/pcie-rockchip-ep.c Shawn Lin 2018-05-09  508  static const struct pci_epc_ops rockchip_pcie_epc_ops = {
> cf590b07 drivers/pci/host/pcie-rockchip-ep.c Shawn Lin 2018-05-09  509  	.write_header	= rockchip_pcie_ep_write_header,
> cf590b07 drivers/pci/host/pcie-rockchip-ep.c Shawn Lin 2018-05-09  510  	.set_bar	= rockchip_pcie_ep_set_bar,
> cf590b07 drivers/pci/host/pcie-rockchip-ep.c Shawn Lin 2018-05-09  511  	.clear_bar	= rockchip_pcie_ep_clear_bar,
> cf590b07 drivers/pci/host/pcie-rockchip-ep.c Shawn Lin 2018-05-09  512  	.map_addr	= rockchip_pcie_ep_map_addr,
> cf590b07 drivers/pci/host/pcie-rockchip-ep.c Shawn Lin 2018-05-09  513  	.unmap_addr	= rockchip_pcie_ep_unmap_addr,
> cf590b07 drivers/pci/host/pcie-rockchip-ep.c Shawn Lin 2018-05-09  514  	.set_msi	= rockchip_pcie_ep_set_msi,
> cf590b07 drivers/pci/host/pcie-rockchip-ep.c Shawn Lin 2018-05-09  515  	.get_msi	= rockchip_pcie_ep_get_msi,
> cf590b07 drivers/pci/host/pcie-rockchip-ep.c Shawn Lin 2018-05-09 @516  	.raise_irq	= rockchip_pcie_ep_raise_irq,
> cf590b07 drivers/pci/host/pcie-rockchip-ep.c Shawn Lin 2018-05-09  517  	.start		= rockchip_pcie_ep_start,
> cf590b07 drivers/pci/host/pcie-rockchip-ep.c Shawn Lin 2018-05-09  518  };
> cf590b07 drivers/pci/host/pcie-rockchip-ep.c Shawn Lin 2018-05-09  519  
> 
> :::::: The code at line 516 was first introduced by commit
> :::::: cf590b07839133146842d2d3d9a68f804c2edc4b PCI: rockchip: Add EP driver for Rockchip PCIe controller
> 
> :::::: TO: Shawn Lin <shawn.lin@rock-chips.com>
> :::::: CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.01.org_pipermail_kbuild-2Dall&d=DwIBAg&c=DPL6_X_6JkXFx7AXWqB0tg&r=bkWxpLoW-f-E3EdiDCCa0_h0PicsViasSlvIpzZvPxs&m=IFx9JKJsE2KvE7siiXs4GRW2a3OkFpE8BFO41SbTjJA&s=Mf1d7cz8MbsSZPkgXFwnxZJY1579nwc7-mpjeQBdweY&e=                   Intel Corporation
> 
