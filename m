Return-Path: <SRS0=vmzI=QL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94960C282C4
	for <linux-pci@archiver.kernel.org>; Mon,  4 Feb 2019 16:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 593FB20815
	for <linux-pci@archiver.kernel.org>; Mon,  4 Feb 2019 16:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mobiveil.co.in header.i=@mobiveil.co.in header.b="JsrHP1Nv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbfBDQvS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 4 Feb 2019 11:51:18 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:54496 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728886AbfBDQvS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Feb 2019 11:51:18 -0500
Received: by mail-wm1-f46.google.com with SMTP id a62so594589wmh.4
        for <linux-pci@vger.kernel.org>; Mon, 04 Feb 2019 08:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mobiveil.co.in; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X+d6h2hPheL1wABUYomV4RG/k4ucsF58Nr90D8kQKXY=;
        b=JsrHP1Nv55hfPbWXTiHNYGANohhmQNezM47Gek0gnHqxKcYvOTNlGM4ZZ38I13w0R3
         JNGFBG1rWg1m8OrXfpxTuJ4Kg7CcYsSTvdEjlBGhWI3yNAebNPiuQUd+r5q25krXt10t
         /3B5bUQY29RrClicTd64FkvNd7qJj41gTl8nY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X+d6h2hPheL1wABUYomV4RG/k4ucsF58Nr90D8kQKXY=;
        b=DgNpbSWTv9DousvH0i08ATdpoYWGX+DC/8EojvhZ4yQZX+k2Do+BJ2HFSWqV7tsgL6
         Ouoy5w8M4LVyz14Ido/n9vzZuQqj/LaZ9UrS1/OXsTYDWULK1/+DOOSeV8QbQjKHJerv
         8exj1KbX62Wp0mbAbymQaNF02BIEAmmADilCxgUNjFaAyw/fIApDefExrbm1ZLfRTNGg
         M8/tewTUIc4u5biHlLa37UaYYp/dSDTszC94xbyy0imajpLUe715k2etiKuNrMLiMnHG
         Ja2sDpQx/J2imNplgxe32T1WbXjIghlogpCIIVX+ymncIXkFk2fPEHzvPgJs9OnemI/A
         dc1A==
X-Gm-Message-State: AHQUAuaGhF274UhkN0CscLl33hTw5MvEw1EaMh6ph7svjvX3e6LKyu4V
        8ubVG9h9CSBsrcgVrNXl+8w3yylwwONjIEohrU6UfO0xQZE=
X-Google-Smtp-Source: AHgI3IamC1rQ8M8KColegEMFaDRwnU7HU25unHdW7ghPmgbofYZpEGZsq8R+PYKRnBwdkc/C0lV7gaAg3jOBGKMezyI=
X-Received: by 2002:a1c:b455:: with SMTP id d82mr265418wmf.78.1549299075096;
 Mon, 04 Feb 2019 08:51:15 -0800 (PST)
MIME-Version: 1.0
References: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com> <20190129113910.GA7467@e107981-ln.cambridge.arm.com>
 <CAFZiPx002HED+YH2GysS7a7uoEDQuHGjxa_CQtwb9nSDH-XNuA@mail.gmail.com> <20190204161303.GA18220@red-moon>
In-Reply-To: <20190204161303.GA18220@red-moon>
From:   Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date:   Mon, 4 Feb 2019 22:21:04 +0530
Message-ID: <CAFZiPx3DTCgRtSehsQKOAfZoSpBgyU-JZXwVhmDvWesefW-32w@mail.gmail.com>
Subject: Re: [PATCHv3 00/27] PCI: refactor Mobiveil driver and add PCIe Gen4
 driver for NXP Layerscape SoCs
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     "Z.q. Hou" <zhiqiang.hou@nxp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
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

Lorenzo,
My apologies again,

I have started looking into these.

Thanks,




On Mon, Feb 4, 2019 at 9:43 PM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Mon, Feb 04, 2019 at 07:44:25PM +0530, Subrahmanya Lingappa wrote:
> >    Bjorn,
> >    My apologies, I was away for a while from this work.
> >    I am starting to review now.
>
> Hi,
>
> I am not Bjorn and as I told you before you should not reply
> with html context (ie use plain text, the public lists will
> reject your emails otherwise) and top-post.
>
> You are supposed to maintain this code, if you can't it is fine but I
> should know because there are developers who are waiting for your
> review, please understand.
>
> Thanks,
> Lorenzo
>
> >    Thanks,
> >    ~subbu
> >    On Tue, Jan 29, 2019 at 5:09 PM Lorenzo Pieralisi
> >    <lorenzo.pieralisi@arm.com> wrote:
> >
> >      On Tue, Jan 29, 2019 at 08:08:28AM +0000, Z.q. Hou wrote:
> >      > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> >      >
> >      > This patch set is aim to refactor the Mobiveil driver and add
> >      > PCIe support for NXP Layerscape series SoCs integrated Mobiveil's
> >      > PCIe Gen4 controller.
> >      >
> >      > Hou Zhiqiang (27):
> >      >   PCI: mobiveil: uniform the register accessors
> >      >   PCI: mobiveil: format the code without function change
> >      >   PCI: mobiveil: correct the returned error number
> >      >   PCI: mobiveil: remove flag MSI_FLAG_MULTI_PCI_MSI
> >      >   PCI: mobiveil: correct PCI base address in MEM/IO outbound windows
> >      >   PCI: mobiveil: replace the resource list iteration function
> >      >   PCI: mobiveil: use WIN_NUM_0 explicitly for CFG outbound window
> >      >   PCI: mobiveil: use the 1st inbound window for MEM inbound
> >      transactions
> >      >   PCI: mobiveil: correct inbound/outbound window setup routines
> >      >   PCI: mobiveil: fix the INTx process error
> >      >   PCI: mobiveil: only fix up the Class Code field
> >      >   PCI: mobiveil: move out the link up waiting from mobiveil_host_init
> >      >   PCI: mobiveil: move irq chained handler setup out of DT parse
> >      >   PCI: mobiveil: initialize Primary/Secondary/Subordinate bus number
> >      >   dt-bindings: pci: mobiveil: change gpio_slave and apb_csr to
> >      optional
> >      >   PCI: mobiveil: refactor Mobiveil PCIe Host Bridge IP driver
> >      >   PCI: mobiveil: fix the checking of valid device
> >      >   PCI: mobiveil: continue to initialize the host upon no PCIe link
> >      >   PCI: mobiveil: disabled IB and OB windows set by bootloader
> >      >   PCI: mobiveil: add Byte and Half-Word width register accessors
> >      >   PCI: mobiveil: make mobiveil_host_init can be used to re-init host
> >      >   dt-bindings: pci: Add NXP Layerscape SoCs PCIe Gen4 controller
> >      >   PCI: mobiveil: add PCIe Gen4 RC driver for NXP Layerscape SoCs
> >      >   PCI: mobiveil: ls_pcie_g4: add Workaround for A-011577
> >      >   PCI: mobiveil: ls_pcie_g4: add Workaround for A-011451
> >      >   arm64: dts: freescale: lx2160a: add pcie DT nodes
> >      >   arm64: defconfig: Enable CONFIG_PCI_LAYERSCAPE_GEN4
> >
> >      Subrahmanya,
> >
> >      Either you review this series or I will have to drop you from
> >      the MAINTAINERS list for this driver, I am sorry but I asked you
> >      before to no avail.
> >
> >      Thanks,
> >      Lorenzo
> >
> >      >  .../bindings/pci/layerscape-pci-gen4.txt      |  52 ++
> >      >  .../devicetree/bindings/pci/mobiveil-pcie.txt |   2 +
> >      >  MAINTAINERS                                   |  10 +-
> >      >  .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 163 ++++
> >      >  arch/arm64/configs/defconfig                  |   1 +
> >      >  drivers/pci/controller/Kconfig                |  11 +-
> >      >  drivers/pci/controller/Makefile               |   2 +-
> >      >  drivers/pci/controller/mobiveil/Kconfig       |  34 +
> >      >  drivers/pci/controller/mobiveil/Makefile      |   5 +
> >      >  .../controller/mobiveil/pci-layerscape-gen4.c | 306 +++++++
> >      >  .../controller/mobiveil/pcie-mobiveil-host.c  | 640 +++++++++++++
> >      >  .../controller/mobiveil/pcie-mobiveil-plat.c  |  54 ++
> >      >  .../pci/controller/mobiveil/pcie-mobiveil.c   | 246 +++++
> >      >  .../pci/controller/mobiveil/pcie-mobiveil.h   | 229 +++++
> >      >  drivers/pci/controller/pcie-mobiveil.c        | 861
> >      ------------------
> >      >  15 files changed, 1743 insertions(+), 873 deletions(-)
> >      >  create mode 100644
> >      Documentation/devicetree/bindings/pci/layerscape-pci-gen4.txt
> >      >  create mode 100644 drivers/pci/controller/mobiveil/Kconfig
> >      >  create mode 100644 drivers/pci/controller/mobiveil/Makefile
> >      >  create mode 100644
> >      drivers/pci/controller/mobiveil/pci-layerscape-gen4.c
> >      >  create mode 100644
> >      drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> >      >  create mode 100644
> >      drivers/pci/controller/mobiveil/pcie-mobiveil-plat.c
> >      >  create mode 100644 drivers/pci/controller/mobiveil/pcie-mobiveil.c
> >      >  create mode 100644 drivers/pci/controller/mobiveil/pcie-mobiveil.h
> >      >  delete mode 100644 drivers/pci/controller/pcie-mobiveil.c
> >      >
> >      > --
> >      > 2.17.1
> >      >
