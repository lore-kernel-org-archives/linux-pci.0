Return-Path: <SRS0=Tpvo=MC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FAC7C433F4
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 09:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D87220880
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 09:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nexA8thG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D87220880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbeITOtC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Sep 2018 10:49:02 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44944 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbeITOtC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Sep 2018 10:49:02 -0400
Received: by mail-wr1-f65.google.com with SMTP id v16-v6so8547951wro.11;
        Thu, 20 Sep 2018 02:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nl/HxkskA+cJfdsHb1BwIVusCaTl8YHES0WfpHElubg=;
        b=nexA8thGwTWXFh52/cJJMif7jvuSeinvyJi6AT1Y6MIyTD+mFYKXdaISaKxr9sSBgH
         acy2ERMdogAruYd0IqPi1UakeaaODk9XurSQfXXYlODEjQATYQduLuJERIcWDGNDoXhO
         JasWrItnB5n4SuyJA/HkIZGQKsZADES4Q4dnBf4OpZa+jVIawIYYlON1r7XUIxEq+9Zx
         ndAm0qToH+YP7LeAXlvC/icVZH/K7L4OkG8rszCn9iUTCzQNcaFdQsfwCjsSWgcOpeTW
         Z+uGW/J6PSWdfVlQ5kCsOZCUcqGDSDgz1ew2StJjdKAcZ6mIwdMVdNcWckTDCr0JAxvm
         Enpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nl/HxkskA+cJfdsHb1BwIVusCaTl8YHES0WfpHElubg=;
        b=FN/wObJ02Qb3eVZPfv+zgqwtpDbMxTMKF2NRwEBMrwTH0UJWY7ohFBUDPbIjUGZ70x
         uKV20luv3T9Fy0ixafEfBoNuvAABYgFVuF98z6gKx92PDoRK8n/S72bU+jjBYOlcp92f
         OcwgEC7hydK+H7KUhzmRM3a3+KbH5fgF6zoD4QpbF1Ugx8uvLLI4zq+yfA2l/CNxigpq
         NMWI88v4H8XOjnA0thfXbZPmoEZIX2b6oS8J88+rS0ypYpPIgB+s3RIsmJYxxx8ifyvq
         ov/SlmRFcRvDpgWr5SrarcJn9ZTyqrQytoJk/KrcZleh+botWbc/ZuPIyEOO0v8s7OGd
         8N0A==
X-Gm-Message-State: APzg51Azfk55saiKI0Lr3kPa1RB8cqzikehS0Kzla/dDesOVogC4A8oS
        644/JZBBvNIvGZaehxUVfkqeu7fyFpFfJBhLHOc=
X-Google-Smtp-Source: ANB0VdY2DngjrlW36f/7VypSautHwWW84WRsnoYlrOaVYpyW68j4E0Jv2ZXkvCCg1vx9lJFAXZJtopXy9qzk91xns6U=
X-Received: by 2002:adf:ad8e:: with SMTP id w14-v6mr34224888wrc.178.1537434392853;
 Thu, 20 Sep 2018 02:06:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:4c86:0:0:0:0:0 with HTTP; Thu, 20 Sep 2018 02:06:12
 -0700 (PDT)
In-Reply-To: <1537367527-20773-3-git-send-email-jim2101024@gmail.com>
References: <1537367527-20773-1-git-send-email-jim2101024@gmail.com> <1537367527-20773-3-git-send-email-jim2101024@gmail.com>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Thu, 20 Sep 2018 11:06:12 +0200
Message-ID: <CAOiHx=mEKoHz6t=PbnG801e2u8GG=ct7ypMTKZ=EALKJhBZf=g@mail.gmail.com>
Subject: Re: [PATCH v5 02/12] dt-bindings: pci: add DT docs for Brcmstb PCIe device
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 19 September 2018 at 16:31, Jim Quinlan <jim2101024@gmail.com> wrote:
> The DT bindings description of the Brcmstb PCIe device is described.
> This node can be used by almost all Broadcom settop box chips, using
> ARM, ARM64, or MIPS CPU architectures.

Oh, hey, *one* email made it finally through :P

>
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/pci/brcmstb-pcie.txt       | 59 ++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/brcmstb-pcie.txt
>
> diff --git a/Documentation/devicetree/bindings/pci/brcmstb-pcie.txt b/Documentation/devicetree/bindings/pci/brcmstb-pcie.txt
> new file mode 100644
> index 0000000..a1a9ad5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/brcmstb-pcie.txt
> @@ -0,0 +1,59 @@
> +Brcmstb PCIe Host Controller Device Tree Bindings
> +
> +Required Properties:
> +- compatible
> +  "brcm,bcm7425-pcie" -- for 7425 family MIPS-based SOCs.
> +  "brcm,bcm7435-pcie" -- for 7435 family MIPS-based SOCs.
> +  "brcm,bcm7445-pcie" -- for 7445 and later ARM based SOCs (not including
> +      the 7278).
> +  "brcm,bcm7278-pcie"  -- for 7278 family ARM-based SOCs.
> +
> +- reg -- the register start address and length for the PCIe reg block.
> +- interrupts -- two interrupts are specified; the first interrupt is for
> +     the PCI host controller and the second is for MSI if the built-in
> +     MSI controller is to be used.
> +- interrupt-names -- names of the interrupts (above): "pcie" and "msi".
> +- #address-cells -- set to <3>.
> +- #size-cells -- set to <2>.
> +- #interrupt-cells: set to <1>.
> +- interrupt-map-mask and interrupt-map, standard PCI properties to define the
> +     mapping of the PCIe interface to interrupt numbers.
> +- ranges: ranges for the PCI memory and I/O regions.
> +- linux,pci-domain -- should be unique per host controller.
> +
> +Optional Properties:
> +- clocks -- phandle of pcie clock.
> +- clock-names -- set to "sw_pcie" if clocks is used.
> +- dma-ranges -- Specifies the inbound memory mapping regions when
> +     an "identity map" is not possible.
> +- msi-controller -- this property is typically specified to have the
> +     PCIe controller use its internal MSI controller.
> +- msi-parent -- set to use an external MSI interrupt controller.
> +- brcm,enable-ssc -- (boolean) indicates usage of spread-spectrum clocking.
> +- max-link-speed --  (integer) indicates desired generation of link:
> +     1 => 2.5 Gbps (gen1), 2 => 5.0 Gbps (gen2), 3 => 8.0 Gbps (gen3).
> +
> +Example Node:
> +
> +pcie0: pcie@f0460000 {
> +               reg = <0x0 0xf0460000 0x0 0x9310>;
> +               interrupts = <0x0 0x0 0x4>;

Your binding says two interrupts, your example has three - what's the
third interrupt for? Also you define the same for MSI and PCIe (I
assume) - is that expected? Are there systems where they are
different? I would expect the msi interrupt to be optional for the
case where its the same as the pcie one, and only required if it is
different.

Also your binding requires an interrupt-names propery, but it's
missing from the example.

> +               compatible = "brcm,bcm7445-pcie";
> +               #address-cells = <3>;
> +               #size-cells = <2>;
> +               ranges = <0x02000000 0x00000000 0x00000000 0x00000000 0xc0000000 0x00000000 0x08000000
> +                         0x02000000 0x00000000 0x08000000 0x00000000 0xc8000000 0x00000000 0x08000000>;
> +               #interrupt-cells = <1>;
> +               interrupt-map-mask = <0 0 0 7>;
> +               interrupt-map = <0 0 0 1 &intc 0 47 3
> +                                0 0 0 2 &intc 0 48 3
> +                                0 0 0 3 &intc 0 49 3
> +                                0 0 0 4 &intc 0 50 3>;
> +               clocks = <&sw_pcie0>;
> +               clock-names = "sw_pcie";
> +               msi-parent = <&pcie0>;  /* use PCIe's internal MSI controller */
> +               msi-controller;         /* use PCIe's internal MSI controller */
> +               brcm,ssc;
> +               max-link-speed = <1>;
> +               linux,pci-domain = <0>;
> +       };
> --
> 1.9.0.138.g2de3478
>

Regards
Jonas
