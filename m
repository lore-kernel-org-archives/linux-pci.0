Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:61027 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752AbaG1N6L (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 28 Jul 2014 09:58:11 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: kbuild test robot <fengguang.wu@intel.com>
Cc: kbuild-all@01.org, Lucas Stach <l.stach@pengutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Mohit KUMAR DCG <Mohit.KUMAR@st.com>,
	Jingoo Han <jg1.han@samsung.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [linux-devel:devel-athens-arm-201407281729 9/13] ERROR: "dw_pcie_host_init" [drivers/pci/host/pcie-spear13xx.ko] undefined!
Date: Mon, 28 Jul 2014 15:57:18 +0200
Message-ID: <5266883.bDcz9kd6ee@wuerfel>
In-Reply-To: <53d65148.2/x780FfPLEYMqov%fengguang.wu@intel.com>
References: <53d65148.2/x780FfPLEYMqov%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday 28 July 2014 21:34:00 kbuild test robot wrote:
> Hi Wu,
> 
> FYI, this happens on a merge commit, which indicates conflicting changes with one of the below merged branches.
> 
> 46b7e36 Merge 'arm-soc/for-next' into devel-athens-arm-201407281729
> ed67b70 Merge 'sound/for-next' into devel-athens-arm-201407281729
> df8c9cc Merge 's390/features' into devel-athens-arm-201407281729
> a97b04d Merge 'powerpc/test' into devel-athens-arm-201407281729
> 6baf298 Merge 'powerpc/next' into devel-athens-arm-201407281729
> e216a37 Merge 'tip/sched/core' into devel-athens-arm-201407281729
> 6c9d717 Merge 'tip/perf/core' into devel-athens-arm-201407281729
> ab83da1 Merge 'ath6kl/ath-next-test' into devel-athens-arm-201407281729
> 86fc732 0day base guard for 'devel-athens-arm-201407281729'
> 64aa90f Linux 3.16-rc7
> 
> 
> tree:   git://internal_merge_and_test_tree devel-athens-arm-201407281729
> head:   ed9c75e87f52f14597c4db2ba5b45950f2e09c1a
> commit: 46b7e363b2006f212f930aa284b0ad3ca6d3fe48 [9/13] Merge 'arm-soc/for-next' into devel-athens-arm-201407281729
> config: make ARCH=arm allmodconfig
> 
> All error/warnings:
> 
> >> ERROR: "dw_pcie_host_init" [drivers/pci/host/pcie-spear13xx.ko] undefined!
> >> ERROR: "dw_handle_msi_irq" [drivers/pci/host/pcie-spear13xx.ko] undefined!
> >> ERROR: "dw_pcie_msi_init" [drivers/pci/host/pcie-spear13xx.ko] undefined!
> >> ERROR: "dw_pcie_cfg_write" [drivers/pci/host/pcie-spear13xx.ko] undefined!
> >> ERROR: "dw_pcie_cfg_read" [drivers/pci/host/pcie-spear13xx.ko] undefined!
> >> ERROR: "dw_pcie_setup_rc" [drivers/pci/host/pcie-spear13xx.ko] undefined!
> >> ERROR: "dw_pcie_link_up" [drivers/pci/host/pcie-spear13xx.ko] undefined!

I submitted a patch for this already:

http://patchwork.ozlabs.org/patch/373209/

Not sure how to deal with that, as Lucas indicated that it conflicts with
another patch of his. I guess I could just apply my patch as-is to fix the
current bug and let Linus deal with the merge conflict later.

Alternatively, we can turn this driver into builtin-only like some of
the other PCI host controllers. Not as nice, but gets rid of the bug
without introducing a conflict.

Jingoo, Mohit, Bjorn, any other opinions?

	Arnd
