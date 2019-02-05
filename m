Return-Path: <SRS0=ZQO4=QM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB258C282CB
	for <linux-pci@archiver.kernel.org>; Tue,  5 Feb 2019 06:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 735A32175B
	for <linux-pci@archiver.kernel.org>; Tue,  5 Feb 2019 06:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mobiveil.co.in header.i=@mobiveil.co.in header.b="jumluG8r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfBEGHh (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 5 Feb 2019 01:07:37 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]:44848 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbfBEGHg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Feb 2019 01:07:36 -0500
Received: by mail-wr1-f43.google.com with SMTP id v16so415839wrn.11
        for <linux-pci@vger.kernel.org>; Mon, 04 Feb 2019 22:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mobiveil.co.in; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1X7N/dVorY1n8o81SeDGrzaKlbKZ1oT9Ljxn+D684ws=;
        b=jumluG8r5o7eqoHVTBNXM7Z+nNa3LZuGQCTHMO01skLXnrTLcrRBGBPAtx88LvgE6F
         GiPEQHi8dL/1FgSrJ7OTeYohrHuhvJl9tu2ZSF5U0lFuBlcNcH2YveeKRPYW9y12G/a0
         DbYgjwSbSH44ln9wfgDpp8716HSHKAEEio5pY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1X7N/dVorY1n8o81SeDGrzaKlbKZ1oT9Ljxn+D684ws=;
        b=RD7KrmjpVkFKm37hSqd7GzPfiaT5ck4GpV1dQDSFj5qAbQqIpNIevLlvnu67pr7C9g
         XlsWSlXxhJsK8akfnn4wDA6t22sJ9pCwsy83yJvq8hSWMfcxjcGNZqdamvDpMRUVNvdE
         bJrQRl7/bc9QC+psfZpuQpW7DHoJuNLqAazwhCt0a8CBnpTfNfX0IsAybLqy1dkIB+M3
         nkP6Vxp5lxyq0hiP35RrZ5gfO12Gm6DMe9rqu/oQcG5yLDugBE+s88PDoEKO8nea6gxy
         XjLvNSVPos1njekc6H4nihqKkeXUG7q2f0oz2y2pzLDQw26bI63WT5+BeWDeXCC0yB+k
         O23w==
X-Gm-Message-State: AHQUAub0mW2SjXHNhwOlVKRL8Dh+yr7aVvgSXlHlSattDKPaYt36i6Bb
        qnB4pn/SYcAJTX1DIIM0M/a1h/BdzaW0Vg9upIMSvg==
X-Google-Smtp-Source: AHgI3IajLMCsjUiL81ay7NlI0dd+u6tmSbiQ8q9kBaX+M8wgdiG6RzjvFLo6n8XPeco0SV0skbS408EoBQX1jwRiKgw=
X-Received: by 2002:a5d:4ec7:: with SMTP id s7mr2206258wrv.14.1549346854954;
 Mon, 04 Feb 2019 22:07:34 -0800 (PST)
MIME-Version: 1.0
References: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com> <20190129080926.36773-10-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190129080926.36773-10-Zhiqiang.Hou@nxp.com>
From:   Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date:   Tue, 5 Feb 2019 11:40:08 +0530
Message-ID: <CAFZiPx2Qc50LpfdaBm=FYcQPmO5eB5j4SB8w-rNVs0jmJc6jqw@mail.gmail.com>
Subject: Re: [PATCHv3 09/27] PCI: mobiveil: correct inbound/outbound window
 setup routines
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

ZQ,
please correct the tab spacing of the macro definitions, otherwise its OK.

Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>

On Tue, Jan 29, 2019 at 1:39 PM Z.q. Hou <zhiqiang.hou@nxp.com> wrote:
>
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>
> Outbound window routine:
>  - Removed unused var definition and register read operations.
>  - Added the upper 32-bit cpu address setup of the window.
>  - Instead of blindly write, only change the fields specified.
>  - Masked the lower bits of window size in case override the
>    control bits.
>  - Check if the passing window number is available, instead of
>    the total number of the initialized windows.
>
> Inbound window routine:
>  - Added parameter 'u64 cpu_addr' to specify the cpu address
>    of the window instead of using 'pci_addr'.
>  - Changed 'int pci_addr' to 'u64 pci_addr', and added setup
>    of the upper 32-bit pci address of the window.
>  - Moved the PCIe PIO master enablement to mobiveil_host_init().
>  - Instead of blindly write, only change the fields specified.
>  - Masked the lower bits of window size in case override the
>    control bits.
>  - Check if the passing window number is available, instead of
>    the total number of the initialized windows.
>  - And added the statistic of initialized inbound windows.
>
> Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host
> Bridge IP driver")
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> ---
> V3:
>  - No change
>
>  drivers/pci/controller/pcie-mobiveil.c | 70 +++++++++++++++-----------
>  1 file changed, 42 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
> index e88afc792a5c..4ba458474e42 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -65,9 +65,13 @@
>  #define PAB_AXI_AMAP_CTRL(win)         PAB_REG_ADDR(0x0ba0, win)
>  #define  WIN_ENABLE_SHIFT              0
>  #define  WIN_TYPE_SHIFT                        1
> +#define  WIN_TYPE_MASK                 0x3
> +#define  WIN_SIZE_SHIFT                        10
> +#define  WIN_SIZE_MASK                 0x3fffff
>
>  #define PAB_EXT_AXI_AMAP_SIZE(win)     PAB_EXT_REG_ADDR(0xbaf0, win)
>
> +#define PAB_EXT_AXI_AMAP_AXI_WIN(win)  PAB_EXT_REG_ADDR(0x80a0, win)
>  #define PAB_AXI_AMAP_AXI_WIN(win)      PAB_REG_ADDR(0x0ba4, win)
>  #define  AXI_WINDOW_ALIGN_MASK         3
>
> @@ -82,8 +86,10 @@
>  #define PAB_PEX_AMAP_CTRL(win)         PAB_REG_ADDR(0x4ba0, win)
>  #define  AMAP_CTRL_EN_SHIFT            0
>  #define  AMAP_CTRL_TYPE_SHIFT          1
> +#define  AMAP_CTRL_TYPE_MASK           3
>
>  #define PAB_EXT_PEX_AMAP_SIZEN(win)    PAB_EXT_REG_ADDR(0xbef0, win)
> +#define PAB_EXT_PEX_AMAP_AXI_WIN(win)  PAB_EXT_REG_ADDR(0xb4a0, win)
>  #define PAB_PEX_AMAP_AXI_WIN(win)      PAB_REG_ADDR(0x4ba4, win)
>  #define PAB_PEX_AMAP_PEX_WIN_L(win)    PAB_REG_ADDR(0x4ba8, win)
>  #define PAB_PEX_AMAP_PEX_WIN_H(win)    PAB_REG_ADDR(0x4bac, win)
> @@ -455,49 +461,51 @@ static int mobiveil_pcie_parse_dt(struct mobiveil_pcie *pcie)
>  }
>
>  static void program_ib_windows(struct mobiveil_pcie *pcie, int win_num,
> -                              int pci_addr, u32 type, u64 size)
> +                              u64 cpu_addr, u64 pci_addr, u32 type, u64 size)
>  {
> -       int pio_ctrl_val;
> -       int amap_ctrl_dw;
> +       u32 value;
>         u64 size64 = ~(size - 1);
>
> -       if ((pcie->ib_wins_configured + 1) > pcie->ppio_wins) {
> +       if (win_num >= pcie->ppio_wins) {
>                 dev_err(&pcie->pdev->dev,
>                         "ERROR: max inbound windows reached !\n");
>                 return;
>         }
>
> -       pio_ctrl_val = csr_readl(pcie, PAB_PEX_PIO_CTRL);
> -       pio_ctrl_val |= 1 << PIO_ENABLE_SHIFT;
> -       csr_writel(pcie, pio_ctrl_val, PAB_PEX_PIO_CTRL);
> -
> -       amap_ctrl_dw = csr_readl(pcie, PAB_PEX_AMAP_CTRL(win_num));
> -       amap_ctrl_dw |= (type << AMAP_CTRL_TYPE_SHIFT) |
> -                       (1 << AMAP_CTRL_EN_SHIFT) |
> -                       lower_32_bits(size64);
> -       csr_writel(pcie, amap_ctrl_dw, PAB_PEX_AMAP_CTRL(win_num));
> +       value = csr_readl(pcie, PAB_PEX_AMAP_CTRL(win_num));
> +       value &= ~(AMAP_CTRL_TYPE_MASK << AMAP_CTRL_TYPE_SHIFT |
> +                WIN_SIZE_MASK << WIN_SIZE_SHIFT);
> +       value |= (type << AMAP_CTRL_TYPE_SHIFT) | (1 << AMAP_CTRL_EN_SHIFT) |
> +                (lower_32_bits(size64) & WIN_SIZE_MASK << WIN_SIZE_SHIFT);
> +       csr_writel(pcie, value, PAB_PEX_AMAP_CTRL(win_num));
>
>         csr_writel(pcie, upper_32_bits(size64),
>                    PAB_EXT_PEX_AMAP_SIZEN(win_num));
>
> -       csr_writel(pcie, pci_addr, PAB_PEX_AMAP_AXI_WIN(win_num));
> +       csr_writel(pcie, lower_32_bits(cpu_addr),
> +                  PAB_PEX_AMAP_AXI_WIN(win_num));
> +       csr_writel(pcie, upper_32_bits(cpu_addr),
> +                  PAB_EXT_PEX_AMAP_AXI_WIN(win_num));
> +
> +       csr_writel(pcie, lower_32_bits(pci_addr),
> +                  PAB_PEX_AMAP_PEX_WIN_L(win_num));
> +       csr_writel(pcie, upper_32_bits(pci_addr),
> +                  PAB_PEX_AMAP_PEX_WIN_H(win_num));
>
> -       csr_writel(pcie, pci_addr, PAB_PEX_AMAP_PEX_WIN_L(win_num));
> -       csr_writel(pcie, 0, PAB_PEX_AMAP_PEX_WIN_H(win_num));
> +       pcie->ib_wins_configured++;
>  }
>
>  /*
>   * routine to program the outbound windows
>   */
>  static void program_ob_windows(struct mobiveil_pcie *pcie, int win_num,
> -                              u64 cpu_addr, u64 pci_addr,
> -                              u32 config_io_bit, u64 size)
> +                              u64 cpu_addr, u64 pci_addr, u32 type, u64 size)
>  {
>
> -       u32 value, type;
> +       u32 value;
>         u64 size64 = ~(size - 1);
>
> -       if ((pcie->ob_wins_configured + 1) > pcie->apio_wins) {
> +       if (win_num >= pcie->apio_wins) {
>                 dev_err(&pcie->pdev->dev,
>                         "ERROR: max outbound windows reached !\n");
>                 return;
> @@ -507,10 +515,12 @@ static void program_ob_windows(struct mobiveil_pcie *pcie, int win_num,
>          * program Enable Bit to 1, Type Bit to (00) base 2, AXI Window Size Bit
>          * to 4 KB in PAB_AXI_AMAP_CTRL register
>          */
> -       type = config_io_bit;
>         value = csr_readl(pcie, PAB_AXI_AMAP_CTRL(win_num));
> -       csr_writel(pcie, 1 << WIN_ENABLE_SHIFT | type << WIN_TYPE_SHIFT |
> -                  lower_32_bits(size64), PAB_AXI_AMAP_CTRL(win_num));
> +       value &= ~(WIN_TYPE_MASK << WIN_TYPE_SHIFT |
> +                WIN_SIZE_MASK << WIN_SIZE_SHIFT);
> +       value |= 1 << WIN_ENABLE_SHIFT | type << WIN_TYPE_SHIFT |
> +                (lower_32_bits(size64) & WIN_SIZE_MASK << WIN_SIZE_SHIFT);
> +       csr_writel(pcie, value, PAB_AXI_AMAP_CTRL(win_num));
>
>         csr_writel(pcie, upper_32_bits(size64), PAB_EXT_AXI_AMAP_SIZE(win_num));
>
> @@ -518,11 +528,10 @@ static void program_ob_windows(struct mobiveil_pcie *pcie, int win_num,
>          * program AXI window base with appropriate value in
>          * PAB_AXI_AMAP_AXI_WIN0 register
>          */
> -       value = csr_readl(pcie, PAB_AXI_AMAP_AXI_WIN(win_num));
> -       csr_writel(pcie, cpu_addr & (~AXI_WINDOW_ALIGN_MASK),
> +       csr_writel(pcie, lower_32_bits(cpu_addr) & (~AXI_WINDOW_ALIGN_MASK),
>                    PAB_AXI_AMAP_AXI_WIN(win_num));
> -
> -       value = csr_readl(pcie, PAB_AXI_AMAP_PEX_WIN_H(win_num));
> +       csr_writel(pcie, upper_32_bits(cpu_addr),
> +                  PAB_EXT_AXI_AMAP_AXI_WIN(win_num));
>
>         csr_writel(pcie, lower_32_bits(pci_addr),
>                    PAB_AXI_AMAP_PEX_WIN_L(win_num));
> @@ -604,6 +613,11 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
>         value |= APIO_EN_MASK;
>         csr_writel(pcie, value, PAB_AXI_PIO_CTRL);
>
> +       /* Enable PCIe PIO master */
> +       value = csr_readl(pcie, PAB_PEX_PIO_CTRL);
> +       value |= 1 << PIO_ENABLE_SHIFT;
> +       csr_writel(pcie, value, PAB_PEX_PIO_CTRL);
> +
>         /*
>          * we'll program one outbound window for config reads and
>          * another default inbound window for all the upstream traffic
> @@ -616,7 +630,7 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
>                            CFG_WINDOW_TYPE, resource_size(pcie->ob_io_res));
>
>         /* memory inbound translation window */
> -       program_ib_windows(pcie, WIN_NUM_0, 0, MEM_WINDOW_TYPE, IB_WIN_SIZE);
> +       program_ib_windows(pcie, WIN_NUM_0, 0, 0, MEM_WINDOW_TYPE, IB_WIN_SIZE);
>
>         /* Get the I/O and memory ranges from DT */
>         resource_list_for_each_entry(win, &pcie->resources) {
> --
> 2.17.1
>
