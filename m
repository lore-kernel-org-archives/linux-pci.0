Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:35888 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754041AbdGJWbn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Jul 2017 18:31:43 -0400
Received: by mail-pf0-f176.google.com with SMTP id q86so56668405pfl.3
        for <linux-pci@vger.kernel.org>; Mon, 10 Jul 2017 15:31:43 -0700 (PDT)
Date: Mon, 10 Jul 2017 15:31:40 -0700
From: Brian Norris <briannorris@chromium.org>
To: jeffy <jeffy.chen@rock-chips.com>
Cc: Amitkumar Karwar <akarwar@marvell.com>,
        Cathy Luo <cluo@marvell.com>,
        Nishant Sarmukadam <nishants@marvell.com>, rajatja@google.com,
        dmitry.torokhov@gmail.com, Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [v4,3/3] mwifiex: Enable WoWLAN for both sdio and pcie
Message-ID: <20170710223138.GA145502@google.com>
References: <1479216964-3328-3-git-send-email-akarwar@marvell.com>
 <595A207D.3000804@rock-chips.com>
 <20170707005302.GA17921@google.com>
 <595EFA40.1080405@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <595EFA40.1080405@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

+ linux-pci
- linux-wireless

On Fri, Jul 07, 2017 at 11:04:32AM +0800, Jeffy Chen wrote:
> On 07/07/2017 08:53 AM, Brian Norris wrote:
> >It kind of seems like we inadvertently conflicted with the PCI OF
> >interrupt spec [1]. There, the "interrupts" property for a device (if
> >present) is supposed to represent INT{A...D} with values of {1...4}.
> >IIUC, there should only be a single entry in this property.
> >
> >If we were to extend this properly, I guess that would mean we'd need a
> >second "interrupts" entry, with a different parent. I think we can use
> >"interrupts-extended" for that.
> >
> >So we'd need to document an optional "interrupt-names" for Marvell, and
> >have the driver try that first. The rough outline would be something
> >like this.
> >
> >For the device tree (e.g., rk3399-gru):
> >
> >-			interrupt-parent = <&gpio0>;
> >-			interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
> >+			interrupts-extended = <&pcie0 1>, <&gpio0 8 IRQ_TYPE_LEVEL_LOW>;
> >+			interrupt-names = "int-A", "wake";
> This is a great idea.
> 
> And how about also add a property to tell of_pci_irq to ignore of
> irq and force using PCI_INTERRUPT_PIN? Since there might be devices
> don't use pci irq, but using other irq(wowlan for example).

Even if they don't use the PCI IRQ, is there a way to provide an empty /
un-mapped entry?

I'm a little wary on trying to "extend" (which can sometimes be read
"break") the device tree spec here too much more. But perhaps DT or PCI
folks have a better recommendation (if they can hold their noses long
enough).

> Then we can specify this property and add a name("wake") to the wifi
> wake irq here. And interrupts-extended would still be an available
> option.

Brian
