Return-Path: <SRS0=mLR+=OX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F8EC67839
	for <linux-pci@archiver.kernel.org>; Fri, 14 Dec 2018 10:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49D7B2086D
	for <linux-pci@archiver.kernel.org>; Fri, 14 Dec 2018 10:29:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49D7B2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbeLNK3c (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 14 Dec 2018 05:29:32 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:41217 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbeLNK3c (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Dec 2018 05:29:32 -0500
Received: by mail-ua1-f67.google.com with SMTP id z24so1808093ual.8;
        Fri, 14 Dec 2018 02:29:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OksxWDOBORJ063i4YQJ3trOg9IUlzJ/EUYP0vfaJVWM=;
        b=LA9jmPJ1hY+nQE/+ENIw4e+krz9GlY+6RJkuX8BSoHGa3nr9JSdE1PGA56+cedS4nb
         vVdlzhEFJjDpk+fDKckeVSCd2WMXNpL0IlKSdsNooR3H6VQqxCLRq5sSqmBHUb9Lup23
         YRR5WQpyDP2I66ywhDm+PFjU967QROfhJZqeAUEvmWws7KF4c6VxaxgYESq2OG7Cx1+z
         EE15dk+USfZN7Gpd5VHO0ccL5VOrZ2KbbYNEOGLmgfugq2LOlcrGTjxiR4hLFug/OVPz
         2h8FKYDQUmIjOShlCDD8aqEJT7yo7HgFP7MEy2j4hrENmJ5JsDEe9Kl4qOJSJV/DZjKJ
         vv9g==
X-Gm-Message-State: AA+aEWaOQ1xQb6ivM9jBgjW+fn1iU98NuNBMqm5p5k6h36ABkkCeQ9jR
        FxZ6RC+LjrW86967QrXsfYpCJAlHZdTdtQxCxeFOpRkx
X-Google-Smtp-Source: AFSGD/V6hT5yZTzCZOaN9HDN0QZL4T7VWK293Knc9MDhJJNOznSh4VYwsRozZcvX1y56655dJbwte7oDoKWnmMbjR/w=
X-Received: by 2002:a9f:364a:: with SMTP id s10mr969809uad.78.1544783371216;
 Fri, 14 Dec 2018 02:29:31 -0800 (PST)
MIME-Version: 1.0
References: <1544732500-6866-1-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1544732500-6866-1-git-send-email-fabrizio.castro@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 14 Dec 2018 11:29:19 +0100
Message-ID: <CAMuHMdUqNR5jKQXvC5gy5r44Jp+cbo8iorfCFpwBHNCu16RH0w@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: PCI: rcar: Add device tree support for r8a774c0
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Fabrizio,

On Thu, Dec 13, 2018 at 9:21 PM Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
> Add PCIe support for the RZ/G2E (a.k.a. R8A774C0).
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

One question below.

> --- a/Documentation/devicetree/bindings/pci/rcar-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/rcar-pci.txt

> @@ -37,7 +39,8 @@ compatible: "renesas,pcie-r8a7743" for the R8A7743 SoC;
>
>  Optional properties:
>  - phys: from common PHY binding: PHY phandle and specifier (only make sense
> -       for R-Car gen3 SoCs where the PCIe PHYs have their own register blocks).
> +       for R-Car gen3 and RZ/G2 SoCs where the PCIe PHYs have their own

Gen3, while at it?

> +       register blocks).

The RZ/G2 Hardware User Manual I have lacks the table specifying which SoCs
have which PHY registers.  So I cannot verify if the above paragraph applies to
RZ/G2(E).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
