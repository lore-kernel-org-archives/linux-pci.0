Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED38C433EF
	for <linux-pci@archiver.kernel.org>; Fri,  1 Jul 2022 14:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbiGAO7K (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 1 Jul 2022 10:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbiGAO7E (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Jul 2022 10:59:04 -0400
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D23396BD;
        Fri,  1 Jul 2022 07:59:03 -0700 (PDT)
Received: by mail-qk1-f176.google.com with SMTP id z12so2007354qki.3;
        Fri, 01 Jul 2022 07:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ClF4/O+9R1s6OCLClNeVfKgbElLOzOXCNjDKPl+CiaU=;
        b=WR+8roYhSHBrrI2fQ61SUYBupCt39ArBkC3H3l6zRoVqaxBKL65713+CCpwHxSmMuW
         +K3/rgtPq/jdTDzII8s44C69NhsQz+WyiR9pMpS1r3hQMoDjqqq2r0fWC77LXnQXaArP
         YTfWQNy2azzNP5TJoNrlayh69ioHeHN9DmPTJVsVMT4YH7KH5p27H8ec6Z8Ni7xOY6lU
         X6yHV+h/FkzoiS3aarkeztfRJb/1PREmbJZIQpjyKFurbUW2AXsML54xKibzLcTH21iA
         oSAhYNGR6e2LABojVYT2/j6x1bSOIc0FoTsiTJopPfblyEY8gWj0oEhY6rN3BwLItpt3
         jhkQ==
X-Gm-Message-State: AJIora8s6Jvc2kMTd8RRm5B75DIySut/k9YvZuamrlvubsQ+YSxrxrRS
        ZZxFaE6r0tmF1Yvmzj4niD5ZfHC+fmO2Dg==
X-Google-Smtp-Source: AGRyM1txTmKwMJvi2qgDbCLgsfSZs9LQAI2x4iFTItFADZQNp2UGErlzzs3nc7msBybH+mE5I+/ypQ==
X-Received: by 2002:a37:ad03:0:b0:6ae:d5a0:d90e with SMTP id f3-20020a37ad03000000b006aed5a0d90emr10573082qkm.48.1656687542507;
        Fri, 01 Jul 2022 07:59:02 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id bm9-20020a05620a198900b006a73ad95d40sm17529541qkb.55.2022.07.01.07.59.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jul 2022 07:59:02 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id q132so4461251ybg.10;
        Fri, 01 Jul 2022 07:59:01 -0700 (PDT)
X-Received: by 2002:a25:2b48:0:b0:668:3b7d:326c with SMTP id
 r69-20020a252b48000000b006683b7d326cmr15360089ybr.380.1656687541538; Fri, 01
 Jul 2022 07:59:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220701085420.870306-1-yoshihiro.shimoda.uh@renesas.com> <20220701085420.870306-11-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <20220701085420.870306-11-yoshihiro.shimoda.uh@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 1 Jul 2022 16:58:50 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU98Thzn5-sVcye1Qz4WFiLy7AHH=X9JXqfa2LrRyqy+A@mail.gmail.com>
Message-ID: <CAMuHMdU98Thzn5-sVcye1Qz4WFiLy7AHH=X9JXqfa2LrRyqy+A@mail.gmail.com>
Subject: Re: [PATCH v3 10/13] PCI: renesas: Add R-Car Gen4 PCIe Endpoint support
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Shimoda-san,

On Fri, Jul 1, 2022 at 10:55 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> Add R-Car Gen4 PCIe Endpoint support. This controller is based on
> Synopsys DesignWare PCIe.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4-ep.c

> +static const struct of_device_id rcar_gen4_pcie_of_match[] = {
> +       { .compatible = "renesas,rcar-gen4-pcie-ep", },
> +       {},

Please drop the comma, as no new entries must be added after the
sentinel.

> +};

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
