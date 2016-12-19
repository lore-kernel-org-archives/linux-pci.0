Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:35469 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752796AbcLST1T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Dec 2016 14:27:19 -0500
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVOUUM3hZ0sfTcs5PFqfvrYR9Sk3egibpuxb-4a80U02A@mail.gmail.com>
References: <1482064022-8998-1-git-send-email-ykaneko0929@gmail.com> <CAMuHMdVOUUM3hZ0sfTcs5PFqfvrYR9Sk3egibpuxb-4a80U02A@mail.gmail.com>
From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Date: Tue, 20 Dec 2016 04:27:17 +0900
Message-ID: <CAH1o70JybP7FR-vC5oCPXqDXygt7G-C9w3bO9JhVQwTQGvEJXQ@mail.gmail.com>
Subject: Re: [PATCH pci/next] PCI: rcar: Add compatible string for r8a7796
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Geert-san,

Thanks for your review.

2016-12-19 18:49 GMT+09:00 Geert Uytterhoeven <geert@linux-m68k.org>:
> Hi Kaneko-san,
>
> On Sun, Dec 18, 2016 at 1:27 PM, Yoshihiro Kaneko <ykaneko0929@gmail.com> wrote:
>> From: Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>
>>
>> This patch adds support for r8a7796.
>>
>> Signed-off-by: Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>
>> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
>> ---
>>
>> This patch is based on the next branch of the pci tree.
>>
>>  Documentation/devicetree/bindings/pci/rcar-pci.txt | 1 +
>>  drivers/pci/host/pcie-rcar.c                       | 1 +
>>  2 files changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/rcar-pci.txt b/Documentation/devicetree/bindings/pci/rcar-pci.txt
>> index eee518d..34712d6 100644
>> --- a/Documentation/devicetree/bindings/pci/rcar-pci.txt
>> +++ b/Documentation/devicetree/bindings/pci/rcar-pci.txt
>> @@ -6,6 +6,7 @@ compatible: "renesas,pcie-r8a7779" for the R8A7779 SoC;
>>             "renesas,pcie-r8a7791" for the R8A7791 SoC;
>>             "renesas,pcie-r8a7793" for the R8A7793 SoC;
>>             "renesas,pcie-r8a7795" for the R8A7795 SoC;
>> +           "renesas,pcie-r8a7796" for the R8A7796 SoC;
>>             "renesas,pcie-rcar-gen2" for a generic R-Car Gen2 compatible device.
>>             "renesas,pcie-rcar-gen3" for a generic R-Car Gen3 compatible device.
>>
>> diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
>> index aca85be..02e5777 100644
>> --- a/drivers/pci/host/pcie-rcar.c
>> +++ b/drivers/pci/host/pcie-rcar.c
>> @@ -1078,6 +1078,7 @@ static int rcar_pcie_parse_map_dma_ranges(struct rcar_pcie *pcie,
>>         { .compatible = "renesas,pcie-rcar-gen2",
>>           .data = rcar_pcie_hw_init_gen2 },
>>         { .compatible = "renesas,pcie-r8a7795", .data = rcar_pcie_hw_init },
>> +       { .compatible = "renesas,pcie-r8a7796", .data = rcar_pcie_hw_init },
>>         { .compatible = "renesas,pcie-rcar-gen3", .data = rcar_pcie_hw_init },
>>         {},
>
> Given the driver already matches against "renesas,pcie-rcar-gen3",
> and mainline arch/arm64/boot/dts/renesas/r8a7796.dtsi doesn't have pcie
> nodes yet, I think there's no need to update the driver, only the bindings.

I agree with you.

>
> Hence if you drop the last chunk, you can add my
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

I will do it.

Thanks,
kaneko

>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
