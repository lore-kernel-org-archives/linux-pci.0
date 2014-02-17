Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:60581 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752359AbaBQXGK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 17 Feb 2014 18:06:10 -0500
Received: by mail-ig0-f181.google.com with SMTP id hl1so4739825igb.2
        for <linux-pci@vger.kernel.org>; Mon, 17 Feb 2014 15:06:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <loom.20140217T065100-603@post.gmane.org>
References: <loom.20140217T065100-603@post.gmane.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 17 Feb 2014 16:05:49 -0700
Message-ID: <CAErSpo4ABT+yMwvZSfR7op130iJnzgA1c=fH2LdH3kDH293kzw@mail.gmail.com>
Subject: Re: PCI-PCI bridge memory ranges in linux device tree
To: Anand Mistry <anand.mistry@spectross.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Feb 16, 2014 at 11:31 PM, Anand Mistry
<anand.mistry@spectross.com> wrote:
> Hello,
>
> Can anybody please help me out with this one. My linux kernel is not
> programming memory ranges of PCI-PCI bridges and crashes on finding devices
> beyond the bridge. How do i enable automatic resource allocation of PCI-PCi
> bridges in the kernel?

Can you collect a complete dmesg log (or console output with
"ignore_loglevel" option)?

> For reference,
> Processor is MPC8313
> Kernel version is 2.6.23.
> Code from the DTS file
>
> /* code starts */
> pci@8500 {
>         bus-range = <0 0>;
>         ranges = <02000000 0 90000000 90000000 0 10000000
>                   42000000 0 80000000 80000000 0 10000000
>                   01000000 0 00000000 e2000000 0 00100000>;
>         #interrupt-cells = <1>;
>         #size-cells = <2>;
>         #address-cells = <3>;
>         reg = <8500 100>;
>         compatible = "fsl,mpc8349-pci";
>         device_type = "pci";
>         interrupt-parent = < &ipic >;
>         interrupts = <42 8>;
>         interrupt-map-mask = <0F800 0 0 7>;
>         interrupt-map = <
>
>                         // ** For reference **
>                         // INTA = IRQ1 = 0x11
>                         // INTB = IRQ2 = 0x12
>                         // INTC = IRQ0 = 0x30
>                         // INTD = IRQ4 = 0x14
>
>                         // BUS 0 IDSEL 0x18 (IDSEL = AD24)
>                         0c000 0 0 1 &ipic 11 8  // PCI_INTA
>                         0c000 0 0 2 &ipic 12 8  // PCI_INTB
>                         0c000 0 0 3 &ipic 30 8  // PCI_INTC
>                         0c000 0 0 4 &ipic 14 8  // PCI_INTD
>                         >;
>
> };
>
> /* code ends */
>
>
>
> Thanks and Regards,
> Anand Mistry
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
