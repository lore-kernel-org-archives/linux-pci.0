Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:18854 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750867AbaGCF6e (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 3 Jul 2014 01:58:34 -0400
Message-ID: <53B4F0F7.9020403@huawei.com>
Date: Thu, 3 Jul 2014 13:58:15 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Ilia Mirkin <imirkin@alum.mit.edu>, <linux-pci@vger.kernel.org>
CC: "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
	<brian.johnathan.b@gmail.com>
Subject: Re: How to check for proper MSI support?
References: <CAKb7UviGCtebGwyHbXRLZhDOiDAez+eKkxPe9jz5kc-3R1kUvQ@mail.gmail.com>
In-Reply-To: <CAKb7UviGCtebGwyHbXRLZhDOiDAez+eKkxPe9jz5kc-3R1kUvQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2014/7/3 11:20, Ilia Mirkin wrote:
> Hello,
> 
> A user (cc'd) reported that nouveau's enabling of MSI causes the card
> to not work on his setup [1]. I think the situation is that MSI is
> just not supported by the underlying motherboard, even though the
> card, and probably bridge, support it just fine. It's a very old
> board. The nouveau code does:


What is the kernel version running in your board ?

> 
> pmc->use_msi = pci_enable_msi(device->pdev) == 0;

Driver call pci_enable_msi() and always return 0 ?

> 
> Does it need to do more checking than that before trying to enable MSI
> on the device? Could it be that the linux pci subsystem is missing on
> inheriting MSI capabilities somewhere?

pci_enable_msi() will checking your device whether it supports MSI.
Can you provide the detailed lspci information ? eg. lspci -vvvxxx ?


> 
>   -ilia
> 
> [1]
> 
> 00:00.0 Host bridge [0600]: Intel Corporation 430FX - 82437FX TSC
> [Triton I] [8086:122d] (rev 01)
>         Flags: bus master, medium devsel, latency 64
> 
> 00:0e.0 PCI bridge [0604]: PLX Technology, Inc. PEX8112 x1 Lane PCI
> Express-to-PCI Bridge [10b5:8112] (rev aa) (prog-if 00 [Normal
> decode])
>         Flags: bus master, 66MHz, medium devsel, latency 66
>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
>         I/O behind bridge: 0000f000-0000ffff
>         Memory behind bridge: f5e00000-fbffffff
>         Prefetchable memory behind bridge: d5d00000-f5dfffff
>         Capabilities: [40] Power Management version 2
>         Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
>         Capabilities: [60] Express PCI/PCI-X to PCI-Express Bridge, MSI 00
> 
> 01:00.0 VGA compatible controller [0300]: NVIDIA Corporation G96
> [GeForce 9400 GT] [10de:0641] (rev a1) (prog-if 00 [VGA controller])
>         Subsystem: Jaton Corp Device [1b13:0641]
>         Flags: bus master, fast devsel, latency 0, IRQ 11
>         Memory at fb000000 (32-bit, non-prefetchable) [size=16M]
>         Memory at e0000000 (64-bit, prefetchable) [size=256M]
>         Memory at f8000000 (64-bit, non-prefetchable) [size=32M]
>         I/O ports at fc80 [size=128]
>         [virtual] Expansion ROM at d5d00000 [disabled] [size=512K]
>         Capabilities: [60] Power Management version 3
>         Capabilities: [68] MSI: Enable- Count=1/1 Maskable- 64bit+
>         Capabilities: [78] Express Endpoint, MSI 00
>         Capabilities: [b4] Vendor Specific Information: Len=14 <?>
>         Kernel driver in use: nouveau
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 


-- 
Thanks!
Yijing

