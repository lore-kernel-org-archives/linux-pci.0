Return-Path: <SRS0=ZQO4=QM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210CEC282CB
	for <linux-pci@archiver.kernel.org>; Tue,  5 Feb 2019 06:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD1DE2083B
	for <linux-pci@archiver.kernel.org>; Tue,  5 Feb 2019 06:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mobiveil.co.in header.i=@mobiveil.co.in header.b="a0lt9vja"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbfBEGEY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 5 Feb 2019 01:04:24 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38284 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbfBEGEY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Feb 2019 01:04:24 -0500
Received: by mail-wr1-f65.google.com with SMTP id v13so2282944wrw.5
        for <linux-pci@vger.kernel.org>; Mon, 04 Feb 2019 22:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mobiveil.co.in; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E8Nz/JOD+e1xoqAI4YK+0goMEU7txF8Kn0+PiGymNa8=;
        b=a0lt9vjaYGvo5ZjCMKI4qBCmuxJB3MEqbdXjeKZbh+T2f2nZ72O8/RHqWxV7l6HJYZ
         UCE2tm6/FROvTqIC+Nj4Xtk13boNIRpa4eHoE2/95EH9a+MyYFmfR2YIAwrsfxbWN3ol
         k0v2t9jjDyZw3M4IrxpaQEeGGibrzRh/SKAfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E8Nz/JOD+e1xoqAI4YK+0goMEU7txF8Kn0+PiGymNa8=;
        b=e9GxRjEgiTMm2+MThnxjpwyXxMGhLVxyTEgwKZYlFcqSzWVZPAHs3p0ho0vTbtC13v
         0Iaip1enUxVkKjhasY+vYQJRVioWTLbvIKjCJbBbUKDlpPfdqnanhlXSjveu6nPjr2OW
         1PGtG5HeGfBtnE24CDMrVXqf5w4h8BpMNgB0VAeBjROKDIHYH7jTkblM9WcHTeNsTAf4
         i8x89C7+GKia93GnnmUsTztQOaPVPr7HOT+xPjOvw44OpeMKOWNVhElCb+T8VPlYLYj6
         syq6+oXn48I6FSY2X8IhbtM8d7BId4Fu0zUHntMVSZmN5yJ6h44Ei2EGg5V1dQxOwKfc
         83LA==
X-Gm-Message-State: AHQUAubvDCVt9ez8Jm9F+Hcp7hhX5p/ocWqSDWY/ZjqMEXKvvc/57L4k
        ZGyDrqkDwdRFrBaPYfVRuhrw9zrs54azkcLzNm/a0A==
X-Google-Smtp-Source: AHgI3IZABnEpCunPrjrSCncSfkYCrTT1Vrxws6KuAXMByp9HYmZCCEG2EFEppAWPTIq00CvmKwpJrXSlEI29F2o99Mw=
X-Received: by 2002:adf:fd81:: with SMTP id d1mr2123021wrr.105.1549346662212;
 Mon, 04 Feb 2019 22:04:22 -0800 (PST)
MIME-Version: 1.0
References: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com> <20190129080926.36773-6-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190129080926.36773-6-Zhiqiang.Hou@nxp.com>
From:   Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date:   Tue, 5 Feb 2019 11:36:56 +0530
Message-ID: <CAFZiPx1eiMYgpaT4q219hcfOGqBB1XkZvX5xjAM5mApiMSVMxw@mail.gmail.com>
Subject: Re: [PATCHv3 05/27] PCI: mobiveil: correct PCI base address in MEM/IO
 outbound windows
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
> It should get PCI base address from the DT node property 'ranges'
> to setup MEM/IO outbound windows instead of always zero.
>
> Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host Bridge
> IP driver")
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> ---
> V3:
>  - No change
>
>  drivers/pci/controller/pcie-mobiveil.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
> index a0dd337c6214..8ff873023b5f 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -630,8 +630,9 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
>
>                 /* configure outbound translation window */
>                 program_ob_windows(pcie, pcie->ob_wins_configured,
> -                                  win->res->start, 0, type,
> -                                  resource_size(win->res));
> +                                  win->res->start,
> +                                  win->res->start - win->offset,
> +                                  type, resource_size(win->res));
>         }
>
>         /* setup MSI hardware registers */
> --
> 2.17.1
>
