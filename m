Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:6559 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755275AbaJVQCp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 22 Oct 2014 12:02:45 -0400
Message-ID: <1413993749.4202.197.camel@ul30vt.home>
Subject: Re: Hard and silent lock up since linux 3.14 with PCIe pass through
 (vfio)
From: Alex Williamson <alex.williamson@redhat.com>
To: Andreas Hartmann <andihartmann@freenet.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci <linux-pci@vger.kernel.org>
Date: Wed, 22 Oct 2014 10:02:29 -0600
In-Reply-To: <20141022173405.2e5474a1@dualc.maya.org>
References: <20140923210318.498dacbd@dualc.maya.org>
			 <1411502866.24563.8.camel@ul30vt.home> <5437A958.3000201@maya.org>
			 <CAErSpo5kkk4itqqmCMU=08-XMcDknur8VY++F3A2LajdvTptOA@mail.gmail.com>
			 <5437F1F5.3010706@maya.org>
			 <CAErSpo6DuWEcJb_gfS=5JnKN8b4DXXV9+u-CRa8m3db0dbzpsQ@mail.gmail.com>
			 <543804BC.3080307@maya.org>
			 <CAErSpo450czUtAM104o+RS=yOcmP+3MKMH7mYk=UYhVJ2+cfSQ@mail.gmail.com>
			 <20141011003219.560cca97@dualc.maya.org>
			 <20141010225408.GA24493@google.com> <5438CC1E.3060407@maya.org>
		 <1413360267.4202.70.camel@ul30vt.home> <54406B34.1050808@maya.org>
	 <1413925580.4202.189.camel@ul30vt.home>
	 <20141022173405.2e5474a1@dualc.maya.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2014-10-22 at 17:34 +0200, Andreas Hartmann wrote:
> Alex Williamson schrieb:
> > Hi Andreas,
> > 
> > On Fri, 2014-10-17 at 03:04 +0200, Andreas Hartmann wrote:
> >> Hello Alex,
> >>
> >> Alex Williamson wrote:
> >>> Hi Andreas,
> >> [...]
> >>> Sorry for the breakage.  Is it possible to run lspci on the device in a
> >>> loop from the host and capture whether we're failing to restore some of
> >>> the VC bits to their previous state? 
> >>
> >>> Does the problem also occur if you
> >>> unbind from host driver,
> >>
> >> The machine is booted w/ blacklisted ath9k. Then, the device is bound to
> >> vfio:
> >>
> >> echo "168c 0030" > /sys/bus/pci/drivers/vfio-pci/new_id
> >> echo 0000:03:00.0 > /sys/bus/pci/devices/0000:03:00.0/driver/unbind
> >> echo 0000:03:00.0 > /sys/bus/pci/drivers/vfio-pci/bind
> >>
> >> afterwards the VM is started -> hang.
> >>
> >> W/o starting th VM, I can bind it to vfio and unbind it from vfio w/o
> >> any problem.
> >>
> >>> echo 1 > reset in pci-sysfs,
> >>
> >> echo 1 > /sys/bus/pci/devices/0000:03:00.0 works w/o any problem while
> >> bound to vfio. Even after unbinding from vfio and rebinding to vfio
> >> again ... .
> >>
> >>> and re-bind to the
> >>
> >> Do you mean loading ath9k in host system after unbinding from vfio? If
> >> yes: Works w/o any problem. It's even possible to reset it or do a
> >> ifconfig wlan0 up, ifconfig wlan0 down, rmmod ath9k, bind it to vfio
> >> again and reset it, ....
> >>
> >> Looks like the hang only is triggered by qemu-system_x86_64 on startup
> >> the VM.
> >>
> >>> host?  I'll also try to reproduce on my 990fx system, but I won't be
> >>> able to do that until next week due to travel.  Thanks,
> > 
> > Could you send me the lspci -vvvxxxx for the device and parent root
> > port?  Thanks,
> 
> 
> Done with kernel 3.12.28 in host while the device was used in VM:
> 
> # lspci -vt
> -[0000:00]-+-00.0  Advanced Micro Devices, Inc. [AMD/ATI] RD890 PCI to PCI bridge (external gfx0 port B)
>            +-00.2  Advanced Micro Devices, Inc. [AMD/ATI] RD990 I/O Memory Management Unit (IOMMU)
>            +-02.0-[01]--+-00.0  Advanced Micro Devices, Inc. [AMD/ATI] Turks PRO [Radeon HD 6570/7570]
>            |            \-00.1  Advanced Micro Devices, Inc. [AMD/ATI] Turks/Whistler HDMI Audio [Radeon HD 6000 Series]
>            +-04.0-[02]----00.0  Etron Technology, Inc. EJ168 USB 3.0 Host Controller
>            +-05.0-[03]----00.0  Qualcomm Atheros AR93xx Wireless Network Adapter
>            +-09.0-[04]----00.0  Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller
>            +-0a.0-[05]----00.0  Etron Technology, Inc. EJ168 USB 3.0 Host Controller
>            +-11.0  Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 SATA Controller [AHCI mode]
>            +-12.0  Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB OHCI0 Controller
>            +-12.2  Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB EHCI Controller
>            +-13.0  Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB OHCI0 Controller
>            +-13.2  Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB EHCI Controller
>            +-14.0  Advanced Micro Devices, Inc. [AMD/ATI] SBx00 SMBus Controller
>            +-14.2  Advanced Micro Devices, Inc. [AMD/ATI] SBx00 Azalia (Intel HDA)
>            +-14.3  Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 LPC host controller
>            +-14.4-[06]--+-06.0  Intel Corporation 82557/8/9/0/1 Ethernet Pro 100
>            |            \-0e.0  VIA Technologies, Inc. VT6306/7/8 [Fire II(M)] IEEE 1394 OHCI Controller
>            +-14.5  Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB OHCI2 Controller
>            +-15.0-[07]--
>            +-16.0  Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB OHCI0 Controller
>            +-16.2  Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB EHCI Controller
>            +-18.0  Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 0
>            +-18.1  Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 1
>            +-18.2  Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 2
>            +-18.3  Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 3
>            +-18.4  Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 4
>            \-18.5  Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 5
> 
> 
> # lspci -s 03:00 -vvvxxxx
> 03:00.0 Network controller: Qualcomm Atheros AR93xx Wireless Network Adapter (rev 01)
[snip]
> 
> 
> I'm not sure what you mean with "parent root port". Could it be this:

No, it's 00:05.0

