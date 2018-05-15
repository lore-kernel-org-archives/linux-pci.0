Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: "Jingoo Han" <jingoohan1@gmail.com>
To: "'Jan Kiszka'" <jan.kiszka@siemens.com>,
 "'Bjorn Helgaas'" <bhelgaas@google.com>,
 "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <cover.1526375226.git.jan.kiszka@siemens.com>
 <5f2226585c6af9920b266d0503e32042d4c9e440.1526375226.git.jan.kiszka@siemens.com>
In-Reply-To: <5f2226585c6af9920b266d0503e32042d4c9e440.1526375226.git.jan.kiszka@siemens.com>
Subject: Re: [PATCH v4 4/8] PCI: Replace dev_node parameter of
 of_pci_get_host_bridge_resources with device
Date: Tue, 15 May 2018 11:34:38 -0400
Message-ID: <000101d3ec62$3ca4f4b0$b5eede10$@gmail.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: 'Lorenzo Pieralisi' <lorenzo.pieralisi@arm.com>,
 'Joao Pinto' <Joao.Pinto@synopsys.com>,
 'Vladimir Zapolskiy' <vladimir_zapolskiy@mentor.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, May 15, 2018 5:07 AM, Jan Kiszka wrote:
> 
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Another step towards a managed version of
> of_pci_get_host_bridge_resources(): Feed in the underlying device,
> rather than just the OF node. This will allow to use managed resource
> allocation internally later on.
> 
> CC: Jingoo Han <jingoohan1@gmail.com>
> CC: Joao Pinto <Joao.Pinto@synopsys.com>
> CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Acked-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han

> ---
>  drivers/pci/dwc/pcie-designware-host.c | 2 +-
>  drivers/pci/host/pci-aardvark.c        | 5 ++---
>  drivers/pci/host/pci-ftpci100.c        | 4 ++--
>  drivers/pci/host/pci-v3-semi.c         | 3 ++-
>  drivers/pci/host/pci-versatile.c       | 3 +--
>  drivers/pci/host/pci-xgene.c           | 3 ++-
>  drivers/pci/host/pcie-altera.c         | 5 ++---
>  drivers/pci/host/pcie-iproc-platform.c | 4 ++--
>  drivers/pci/host/pcie-rcar.c           | 5 ++---
>  drivers/pci/host/pcie-rockchip.c       | 4 ++--
>  drivers/pci/host/pcie-xilinx-nwl.c     | 4 ++--
>  drivers/pci/host/pcie-xilinx.c         | 4 ++--
>  drivers/pci/of.c                       | 9 +++++----
>  include/linux/of_pci.h                 | 4 ++--
>  14 files changed, 29 insertions(+), 30 deletions(-)
> 



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
