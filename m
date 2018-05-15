Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 15 May 2018 14:00:57 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH v4 0/8] PCI: leak fixes, removable generic PCI host,
 assorted stuff
Message-ID: <20180515190057.GA11156@bhelgaas-glaptop.roam.corp.google.com>
References: <cover.1526375226.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
In-Reply-To: <cover.1526375226.git.jan.kiszka@siemens.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Joao Pinto <Joao.Pinto@synopsys.com>, linux-pci@vger.kernel.org,
 Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
 Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 15, 2018 at 11:06:59AM +0200, Jan Kiszka wrote:
> Changes in v4:
>  - restore pci_free_resource_list() in error path of
>    of_pci_get_host_bridge_resources()
> 
> Changes in v3:
>  - refactor series to be both bisectable and simpler while reworking
>    of_pci_get_host_bridge_resources()
>  - include of_pci_get_host_bridge_resources() removal
>  - include devm_of_pci_get_host_bridge_resources() error path fixes
>  - effectively, no functional changes to v2
> 
> Changes in v2:
>  - patch 1: commit message reworking as suggested by Lorenzo
>  - patch 3-6: split-up as suggested by Bjorn
>  - patch 8: new
>  - patch 10: select PCI_DOMAINS from PCI_HOST_GENERIC, rather than
>    allowing manual choice, as suggested by Lorenzo
> 
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

This is beautiful!  Thanks for tweaking this one more time; I think it
really makes the patches much more readable.

I applied these with the tested-by/reviewed-by/acks to pci/resource for
v4.18.

Andy's comments certainly make sense, but doing it in the "Rework
of_pci_get_host_bridge_resources()" patch would make that patch less
obvious, so I'd rather do it as a cleanup on top.

> [1] http://lkml.iu.edu/hypermail/linux/kernel/1606.3/00072.html
> 
> 
> CC: Jingoo Han <jingoohan1@gmail.com>
> CC: Joao Pinto <Joao.Pinto@synopsys.com>
> CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> CC: Will Deacon <will.deacon@arm.com>
> 
> Jan Kiszka (8):
>   PCI: Make pci_get_new_domain_nr() static
>   PCI: Fix memory leak of devm_pci_alloc_host_bridge()
>   PCI: Rename device node parameter of
>     of_pci_get_host_bridge_resources()
>   PCI: Replace dev_node parameter of of_pci_get_host_bridge_resources
>     with device
>   PCI: Replace pr_*() with dev_*() in of_pci_get_host_bridge_resources()
>   PCI: Rework of_pci_get_host_bridge_resources() to
>     devm_of_pci_get_host_bridge_resources()
>   PCI: Add support for unbinding the generic PCI host controller
>   PCI: Enable PCI_DOMAINS along with generic PCI host controller
> 
>  drivers/pci/dwc/pcie-designware-host.c |  2 +-
>  drivers/pci/host/Kconfig               |  1 +
>  drivers/pci/host/pci-aardvark.c        |  5 ++-
>  drivers/pci/host/pci-ftpci100.c        |  4 +--
>  drivers/pci/host/pci-host-common.c     | 13 +++++++
>  drivers/pci/host/pci-host-generic.c    |  1 +
>  drivers/pci/host/pci-v3-semi.c         |  3 +-
>  drivers/pci/host/pci-versatile.c       |  3 +-
>  drivers/pci/host/pci-xgene.c           |  3 +-
>  drivers/pci/host/pcie-altera.c         |  5 ++-
>  drivers/pci/host/pcie-iproc-platform.c |  4 +--
>  drivers/pci/host/pcie-rcar.c           |  5 ++-
>  drivers/pci/host/pcie-rockchip.c       |  4 +--
>  drivers/pci/host/pcie-xilinx-nwl.c     |  4 +--
>  drivers/pci/host/pcie-xilinx.c         |  4 +--
>  drivers/pci/of.c                       | 65 ++++++++++++++++------------------
>  drivers/pci/pci.c                      |  6 ++--
>  drivers/pci/probe.c                    |  4 ++-
>  include/linux/of_pci.h                 |  4 +--
>  include/linux/pci-ecam.h               |  1 +
>  include/linux/pci.h                    |  3 --
>  21 files changed, 76 insertions(+), 68 deletions(-)
> 
> -- 
> 2.13.6
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
