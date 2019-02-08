Return-Path: <SRS0=vzDi=QP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD013C169C4
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 12:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABEDF20857
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 12:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mobiveil.co.in header.i=@mobiveil.co.in header.b="L/fyudzr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbfBHM2U (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 8 Feb 2019 07:28:20 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39530 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbfBHM2U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Feb 2019 07:28:20 -0500
Received: by mail-wr1-f67.google.com with SMTP id t27so3362599wra.6
        for <linux-pci@vger.kernel.org>; Fri, 08 Feb 2019 04:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mobiveil.co.in; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U4llWnWHk/iioaBg109tqNu+HuUT0xmojGp7I0EC54Q=;
        b=L/fyudzrkzoYTq4L/ntv6UXvIiIYQqA7Ub6OxQPODZcgS/4JVHGT856I6pqUC7Zb0G
         tFb21UBAOnBWD35EphMs15SF7tcLOw0jAiGEHEe6OmRmpSUTj8c9+Qwc+Uru7p+SYopy
         yhQ2gqJozThixs3FipH3W96aeQ/uAzyRp6uHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U4llWnWHk/iioaBg109tqNu+HuUT0xmojGp7I0EC54Q=;
        b=JhQS1HBK2Iuxr2G2/zHYJq2iM6V5jnjE93jAlKKXkzg9+uGLb21S8M+dc57aTE/qlo
         5SOWyw4AZxKOGqW1a68xgnvTqdFU8zEGLmZ1DFsvsx08j8fZMPn7YI04vRP6VIS8n+UV
         GsY9gNrwCUcXRYfh1Ygvc+meAzwNyi7DT1V17yA75qlKRGMfWhnkaiL+f8JXW9D62iaG
         fkg6erpSiGAR+RyAe+T8kkg+IMvrK+yCA6BMQ8lxFp6+QJYvKbp25Oqkr6pecCtH371m
         NmA0KgVzFnutofv/wzKCNIH06lCMmnw7xZpDfyv/YxIo3x78PRQWOhGxYKMtrhG/2V4q
         fTgQ==
X-Gm-Message-State: AHQUAuafKTCTKmR5CQIlf15VQiqTetqo0E3NxEV3pl8aE4QQYsfburJt
        sGETX0a/f3pFQ8vAUa/6DpMriFRlSNc8ZNbb8ls4yg==
X-Google-Smtp-Source: AHgI3IbX0QUvVY2C3pm3ZumTALuuw3Fd6Hjq/SfVvqMKAzNqiHmSISFhlnJFt3zuK1w52e5QmA/4xzfTVQs0EHUfML4=
X-Received: by 2002:a5d:468e:: with SMTP id u14mr14259352wrq.253.1549628898050;
 Fri, 08 Feb 2019 04:28:18 -0800 (PST)
MIME-Version: 1.0
References: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com> <20190129080926.36773-14-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190129080926.36773-14-Zhiqiang.Hou@nxp.com>
From:   Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date:   Fri, 8 Feb 2019 18:00:57 +0530
Message-ID: <CAFZiPx165X4AQqxFW4r_zZDNjB29-OQD46xce2Lhh4=n-qYHxw@mail.gmail.com>
Subject: Re: [PATCHv3 13/27] PCI: mobiveil: move irq chained handler setup out
 of DT parse
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

On Tue, Jan 29, 2019 at 1:39 PM Z.q. Hou <zhiqiang.hou@nxp.com> wrote:
>
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>
> Move irq_set_chained_handler_and_data() out of DT parse function.
>
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> ---
> V3:
>  - No change
>
>  drivers/pci/controller/pcie-mobiveil.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
> index c2848c22b466..db7ecb021c63 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -460,8 +460,6 @@ static int mobiveil_pcie_parse_dt(struct mobiveil_pcie *pcie)
>                 return -ENODEV;
>         }
>
> -       irq_set_chained_handler_and_data(pcie->irq, mobiveil_pcie_isr, pcie);
> -
>         return 0;
>  }
>
> @@ -902,6 +900,8 @@ static int mobiveil_pcie_probe(struct platform_device *pdev)
>                 goto error;
>         }
>
> +       irq_set_chained_handler_and_data(pcie->irq, mobiveil_pcie_isr, pcie);
> +
>         ret = devm_request_pci_bus_resources(dev, &pcie->resources);
>         if (ret)
>                 goto error;
> --
> 2.17.1
>
Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
