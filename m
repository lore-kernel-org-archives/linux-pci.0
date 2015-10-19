Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 19 Oct 2015 17:29:33 +0800
From: kbuild test robot <lkp@intel.com>
To: Ley Foon Tan <lftan@altera.com>
Cc: kbuild-all@01.org, Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Dinh Nguyen <dinguyen@opensource.altera.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ley Foon Tan <lftan@altera.com>,
	lftan.linux@gmail.com, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v10 3/6] pci:host: Add Altera PCIe host controller driver
Message-ID: <201510191737.ufAp63BH%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1445242768-4423-4-git-send-email-lftan@altera.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Ley,

[auto build test WARNING on pci/next -- if it's inappropriate base, please suggest rules for selecting the more suitable base]

url:    https://github.com/0day-ci/linux/commits/Ley-Foon-Tan/arm-add-msi-h-to-Kbuild/20151019-162417
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/pci/host/pcie-altera.c:117:6: sparse: symbol 'altera_pcie_fixups' was not declared. Should it be static?
   drivers/pci/host/pcie-altera.c:496:53: sparse: incorrect type in argument 2 (incompatible argument 1 (different base types))
   drivers/pci/host/pcie-altera.c:496:53:    expected void ( *[usertype] handle )( ... )
   drivers/pci/host/pcie-altera.c:496:53:    got void ( static [toplevel] *<noident> )( ... )
   drivers/pci/host/pcie-altera.c: In function 'altera_pcie_parse_dt':
   drivers/pci/host/pcie-altera.c:496:46: warning: passing argument 2 of 'irq_set_chained_handler_and_data' from incompatible pointer type [-Wincompatible-pointer-types]
     irq_set_chained_handler_and_data(pcie->irq, altera_pcie_isr, pcie);
                                                 ^
   In file included from arch/x86/include/asm/hardirq.h:5:0,
                    from include/linux/hardirq.h:8,
                    from include/linux/interrupt.h:12,
                    from drivers/pci/host/pcie-altera.c:17:
   include/linux/irq.h:545:1: note: expected 'irq_flow_handler_t {aka void (*)(unsigned int,  struct irq_desc *)}' but argument is of type 'void (*)(struct irq_desc *)'
    irq_set_chained_handler_and_data(unsigned int irq, irq_flow_handler_t handle,
    ^

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
