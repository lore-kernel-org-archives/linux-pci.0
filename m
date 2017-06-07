Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:34311 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751666AbdFGHS2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Jun 2017 03:18:28 -0400
MIME-Version: 1.0
In-Reply-To: <20170606230007.19101-3-palmer@dabbelt.com>
References: <20170523004107.536-1-palmer@dabbelt.com> <20170606230007.19101-1-palmer@dabbelt.com>
 <20170606230007.19101-3-palmer@dabbelt.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 7 Jun 2017 09:18:26 +0200
Message-ID: <CAMuHMdULk48qf5s9VeqzSCKTSpcY5zdZoTzq_DR0TSbsP+dbNQ@mail.gmail.com>
Subject: Re: [PATCH 02/17] pcie-xilinx: add missing 5th legacy interrupt
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        albert@sifive.com, patches@groups.riscv.org,
        "Wesley W. Terpstra" <wesley@sifive.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Soren Brinkmann <soren.brinkmann@xilinx.com>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

CC pci folks

On Wed, Jun 7, 2017 at 12:59 AM, Palmer Dabbelt <palmer@dabbelt.com> wrote:
> From: "Wesley W. Terpstra" <wesley@sifive.com>
>
> These are numbered from 1.
>
> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
> ---
>  drivers/pci/host/pcie-xilinx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
> index 2fe2df51f9f8..8804145d399a 100644
> --- a/drivers/pci/host/pcie-xilinx.c
> +++ b/drivers/pci/host/pcie-xilinx.c
> @@ -443,7 +443,7 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
>                         val = ((val & XILINX_PCIE_RPIFR1_INTR_MASK) >>
>                                 XILINX_PCIE_RPIFR1_INTR_SHIFT) + 1;
>                         generic_handle_irq(irq_find_mapping(port->leg_domain,
> -                                                           val));
> +                                                           val + 1));
>                 }
>         }
>
> @@ -524,7 +524,7 @@ static int xilinx_pcie_init_irq_domain(struct xilinx_pcie_port *port)
>                 return -ENODEV;
>         }
>
> -       port->leg_domain = irq_domain_add_linear(pcie_intc_node, 4,
> +       port->leg_domain = irq_domain_add_linear(pcie_intc_node, 5,
>                                                  &intx_domain_ops,
>                                                  port);
>         if (!port->leg_domain) {
> --
> 2.13.0
