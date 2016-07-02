Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail5.windriver.com ([192.103.53.11]:38344 "EHLO mail5.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752722AbcGBXOf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sat, 2 Jul 2016 19:14:35 -0400
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: <linux-kernel@vger.kernel.org>
CC: Paul Gortmaker <paul.gortmaker@windriver.com>,
	Alexandre Courbot <gnurou@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Daney <david.daney@cavium.com>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>,
	Minghuan Lian <minghuan.Lian@freescale.com>,
	Mingkai Hu <mingkai.hu@freescale.com>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Niklas Cassel <niklas.cassel@axis.com>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Roy Zang <tie-fei.zang@freescale.com>,
	Simon Horman <horms@verge.net.au>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>,
	Will Deacon <will.deacon@arm.com>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	<linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH 00/14] PCI: trivial demodularization of builtin code
Date: Sat, 2 Jul 2016 19:13:20 -0400
Message-ID: <20160702231334.26684-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Firstly, this group of commits was chosen for the fact that they don't
change anything even at a binary object file level ; they just replace
module_platform_driver with builtin_platform_driver, and remove some
MODULE_<blah> tags that are no-ops in code.  So the regression risk
is zero here.

More specifically, we are doing the following to pci/host files that
currently can only be built-in:

 -- remove the include of module.h ; replace it with init.h as req'd

 -- drop instances of MODULE_DEVICE_TABLE which is a no-op built-in.

 -- replace module_platform_driver with builtin_platform_driver, which
    is functionally identical once CPP has processed the source.

 -- drop instances of MODULE_LICENSE, MODULE_AUTHOR, MODULE_DESCRIPTION
    while ensuring the contained info is present in the file comments.

After considering the inital version of demodularization PCI host
commits[1], we did consider striving for tristate[2] on another
subset of PCI host files in order to keep bzImage sizes lower on
multi-platform builds, but that proved to have technical challenges
well outside the scope of what we are trying to achieve here, given
PCI is infrastructure code and not a case of simple endpoint
drivers.

In the meantime more new code copies the existing examples of bool
Kconfig using modular references; further expanding the problem
space.  So we are just going to proceed with the demodularization
as originally planned.  Nothing removed here is rocket science, and
can easily be restored if someone has the hardware to test on and
the desire to expand functionality into the tristate realm.

A more complete description of why we are doing this can be found
in the original posting[1] for those that haven't seen it yet.

This represents just over 1/2 the PCI drivers that have their Kconfig
as bool but needlessly use modular references.  The remainder do not
deliver exact binary equivalence, since they delete unused __exit
functions and/or unused ".remove" functions.  So they are more
appropriate for submission earlier in the next development window.

Build tested for allmodconfig on several arch, including ARM and
ARM-64 on the most recent linux-next baseline.

Paul.

[1] https://lkml.kernel.org/r/1449970917-12633-1-git-send-email-paul.gortmaker@windriver.com
[2] https://lkml.kernel.org/r/1454889644-27830-1-git-send-email-paul.gortmaker@windriver.com

---

[vs v1 in [1] above, I tweaked the subjects slightly to match the
 format used by most PCI commits, i.e drop the "driver/" prefix. ]

Cc: Alexandre Courbot <gnurou@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: David Daney <david.daney@cavium.com>
Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Joao Pinto <jpinto@synopsys.com>
Cc: Minghuan Lian <minghuan.Lian@freescale.com>
Cc: Mingkai Hu <mingkai.hu@freescale.com>
Cc: Murali Karicheri <m-karicheri2@ti.com>
Cc: Niklas Cassel <niklas.cassel@axis.com>
Cc: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Pratyush Anand <pratyush.anand@gmail.com>
Cc: Roy Zang <tie-fei.zang@freescale.com>
Cc: Simon Horman <horms@verge.net.au>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Tanmay Inamdar <tinamdar@apm.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Valentine Barshak <valentine.barshak@cogentembedded.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Zhou Wang <wangzhou1@hisilicon.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-tegra@vger.kernel.org

Paul Gortmaker (14):
  PCI: armada8k: make it explicitly non-modular
  PCI: artpec6: make it explicitly non-modular
  PCI: designware-plat: make it explicitly non-modular
  PCI: generic: make it explicitly non-modular
  PCI: hisi: make it explicitly non-modular
  PCI: keystone: make it explicitly non-modular
  PCI: layerscape: make it explicitly non-modular
  PCI: mvebu: make it explicitly non-modular
  PCI: rcar: make it explicitly non-modular
  PCI: rcar-gen2: make it explicitly non-modular
  PCI: tegra: make it explicitly non-modular
  PCI: thunder-ecam: make it explicitly non-modular
  PCI: thunder-pem: make it explicitly non-modular
  PCI: xgene: make it explicitly non-modular

 drivers/pci/host/pci-host-generic.c     | 10 ++--------
 drivers/pci/host/pci-keystone.c         | 10 ++--------
 drivers/pci/host/pci-layerscape.c       | 10 ++--------
 drivers/pci/host/pci-mvebu.c            | 11 ++++-------
 drivers/pci/host/pci-rcar-gen2.c        | 12 +++---------
 drivers/pci/host/pci-tegra.c            | 11 ++++-------
 drivers/pci/host/pci-thunder-ecam.c     |  8 ++------
 drivers/pci/host/pci-thunder-pem.c      |  8 ++------
 drivers/pci/host/pci-xgene.c            |  8 ++------
 drivers/pci/host/pcie-armada8k.c        | 14 +++++---------
 drivers/pci/host/pcie-artpec6.c         | 10 ++--------
 drivers/pci/host/pcie-designware-plat.c | 10 ++--------
 drivers/pci/host/pcie-hisi.c            | 13 ++-----------
 drivers/pci/host/pcie-rcar.c            | 11 ++++-------
 14 files changed, 38 insertions(+), 108 deletions(-)

-- 
2.8.4

