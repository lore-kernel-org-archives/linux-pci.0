Return-Path: <SRS0=ZQO4=QM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B936C282CB
	for <linux-pci@archiver.kernel.org>; Tue,  5 Feb 2019 06:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 089D52083B
	for <linux-pci@archiver.kernel.org>; Tue,  5 Feb 2019 06:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mobiveil.co.in header.i=@mobiveil.co.in header.b="u0hfqtB6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfBEGCr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 5 Feb 2019 01:02:47 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45532 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfBEGCr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Feb 2019 01:02:47 -0500
Received: by mail-wr1-f68.google.com with SMTP id q15so2226665wro.12
        for <linux-pci@vger.kernel.org>; Mon, 04 Feb 2019 22:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mobiveil.co.in; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+iXYvqbL04CrMC9Msn9+P2yhEIYzuGJ1s0Z7Tbi9M9Q=;
        b=u0hfqtB6n/9xUdBNpa+lUEjHPSk0axN4rIGHPdjhsjG/v2VvNzoR9t/3kaCEzLeaas
         OHCgZhiEc5h7gQrWYefmkhDJo24KkLKA+fH16gY+JW6aJI5oZjjv8JXBSWCyMDPMMVht
         6qBwfjmveYOlfNjzJOw51ZZsJX5tnM+ZL6oB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+iXYvqbL04CrMC9Msn9+P2yhEIYzuGJ1s0Z7Tbi9M9Q=;
        b=Jr7d2SVfJuQnIk9UKqgSj3shAlXALUyawZ7V15t46TtUsjD1lvRq9m7eznF3g1//wW
         PwmYmHEPOrrAKZmKzBWUZTKlHf1flUshWQ3MXVIMZasMe0r7BKzEwpiQ17/aFC2gABtL
         E3Rfbl1QNmfk3gI/9Oz4ti+kE5Gc1dcjprMpp1alXYQA0d39d+AoF/FyEeTpKbtOjZTI
         x1jPp5uRo8E0ZrQ3E8r/NeOyV/OTc20Z7vgcrXtMNFQwqaEGIQB4heSMxdvpmYGLsr9K
         nNANG1ZFA/uFphAuus66++E7qh2rHJ/K/ycb4/Z7oBfILzmA/LL6xlAgrh2tKjNK3Sxf
         07hw==
X-Gm-Message-State: AHQUAuaeJ75/elM6NDZnOBsYJXt20bVTyxj05VCHUt9bUUZfszElJ54M
        RqSthEcIPIvASZJdvnSvBWsFDK06klN2aMu7ML0ZAA==
X-Google-Smtp-Source: AHgI3IabIa+8GnpOhA0TxuLJJFYCpplG1t9plmrYCiZAkge7q1SBCrmcqhBkCINFhgjx2A+iGoBr42hYp8YZYZD3u/Q=
X-Received: by 2002:a5d:4ec7:: with SMTP id s7mr2188770wrv.14.1549346564989;
 Mon, 04 Feb 2019 22:02:44 -0800 (PST)
MIME-Version: 1.0
References: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com> <20190129080926.36773-5-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190129080926.36773-5-Zhiqiang.Hou@nxp.com>
From:   Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date:   Tue, 5 Feb 2019 11:35:19 +0530
Message-ID: <CAFZiPx0aiLkVrqVxmyLRcVZJ0G=+60vED4cJOfAo=18DDnOtcA@mail.gmail.com>
Subject: Re: [PATCHv3 04/27] PCI: mobiveil: remove flag MSI_FLAG_MULTI_PCI_MSI
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

Zhiqiang,
why are we removing multi-MSI support ?
what functionality this driver is not providing to support it ?

Thanks.

On Tue, Jan 29, 2019 at 1:38 PM Z.q. Hou <zhiqiang.hou@nxp.com> wrote:
>
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>
> The current code does not support multiple MSIs, so remove
> the corresponding flag from the msi_domain_info structure.
>
> Fixes: 1e913e58335f ("PCI: mobiveil: Add MSI support")
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> ---
> V3:
>  - No change
>
>  drivers/pci/controller/pcie-mobiveil.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
> index 563210e731d3..a0dd337c6214 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -703,7 +703,7 @@ static struct irq_chip mobiveil_msi_irq_chip = {
>
>  static struct msi_domain_info mobiveil_msi_domain_info = {
>         .flags  = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
> -                  MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX),
> +                  MSI_FLAG_PCI_MSIX),
>         .chip   = &mobiveil_msi_irq_chip,
>  };
>
> --
> 2.17.1
>
