Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from blu0-omc4-s19.blu0.hotmail.com ([65.55.111.158]:10536 "EHLO
	blu0-omc4-s19.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965552Ab3DTC1c (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 19 Apr 2013 22:27:32 -0400
Message-ID: <BLU0-SMTP185893DF37F0C811FA0BCB7B2C90@phx.gbl>
Content-Type: text/plain; charset="iso-8859-15"; format=flowed; delsp=yes
To: "Yijing Wang" <wangyijing@huawei.com>
CC: "Bjorn Helgaas" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Rescan PCIE bus to find recently powered on device.
References: <SNT136-W425B9A4DBEA719E570080DB2C80@phx.gbl>
 <5170B9BD.6040408@huawei.com>
 <CAErSpo43xWdYE8MT9Y4Hdi0bkNh3D4Su6zThAVs72+nYiUD5qg@mail.gmail.com>
 <BLU0-SMTP305A7D1308063E03F4C5CE9B2C90@phx.gbl> <5171F610.80001@huawei.com>
Date: Fri, 19 Apr 2013 19:22:08 -0700
MIME-Version: 1.0
From: Frank Rizzo <thefrankrizzo@hotmail.com>
In-Reply-To: <5171F610.80001@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

(with device powered on AFTER boot)

root@frank-System-Product-Name:~# echo 1 > /sys/bus/pci/rescan
root@frank-System-Product-Name:~# lspci -tv
-[0000:00]-+-00.0  Advanced Micro Devices [AMD] RS780 Host Bridge
            +-01.0-[01]--+-05.0  Advanced Micro Devices [AMD] nee ATI RS780  
[Radeon HD 3200]
            |            \-05.1  Advanced Micro Devices [AMD] nee ATI RS780  
HDMI Audio [Radeon HD 3000-3300 Series]
            +-05.0-[02]----00.0  JMicron Technology Corp. IEEE 1394 Host  
Controller
            +-06.0-[03]----00.0  Realtek Semiconductor Co., Ltd.  
RTL8111/8168B PCI Express Gigabit Ethernet controller
            +-11.0  Advanced Micro Devices [AMD] nee ATI SB7x0/SB8x0/SB9x0  
SATA Controller [IDE mode]
            +-12.0  Advanced Micro Devices [AMD] nee ATI SB7x0/SB8x0/SB9x0  
USB OHCI0 Controller
            +-12.1  Advanced Micro Devices [AMD] nee ATI SB7x0 USB OHCI1  
Controller
            +-12.2  Advanced Micro Devices [AMD] nee ATI SB7x0/SB8x0/SB9x0  
USB EHCI Controller
            +-13.0  Advanced Micro Devices [AMD] nee ATI SB7x0/SB8x0/SB9x0  
USB OHCI0 Controller
            +-13.1  Advanced Micro Devices [AMD] nee ATI SB7x0 USB OHCI1  
Controller
            +-13.2  Advanced Micro Devices [AMD] nee ATI SB7x0/SB8x0/SB9x0  
USB EHCI Controller
            +-14.0  Advanced Micro Devices [AMD] nee ATI SBx00 SMBus  
Controller
            +-14.1  Advanced Micro Devices [AMD] nee ATI SB7x0/SB8x0/SB9x0  
IDE Controller
            +-14.2  Advanced Micro Devices [AMD] nee ATI SBx00 Azalia  
(Intel HDA)
            +-14.3  Advanced Micro Devices [AMD] nee ATI SB7x0/SB8x0/SB9x0  
LPC host controller
            +-14.4-[04]--
            +-14.5  Advanced Micro Devices [AMD] nee ATI SB7x0/SB8x0/SB9x0  
USB OHCI2 Controller
            +-18.0  Advanced Micro Devices [AMD] Family 10h Processor  
HyperTransport Configuration
            +-18.1  Advanced Micro Devices [AMD] Family 10h Processor  
Address Map
            +-18.2  Advanced Micro Devices [AMD] Family 10h Processor DRAM  
Controller
            +-18.3  Advanced Micro Devices [AMD] Family 10h Processor  
Miscellaneous Control
            \-18.4  Advanced Micro Devices [AMD] Family 10h Processor Link  
Control



(with device powered on BEFORE boot)

root@frank-System-Product-Name:~# lspci -tv
-[0000:00]-+-00.0  Advanced Micro Devices [AMD] RS780 Host Bridge
            +-01.0-[01]--+-05.0  Advanced Micro Devices [AMD] nee ATI RS780  
[Radeon HD 3200]
            |            \-05.1  Advanced Micro Devices [AMD] nee ATI RS780  
HDMI Audio [Radeon HD 3000-3300 Series]
            +-02.0-[02]----00.0  Device 1a39:0004
            +-05.0-[03]----00.0  JMicron Technology Corp. IEEE 1394 Host  
Controller
            +-06.0-[04]----00.0  Realtek Semiconductor Co., Ltd.  
RTL8111/8168B PCI Express Gigabit Ethernet controller
            +-11.0  Advanced Micro Devices [AMD] nee ATI SB7x0/SB8x0/SB9x0  
SATA Controller [IDE mode]
            +-12.0  Advanced Micro Devices [AMD] nee ATI SB7x0/SB8x0/SB9x0  
USB OHCI0 Controller
            +-12.1  Advanced Micro Devices [AMD] nee ATI SB7x0 USB OHCI1  
Controller
            +-12.2  Advanced Micro Devices [AMD] nee ATI SB7x0/SB8x0/SB9x0  
USB EHCI Controller
            +-13.0  Advanced Micro Devices [AMD] nee ATI SB7x0/SB8x0/SB9x0  
USB OHCI0 Controller
            +-13.1  Advanced Micro Devices [AMD] nee ATI SB7x0 USB OHCI1  
Controller
            +-13.2  Advanced Micro Devices [AMD] nee ATI SB7x0/SB8x0/SB9x0  
USB EHCI Controller
            +-14.0  Advanced Micro Devices [AMD] nee ATI SBx00 SMBus  
Controller
            +-14.1  Advanced Micro Devices [AMD] nee ATI SB7x0/SB8x0/SB9x0  
IDE Controller
            +-14.2  Advanced Micro Devices [AMD] nee ATI SBx00 Azalia  
(Intel HDA)
            +-14.3  Advanced Micro Devices [AMD] nee ATI SB7x0/SB8x0/SB9x0  
LPC host controller
            +-14.4-[05]--
            +-14.5  Advanced Micro Devices [AMD] nee ATI SB7x0/SB8x0/SB9x0  
USB OHCI2 Controller
            +-18.0  Advanced Micro Devices [AMD] Family 10h Processor  
HyperTransport Configuration
            +-18.1  Advanced Micro Devices [AMD] Family 10h Processor  
Address Map
            +-18.2  Advanced Micro Devices [AMD] Family 10h Processor DRAM  
Controller
            +-18.3  Advanced Micro Devices [AMD] Family 10h Processor  
Miscellaneous Control
            \-18.4  Advanced Micro Devices [AMD] Family 10h Processor Link  
Control
