Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46737 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932078AbcBHX2N (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 8 Feb 2016 18:28:13 -0500
Date: Mon, 8 Feb 2016 17:28:08 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: kbuild test robot <lkp@intel.com>
Cc: Joao Pinto <Joao.Pinto@synopsys.com>, kbuild-all@01.org,
	Vineet.Gupta1@synopsys.com, arnd@arndb.de,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org, CARLOS.PALMINHA@synopsys.com,
	Alexey.Brodkin@synopsys.com, robh+dt@kernel.org,
	pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org
Subject: Re: [PATCH v9 2/2] pcie-designware platform driver
Message-ID: <20160208232808.GB1353@localhost>
References: <9069117816a5cd9cc3314b6d584c26d457807b8e.1454952698.git.jpinto@synopsys.com>
 <201602090552.plkRtxUR%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201602090552.plkRtxUR%fengguang.wu@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 09, 2016 at 05:29:15AM +0800, kbuild test robot wrote:
> Hi Joao,
> 
> [auto build test ERROR on arc/for-next]
> [cannot apply to pci/next v4.5-rc3 next-20160208]
> [if your patch is applied to the wrong git tree, please drop us a note to help improving the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Joao-Pinto/PCI-support-added-to-ARC/20160209-014808
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc for-next
> config: x86_64-allmodconfig (attached as .config)
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All errors (new ones prefixed by >>):
> 
>    include/linux/compiler.h:228:8: sparse: attribute 'no_sanitize_address': unknown attribute
>    drivers/pci/host/pcie-designware.c:581:14: sparse: undefined identifier 'pci_has_flag'
>    drivers/pci/host/pcie-designware.c: In function 'dw_pcie_host_init':
> >> drivers/pci/host/pcie-designware.c:581:7: error: implicit declaration of function 'pci_has_flag' [-Werror=implicit-function-declaration]
>      if (!pci_has_flag(PCI_PROBE_ONLY)) {
>           ^
> >> drivers/pci/host/pcie-designware.c:581:20: error: 'PCI_PROBE_ONLY' undeclared (first use in this function)
>      if (!pci_has_flag(PCI_PROBE_ONLY)) {
>                        ^
>    drivers/pci/host/pcie-designware.c:581:20: note: each undeclared identifier is reported only once for each function it appears in
>    cc1: some warnings being treated as errors

I have fixes for this on my pci/misc branch, so you don't need to
worry about these errors.  Basically I'm moving the PCI_PROBE_ONLY and
pci_has_flag() declarations from the arch-specific asm/pci-bridge.h
files to the generic linux/pci.h file.

> vim +/pci_has_flag +581 drivers/pci/host/pcie-designware.c
> 
> cbce7900 Zhou Wang   2015-10-29  575  
> cbce7900 Zhou Wang   2015-10-29  576  #ifdef CONFIG_ARM
> cbce7900 Zhou Wang   2015-10-29  577  	/* support old dtbs that incorrectly describe IRQs */
> cbce7900 Zhou Wang   2015-10-29  578  	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
> 0815f957 Yijing Wang 2014-11-11  579  #endif
> 0815f957 Yijing Wang 2014-11-11  580  
> cbce7900 Zhou Wang   2015-10-29 @581  	if (!pci_has_flag(PCI_PROBE_ONLY)) {
> cbce7900 Zhou Wang   2015-10-29  582  		pci_bus_size_bridges(bus);
> cbce7900 Zhou Wang   2015-10-29  583  		pci_bus_assign_resources(bus);
> 4b1ced84 Jingoo Han  2013-07-31  584  
> 
> :::::: The code at line 581 was first introduced by commit
> :::::: cbce7900598c26a12652f8ca9c41c5b29034c38d PCI: designware: Make driver arch-agnostic
> 
> :::::: TO: Zhou Wang <wangzhou1@hisilicon.com>
> :::::: CC: Bjorn Helgaas <bhelgaas@google.com>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation


