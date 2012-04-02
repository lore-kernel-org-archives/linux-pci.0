Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:64011 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751333Ab2DBOOE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 2 Apr 2012 10:14:04 -0400
Received: by lahj13 with SMTP id j13so2993339lah.19
        for <linux-pci@vger.kernel.org>; Mon, 02 Apr 2012 07:14:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4F79584B.2010301@jp.fujitsu.com>
References: <4F79584B.2010301@jp.fujitsu.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 2 Apr 2012 08:13:42 -0600
Message-ID: <CAErSpo4Yy9d93gNzDadFxSN+41NkEKBz4yai9KzB1aaCP3pwWw@mail.gmail.com>
Subject: Re: [RFC] pciehp: Add archdata setting
To: =?UTF-8?B?5p2+5pys5Y2a6YOO?= <matsumoto.hiroo@jp.fujitsu.com>
Cc: jbarnes@virtuousgeek.org, linux-pci@vger.kernel.org,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 2, 2012 at 1:42 AM, 松本博郎 <matsumoto.hiroo@jp.fujitsu.com> wrote:
> I'm trying to use pciehp on powerpc platform.
> I set e1000e card to PCI Express bridge that has PCI Express HotPlug
> Capability.
>
> There is problem when poweron PCI Express HotPlug slot with pciehp.
> e1000e driver needs dma_ops in struct dev_archdata, but archdata isn't
> set (dma_ops is NULL) when probe from pciehp.
> Then e1000e driver returns error as below.
>
> -sh-3.2# echo 1 > /sys/bus/pci/slots/1/power
> <snip>
> [   65.493662] pci 0000:03:00.0: BAR 2: set to [io
> 0xff7ee000-0xff7ee01f] (PCI address [0x1000-0x101f])
> [   65.502890] pcieport 0000:02:01.0: PCI bridge to [bus 03-03]
> [   65.508555] pcieport 0000:02:01.0:   bridge window [io
> 0xff7ee000-0xff7eefff]
> [   65.515785] pcieport 0000:02:01.0:   bridge window [mem
> 0xa0100000-0xa01fffff]
> [   65.523015] pcieport 0000:02:01.0:   bridge window [mem
> 0xa0200000-0xa02fffff 64bit pref]
> [   65.531238] pci 0000:03:00.0: no hotplug settings from platform
> [   65.538361] e1000e 0000:03:00.0: Disabling ASPM  L1
> [   65.543616] e1000e 0000:03:00.0: enabling device (0000 -> 0002)
> [   65.549876] e1000e 0000:03:00.0: No usable DMA configuration, aborting
> [   65.557194] e1000e: probe of 0000:03:00.0 failed with error -5
> -sh-3.2# lspci
> <snip>
> 0000:03:00.0 Ethernet controller: Intel Corporation 82572EI Gigabit
> Ethernet Controller (Copper) (rev 06)
> <snip>
> -sh-3.2# ifconfig -a
> <snip>  // There is no network interface for 82572EI
>
> If archdata.dma_ops is NULL on x86 platform, e1000e will get dma_ops
> without archdata.
> So e1000e driver doesn't return error.
>
> I think that archdata should be set before driver probe (e.g pciehp).
> I tried to fix it (pciehp-add-archdata.patch), but I'm not good at PCI
> driver..., so please give better way.

Interesting.  It would be nice if we could set archdata the same way
for both devices present at boot and those hot-added later.  Can you
figure out where archdata is set for devices present at boot?

Bjorn

> Signed-off-by: Hiroo MATSUMOTO <matsumoto.hiroo@jp.fujitsu.com>
> diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
> index a4031df..a021fbc 100644
> --- a/drivers/pci/hotplug/pciehp_pci.c
> +++ b/drivers/pci/hotplug/pciehp_pci.c
> @@ -89,6 +89,7 @@ int pciehp_configure_device(struct slot *p_slot)
>                        pciehp_add_bridge(dev);
>                }
>                pci_dev_put(dev);
> +               dev->dev.archdata = bridge->dev.archdata;
>        }
>
>        pci_assign_unassigned_bridge_resources(bridge);
>
