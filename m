Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:56560 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933926AbeALPTr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Jan 2018 10:19:47 -0500
Date: Fri, 12 Jan 2018 17:19:43 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ian Ray <ian.ray@ge.com>, Nandor Han <nandor.han@ge.com>,
        Koen Vandeputte <koen.vandeputte@ncentric.com>
Subject: Re: Regression due to "PCI: Do not allocate more buses than
 available in parent"
Message-ID: <20180112151943.GE27654@lahna.fi.intel.com>
References: <20180112150744.sjntmpas5noaub6g@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180112150744.sjntmpas5noaub6g@earth.universe>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Fri, Jan 12, 2018 at 04:07:44PM +0100, Sebastian Reichel wrote:
> Hi,
> 
> I have an ARM/DT based system [0], that no longer finds its ethernet cards
> behind a PCIe switch. I bisected the problem and ended up on
> a20c7f36bd3d. I tried providing some space using the suggested "pci=hpbussize=<N>",
> but it does not seem to work.
> 
> I added dmesg for working, broken and broken + parameter below. At
> the moment I would say this is a regression and the commit should be
> reverted.
> 
> [0] arch/arm/boot/dts/imx6q-b850v3.dts
> 
> -- Sebastian
> 
> root@GE004097290225 b850v3:~# uname -a
> Linux GE004097290225 4.14.0-rc3-00007-g4147c2fd9b12 #1678 SMP Fri Jan 12 15:42:05 CET 2018 armv7l GNU/Linux
> root@GE004097290225 b850v3:~# dmesg | grep pci
> [    0.189198] OF: PCI: host bridge /soc/pcie@1ffc000 ranges:
> [    0.402498] imx6q-pcie 1ffc000.pcie: link up
> [    0.402509] imx6q-pcie 1ffc000.pcie: Link: Gen2 disabled
> [    0.402519] imx6q-pcie 1ffc000.pcie: Link up, Gen1
> [    0.402643] imx6q-pcie 1ffc000.pcie: PCI host bridge to bus 0000:00
> [    0.402656] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    0.402667] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
> [    0.402676] pci_bus 0000:00: root bus resource [mem 0x01000000-0x01efffff]
> [    0.402716] pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400
> [    0.402756] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x000fffff]
> [    0.402779] pci 0000:00:00.0: reg 0x38: [mem 0x00000000-0x0000ffff pref]
> [    0.402859] pci 0000:00:00.0: supports D1
> [    0.402870] pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
> [    0.403276] pci 0000:01:00.0: [10b5:8605] type 01 class 0x060400
> [    0.403478] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00003fff]
> [    0.404151] pci 0000:01:00.0: supports D1 D2
> [    0.404159] pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [    0.432595] pci 0000:01:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> [    0.432924] pci_bus 0000:02: busn_res: can not insert [bus 02-ff] under [bus 01] (conflicts with (null) [bus 01])
> [    0.433056] pci 0000:02:01.0: [10b5:8605] type 01 class 0x060400
> [    0.433912] pci 0000:02:01.0: supports D1 D2
> [    0.433921] pci 0000:02:01.0: PME# supported from D0 D1 D2 D3hot D3cold
> [    0.434312] pci 0000:02:02.0: [10b5:8605] type 01 class 0x060400
> [    0.435168] pci 0000:02:02.0: supports D1 D2
> [    0.435177] pci 0000:02:02.0: PME# supported from D0 D1 D2 D3hot D3cold
> [    0.435568] pci 0000:02:03.0: [10b5:8605] type 01 class 0x060400
> [    0.436423] pci 0000:02:03.0: supports D1 D2
> [    0.436432] pci 0000:02:03.0: PME# supported from D0 D1 D2 D3hot D3cold
> [    0.437174] pci 0000:02:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> [    0.437230] pci 0000:02:02.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> [    0.437285] pci 0000:02:03.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> [    0.437738] pci 0000:03:00.0: [8086:1533] type 00 class 0x020000
> [    0.437922] pci 0000:03:00.0: reg 0x10: [mem 0x00000000-0x0007ffff]
> [    0.438032] pci 0000:03:00.0: reg 0x18: [io  0x0000-0x001f]
> [    0.438091] pci 0000:03:00.0: reg 0x1c: [mem 0x00000000-0x00003fff]
> [    0.438748] pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
> [    0.439458] pci_bus 0000:03: busn_res: [bus 03-ff] end is updated to 03
> [    0.439482] pci_bus 0000:03: [bus 03] partially hidden behind bridge 0000:01 [bus 01]

Even your working configuration is not actually working very well.
I think this is the same problem Koen's (CC'd) patch is fixing. Could
you try the patch here:

https://patchwork.ozlabs.org/patch/857566/

and see if it works better?
