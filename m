Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lhrrgout.huawei.com ([194.213.3.17]:2074 "EHLO
	lhrrgout.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213AbcDPLF4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 16 Apr 2016 07:05:56 -0400
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: kbuild test robot <lkp@intel.com>
CC: "kbuild-all@01.org" <kbuild-all@01.org>,
	"pratyush.anand@gmail.com" <pratyush.anand@gmail.com>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	Linuxarm <linuxarm@huawei.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"helgaas@kernel.org" <helgaas@kernel.org>
Subject: RE: [PATCH] PCI: Designware: remove wrong RC memory base/limit
 configuration
Date: Sat, 16 Apr 2016 11:05:25 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1ED55444@lhreml503-mbs>
References: <1460737283-117495-1-git-send-email-gabriele.paoloni@huawei.com>
 <201604160047.8h0rkLwN%fengguang.wu@intel.com>
In-Reply-To: <201604160047.8h0rkLwN%fengguang.wu@intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: kbuild test robot [mailto:lkp@intel.com]
> Sent: 15 April 2016 17:24
> To: Gabriele Paoloni
> Cc: kbuild-all@01.org; pratyush.anand@gmail.com; jingoohan1@gmail.com;
> Gabriele Paoloni; Linuxarm; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; helgaas@kernel.org
> Subject: Re: [PATCH] PCI: Designware: remove wrong RC memory base/limit
> configuration
> 
> Hi gabriele,
> 
> [auto build test WARNING on pci/next]
> [also build test WARNING on v4.6-rc3 next-20160415]
> [if your patch is applied to the wrong git tree, please drop us a note
> to help improving the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Gabriele-Paoloni/PCI-
> Designware-remove-wrong-RC-memory-base-limit-configuration/20160416-
> 000746
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
> next
> config: x86_64-randconfig-x011-201615 (attached as .config)
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/pci/host/pcie-designware.c: In function 'dw_pcie_setup_rc':
> >> drivers/pci/host/pcie-designware.c:732:6: warning: unused variable
> 'memlimit' [-Wunused-variable]
>      u32 memlimit;
>          ^
> >> drivers/pci/host/pcie-designware.c:731:6: warning: unused variable
> 'membase' [-Wunused-variable]
>      u32 membase;
>          ^

Just sent v2 to fix this

Gab

> 
> vim +/memlimit +732 drivers/pci/host/pcie-designware.c
> 
> 4b1ced84 Jingoo Han    2013-07-31  725  	.write = dw_pcie_wr_conf,
> 340cba60 Jingoo Han    2013-06-21  726  };
> 340cba60 Jingoo Han    2013-06-21  727
> 4b1ced84 Jingoo Han    2013-07-31  728  void dw_pcie_setup_rc(struct
> pcie_port *pp)
> 340cba60 Jingoo Han    2013-06-21  729  {
> 340cba60 Jingoo Han    2013-06-21  730  	u32 val;
> 340cba60 Jingoo Han    2013-06-21 @731  	u32 membase;
> 340cba60 Jingoo Han    2013-06-21 @732  	u32 memlimit;
> 340cba60 Jingoo Han    2013-06-21  733
> 66c5c34b Mohit Kumar   2014-04-14  734  	/* set the number of lanes */
> f7b7868c Seungwon Jeon 2013-08-28  735  	dw_pcie_readl_rc(pp,
> PCIE_PORT_LINK_CONTROL, &val);
> 
> :::::: The code at line 732 was first introduced by commit
> :::::: 340cba6092c2c1688629d327b74e7eb746a571a7 pci: Add PCIe driver
> for Samsung Exynos
> 
> :::::: TO: Jingoo Han <jg1.han@samsung.com>
> :::::: CC: Arnd Bergmann <arnd@arndb.de>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology
> Center
> https://lists.01.org/pipermail/kbuild-all                   Intel
> Corporation
