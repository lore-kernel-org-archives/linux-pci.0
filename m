Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:36941 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915AbcGONz2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jul 2016 09:55:28 -0400
Received: by mail-wm0-f42.google.com with SMTP id i5so31107071wmg.0
        for <linux-pci@vger.kernel.org>; Fri, 15 Jul 2016 06:55:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <VI1PR0401MB26249BF2429EF9FD6DB7F7EF8C330@VI1PR0401MB2624.eurprd04.prod.outlook.com>
References: <CAO1575Vzw5=JMVW4yh6HNz730r-RtONt_+J1A4BhygVowAWLZQ@mail.gmail.com>
 <CAO1575Wo_Qgk-YX7kZchUTEv7o3W5-b_DJQktoF2AR+OwvAxNg@mail.gmail.com>
 <VI1PR0401MB2624BC92B13026C53D4B13198C330@VI1PR0401MB2624.eurprd04.prod.outlook.com>
 <CAO1575VC_cVHMxnWWDHcJhrymchJM1zMmR4X2O38JdrGP4dJfA@mail.gmail.com> <VI1PR0401MB26249BF2429EF9FD6DB7F7EF8C330@VI1PR0401MB2624.eurprd04.prod.outlook.com>
From: Ivan Grimaldi <grimaldi.ivan@gmail.com>
Date: Fri, 15 Jul 2016 15:55:07 +0200
Message-ID: <CAO1575VjjoA3O-8big2NG7v=xCeeLjf1K0Ck7b9AUcZ=H8HL1w@mail.gmail.com>
Subject: Re: PROBLEM: pcie imx6 link problem after a random number of reboot
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: "r65037@freescale.com" <r65037@freescale.com>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi ,

 i have aligned pci-imx.c file with SHA
"b2d7a9cd3ff8ec561348267c2ef7d47b2b91e801" (same of kernel 4.6) and
after a random number of restart the kernel hangs (below the kernel
log). From log, as you see, the U-Boot haven't problem with PCI.

...
U-Boot 2015.01-ge2977fb-dirty (Jul 15 2016 - 11:28:42)

CPU:   Freescale i.MX6DL rev1.1 at 792 MHz
Reset cause: WDOG
       Watchdog enabled
DRAM:  1 GiB
Flash: 96 MiB
MMC:   FSL_SDHC: 0
WARNING: Make sure the PCIe #PERST line is connected!
  00:01.0     - 16c3:abcd - Bridge device
   01:00.0    - 14e4:b242 - Network controller
In:    serial
Out:   serial
Err:   serial
Net:   FEC [PRIME]
Hit any key to stop autoboot:  0
Booting from NFS...
Using FEC device
TFTP from server 192.168.74.130; our IP address is 192.168.74.235
Filename 'ags20.dtb'.
Load address: 0x12000000
Loading: ###
         3.2 MiB/s
done
Bytes transferred = 29921 (74e1 hex)
Using FEC device
TFTP from server 192.168.74.130; our IP address is 192.168.74.235
Filename 'zImage'.
Load address: 0x12100000
Loading: #################################################################
         #################################################################
         #################################################################
         ##########################################
         3.9 MiB/s
done
Bytes transferred = 3472120 (34faf8 hex)
Kernel image @ 0x12100000 [ 0x000000 - 0x34faf8 ]
## Flattened Device Tree blob at 12000000
   Booting using the fdt blob at 0x12000000
   Loading Device Tree to 4f530000, end 4f53a4e0 ... OK

Starting kernel ...



Best regards
IVan

2016-07-15 9:23 GMT+02:00 Richard Zhu <hongxing.zhu@nxp.com>:
> Hi Ivan:
> Okay to do that.
>
> It’s just what I suggested in the previous email.
>
> Good luck.
>
>
>
> Best Regards
>
> hongxing zhu
>
> Linux BSP team
>
> Office: 86-21-28937189
>
> Email: hongxing.zhu@nxp.com
>
>
>
> From: Ivan Grimaldi [mailto:grimaldi.ivan@gmail.com]
> Sent: Friday, July 15, 2016 3:21 PM
> To: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: r65037@freescale.com; l.stach@pengutronix.de; linux-pci@vger.kernel.org;
> bhelgaas@google.com; linux-arm-kernel@lists.infradead.org
> Subject: Re: PROBLEM: pcie imx6 link problem after a random number of reboot
>
>
>
> Hi Richard,
>
>  i can patch the pci-imx.c file and aligned it with same file in kernel 4.6,
> and start with a new test session. What do you think?
>
> Best regards
>
> IVan
>
>
>
> 2016-07-15 3:03 GMT+02:00 Richard Zhu <hongxing.zhu@nxp.com>:
>
> Hi Ivan:
> The imx6 pcie link training mechanism had been changed a lot from 3.18 to
> the latest kernel.
>
> Can you update it at your side refer to the Linux kernel 4.6?
>
>
>
> Best Regards
>
> hongxing zhu
>
> Linux BSP team
>
> Office: 86-21-28937189
>
> Email: hongxing.zhu@nxp.com
>
>
>
> From: Ivan Grimaldi [mailto:grimaldi.ivan@gmail.com]
> Sent: Thursday, July 14, 2016 6:30 PM
> To: r65037@freescale.com; l.stach@pengutronix.de; linux-pci@vger.kernel.org;
> Ivan Grimaldi <grimaldi.ivan@gmail.com>
> Cc: bhelgaas@google.com; linux-arm-kernel@lists.infradead.org
> Subject: Fwd: PROBLEM: pcie imx6 link problem after a random number of
> reboot
>
>
>
> Hi,
>
>
>  I am having a problem with the iMX6 PCIe bus working, after a random number
> of reboots i have a problem with pci link (below the kenel log), the link is
> up but still in training.
>
> The hardware and software configuration is the following:
> 1) Linux kernel 3.18.26
> 2) Custom board based on IMX6DL SoC
>
> ....
> imx6q-pcie 1ffc000.pcie: Link is up, but still in training
> imx6q-pcie 1ffc000.pcie: Link up, Gen=2
> imx6q-pcie 1ffc000.pcie: PCI host bridge to bus 0000:00
> pci_bus 0000:00: root bus resource [io  0x1000-0xffff]
> pci_bus 0000:00: root bus resource [mem 0x01000000-0x01efffff]
> pci_bus 0000:00: root bus resource [bus 00-ff]
> pci_bus 0000:00: scanning bus
> pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400
> pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x000fffff]
> pci 0000:00:00.0: reg 0x38: [mem 0x00000000-0x0000ffff pref]
> pci 0000:00:00.0: calling pci_fixup_ide_bases+0x0/0x4c
> pci 0000:00:00.0: supports D1
> pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
> pci 0000:00:00.0: PME# disabled
> pci_bus 0000:00: fixups for bus
> PCI: bus0: Fast back to back transfers disabled
> pci 0000:00:00.0: scanning [bus 01-01] behind bridge, pass 0
> pci 0000:00:00.0: scanning [bus 00-00] behind bridge, pass 1
> pci_bus 0000:01: scanning bus
> imx6q-pcie 1ffc000.pcie: Link is up, but still in training
> imx6q-pcie 1ffc000.pcie: Link is up, but still in training
> imx6q-pcie 1ffc000.pcie: Link is up, but still in training
> imx6q-pcie 1ffc000.pcie: Link is up, but still in training
> imx6q-pcie 1ffc000.pcie: Link is up, but still in training
> imx6q-pcie 1ffc000.pcie: transition to gen2 is stuck, reset PHY!
> imx6q-pcie 1ffc000.pcie: debug_r0=0000060d debug_r1=28000410
> pci_bus 0000:01: fixups for bus
> PCI: bus1: Fast back to back transfers enabled
> pci_bus 0000:01: bus scan returning with max=01
> pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
> pci_bus 0000:00: bus scan returning with max=01
> pci 0000:00:00.0: fixup irq: got 155
> pci 0000:00:00.0: assigning IRQ 155
> pci 0000:00:00.0: BAR 0: assigned [mem 0x01000000-0x010fffff]
> pci 0000:00:00.0: BAR 6: assigned [mem 0x01100000-0x0110ffff pref]
> pci 0000:00:00.0: PCI bridge to [bus 01]
> ....
>
> IVan
>
>
>
>
