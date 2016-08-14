Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <1470807079-366-2-git-send-email-jszhang@marvell.com>
References: <1470807079-366-1-git-send-email-jszhang@marvell.com>
 <1470807079-366-2-git-send-email-jszhang@marvell.com>
From: Pratyush Anand <pratyush.anand@gmail.com>
Date: Sun, 14 Aug 2016 21:31:48 +0530
Message-ID: <CAHM4w1kDDK-HcAad5OT6+mG6J5ps1BJE2d=xK51oJcA-i3vEKQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PCI: designware: mv parameters for wait for link
 into pcie-designware.c
To: Jisheng Zhang <jszhang@marvell.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Joao Pinto <Joao.Pinto@synopsys.com>, Jingoo Han <jingoohan1@gmail.com>,
 linux-kernel@vger.kernel.org,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 10, 2016 at 11:01 AM, Jisheng Zhang <jszhang@marvell.com> wrote:
> These parameters are only used in the core pcie-designware.c, let's
> move them to the core driver.
>
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
Acked-by: Pratyush Anand <pratyush.anand@gmail.com>

> ---
>  drivers/pci/host/pcie-designware.c | 5 +++++
>  drivers/pci/host/pcie-designware.h | 5 -----
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 12afce1..24a16dd 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -75,6 +75,11 @@
>  #define PCIE_PHY_DEBUG_R1              (PLR_OFFSET + 0x2c)
>  #define PCIE_PHY_DEBUG_R1_LINK_UP      0x00000010
>
> +/* Parameters for the waiting for link up routine */
> +#define LINK_WAIT_MAX_RETRIES          10
> +#define LINK_WAIT_USLEEP_MIN           90000
> +#define LINK_WAIT_USLEEP_MAX           100000
> +
>  static struct pci_ops dw_pcie_ops;
>
>  int dw_pcie_cfg_read(void __iomem *addr, int size, u32 *val)
> diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
> index f437f9b..384e79b 100644
> --- a/drivers/pci/host/pcie-designware.h
> +++ b/drivers/pci/host/pcie-designware.h
> @@ -22,11 +22,6 @@
>  #define MAX_MSI_IRQS                   32
>  #define MAX_MSI_CTRLS                  (MAX_MSI_IRQS / 32)
>
> -/* Parameters for the waiting for link up routine */
> -#define LINK_WAIT_MAX_RETRIES          10
> -#define LINK_WAIT_USLEEP_MIN           90000
> -#define LINK_WAIT_USLEEP_MAX           100000
> -
>  struct pcie_port {
>         struct device           *dev;
>         u8                      root_bus_nr;
> --
> 2.8.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
