Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <1470807079-366-3-git-send-email-jszhang@marvell.com>
References: <1470807079-366-1-git-send-email-jszhang@marvell.com>
 <1470807079-366-3-git-send-email-jszhang@marvell.com>
From: Pratyush Anand <pratyush.anand@gmail.com>
Date: Sun, 14 Aug 2016 21:30:04 +0530
Message-ID: <CAHM4w1kZ=c-hF8nwXE0h4SYcQD2QG3NvZ-R0gjyDEPmc+7E7aw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] PCI: designware: let dw_pcie_link_up() beware of
 LTSSM training bit
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
> The link may be UP but still in link training. In this case, we can't
> think the link is up and operating correctly. So we need to teach
> dw_pcie_link_up() beware of the PCIE_PHY_DEBUG_R1_LINK_IN_TRAINING bit.
>

I have no more access of designware PCIe specification now. Since Joao
has acked it, so I would consider that
PCIE_PHY_DEBUG_R1_LINK_IN_TRAINING bit exists in older core as well.
If it is there then you have my Acked-by too.

~Pratyush

> This patch also rewrite PCIE_PHY_DEBUG_R1_LINK_UP definition so that
> it's consistent with other MACROS.
>
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> Acked-by: Joao Pinto <jpinto@synopsys.com>
> ---
>  drivers/pci/host/pcie-designware.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 24a16dd..6cc21bb 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -73,7 +73,8 @@
>  /* PCIe Port Logic registers */
>  #define PLR_OFFSET                     0x700
>  #define PCIE_PHY_DEBUG_R1              (PLR_OFFSET + 0x2c)
> -#define PCIE_PHY_DEBUG_R1_LINK_UP      0x00000010
> +#define PCIE_PHY_DEBUG_R1_LINK_UP      (0x1 << 4)
> +#define PCIE_PHY_DEBUG_R1_LINK_IN_TRAINING     (0x1 << 29)
>
>  /* Parameters for the waiting for link up routine */
>  #define LINK_WAIT_MAX_RETRIES          10
> @@ -417,7 +418,8 @@ int dw_pcie_link_up(struct pcie_port *pp)
>                 return pp->ops->link_up(pp);
>
>         val = readl(pp->dbi_base + PCIE_PHY_DEBUG_R1);
> -       return val & PCIE_PHY_DEBUG_R1_LINK_UP;
> +       return ((val & PCIE_PHY_DEBUG_R1_LINK_UP) &&
> +               (!(val & PCIE_PHY_DEBUG_R1_LINK_IN_TRAINING)));
>  }
>
>  static int dw_pcie_msi_map(struct irq_domain *domain, unsigned int irq,
> --
> 2.8.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
