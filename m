Return-Path: <SRS0=ZQO4=QM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557D0C282CB
	for <linux-pci@archiver.kernel.org>; Tue,  5 Feb 2019 06:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 253372083B
	for <linux-pci@archiver.kernel.org>; Tue,  5 Feb 2019 06:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mobiveil.co.in header.i=@mobiveil.co.in header.b="PuZH3LDR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfBEGEx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 5 Feb 2019 01:04:53 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:55251 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbfBEGEx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Feb 2019 01:04:53 -0500
Received: by mail-wm1-f45.google.com with SMTP id a62so2228249wmh.4
        for <linux-pci@vger.kernel.org>; Mon, 04 Feb 2019 22:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mobiveil.co.in; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3aQtR76X4VtJOe5HikigbKlmMNbkcyXJpnJePsqpATQ=;
        b=PuZH3LDRHXppM67bMX3nu+bUj3v5Xdm4kGzc3NjlmHaE5N4KR78ROx2/Ki4QA1i84K
         NDeWLjYlBuLu2VrSQXSQkYUMnO/DZFqh/Q/E+4CZCtSRTdasmo7B2tM8DrLl6qzcJRjM
         LIfV49RB3P5yCq5775EuUYxz6sh3EUkT1rbSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3aQtR76X4VtJOe5HikigbKlmMNbkcyXJpnJePsqpATQ=;
        b=Lg/5m8Bjgf4V7AECouEJVilQYsH4KUhwMnH0an6soUuUore7PE3+mJyU1VROvKD4vu
         e3OYto/DAbyGl2NnOm/ACzHV/L2JwYYc7nbQTIzyHj8LWxaSmKJOFYm5Wp0lgQZ8T19P
         8QTz/+0IuFbueNZDmEpviMaNTB8XO1vMuvltMPFx/NeUzz5ZjxfBoy8ikxNxLig1GMZh
         x5RXA0vETFxX6NMsrkunDa8ftj0OOOx6j67gN30EvOA9xG59nU/N32QKwEWbm6XKaS2n
         072sdeA8IVi6DuVz0gNs99zWn/zYhDNINZhr1qFXjayk6Jto+U29TJfPmbHcoWvBjRcq
         506Q==
X-Gm-Message-State: AHQUAub1h8F1eyGk8vDWi2kp6GRirW3ecXtmALnmzeAZUO8l5EseIBcc
        /Of4GLGxoUxYDaLajcUA000l9aBOW4v/j38x8IXc4A==
X-Google-Smtp-Source: AHgI3IaUIENwON4vGBErykNufFGyL0jwh+Mj0IuiqAvWyNwrw1Szt8ore/d9WT1qSCmzWYRd0/UO91ZvfY245DOe5Rc=
X-Received: by 2002:a7b:c5d1:: with SMTP id n17mr2145787wmk.152.1549346690855;
 Mon, 04 Feb 2019 22:04:50 -0800 (PST)
MIME-Version: 1.0
References: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com> <20190129080926.36773-7-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190129080926.36773-7-Zhiqiang.Hou@nxp.com>
From:   Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date:   Tue, 5 Feb 2019 11:37:24 +0530
Message-ID: <CAFZiPx3yW89pXsB+Qo5nSQX-C998CYPVr7HWDrJotrV+6q9DBQ@mail.gmail.com>
Subject: Re: [PATCHv3 06/27] PCI: mobiveil: replace the resource list
 iteration function
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

On Tue, Jan 29, 2019 at 1:39 PM Z.q. Hou <zhiqiang.hou@nxp.com> wrote:
>
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>
> As it won't delete any node in this iteration, replaced
> the function resource_list_for_each_entry_safe() with
> the resource_list_for_each_entry().
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
> index 8ff873023b5f..b2cc9c097fc9 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -569,7 +569,7 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
>  {
>         u32 value, pab_ctrl, type;
>         int err;
> -       struct resource_entry *win, *tmp;
> +       struct resource_entry *win;
>
>         err = mobiveil_bringup_link(pcie);
>         if (err) {
> @@ -620,7 +620,7 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
>         program_ib_windows(pcie, WIN_NUM_1, 0, MEM_WINDOW_TYPE, IB_WIN_SIZE);
>
>         /* Get the I/O and memory ranges from DT */
> -       resource_list_for_each_entry_safe(win, tmp, &pcie->resources) {
> +       resource_list_for_each_entry(win, &pcie->resources) {
>                 if (resource_type(win->res) == IORESOURCE_MEM)
>                         type = MEM_WINDOW_TYPE;
>                 else if (resource_type(win->res) == IORESOURCE_IO)
> --
> 2.17.1
>
