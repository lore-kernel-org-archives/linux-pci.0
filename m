Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:16291 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965593Ab3DTDAQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 19 Apr 2013 23:00:16 -0400
Message-ID: <517204AE.9030907@huawei.com>
Date: Sat, 20 Apr 2013 10:59:58 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Frank Rizzo <thefrankrizzo@hotmail.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Rescan PCIE bus to find recently powered on device.
References: <SNT136-W425B9A4DBEA719E570080DB2C80@phx.gbl> <5170B9BD.6040408@huawei.com> <CAErSpo43xWdYE8MT9Y4Hdi0bkNh3D4Su6zThAVs72+nYiUD5qg@mail.gmail.com> <BLU0-SMTP305A7D1308063E03F4C5CE9B2C90@phx.gbl> <5171F610.80001@huawei.com> <BLU0-SMTP185893DF37F0C811FA0BCB7B2C90@phx.gbl>
In-Reply-To: <BLU0-SMTP185893DF37F0C811FA0BCB7B2C90@phx.gbl>
Content-Type: text/plain; charset="ISO-8859-15"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2013/4/20 10:22, Frank Rizzo wrote:
> (with device powered on AFTER boot)
> 
> root@frank-System-Product-Name:~# echo 1 > /sys/bus/pci/rescan

Hi Frank,
   When you do rescan here, any new message info will print in dmesg?
Compare the two lspci info, it seems like your external device is
02.0-[02]----00.0  Device 1a39:0004, which include a pci bridge and a pci endpoint device.
But let me confused is that after you rescan (with device powered on AFTER boot),
there is no any new device found, normally, at least we should found the bridge device.
Maybe the link between host bridge and your external device got some problems? I am not sure.

> root@frank-System-Product-Name:~# lspci -tv
> -[0000:00]-+-00.0  Advanced Micro Devices [AMD] RS780 Host Bridge
>            +-01.0-[01]--+-05.0  Advanced Micro Devices [AMD] nee ATI RS780 [Radeon HD 3200]
>            |            \-05.1  Advanced Micro Devices [AMD] nee ATI RS780 HDMI Audio [Radeon HD 3000-3300 Series]
>            +-05.0-[02]----00.0  JMicron Technology Corp. IEEE 1394 Host Controller
>            +-06.0-[03]----00.0  Realtek Semiconductor Co., Ltd. RTL8111/8168B PCI Express Gigabit Ethernet controller
>            +-11.0  Advanced Micro Devices [AMD] nee ATI SB7x0/SB8x0/SB9x0 SATA Controller [IDE mode]
>            +-12.0  Advanced Micro Devices [AMD] nee ATI SB7x0/SB8x0/SB9x0 USB OHCI0 Controller
>            +-12.1  Advanced Micro Devices [AMD] nee ATI SB7x0 USB OHCI1 Controller
>            +-12.2  Advanced Micro Devices [AMD] nee ATI SB7x0/SB8x0/SB9x0 USB EHCI Controller
>            +-13.0  Advanced Micro Devices [AMD] nee ATI SB7x0/SB8x0/SB9x0 USB OHCI0 Controller
>            +-13.1  Advanced Micro Devices [AMD] nee ATI SB7x0 USB OHCI1 Controller
>            +-13.2  Advanced Micro Devices [AMD] nee ATI SB7x0/SB8x0/SB9x0 USB EHCI Controller
>            +-14.0  Advanced Micro Devices [AMD] nee ATI SBx00 SMBus Controller
>            +-14.1  Advanced Micro Devices [AMD] nee ATI SB7x0/SB8x0/SB9x0 IDE Controller
>            +-14.2  Advanced Micro Devices [AMD] nee ATI SBx00 Azalia (Intel HDA)
>            +-14.3  Advanced Micro Devices [AMD] nee ATI SB7x0/SB8x0/SB9x0 LPC host controller
>            +-14.4-[04]--
>            +-14.5  Advanced Micro Devices [AMD] nee ATI SB7x0/SB8x0/SB9x0 USB OHCI2 Controller
>            +-18.0  Advanced Micro Devices [AMD] Family 10h Processor HyperTransport Configuration
>            +-18.1  Advanced Micro Devices [AMD] Family 10h Processor Address Map
>            +-18.2  Advanced Micro Devices [AMD] Family 10h Processor DRAM Controller
>            +-18.3  Advanced Micro Devices [AMD] Family 10h Processor Miscellaneous Control
>            \-18.4  Advanced Micro Devices [AMD] Family 10h Processor Link Control
> 
> 


> 
> (with device powered on BEFORE boot)
> 
> root@frank-System-Product-Name:~# lspci -tv
> -[0000:00]-+-00.0  Advanced Micro Devices [AMD] RS780 Host Bridge
>            +-01.0-[01]--+-05.0  Advanced Micro Devices [AMD] nee ATI RS780 [Radeon HD 3200]
>            |            \-05.1  Advanced Micro Devices [AMD] nee ATI RS780 HDMI Audio [Radeon HD 3000-3300 Series]
>            +-02.0-[02]----00.0  Device 1a39:0004
>            +-05.0-[03]----00.0  JMicron Technology Corp. IEEE 1394 Host Controller
>            +-06.0-[04]----00.0  Realtek Semiconductor Co., Ltd. RTL8111/8168B PCI Express Gigabit Ethernet controller
>            +-11.0  Advanced Micro Devices [AMD] nee ATI SB7x0/SB8x0/SB9x0 SATA Controller [IDE mode]
>            +-12.0  Advanced Micro Devices [AMD] nee ATI SB7x0/SB8x0/SB9x0 USB OHCI0 Controller
>            +-12.1  Advanced Micro Devices [AMD] nee ATI SB7x0 USB OHCI1 Controller
>            +-12.2  Advanced Micro Devices [AMD] nee ATI SB7x0/SB8x0/SB9x0 USB EHCI Controller
>            +-13.0  Advanced Micro Devices [AMD] nee ATI SB7x0/SB8x0/SB9x0 USB OHCI0 Controller
>            +-13.1  Advanced Micro Devices [AMD] nee ATI SB7x0 USB OHCI1 Controller
>            +-13.2  Advanced Micro Devices [AMD] nee ATI SB7x0/SB8x0/SB9x0 USB EHCI Controller
>            +-14.0  Advanced Micro Devices [AMD] nee ATI SBx00 SMBus Controller
>            +-14.1  Advanced Micro Devices [AMD] nee ATI SB7x0/SB8x0/SB9x0 IDE Controller
>            +-14.2  Advanced Micro Devices [AMD] nee ATI SBx00 Azalia (Intel HDA)
>            +-14.3  Advanced Micro Devices [AMD] nee ATI SB7x0/SB8x0/SB9x0 LPC host controller
>            +-14.4-[05]--
>            +-14.5  Advanced Micro Devices [AMD] nee ATI SB7x0/SB8x0/SB9x0 USB OHCI2 Controller
>            +-18.0  Advanced Micro Devices [AMD] Family 10h Processor HyperTransport Configuration
>            +-18.1  Advanced Micro Devices [AMD] Family 10h Processor Address Map
>            +-18.2  Advanced Micro Devices [AMD] Family 10h Processor DRAM Controller
>            +-18.3  Advanced Micro Devices [AMD] Family 10h Processor Miscellaneous Control
>            \-18.4  Advanced Micro Devices [AMD] Family 10h Processor Link Control
> 
> .
> 


-- 
Thanks!
Yijing

