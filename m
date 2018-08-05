Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yb0-f193.google.com ([209.85.213.193]:33983 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbeHEWIm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 5 Aug 2018 18:08:42 -0400
Received: by mail-yb0-f193.google.com with SMTP id e9-v6so4557332ybq.1
        for <linux-pci@vger.kernel.org>; Sun, 05 Aug 2018 13:02:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180804101402.10022-3-hch@lst.de>
References: <20180804101402.10022-1-hch@lst.de> <20180804101402.10022-3-hch@lst.de>
From: Wesley Terpstra <wesley@sifive.com>
Date: Sun, 5 Aug 2018 13:02:58 -0700
Message-ID: <CAMgXwTgr572J_HH396tfvT7Zj8Jj0fefKOSmVw2+Gwn8qcPR1g@mail.gmail.com>
Subject: Re: [PATCH 2/3] PCI/xilinx: Work-around for hardware DMA limit (32 bits)
To: Christoph Hellwig <hch@lst.de>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

FYI, This Xilinx PCIe IP 32-bit cap only applies to SOME instances of
the IP. The Ultrascale+ version of Xilinx PCIe hard IP does support
64-bit or 32-bit. The Virtex7 version only supports 32-bit. The
pcie-xilinx driver woks with both of these root complexes. So probably
there should be a conditional hook in the DTS that triggers the
work-around behaviour.

On Sat, Aug 4, 2018 at 3:14 AM, Christoph Hellwig <hch@lst.de> wrote:
> This PCIe bridge only has a 32 bit bus master interface, thus truncating
> the DMA capability of all PCIe devices attached beneath it. This caps
> the child device capability so that these devices work on systems with
> physical memory beyond the 4GiB threshold.
>
> Based on an earlier patch from Wesley W. Terpstra <wesley@sifive.com>.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/pci/controller/pcie-xilinx.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/pci/controller/pcie-xilinx.c b/drivers/pci/controller/pcie-xilinx.c
> index 7b1389d8e2a5..ccfd91e0515f 100644
> --- a/drivers/pci/controller/pcie-xilinx.c
> +++ b/drivers/pci/controller/pcie-xilinx.c
> @@ -197,6 +197,16 @@ static void __iomem *xilinx_pcie_map_bus(struct pci_bus *bus,
>         return port->reg_base + relbus + where;
>  }
>
> +/*
> + * This PCIe bridge only has a 32 bit bus master interface, thus truncating
> + * the DMA capability of all PCIe devices attached beneath it.
> + */
> +static int xilinx_pcie_add_device(struct pci_dev *pdev)
> +{
> +       pdev->dev.bus_dma_mask = DMA_BIT_MASK(32);
> +       return 0;
> +}
> +
>  /* PCIe operations */
>  static struct pci_ops xilinx_pcie_ops = {
>         .map_bus = xilinx_pcie_map_bus,
> @@ -665,6 +675,7 @@ static int xilinx_pcie_probe(struct platform_device *pdev)
>         bridge->ops = &xilinx_pcie_ops;
>         bridge->map_irq = of_irq_parse_and_map_pci;
>         bridge->swizzle_irq = pci_common_swizzle;
> +       bridge->add_device = xilinx_pcie_add_device;
>
>  #ifdef CONFIG_PCI_MSI
>         xilinx_pcie_msi_chip.dev = dev;
> --
> 2.18.0
>
