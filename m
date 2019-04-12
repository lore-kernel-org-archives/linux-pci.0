Return-Path: <SRS0=vi1x=SO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7327BC10F0E
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 14:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 499CF2084D
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 14:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfDLOji (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Apr 2019 10:39:38 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39664 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbfDLOjf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Apr 2019 10:39:35 -0400
Received: by mail-qt1-f193.google.com with SMTP id t28so11457446qte.6;
        Fri, 12 Apr 2019 07:39:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BXbeXUrjBjLrWlL0TmLgzo3uh8ojGyU8TTFaDmZ16kk=;
        b=Sn1t/7K4jJGZGLf0mmEZHzMpyPllARc5qskuEOjKGV0yWzrjnNVzLk+k4RtWsSB/hr
         hN9MV0gmBLEsxRBUaThqRWhcs1FfmHpXffeE+WjPsq/4oZMoThSGMLbBYI8ACZyXPQTu
         FBSOj07PDrCM/OyagyPaovxL+EcPkMKlqyRvSo9TUGIULlntXdo2vOM63ktoF8sN9SSW
         RZBgiAgSgZp72+ytoByMAqON2y8ek7AAHFvhiEGTtCe53tXEXK1vsKRlp8ZDW7GKpewJ
         0Nzc+HrXQzK9ELoNtRSz7MsvW8/5R74HuIq0pxAP63waxNlKPv4KF6KQznFPYzZMSF74
         NSOQ==
X-Gm-Message-State: APjAAAV/aHI0Au3R0ps9r/zuP+nhWtB4aONZ3Lf8QsDstVehiX/aEdIM
        t4vf/ngZSPP+0vcusPDwphsq268YrfUtIW0C9uw=
X-Google-Smtp-Source: APXvYqx9IYTaBvuX1Bh7kyA4+Z1jvyCRS7F/0S92m/uaEM5tBGwZ2komykL6tgsBY/XTkm8WLrk7G6ORo59ap3GwaVg=
X-Received: by 2002:ac8:276b:: with SMTP id h40mr48268242qth.319.1555079973925;
 Fri, 12 Apr 2019 07:39:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190412095332.41370-1-Zhiqiang.Hou@nxp.com> <20190412095332.41370-2-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190412095332.41370-2-Zhiqiang.Hou@nxp.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 12 Apr 2019 16:39:16 +0200
Message-ID: <CAK8P3a38F=y92ECU-iB-D=OqmuY5ANAwDw2NDPOTFmhUZQTovA@mail.gmail.com>
Subject: Re: [PATCHv5 1/6] PCI: mobiveil: Refactor Mobiveil PCIe Host Bridge
 IP driver
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 12, 2019 at 11:53 AM Z.q. Hou <zhiqiang.hou@nxp.com> wrote:

> +int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie)
>  {
> -       struct mobiveil_pcie *pcie;
>         struct pci_bus *bus;
>         struct pci_bus *child;
>         struct pci_host_bridge *bridge;
> -       struct device *dev = &pdev->dev;
> +       struct device *dev = &pcie->pdev->dev;
>         resource_size_t iobase;
>         int ret;
>
> -       /* allocate the PCIe port */
> -       bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
> -       if (!bridge)
> -               return -ENOMEM;
> -
> -       pcie = pci_host_bridge_priv(bridge);
> -
> -       pcie->pdev = pdev;
> +       INIT_LIST_HEAD(&pcie->resources);
>
>         ret = mobiveil_pcie_parse_dt(pcie);
>         if (ret) {
> @@ -928,7 +560,10 @@ static int mobiveil_pcie_probe(struct platform_device *pdev)
>                 return ret;
>         }
>
> -       INIT_LIST_HEAD(&pcie->resources);
> +       /* allocate the PCIe port */
> +       bridge = devm_pci_alloc_host_bridge(dev, 0);
> +       if (!bridge)
> +               return -ENOMEM;
>

> +static int mobiveil_pcie_probe(struct platform_device *pdev)
> +{
> +       struct mobiveil_pcie *pcie;
> +       struct device *dev = &pdev->dev;
> +
> +       pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> +       if (!pcie)
> +               return -ENOMEM;
> +
> +       pcie->pdev = pdev;
> +
> +       return mobiveil_pcie_host_probe(pcie);
> +}

I think you need to pull the allocation of the host structure out into the
main driver here, to keep both allocations together, otherwise the
release function will free the mobiveil_pcie structure before freeing
the pci_host_bridge if that is still in use.

> +
> +struct mobiveil_pcie {
> +       struct platform_device *pdev;
> +       struct list_head resources;

These two should not be needed here, as they are already part
of the pci_host_bridge structure.

     Arnd
