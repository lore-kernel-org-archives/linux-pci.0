Return-Path: <SRS0=TyEb=B3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A36CC433F7
	for <linux-pci@archiver.kernel.org>; Mon, 17 Aug 2020 16:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63CAD20674
	for <linux-pci@archiver.kernel.org>; Mon, 17 Aug 2020 16:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597682930;
	bh=cr4ed1+wAP4LE1t7Olx9PbLZFx5mHkvQNQCN7Bnf8T8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Ykq7Gjly9NpTpldX1dosN9DuIGgVogd9ucsz+fYZyffFOJDr9Iqte0cDLCM9w2OkU
	 3LrMvvvhVEXcXiuzyAoUEl4t5En17/qghTo9d3A9vUXdYmnKa/IzB3whfH0gANd9y2
	 4T2H4681PQKE2yZKwnnKFffVWQb8XqtDWN4hY5Fk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388969AbgHQQso (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 Aug 2020 12:48:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:36282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388953AbgHQQse (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Aug 2020 12:48:34 -0400
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9113920729;
        Mon, 17 Aug 2020 16:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597682912;
        bh=cr4ed1+wAP4LE1t7Olx9PbLZFx5mHkvQNQCN7Bnf8T8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=znYZ5yvsLRpkEdePuy6tC3joBPK0xJHf9nDYgKlmoXss0jHQtChfpKdYQzlPeK8hk
         bMFX0uMubHOlONiKBZUp5AOnr9OE5khS40uNTCGY3DeRp9oeT6OGSkxKvtrkIoYaUd
         dlw77GXtToNLsZPnE86uwrBNwgJPOP/GCnEVpWnU=
Received: by mail-ot1-f41.google.com with SMTP id r21so13906281ota.10;
        Mon, 17 Aug 2020 09:48:32 -0700 (PDT)
X-Gm-Message-State: AOAM532rwmPD4ejIqcr+qjQpF2GuFvIy38LYsvpi//nEZqFBZ56YaicN
        Rmkd/SHeT4RkFLb1B/Ye/eExq+rEXiNflrDuzw==
X-Google-Smtp-Source: ABdhPJxaIJ/5yIBh3pYah1vkE3SudC65lsnoRMq8W4mfltRwx3uDQ1BoQvhIj5sBtTElnPyyUac/41RrgElt7gohyCw=
X-Received: by 2002:a05:6830:1b79:: with SMTP id d25mr11034659ote.107.1597682911876;
 Mon, 17 Aug 2020 09:48:31 -0700 (PDT)
MIME-Version: 1.0
References: <1596795922-705-1-git-send-email-hayashi.kunihiko@socionext.com> <1596795922-705-6-git-send-email-hayashi.kunihiko@socionext.com>
In-Reply-To: <1596795922-705-6-git-send-email-hayashi.kunihiko@socionext.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 17 Aug 2020 10:48:20 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+nGtrBpzNKU9+1cHYkuQ3KBHpgwZRQfDKKUMJVSx_b1A@mail.gmail.com>
Message-ID: <CAL_Jsq+nGtrBpzNKU9+1cHYkuQ3KBHpgwZRQfDKKUMJVSx_b1A@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] PCI: uniphier: Add iATU register support
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Marc Zyngier <maz@kernel.org>, PCI <linux-pci@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 7, 2020 at 4:25 AM Kunihiko Hayashi
<hayashi.kunihiko@socionext.com> wrote:
>
> This gets iATU register area from reg property. In Synopsys DWC version
> 4.80 or later, since iATU register area is separated from core register
> area, this area is necessary to get from DT independently.
>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  drivers/pci/controller/dwc/pcie-uniphier.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
> index 55a7166..93ef608 100644
> --- a/drivers/pci/controller/dwc/pcie-uniphier.c
> +++ b/drivers/pci/controller/dwc/pcie-uniphier.c
> @@ -471,6 +471,11 @@ static int uniphier_pcie_probe(struct platform_device *pdev)
>         if (IS_ERR(priv->pci.dbi_base))
>                 return PTR_ERR(priv->pci.dbi_base);
>
> +       priv->pci.atu_base =
> +               devm_platform_ioremap_resource_byname(pdev, "atu");
> +       if (IS_ERR(priv->pci.atu_base))
> +               priv->pci.atu_base = NULL;

Keystone has the same 'atu' resource setup. Please move its code to
the DW core and use that.

Rob
