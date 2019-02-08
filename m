Return-Path: <SRS0=vzDi=QP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 414C3C282CC
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 12:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03994217D8
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 12:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mobiveil.co.in header.i=@mobiveil.co.in header.b="hj5tQ54y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfBHMnf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 8 Feb 2019 07:43:35 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34325 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbfBHMnf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Feb 2019 07:43:35 -0500
Received: by mail-wr1-f66.google.com with SMTP id z15so3461543wrn.1
        for <linux-pci@vger.kernel.org>; Fri, 08 Feb 2019 04:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mobiveil.co.in; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=le6Kczd428l77A5GbTImJiCcU9m+08tK25W6Q6TDEPg=;
        b=hj5tQ54yK4e4L6GbbCUqEn6EyL3hWZKceiCt+6G2uw9/RI4ooZHizqPyeJT5jaBl1S
         dsHGbsgAYm+MkgCaW/dLl9/cb19xCa9bVvVObDQtJN4FnjpVgN0Px2slRZv3sxclcUMe
         4l0YFWDgPlGEXqcbaQFJJOFaGn4x2QYTrHjZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=le6Kczd428l77A5GbTImJiCcU9m+08tK25W6Q6TDEPg=;
        b=BVb88ElWSTqVPtW2m0mNncIZYm43MM60mWYPut/kljM2k88aLZJS4PK9JHZnID9DKV
         tHP09+ZrE0kuOj2u4rI9N8yPF/ZkmgPKrz3M6R0vRB3LNqKVVrIXSnUjYc+kbGUioY07
         oBMMHBvf9ES++ffYggbJOkeNBnImOFRMgD0J3cmGAFUu79tjaGb/sP4+D/ItdpNJ9KmT
         5vsDWP233zELN4apwfVlbjZmgLpemAhmcbfUWWsVXBqZhcSkyEfeQvnu6bf+yYfgm6JG
         yDXBUO/uKBrBU4X4ptQT/qqWqzkkgog+qRgo+ZOx5RCj3vnT5d7aieNodNqBWbsKc5bt
         Kw5A==
X-Gm-Message-State: AHQUAuZhYTD7kLBat99OzTCOetsugAsPaEp2a6n6/PbCElVx3QYrvMg9
        cHfkITLk/4i61LiBE/9NGcT/h0BS32pGMH6H7//ekQ==
X-Google-Smtp-Source: AHgI3Ib27sOpr5csHnJpPID5qa25dzB8lESyk5/lpxD01iB3Mojez8OdvxZYARViFdpd2jj9lSEgOIC8Fi51ZHYHpSA=
X-Received: by 2002:adf:fd81:: with SMTP id d1mr16536788wrr.105.1549629812576;
 Fri, 08 Feb 2019 04:43:32 -0800 (PST)
MIME-Version: 1.0
References: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com> <20190129080926.36773-22-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190129080926.36773-22-Zhiqiang.Hou@nxp.com>
From:   Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date:   Fri, 8 Feb 2019 18:16:11 +0530
Message-ID: <CAFZiPx0SUBd_ad-P2yyOA_==PbXN58YamT1-kQVTuz27+8Q+bw@mail.gmail.com>
Subject: Re: [PATCHv3 21/27] PCI: mobiveil: make mobiveil_host_init can be
 used to re-init host
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 29, 2019 at 1:40 PM Z.q. Hou <zhiqiang.hou@nxp.com> wrote:
>
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>
> Make the mobiveil_host_init function can be used to re-init
> host controller's PAB and GPEX CSR register block, as NXP
> integrated Mobiveil IP has to reset and then re-init the PAB
> and GPEX CSR registers upon Hot-reset.
>
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V3:
>  - Removed the duplicated free opteration of pcie->resources.
>
>  .../controller/mobiveil/pcie-mobiveil-host.c  | 41 ++++++++++---------
>  .../pci/controller/mobiveil/pcie-mobiveil.h   |  3 +-
>  2 files changed, 23 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> index d028cdf31d0e..e8d0c4989013 100644
> --- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> @@ -217,7 +217,7 @@ static void mobiveil_pcie_enable_msi(struct mobiveil_pcie *pcie)
>         writel_relaxed(1, pcie->apb_csr_base + MSI_ENABLE_OFFSET);
>  }
>
> -static int mobiveil_host_init(struct mobiveil_pcie *pcie)
> +int mobiveil_host_init(struct mobiveil_pcie *pcie, bool reinit)
>  {
>         u32 value, pab_ctrl, type;
>         struct resource_entry *win;
> @@ -229,11 +229,16 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
>         for (i = 0; i < pcie->ppio_wins; i++)
>                 mobiveil_pcie_disable_ib_win(pcie, i);
>
> -       /* setup bus numbers */
> -       value = csr_readl(pcie, PCI_PRIMARY_BUS);
> -       value &= 0xff000000;
> -       value |= 0x00ff0100;
> -       csr_writel(pcie, value, PCI_PRIMARY_BUS);
> +       pcie->ib_wins_configured = 0;
> +       pcie->ob_wins_configured = 0;
> +
> +       if (!reinit) {
> +               /* setup bus numbers */
> +               value = csr_readl(pcie, PCI_PRIMARY_BUS);
> +               value &= 0xff000000;
> +               value |= 0x00ff0100;
> +               csr_writel(pcie, value, PCI_PRIMARY_BUS);
> +       }
>
>         /*
>          * program Bus Master Enable Bit in Command Register in PAB Config
> @@ -279,7 +284,7 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
>         program_ib_windows(pcie, WIN_NUM_0, 0, 0, MEM_WINDOW_TYPE, IB_WIN_SIZE);
>
>         /* Get the I/O and memory ranges from DT */
> -       resource_list_for_each_entry(win, &pcie->resources) {
> +       resource_list_for_each_entry(win, pcie->resources) {
>                 if (resource_type(win->res) == IORESOURCE_MEM) {
>                         type = MEM_WINDOW_TYPE;
>                 } else if (resource_type(win->res) == IORESOURCE_IO) {
> @@ -550,8 +555,6 @@ int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie)
>         resource_size_t iobase;
>         int ret;
>
> -       INIT_LIST_HEAD(&pcie->resources);
> -
>         ret = mobiveil_pcie_parse_dt(pcie);
>         if (ret) {
>                 dev_err(dev, "Parsing DT failed, ret: %x\n", ret);
> @@ -565,34 +568,35 @@ int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie)
>
>         /* parse the host bridge base addresses from the device tree file */
>         ret = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
> -                                                   &pcie->resources, &iobase);
> +                                                   &bridge->windows, &iobase);
>         if (ret) {
>                 dev_err(dev, "Getting bridge resources failed\n");
>                 return ret;
>         }
>
> +       pcie->resources = &bridge->windows;
> +
>         /*
>          * configure all inbound and outbound windows and prepare the RC for
>          * config access
>          */
> -       ret = mobiveil_host_init(pcie);
> +       ret = mobiveil_host_init(pcie, false);
>         if (ret) {
>                 dev_err(dev, "Failed to initialize host\n");
> -               goto error;
> +               return ret;
>         }
>
>         ret = mobiveil_pcie_interrupt_init(pcie);
>         if (ret) {
>                 dev_err(dev, "Interrupt init failed\n");
> -               goto error;
> +               return ret;
>         }
>
> -       ret = devm_request_pci_bus_resources(dev, &pcie->resources);
> +       ret = devm_request_pci_bus_resources(dev, pcie->resources);
>         if (ret)
> -               goto error;
> +               return ret;
>
>         /* Initialize bridge */
> -       list_splice_init(&pcie->resources, &bridge->windows);
>         bridge->dev.parent = dev;
>         bridge->sysdata = pcie;
>         bridge->busnr = pcie->rp.root_bus_nr;
> @@ -608,7 +612,7 @@ int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie)
>         /* setup the kernel resources for the newly added PCIe root bus */
>         ret = pci_scan_root_bus_bridge(bridge);
>         if (ret)
> -               goto error;
> +               return ret;
>
>         bus = bridge->bus;
>
> @@ -618,7 +622,4 @@ int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie)
>         pci_bus_add_devices(bus);
>
>         return 0;
> -error:
> -       pci_free_resource_list(&pcie->resources);
> -       return ret;
>  }
> diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.h b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> index 933c2f34bc52..0f5303962e88 100644
> --- a/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> @@ -152,7 +152,7 @@ struct mobiveil_pab_ops {
>
>  struct mobiveil_pcie {
>         struct platform_device *pdev;
> -       struct list_head resources;
> +       struct list_head *resources;
>         void __iomem *csr_axi_slave_base;       /* PAB registers base */
>         phys_addr_t pcie_reg_base;      /* Physical PCIe Controller Base */
>         void __iomem *apb_csr_base;     /* MSI register base */
> @@ -165,6 +165,7 @@ struct mobiveil_pcie {
>  };
>
>  int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie);
> +int mobiveil_host_init(struct mobiveil_pcie *pcie, bool reinit);
>  bool mobiveil_pcie_link_up(struct mobiveil_pcie *pcie);
>  int mobiveil_bringup_link(struct mobiveil_pcie *pcie);
>  void program_ob_windows(struct mobiveil_pcie *pcie, int win_num, u64 cpu_addr,
> --
> 2.17.1
>
Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
