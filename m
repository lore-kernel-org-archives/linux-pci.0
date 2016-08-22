Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: <linux-kernel@vger.kernel.org>
CC: Paul Gortmaker <paul.gortmaker@windriver.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, Ley Foon Tan <lftan@altera.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Richard Zhu <Richard.Zhu@freescale.com>,
        Tom Long Nguyen <tom.l.nguyen@intel.com>,
        Will Deacon <will.deacon@arm.com>,
        <rfi@lists.rocketboards.org>, <linux-pci@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>
Subject: [PATCH 0/8] PCI: more trivial demodularization of builtin code
Date: Mon, 22 Aug 2016 17:59:40 -0400
Message-ID: <20160822215948.27251-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is another group of commits that was chosen since they really don't
change anything even at a binary object file level ; they just replace
module_init with device_initcall (which are identical), and remove some
MODULE_<blah> tags that are no-ops in code.  So the run time regression
risk is zero here.

More specifically, we are doing the following to these PCI files that
currently can only be built-in:

 -- remove the include of module.h ; replace it with init.h as req'd

 -- drop instances of MODULE_DEVICE_TABLE which is a no-op built-in.

 -- replace module_init (if present) with device_initcall, which is
    functionally identical once CPP has processed the source.

 -- drop instances of MODULE_LICENSE, MODULE_AUTHOR, MODULE_DESCRIPTION
    while ensuring the contained info is present in the file comments.

Build tested for allmodconfig on several arch, including ARM and ARM-64
on a recent linux-next baseline.

Some non-modular PCI files still remain with unused __exit and/or .remove
functions.  Those will be dealt with in a separate series after this.

Also note that we looked into modularizing some of the PCI_DW stuff at
an earlier time[1] but that ran into problems such as trying to create
unwind for hook_fault_code etc. that wasn't easily solved.  So we just
go with keeping the code runtime functionally equivalent to what it was.

Paul.

[1] https://lkml.kernel.org/r/1454889644-27830-1-git-send-email-paul.gortmaker@windriver.com

---

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Ley Foon Tan <lftan@altera.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Pratyush Anand <pratyush.anand@gmail.com>
Cc: Richard Zhu <Richard.Zhu@freescale.com>
Cc: Tom Long Nguyen <tom.l.nguyen@intel.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: rfi@lists.rocketboards.org
Cc: linux-pci@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org

Paul Gortmaker (8):
  PCI: altera: make msi explicitly non-modular
  PCI: altera: make it explicitly non-modular
  PCI: imx6: make it explicitly non-modular
  PCI: portdrv: make it explicitly non-modular
  PCI: spear13xx: make it explicitly non-modular
  PCI: designware: make host support explicitly non-modular
  PCI: exynos: make host support explicitly non-modular
  PCI: generic: make host-common explicitly non-modular

 drivers/pci/host/pci-exynos.c      |  7 +------
 drivers/pci/host/pci-host-common.c |  7 ++-----
 drivers/pci/host/pci-imx6.c        |  9 +--------
 drivers/pci/host/pcie-altera-msi.c | 10 +++++-----
 drivers/pci/host/pcie-altera.c     | 12 +++++-------
 drivers/pci/host/pcie-designware.c |  5 -----
 drivers/pci/host/pcie-spear13xx.c  | 11 ++---------
 drivers/pci/pcie/portdrv_pci.c     |  8 +-------
 8 files changed, 17 insertions(+), 52 deletions(-)

-- 
2.8.4
