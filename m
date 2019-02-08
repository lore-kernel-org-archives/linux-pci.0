Return-Path: <SRS0=vzDi=QP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34471C169C4
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 12:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02F572086C
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 12:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mobiveil.co.in header.i=@mobiveil.co.in header.b="0k9WPPCK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbfBHMul (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 8 Feb 2019 07:50:41 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45183 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbfBHMul (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Feb 2019 07:50:41 -0500
Received: by mail-wr1-f68.google.com with SMTP id q15so3392825wro.12
        for <linux-pci@vger.kernel.org>; Fri, 08 Feb 2019 04:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mobiveil.co.in; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qnHdX7TnXOEiHXHYVasMmzva4CaTpXguv8jLldqZ/zM=;
        b=0k9WPPCKKItYXzndcogdzxnVoO9cQlpjEn2qq4gxRc/FV272WdMDa/HugcL9upD7P6
         t8xXnl6q1RTUo5498d+qetP/xj0gz+rlcUWUhDBPM2JNl47QC+KxFSUeH4b9wHJX+A4E
         dK7tUg9ny3O1jwPkgEAHETOzII/BJLVdDNXV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qnHdX7TnXOEiHXHYVasMmzva4CaTpXguv8jLldqZ/zM=;
        b=T+8tPwZmDx5JzJsLX9b1v0lX5K5sAK2CGhVglkil/Ml5hY1Ap4HSzZR31fqufG3ip6
         jksdqxD3OJPT7kjXn28rD4nCzuDDKn8LyyZBQo4xzVa74R6eTjyO2DADczfL9mN1yIvk
         Fb8GJR4+derQqlvkSyAxcjGBu0wSwBvFbynROqIa5qII0ZYf2itWVzldI+U+Q0FQL9IG
         lDxcQuCT97BVQ9n63Xss1n9w0bZVu0pCcZ+oISLTap+gNlaEbUgOn/Er2bLbV6zD0t9v
         rdRe7T/zqlrYlqoI82T9CA4fhGV+IjicslrE9rJud3zrzp2BWl6x+7OehR4iCXlP0i0D
         P73A==
X-Gm-Message-State: AHQUAubK/qmwHZZESd1KWLIhY/gmVfXW+sT1cIsIuQ4JA1i9LI/ZJmiI
        3lR5fZ5uFG4jAbEk+K4V4oUK5BR81d8eXRoFZjHsJw==
X-Google-Smtp-Source: AHgI3IYkO1gBaw8j2seTdh1YGRiQzYKKQql6G6YxqXpzAf/hB9zHkLibVQpTzUvEP9Z7w1HZvDqzA1aD42q9jVaM4Ms=
X-Received: by 2002:adf:fd81:: with SMTP id d1mr16559738wrr.105.1549630239150;
 Fri, 08 Feb 2019 04:50:39 -0800 (PST)
MIME-Version: 1.0
References: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com> <20190129080926.36773-26-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190129080926.36773-26-Zhiqiang.Hou@nxp.com>
From:   Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date:   Fri, 8 Feb 2019 18:23:18 +0530
Message-ID: <CAFZiPx24PEE6LnUaY5MiQ_QDLbwkF-BvWe8s9ycUDVH-dN2_xg@mail.gmail.com>
Subject: Re: [PATCHv3 25/27] PCI: mobiveil: ls_pcie_g4: add Workaround for A-011451
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

On Tue, Jan 29, 2019 at 1:41 PM Z.q. Hou <zhiqiang.hou@nxp.com> wrote:
>
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>
> When LX2 PCIe controller is sending multiple split completions and
> ACK latency expires indicating that ACK should be send at priority.
> But because of large number of split completions and FC update DLLP,
> the controller does not give priority to ACK transmission. This
> results into ACK latency timer timeout error at the link partner and
> the pending TLPs are replayed by the link partner again.
>
> Workaround:
> 1. Reduce the ACK latency timeout value to a very small value.
> 2. Restrict the number of completions from the LX2 PCIe controller
>    to 1, by changing the Max Read Request Size (MRRS) of link partner
>    to the same value as Max Packet size (MPS).
>
> This patch implemented part 1, the part 2 can be set by kernel parameter
> 'pci=pcie_bus_perf'
>
> This ERRATA is only for LX2160A Rev1.0, and it will be fixed
> in Rev2.0.
>
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V3:
>  - Integrated without change from http://patchwork.ozlabs.org/patch/1006796/
>
>  .../pci/controller/mobiveil/pci-layerscape-gen4.c | 15 +++++++++++++++
>  drivers/pci/controller/mobiveil/pcie-mobiveil.h   |  4 ++++
>  2 files changed, 19 insertions(+)
>
> diff --git a/drivers/pci/controller/mobiveil/pci-layerscape-gen4.c b/drivers/pci/controller/mobiveil/pci-layerscape-gen4.c
> index d2c5dbbd5e3c..20ce146788ca 100644
> --- a/drivers/pci/controller/mobiveil/pci-layerscape-gen4.c
> +++ b/drivers/pci/controller/mobiveil/pci-layerscape-gen4.c
> @@ -82,12 +82,27 @@ static bool ls_pcie_g4_is_bridge(struct ls_pcie_g4 *pcie)
>         return header_type == PCI_HEADER_TYPE_BRIDGE;
>  }
>
> +static void workaround_A011451(struct ls_pcie_g4 *pcie)
> +{
> +       struct mobiveil_pcie *mv_pci = pcie->pci;
> +       u32 val;
> +
> +       /* Set ACK latency timeout */
> +       val = csr_readl(mv_pci, GPEX_ACK_REPLAY_TO);
> +       val &= ~(ACK_LAT_TO_VAL_MASK << ACK_LAT_TO_VAL_SHIFT);
> +       val |= (4 << ACK_LAT_TO_VAL_SHIFT);
> +       csr_writel(mv_pci, val, GPEX_ACK_REPLAY_TO);
> +}
> +
>  static int ls_pcie_g4_host_init(struct mobiveil_pcie *pci)
>  {
>         struct ls_pcie_g4 *pcie = to_ls_pcie_g4(pci);
>
>         pcie->rev = csr_readb(pci, PCI_REVISION_ID);
>
> +       if (pcie->rev == REV_1_0)
> +               workaround_A011451(pcie);
> +
>         return 0;
>  }
>
> diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.h b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> index ab43de5e4b2b..f0e2e4ae09b5 100644
> --- a/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> @@ -85,6 +85,10 @@
>  #define PAB_AXI_AMAP_PEX_WIN_H(win)    PAB_REG_ADDR(0x0bac, win)
>  #define PAB_INTP_AXI_PIO_CLASS         0x474
>
> +#define GPEX_ACK_REPLAY_TO             0x438
> +#define  ACK_LAT_TO_VAL_MASK           0x1fff
> +#define  ACK_LAT_TO_VAL_SHIFT          0
> +
>  #define PAB_PEX_AMAP_CTRL(win)         PAB_REG_ADDR(0x4ba0, win)
>  #define  AMAP_CTRL_EN_SHIFT            0
>  #define  AMAP_CTRL_TYPE_SHIFT          1
> --
> 2.17.1
>
again, can we avoid errata number on patch title and have a brief title instead?
