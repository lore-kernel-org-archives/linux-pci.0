Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:36721 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750750AbcLCLUT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 3 Dec 2016 06:20:19 -0500
MIME-Version: 1.0
In-Reply-To: <20161202215016.GA21497@verge.net.au>
References: <1480675020-26346-1-git-send-email-horms+renesas@verge.net.au>
 <1480675020-26346-4-git-send-email-horms+renesas@verge.net.au> <20161202215016.GA21497@verge.net.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 3 Dec 2016 12:19:39 +0100
Message-ID: <CAMuHMdVhiz971JTU3T3GZehfmPqFOX6XPRjG01=NZrGONSi55g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3 pci/next] PCI: rcar: Add gen3 fallback
 compatibility string for pcie-rcar
To: Simon Horman <horms@verge.net.au>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 2, 2016 at 10:50 PM, Simon Horman <horms@verge.net.au> wrote:
> On Fri, Dec 02, 2016 at 11:37:00AM +0100, Simon Horman wrote:
>> --- a/drivers/pci/host/pcie-rcar.c
>> +++ b/drivers/pci/host/pcie-rcar.c
>> @@ -1078,6 +1078,8 @@ static const struct of_device_id rcar_pcie_of_match[] = {
>>       { .compatible = "renesas,pcie-rcar-gen2",
>>         .data = rcar_pcie_hw_init_gen2 },
>>       { .compatible = "renesas,pcie-r8a7795", .data = rcar_pcie_hw_init },
>> +     { .compatible = "renesas,pcie-rcar-gen3",
>> +             .data = rcar_pcie_hw_init_hw_init },
>
> It looks like I failed to compile-test this.
>
> s/rcar_pcie_hw_init_hw_init/rcar_pcie_hw_init/

Bummer, and my tired eyes didn't notice...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
