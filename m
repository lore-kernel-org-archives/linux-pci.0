Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn3nam01on0043.outbound.protection.outlook.com ([104.47.33.43]:11712
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752105AbcLHSd2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Dec 2016 13:33:28 -0500
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Janusz.Dziedzic@tieto.com" <Janusz.Dziedzic@tieto.com>,
        "rmanohar@qti.qualcomm.com" <rmanohar@qti.qualcomm.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "ath9k-devel@qca.qualcomm.com" <ath9k-devel@qca.qualcomm.com>
Subject: RE: ATH9 driver issues on ARM64
Date: Thu, 8 Dec 2016 18:33:17 +0000
Message-ID: <8520D5D51A55D047800579B094147198263A77C5@XAP-PVEXMBX02.xlnx.xilinx.com>
References: <8520D5D51A55D047800579B094147198263A7222@XAP-PVEXMBX02.xlnx.xilinx.com>
 <20161208145608.GA19822@bhelgaas-glaptop.roam.corp.google.com>
 <8520D5D51A55D047800579B094147198263A72F5@XAP-PVEXMBX02.xlnx.xilinx.com>
 <48ec7cdf-5a5f-bd4a-3ba2-a7bb294e161f@arm.com>
In-Reply-To: <48ec7cdf-5a5f-bd4a-3ba2-a7bb294e161f@arm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> On 08/12/16 15:29, Bharat Kumar Gogada wrote:
>=20
> Two things:
>=20
> > Here is the cat /proc/interrupts (after we do interface up):
> >
> > root@:~# ifconfig wlan0 up
> > [ 1548.926601] IPv6: ADDRCONF(NETDEV_UP): wlan0: link is not ready
> > root@Xilinx-ZCU102-2016_3:~# cat /proc/interrupts
> >            CPU0       CPU1       CPU2       CPU3
> >   1:          0          0          0          0     GICv2  29 Edge    =
  arch_timer
> >   2:      19873      20058      19089      17435     GICv2  30 Edge    =
  arch_timer
> >  12:          0          0          0          0     GICv2 156 Level   =
  zynqmp-dma
> >  13:          0          0          0          0     GICv2 157 Level   =
  zynqmp-dma
> >  14:          0          0          0          0     GICv2 158 Level   =
  zynqmp-dma
> >  15:          0          0          0          0     GICv2 159 Level   =
  zynqmp-dma
> >  16:          0          0          0          0     GICv2 160 Level   =
  zynqmp-dma
> >  17:          0          0          0          0     GICv2 161 Level   =
  zynqmp-dma
> >  18:          0          0          0          0     GICv2 162 Level   =
  zynqmp-dma
> >  19:          0          0          0          0     GICv2 163 Level   =
  zynqmp-dma
> >  20:          0          0          0          0     GICv2 164 Level   =
  Mali_GP_MMU, Mali_GP,
> Mali_PP0_MMU, Mali_PP0, Mali_PP1_MMU, Mali_PP1
>=20
> I'm not even going to consider looking at something that is running out o=
f tree
> code. So please start things with a fresh kernel that doesn't contain stu=
ff we
> can't debug.
>=20
Ok will test with fresh kernel.

> >  30:          0          0          0          0     GICv2  95 Level   =
  eth0, eth0
> > 206:        314          0          0          0     GICv2  49 Level   =
  cdns-i2c
> > 207:         40          0          0          0     GICv2  50 Level   =
  cdns-i2c
> > 209:          0          0          0          0     GICv2 150 Level   =
  nwl_pcie:misc
> > 214:         12          0          0          0     GICv2  47 Level   =
  ff0f0000.spi
> > 215:          0          0          0          0     GICv2  58 Level   =
  ffa60000.rtc
> > 216:          0          0          0          0     GICv2  59 Level   =
  ffa60000.rtc
> > 217:          0          0          0          0     GICv2 165 Level   =
  ahci-ceva[fd0c0000.ahci]
> > 218:         61          0          0          0     GICv2  81 Level   =
  mmc0
> > 219:          0          0          0          0     GICv2 187 Level   =
  arm-smmu global fault
> > 220:        471          0          0          0     GICv2  53 Level   =
  xuartps
> > 223:          0          0          0          0     GICv2 154 Level   =
  fd4c0000.dma
> > 224:          3          0          0          0     dummy   1 Edge    =
  ath9k
>=20
> What is this "dummy" controller? And if that's supposed to be a legacy in=
terrupt
> from the PCI device, it has the wrong trigger.

Yes it is for legacy interrupt, wrong trigger means ?=20

Thanks & Regards,
Bharat
