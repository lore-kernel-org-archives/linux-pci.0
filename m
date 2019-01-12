Return-Path: <SRS0=29+c=PU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A2FC43387
	for <linux-pci@archiver.kernel.org>; Sat, 12 Jan 2019 21:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A00D2084C
	for <linux-pci@archiver.kernel.org>; Sat, 12 Jan 2019 21:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s8yimM9i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbfALV3B (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 12 Jan 2019 16:29:01 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39691 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfALV3B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 12 Jan 2019 16:29:01 -0500
Received: by mail-wm1-f66.google.com with SMTP id y8so5430008wmi.4;
        Sat, 12 Jan 2019 13:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ooKEQ4ZeSh9S8Oavvq32L6+q3A5n2i2/6WZctBkb0Vs=;
        b=s8yimM9iVaz9pdAISG/qdcdXUnl152PHsRguhegzVx/n7QqqLn3Ni0XG7gJG+eaPNL
         pRUISQ8+BbZ+MRgmm1Eoku9DfwPE3gsnYvUNCYBGaFKffv9ojaHDEwFbg9UvZSg8rXis
         +vkh11IaftcqHLDdq/ZaC+jyKb6SLK7o2VaLSdGCcanbl8oN8yDnUvr9lbISSCwD0gI5
         lc0bxZiVaZUfhPTkpf2cAt58v48Ggn53lPuf0D6WitTIavN6Jugd2Gjsh/L5pCPCh62j
         YFIOVfECz4xZ3yTqAxK/MglYwJ99Vz86P+yGTZx2T4O4Nd2AQM1gI82jTR/Ssd8WLHqG
         Jy0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ooKEQ4ZeSh9S8Oavvq32L6+q3A5n2i2/6WZctBkb0Vs=;
        b=nopGWLAVH3f//ze5mKQgK55+KWzPIst7YyNWHH7LleLQASy70HAKxiRoLN9CQDcfx8
         zk2Dm9YeOqna9ejuN+X3+vDLpm2oBX3zUs3aTonb8hBxwXyS+ki1/PvX2OT289DCz3s5
         WrMWHRM8fmaage0XnVoqr/pltXEhwJ9x+UyvmXw2EgOZ++F6FGo0HnD7anpXixX8eY0+
         PeGypQ6BgqguKOiMpruK5tuhmrgZJo2oPb247BXx+hFy+5VbO8CbsIoKx/eiTRXonqj7
         peBcSvv7+Qb76jE1ZNz4TOZ4r+rofFKSieyPkf9bo6roVGmm56lFbcjVv5Zk/4WqUecW
         qzKg==
X-Gm-Message-State: AJcUukcmHSQuaCZJBd1hckHu/PJ6DXndMRQlxFpMZHXM4ilr3QjudwBR
        JuLHs77lqGBfbSC6Mhn/blvWVsXMZwxgjnWX1Ho=
X-Google-Smtp-Source: ALg8bN7L73/bJgLbupcaiTT+puhQnterhUD7PlF4Bo413G1C/ACmTJmdJXT4aLbtaKGksYdrGuTX8PbjTxxI17fJZbY=
X-Received: by 2002:a1c:f605:: with SMTP id w5mr6983677wmc.116.1547328538576;
 Sat, 12 Jan 2019 13:28:58 -0800 (PST)
MIME-Version: 1.0
References: <20190104165335.13205-1-andrew.smirnov@gmail.com>
 <20190104165335.13205-5-andrew.smirnov@gmail.com> <20190111195302.GA18985@bogus>
In-Reply-To: <20190111195302.GA18985@bogus>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Sat, 12 Jan 2019 13:28:47 -0800
Message-ID: <CAHQ1cqHO=aw0AoLCrO+r7uCG5tE=Ai9or+UAOM3MJ1Cu-fCZ-w@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] PCI: imx6: Add support for i.MX8MQ
To:     Rob Herring <robh@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 11, 2019 at 11:53 AM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Jan 04, 2019 at 08:53:35AM -0800, Andrey Smirnov wrote:
> > Add code needed to support i.MX8MQ variant.
> >
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > Cc: Chris Healy <cphealy@gmail.com>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: Leonard Crestez <leonard.crestez@nxp.com>
> > Cc: "A.s. Dong" <aisheng.dong@nxp.com>
> > Cc: Richard Zhu <hongxing.zhu@nxp.com>
> > Cc: Rob Herring <robh@kernel.org>,
> > Cc: devicetree@vger.kernel.org,
> > Cc: linux-imx@nxp.com
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-pci@vger.kernel.org
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > ---
> >  .../bindings/pci/fsl,imx6q-pcie.txt           |  3 +-
> >  drivers/pci/controller/dwc/Kconfig            |  4 +-
> >  drivers/pci/controller/dwc/pci-imx6.c         | 77 ++++++++++++++++++-
> >  3 files changed, 79 insertions(+), 5 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> > index d514c1f2365f..920ca93870a8 100644
> > --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> > +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> > @@ -9,6 +9,7 @@ Required properties:
> >       - "fsl,imx6sx-pcie",
> >       - "fsl,imx6qp-pcie"
> >       - "fsl,imx7d-pcie"
> > +     - "fsl,imx8mq-pcie"
> >  - reg: base address and length of the PCIe controller
> >  - interrupts: A list of interrupt outputs of the controller. Must contain an
> >    entry for each entry in the interrupt-names property.
> > @@ -45,7 +46,7 @@ Additional required properties for imx6sx-pcie:
> >    PCIE_PHY power domains
> >  - power-domain-names: Must be "pcie", "pcie_phy"
> >
> > -Additional required properties for imx7d-pcie:
> > +Additional required properties for imx7d-pcie and imx8mq-pcie:
> >  - power-domains: Must be set to a phandle pointing to PCIE_PHY power domain
> >  - resets: Must contain phandles to PCIe-related reset lines exposed by SRC
> >    IP block
> > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> > index 6aafec3fad00..83ea318ad989 100644
> > --- a/drivers/pci/controller/dwc/Kconfig
> > +++ b/drivers/pci/controller/dwc/Kconfig
> > @@ -89,8 +89,8 @@ config PCI_EXYNOS
> >       select PCIE_DW_HOST
> >
> >  config PCI_IMX6
> > -     bool "Freescale i.MX6/7 PCIe controller"
> > -     depends on SOC_IMX6Q || SOC_IMX7D || (ARM && COMPILE_TEST)
> > +     bool "Freescale i.MX6/7/8 PCIe controller"
> > +     depends on SOC_IMX6Q || SOC_IMX7D || (ARM64 && ARCH_MXC) || ((ARM || ARM64) && COMPILE_TEST)
>
> Since you added the ifdef around the abort handler, I think you can drop
> "(ARM || ARM64)" and enable building other arches.
>

OK, makes sense. I'll give it a go in v5.

Thanks,
Andrey Smirnov
