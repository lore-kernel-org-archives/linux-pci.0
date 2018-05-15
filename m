Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: "Jingoo Han" <jingoohan1@gmail.com>
To: "'Jan Kiszka'" <jan.kiszka@siemens.com>,
 "'Bjorn Helgaas'" <bhelgaas@google.com>,
 "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <cover.1526375226.git.jan.kiszka@siemens.com>
 <3aeb2ed038cbce8fe744b614dc19d414555a7e8f.1526375226.git.jan.kiszka@siemens.com>
In-Reply-To: <3aeb2ed038cbce8fe744b614dc19d414555a7e8f.1526375226.git.jan.kiszka@siemens.com>
Subject: Re: [PATCH v4 6/8] PCI: Rework of_pci_get_host_bridge_resources() to
 devm_of_pci_get_host_bridge_resources()
Date: Tue, 15 May 2018 11:31:47 -0400
Message-ID: <000001d3ec61$d70e2e50$852a8af0$@gmail.com>
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
> of_pci_get_host_bridge_resources() allocates the resource structures it
> fills dynamically, but none of its callers care to release them so far.
> Rather than requiring everyone to do this explicitly, convert the
> existing function to a managed version.
> 
> CC: Jingoo Han <jingoohan1@gmail.com>
> CC: Joao Pinto <Joao.Pinto@synopsys.com>
> CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Acked-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han

> ---
>  drivers/pci/dwc/pcie-designware-host.c |  2 +-
>  drivers/pci/host/pci-aardvark.c        |  2 +-
>  drivers/pci/host/pci-ftpci100.c        |  2 +-
>  drivers/pci/host/pci-v3-semi.c         |  2 +-
>  drivers/pci/host/pci-versatile.c       |  2 +-
>  drivers/pci/host/pci-xgene.c           |  2 +-
>  drivers/pci/host/pcie-altera.c         |  2 +-
>  drivers/pci/host/pcie-iproc-platform.c |  2 +-
>  drivers/pci/host/pcie-rcar.c           |  2 +-
>  drivers/pci/host/pcie-rockchip.c       |  2 +-
>  drivers/pci/host/pcie-xilinx-nwl.c     |  2 +-
>  drivers/pci/host/pcie-xilinx.c         |  2 +-
>  drivers/pci/of.c                       | 30
++++++++++++------------------
>  include/linux/of_pci.h                 |  4 ++--
>  14 files changed, 26 insertions(+), 32 deletions(-)
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
