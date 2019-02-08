Return-Path: <SRS0=vzDi=QP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F8EC282CB
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 12:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9930A218D2
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 12:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mobiveil.co.in header.i=@mobiveil.co.in header.b="fHYpdPCu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfBHMjP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 8 Feb 2019 07:39:15 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33397 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbfBHMjK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Feb 2019 07:39:10 -0500
Received: by mail-wm1-f65.google.com with SMTP id h22so6710439wmb.0
        for <linux-pci@vger.kernel.org>; Fri, 08 Feb 2019 04:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mobiveil.co.in; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SOmmoEnVav+euIt9Iv/uAN2WfRPzXaYHTM5sqnc8FUg=;
        b=fHYpdPCuqrHZZ8RtFUO8NNmfzDp8Hp+hyisTU7ORlGPs+J7aGd7wnv9Vj0aASwU2ZP
         CA9u2vEdVZvsq0UwbBucKmlcDIP72/hSmegsjMGX9ybOb55p9E5+961tIdC2hK+p8DqI
         AmuvcI1cWY17NJvHINuU3Pl5Q6XYPARf6imrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SOmmoEnVav+euIt9Iv/uAN2WfRPzXaYHTM5sqnc8FUg=;
        b=I+M30phOtv8ow7KdmtmLCeTmJiefL6Bd+Z73g4GrsW6ZHBr53qnWm0vjem4YYkO22/
         xeJEJBV63FTQH2egNksPeQX5/R3apdES1BQY7TpQubO2pFWInr4U8o0FBw9rXo5lYB3b
         F9J8mAIT3j+S18PS9GUNnh47SSMILvDfv+sbSIqfXfAak+fS1fAhrqLxt2gZHSQ2nTd9
         gtFcxvID/oB5n1bIZ50cv/vbRoHsaKNNaeqXEN56PS/gf3sFRWa8PsnVhFvu/t2hYKHx
         aENqmH4Q2C3SbaZuUQMZhQXvcKTYdRc+aNTRJfusPc+o/mskhQLl4At1NPQPPStaq5Yw
         J3FQ==
X-Gm-Message-State: AHQUAuYKuaKIKvQUOSF7YyingI+g3El5ClKzAX9dhKo7iwM9+avHUVmw
        lfcCn2mOLqp4Ykt8SLQ4VC1ss6wa3gK9gUONjTXcWg==
X-Google-Smtp-Source: AHgI3IbFjpJWc8rNSFfqShcxmeGZCZTlTw3MsHSYS4+CSbBi8WavbbLbYYm+HrwAPPxI2i47LEa7EBpfVljyxDI0qas=
X-Received: by 2002:a7b:c458:: with SMTP id l24mr12191490wmi.143.1549629548841;
 Fri, 08 Feb 2019 04:39:08 -0800 (PST)
MIME-Version: 1.0
References: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com> <20190129080926.36773-19-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190129080926.36773-19-Zhiqiang.Hou@nxp.com>
From:   Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date:   Fri, 8 Feb 2019 18:11:48 +0530
Message-ID: <CAFZiPx0v9nw=k=Cq3dhy_NB4iR7P0FmvZ=9hgKv27xbgxaCFNA@mail.gmail.com>
Subject: Re: [PATCHv3 18/27] PCI: mobiveil: continue to initialize the host
 upon no PCIe link
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
> Sometimes there is not a PCIe Endpoint in the PCIe slot, so do
> not exit when the PCIe link is not up. And degrade the print
> level of link up info.
>
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> ---
> V3:
>  - No change
>
>  drivers/pci/controller/mobiveil/pcie-mobiveil-host.c | 1 -
>  drivers/pci/controller/mobiveil/pcie-mobiveil.c      | 2 +-
>  2 files changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> index 1ae82e790562..d1765d572f44 100644
> --- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> @@ -596,7 +596,6 @@ int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie)
>         ret = mobiveil_bringup_link(pcie);
>         if (ret) {
>                 dev_info(dev, "link bring-up failed\n");
> -               goto error;
>         }
>
>         /* setup the kernel resources for the newly added PCIe root bus */
> diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.c b/drivers/pci/controller/mobiveil/pcie-mobiveil.c
> index ee678a60825d..370658d6546d 100644
> --- a/drivers/pci/controller/mobiveil/pcie-mobiveil.c
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.c
> @@ -222,7 +222,7 @@ int mobiveil_bringup_link(struct mobiveil_pcie *pcie)
>                 usleep_range(LINK_WAIT_MIN, LINK_WAIT_MAX);
>         }
>
> -       dev_err(&pcie->pdev->dev, "link never came up\n");
> +       dev_info(&pcie->pdev->dev, "link never came up\n");
>
>         return -ETIMEDOUT;
>  }
> --
> 2.17.1
>
Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
