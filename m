Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 9 Jun 2018 18:03:45 +0800
From: kbuild test robot <lkp@intel.com>
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: kbuild-all@01.org, bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        adouglas@cadence.com, jesper.nilsson@axis.com,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: Re: [PATCH v3 03/10] PCI: Update xxx_pcie_ep_raise_irq() and
 pci_epc_raise_irq() signatures
Message-ID: <201806091725.uRBp8LOU%fengguang.wu@intel.com>
References: <b4eba65e4ae7b8d15a5770a31d6a339de518cea7.1527862777.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b4eba65e4ae7b8d15a5770a31d6a339de518cea7.1527862777.git.gustavo.pimentel@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Gustavo,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on pci/next]
[also build test WARNING on next-20180608]
[cannot apply to v4.17]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Gustavo-Pimentel/Add-MSI-X-support-on-pcitest-tool/20180609-143316
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   drivers/pci/host/pcie-rockchip-ep.c:173:14: sparse: expression using sizeof(void)
>> drivers/pci/host/pcie-rockchip-ep.c:516:27: sparse: incorrect type in initializer (incompatible argument 4 (different type sizes)) @@    expected int ( *raise_irq )( ... ) @@    got int ( *raise_irq )( ... ) @@
   drivers/pci/host/pcie-rockchip-ep.c:516:27:    expected int ( *raise_irq )( ... )
   drivers/pci/host/pcie-rockchip-ep.c:516:27:    got int ( *<noident> )( ... )
   drivers/pci/host/pcie-rockchip-ep.c:516:15: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     .raise_irq = rockchip_pcie_ep_raise_irq,
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/host/pcie-rockchip-ep.c:516:15: note: (near initialization for 'rockchip_pcie_epc_ops.raise_irq')
   cc1: some warnings being treated as errors

vim +516 drivers/pci/host/pcie-rockchip-ep.c

cf590b07 Shawn Lin 2018-05-09  507  
cf590b07 Shawn Lin 2018-05-09  508  static const struct pci_epc_ops rockchip_pcie_epc_ops = {
cf590b07 Shawn Lin 2018-05-09  509  	.write_header	= rockchip_pcie_ep_write_header,
cf590b07 Shawn Lin 2018-05-09  510  	.set_bar	= rockchip_pcie_ep_set_bar,
cf590b07 Shawn Lin 2018-05-09  511  	.clear_bar	= rockchip_pcie_ep_clear_bar,
cf590b07 Shawn Lin 2018-05-09  512  	.map_addr	= rockchip_pcie_ep_map_addr,
cf590b07 Shawn Lin 2018-05-09  513  	.unmap_addr	= rockchip_pcie_ep_unmap_addr,
cf590b07 Shawn Lin 2018-05-09  514  	.set_msi	= rockchip_pcie_ep_set_msi,
cf590b07 Shawn Lin 2018-05-09  515  	.get_msi	= rockchip_pcie_ep_get_msi,
cf590b07 Shawn Lin 2018-05-09 @516  	.raise_irq	= rockchip_pcie_ep_raise_irq,
cf590b07 Shawn Lin 2018-05-09  517  	.start		= rockchip_pcie_ep_start,
cf590b07 Shawn Lin 2018-05-09  518  };
cf590b07 Shawn Lin 2018-05-09  519  

:::::: The code at line 516 was first introduced by commit
:::::: cf590b07839133146842d2d3d9a68f804c2edc4b PCI: rockchip: Add EP driver for Rockchip PCIe controller

:::::: TO: Shawn Lin <shawn.lin@rock-chips.com>
:::::: CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
