Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 10 May 2018 17:51:32 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH v2 00/10] PCI: leak fixes, removable generic PCI host,
 assorted stuff
Message-ID: <20180510225132.GD190385@bhelgaas-glaptop.roam.corp.google.com>
References: <cover.1525067324.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
In-Reply-To: <cover.1525067324.git.jan.kiszka@siemens.com>
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
 Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 30, 2018 at 07:48:34AM +0200, Jan Kiszka wrote:
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
> 
> Jan
> 
> [1] http://lkml.iu.edu/hypermail/linux/kernel/1606.3/00072.html
> 
> 
> CC: Jingoo Han <jingoohan1@gmail.com>
> CC: Joao Pinto <Joao.Pinto@synopsys.com>
> CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> CC: Will Deacon <will.deacon@arm.com>
> 
> Jan Kiszka (10):
>   PCI: Make pci_get_new_domain_nr() static
>   PCI: Fix memory leak of devm_pci_alloc_host_bridge()
>   PCI: Factor out __of_pci_get_host_bridge_resources()
>   PCI: Add dev parameter to __of_pci_get_host_bridge_resources()
>   PCI: Replace pr_*() with dev_*() in
>     __of_pci_get_host_bridge_resources()
>   PCI: Introduce devm_of_pci_get_host_bridge_resources()
>   PCI: Convert of_pci_get_host_bridge_resources() users to devm variant
>   PCI: Deprecate of_pci_get_host_bridge_resources()
>   PCI: Add support for unbinding the generic PCI host controller
>   PCI: Enable PCI_DOMAINS along with generic PCI host controller

Applied to pci/resource for v4.18, thanks!

I added the reviewed-by tags from Vladimir (thank you!) and replaced the
"Deprecate" patch by the v3 "Remove" patch.

>  drivers/pci/dwc/pcie-designware-host.c |   2 +-
>  drivers/pci/host/Kconfig               |   1 +
>  drivers/pci/host/pci-aardvark.c        |   5 +-
>  drivers/pci/host/pci-ftpci100.c        |   4 +-
>  drivers/pci/host/pci-host-common.c     |  13 ++++
>  drivers/pci/host/pci-host-generic.c    |   1 +
>  drivers/pci/host/pci-v3-semi.c         |   3 +-
>  drivers/pci/host/pci-versatile.c       |   3 +-
>  drivers/pci/host/pci-xgene.c           |   3 +-
>  drivers/pci/host/pcie-altera.c         |   5 +-
>  drivers/pci/host/pcie-iproc-platform.c |   4 +-
>  drivers/pci/host/pcie-rcar.c           |   5 +-
>  drivers/pci/host/pcie-rockchip.c       |   4 +-
>  drivers/pci/host/pcie-xilinx-nwl.c     |   4 +-
>  drivers/pci/host/pcie-xilinx.c         |   4 +-
>  drivers/pci/of.c                       | 105 +++++++++++++++++++++------------
>  drivers/pci/pci.c                      |   6 +-
>  drivers/pci/probe.c                    |   4 +-
>  include/linux/of_pci.h                 |  42 ++++++++++++-
>  include/linux/pci-ecam.h               |   1 +
>  include/linux/pci.h                    |   3 -
>  21 files changed, 149 insertions(+), 73 deletions(-)
> 
> -- 
> 2.13.6
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
