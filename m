Return-Path: <SRS0=ZQO4=QM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115E5C282CB
	for <linux-pci@archiver.kernel.org>; Tue,  5 Feb 2019 05:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBFF42081B
	for <linux-pci@archiver.kernel.org>; Tue,  5 Feb 2019 05:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mobiveil.co.in header.i=@mobiveil.co.in header.b="E+UDUSp/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbfBEFuq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 5 Feb 2019 00:50:46 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36060 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbfBEFup (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Feb 2019 00:50:45 -0500
Received: by mail-wr1-f67.google.com with SMTP id z3so2281011wrv.3
        for <linux-pci@vger.kernel.org>; Mon, 04 Feb 2019 21:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mobiveil.co.in; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DGP7CYkwt8gajGxukPC10TzFSfh8YkD3ft+233LUnPc=;
        b=E+UDUSp/GyYiWB43ftq1KJ9tO71GKLpyU+hJeJ3PcAFENA0vlGACg92Eb8fAZTbKx8
         cQnTD+MUm6PGEWDUOIPsK0hojZqxaecuK3/N7LjjbkcNPfOYzlP7NJfkzzYQka/3h8rv
         Hwid220rMqd32SgWUa9Zu1JZWqHyAwieojzx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DGP7CYkwt8gajGxukPC10TzFSfh8YkD3ft+233LUnPc=;
        b=TD4NVrrAXm2lcLDEwEielwdGqM9WCc5dRVwKLWPj0Y3lky7nYV/hGMi0hbKSMU9Vj1
         VbMzDKkGWcwF12jsxtaShaSKH4yH7Bms0hS3IBkQC8ZU+zAoq222t6t8E8/kI0hcyoVe
         IVk8kCcb7qCK931VElhYV64BpQxobG4NpH/npCroLZlJ4d1GMcl74apZp7JBpVtedVGN
         XZRrWORs9BvrHhqslez63G4b9iw7sHiHon5kSL+JJaD7Kp+BaK77DqKOKTKJ1IVaGgUY
         NXy38l9NvNqSk4BXgkL24y9XqwWbZa3Y+TuAP32EoQeholvlI7ZKoX7N6Ra2hfmD8RmL
         1lwQ==
X-Gm-Message-State: AHQUAubma1SbDnOGeP586qKXF/AVzGX42e0SQr1HyBr/VY79NFjdLv0f
        M1JNxo+nuExMqJkNMlBEvgRYupdso+sMwxM0VAFOMA==
X-Google-Smtp-Source: AHgI3IZ9lcUK/himpXBmGtHLRnUU/pMEVpRnfCRfaNkF03EF1nUqC0gZHNkj/MWPyz652Z64RDZuDcZgK0CxF48E1hM=
X-Received: by 2002:a5d:4250:: with SMTP id s16mr2087442wrr.253.1549345843781;
 Mon, 04 Feb 2019 21:50:43 -0800 (PST)
MIME-Version: 1.0
References: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com> <20190129080926.36773-4-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190129080926.36773-4-Zhiqiang.Hou@nxp.com>
From:   Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date:   Tue, 5 Feb 2019 11:23:17 +0530
Message-ID: <CAFZiPx0wjqHFbu_b9cphSfsbBSU9W6Nupn6QS6R9MgmO_S0Vnw@mail.gmail.com>
Subject: Re: [PATCHv3 03/27] PCI: mobiveil: correct the returned error number
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

Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>

On Tue, Jan 29, 2019 at 1:38 PM Z.q. Hou <zhiqiang.hou@nxp.com> wrote:
>
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>
> This patch corrected the returned error number by convention,
> and removed a unnecessary error check.
>
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> ---
> V3:
>  - No change
>
>  drivers/pci/controller/pcie-mobiveil.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
> index b87471f08a40..563210e731d3 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -819,7 +819,7 @@ static int mobiveil_pcie_init_irq_domain(struct mobiveil_pcie *pcie)
>
>         if (!pcie->intx_domain) {
>                 dev_err(dev, "Failed to get a INTx IRQ domain\n");
> -               return -ENODEV;
> +               return -ENOMEM;
>         }
>
>         raw_spin_lock_init(&pcie->intx_mask_lock);
> @@ -845,11 +845,9 @@ static int mobiveil_pcie_probe(struct platform_device *pdev)
>         /* allocate the PCIe port */
>         bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
>         if (!bridge)
> -               return -ENODEV;
> +               return -ENOMEM;
>
>         pcie = pci_host_bridge_priv(bridge);
> -       if (!pcie)
> -               return -ENOMEM;
>
>         pcie->pdev = pdev;
>
> @@ -866,7 +864,7 @@ static int mobiveil_pcie_probe(struct platform_device *pdev)
>                                                     &pcie->resources, &iobase);
>         if (ret) {
>                 dev_err(dev, "Getting bridge resources failed\n");
> -               return -ENOMEM;
> +               return ret;
>         }
>
>         /*
> --
> 2.17.1
>
