Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:55825 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751115AbdJ0Fkc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Oct 2017 01:40:32 -0400
Received: by mail-io0-f195.google.com with SMTP id p186so10256086ioe.12
        for <linux-pci@vger.kernel.org>; Thu, 26 Oct 2017 22:40:32 -0700 (PDT)
Date: Thu, 26 Oct 2017 22:40:28 -0700
From: Brian Norris <briannorris@chromium.org>
To: jeffy <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, bhelgaas@google.com,
        linux-pm@vger.kernel.org, tony@atomide.com,
        shawn.lin@rock-chips.com, rjw@rjwysocki.net, dianders@chromium.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC PATCH v8 1/7] dt-bindings: PCI: Add definition of PCIe
 WAKE# irq and PCI irq
Message-ID: <20171027054025.GA85582@google.com>
References: <20171026132840.20946-1-jeffy.chen@rock-chips.com>
 <20171026132840.20946-2-jeffy.chen@rock-chips.com>
 <20171027023331.GA11665@google.com>
 <59F2A2BA.5030307@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <59F2A2BA.5030307@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jeffy,

On Fri, Oct 27, 2017 at 11:06:34AM +0800, Jeffy Chen wrote:
> On 10/27/2017 10:33 AM, Brian Norris wrote:
> >In fact, I'm pretty sure this series fails to actually look in the host
> >bridge for the "wakeup" interrupt at all! Did you actually test this?
> actually it could...
> 
> static void *of_pci_setup(struct device *dev)
> {
> ...
>         device_init_wakeup(dev, false);
> 
>         dev_info(dev, "Wakeup IRQ %d\n", irq);
>         return data;
> }
> 
> [    1.546561] OF: PCI:   MEM 0xfa000000..0xfbdfffff -> 0xfa000000
> [    1.553154] OF: PCI:    IO 0xfbe00000..0xfbefffff -> 0xfbe00000
> [    1.560859] rockchip-pcie f8000000.pcie: Wakeup IRQ 64
> [    1.566555] rockchip-pcie f8000000.pcie: PCI host bridge to bus

Hmm, I think I missed the .setup_host_bridge() stuff. So you do handle
both. I'll have to take a little closer look tomorrow. But you
definitely at least need to improve the documentation as mentioned.

Another odd thing about this series is that the interrupt doesn't
actually show up in /proc/interrupts, /sys/kernel/debug/gpio, or
similar, seemingly because the wakeirq is requested/released every time
we suspend/resume. So it's really not that obvious that the interrupt is
being configured properly. That's not really a functional problem,
necessarily, but it doesn't quite seem ideal.

Brian
