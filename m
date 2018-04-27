Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753569AbeD0WQF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 27 Apr 2018 18:16:05 -0400
Date: Fri, 27 Apr 2018 17:16:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 0/6] PCI: leak fixes, removable generic PCI host,
 assorted stuff
Message-ID: <20180427221602.GB73256@bhelgaas-glaptop.roam.corp.google.com>
References: <cover.1524582822.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1524582822.git.jan.kiszka@siemens.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 24, 2018 at 05:13:36PM +0200, Jan Kiszka wrote:
> This primarily enables to unbind the generic PCI host controller without
> leaving lots of memory leaks behind. A previous proposal patch 5 was
> rejected because of those issues [1].
> 
> The fixes have been validated in the Jailhouse setup, where we add and
> remove a virtual PCI host controller on hypervisor activation/
> deactivation, with the help of kmemleak.
> 
> Besides that, there is tiny PCI API cleanup at the beginning and
> support for manually enabled PCI domains at the end that enables the
> Jailhouse scenario.

Sounds like you have a couple things lined up for a v2 posting.  When you
do that, would you mind updating the function references in subjects,
changelogs, and comments to include "()" after the function name, e.g.,
s/pci_get_new_domain_nr/pci_get_new_domain_nr()/?

> [1] http://lkml.iu.edu/hypermail/linux/kernel/1606.3/00072.html
> 
> 
> CC: Jingoo Han <jingoohan1@gmail.com>
> CC: Joao Pinto <Joao.Pinto@synopsys.com>
> CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> CC: Will Deacon <will.deacon@arm.com>
> 
> Jan Kiszka (6):
>   PCI: Make pci_get_new_domain_nr static
>   PCI: Fix memory leak of devm_pci_alloc_host_bridge
>   PCI: Introduce devm_of_pci_get_host_bridge_resources
>   PCI: Convert of_pci_get_host_bridge_resources users to devm variant
>   PCI: Add support for unbinding the generic PCI host controller
>   arm: Allow to enable PCI_DOMAINS manually
> 
>  arch/arm/Kconfig                       |  7 ++-
>  drivers/pci/dwc/pcie-designware-host.c |  2 +-
>  drivers/pci/host/pci-aardvark.c        |  5 +-
>  drivers/pci/host/pci-ftpci100.c        |  4 +-
>  drivers/pci/host/pci-host-common.c     | 13 +++++
>  drivers/pci/host/pci-host-generic.c    |  1 +
>  drivers/pci/host/pci-v3-semi.c         |  3 +-
>  drivers/pci/host/pci-versatile.c       |  3 +-
>  drivers/pci/host/pci-xgene.c           |  3 +-
>  drivers/pci/host/pcie-altera.c         |  5 +-
>  drivers/pci/host/pcie-iproc-platform.c |  4 +-
>  drivers/pci/host/pcie-rcar.c           |  5 +-
>  drivers/pci/host/pcie-rockchip.c       |  4 +-
>  drivers/pci/host/pcie-xilinx-nwl.c     |  4 +-
>  drivers/pci/host/pcie-xilinx.c         |  4 +-
>  drivers/pci/of.c                       | 93 ++++++++++++++++++++++------------
>  drivers/pci/pci.c                      |  6 +--
>  drivers/pci/probe.c                    |  4 +-
>  include/linux/of_pci.h                 | 14 ++++-
>  include/linux/pci-ecam.h               |  1 +
>  include/linux/pci.h                    |  3 --
>  21 files changed, 120 insertions(+), 68 deletions(-)
> 
> -- 
> 2.13.6
> 
