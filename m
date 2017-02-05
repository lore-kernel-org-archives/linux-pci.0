Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:35288 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751213AbdBEO4p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 5 Feb 2017 09:56:45 -0500
Received: by mail-it0-f49.google.com with SMTP id 203so40622725ith.0
        for <linux-pci@vger.kernel.org>; Sun, 05 Feb 2017 06:56:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <17693846.Edk12xXofc@wuerfel>
References: <20170128204839.18330-1-linus.walleij@linaro.org> <17693846.Edk12xXofc@wuerfel>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 5 Feb 2017 15:56:43 +0100
Message-ID: <CACRpkdYpBYaeTo2SJ55=cwKcZ5Y7A1k-wy1N3UuR6u3L3RdNoA@mail.gmail.com>
Subject: Re: [PATCH 1/4] PCI: add DT bindings for Cortina Gemini PCI Host Bridge
To: Arnd Bergmann <arnd@arndb.de>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Janos Laube <janos.dev@gmail.com>,
        Paulius Zaleckas <paulius.zaleckas@gmail.com>,
        openwrt-devel@openwrt.org,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 1, 2017 at 12:19 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Saturday, January 28, 2017 9:48:36 PM CET Linus Walleij wrote:
>> +       interrupt-map-mask =3D <0xff00 0 0 7>;
>> +       interrupt-map =3D <0x4800 0 0 1 &pci_intc 0>, /* Slot 9 */
>> +                       <0x4900 0 0 2 &pci_intc 1>,
>> +                       <0x4a00 0 0 3 &pci_intc 2>,
>> +                       <0x4b00 0 0 4 &pci_intc 3>,
>> +                       <0x5000 0 0 1 &pci_intc 0>, /* Slot 10 */
>> +                       <0x5100 0 0 2 &pci_intc 1>,
>> +                       <0x5200 0 0 3 &pci_intc 2>,
>> +                       <0x5300 0 0 4 &pci_intc 3>,
>> +                       <0x5800 0 0 1 &pci_intc 0>, /* Slot 11 */
>> +                       <0x5900 0 0 2 &pci_intc 1>,
>> +                       <0x5a00 0 0 3 &pci_intc 2>,
>> +                       <0x5b00 0 0 4 &pci_intc 3>,
>> +                       <0x6000 0 0 1 &pci_intc 0>, /* Slot 12 */
>> +                       <0x6100 0 0 2 &pci_intc 1>,
>> +                       <0x6200 0 0 3 &pci_intc 2>,
>> +                       <0x6300 0 0 4 &pci_intc 3>;
>>
>
> The mapping looks wrong here, we normally don't list interrupts per funct=
ion
> so the mask should be 0xf800.

Yup it works that way too, and indeed the USB hub on function
2 was requesting the right pin and everything.

> Note that the interrupt map is board specific, so this should probably
> go in the board.dts file rather than platform.dtsi.

OK moving it down there.

> For this particular board, the interrupt lines appear to have been badly
> configured so all slots use the same interrupt 0 for IntA. IIRC This also
> means you can probably use <0 0 0 7> as the mask and just specify each of
> the four interrupts once. A properly wired board would swizzle the
> interrupts so that each slot has a different IRQ for its IntA line.

They are swizzled, I just have very bad hardware docs. (Only
code.) It turns out when I'm browsing through old board support
code that there is a comment followed by a piece of code like this:

/*
 *      No swizzle on SL2312
 */
static u8 __init sl2312_pci_swizzle(struct pci_dev *dev, u8 *pinp)
{
        return PCI_SLOT(dev->devfn);
}

/*
 * map the specified device/slot/pin to an IRQ.  This works out such
 * that slot 9 pin 1 is INT0, pin 2 is INT1, and slot 10 pin 1 is INT1.
 */
static int __init sl2312_pci_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
{
        int intnr =3D ((slot  + (pin - 1)) & 3) + 4;  /* the IRQ number
of PCI bridge */

        printk("%s : slot =3D %d  pin =3D %d \n",__func__,slot,pin);
    switch (slot)
    {
        case 12:
                if (pin=3D=3D1)
                {
                        intnr =3D 3;
                    }
                    else
                    {
                        intnr =3D 0;
                    }
#ifdef CONFIG_DUAL_PCI
                    return IRQ_PCI_INTD;
#endif
            break;
        case 11:
                    intnr =3D (2 + (pin - 1)) & 3;
#ifdef CONFIG_DUAL_PCI
                    return IRQ_PCI_INTC;
#endif
            break;
        case 10:
                    intnr =3D (1 + (pin - 1)) & 3;
#ifdef CONFIG_DUAL_PCI
                    return IRQ_PCI_INTB;
#endif
            break;
        case  9:
                    intnr =3D (pin - 1) & 3;
            break;
    }
//      if (slot =3D=3D 10)
//              intnr =3D (1 + (pin - 1)) & 3;
//      else if (slot =3D=3D 9)
//              intnr =3D (pin - 1) & 3;
        return (IRQ_PCI_INTA + intnr);
}

If I understand correctly they say that the IRQs are not swizzled
on the PCI bridge side but on the IRQ handler side.

So if I put it in the device tree like so:

+                         interrupt-map =3D
+                               <0x4800 0 0 1 &pci_intc 0>, /* Slot 9 */
+                               <0x4800 0 0 2 &pci_intc 1>,
+                               <0x4800 0 0 3 &pci_intc 2>,
+                               <0x4800 0 0 4 &pci_intc 3>,
+                               <0x5000 0 0 1 &pci_intc 1>, /* Slot 10 */
+                               <0x5000 0 0 2 &pci_intc 2>,
+                               <0x5000 0 0 3 &pci_intc 3>,
+                               <0x5000 0 0 4 &pci_intc 0>,
+                               <0x5800 0 0 1 &pci_intc 2>, /* Slot 11 */
+                               <0x5800 0 0 2 &pci_intc 3>,
+                               <0x5800 0 0 3 &pci_intc 0>,
+                               <0x5800 0 0 4 &pci_intc 1>,
+                               <0x6000 0 0 1 &pci_intc 3>, /* Slot 12 */
+                               <0x6000 0 0 2 &pci_intc 0>,
+                               <0x6000 0 0 3 &pci_intc 1>,
+                               <0x6000 0 0 4 &pci_intc 2>;

So the IRQs on the right side are swizzled instead
of the pins being swizzled.

...but that looks a bit insane.

Isn't that exactly the same thing just exposed in some
inverse way?

I'll try to get the RALink MiniPCI I have =C3=ADn the slot going and
see if it works the same with just good old vanilla
swizzling.

Yours,
Linus Walleij
