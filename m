Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2nam01on0084.outbound.protection.outlook.com ([104.47.34.84]:6320
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752097AbcLILEQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Dec 2016 06:04:16 -0500
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
Date: Fri, 9 Dec 2016 11:04:00 +0000
Message-ID: <8520D5D51A55D047800579B094147198263A7F11@XAP-PVEXMBX02.xlnx.xilinx.com>
References: <8520D5D51A55D047800579B094147198263A7222@XAP-PVEXMBX02.xlnx.xilinx.com>
 <20161208145608.GA19822@bhelgaas-glaptop.roam.corp.google.com>
 <8520D5D51A55D047800579B094147198263A72F5@XAP-PVEXMBX02.xlnx.xilinx.com>
 <48ec7cdf-5a5f-bd4a-3ba2-a7bb294e161f@arm.com>
 <8520D5D51A55D047800579B094147198263A77C5@XAP-PVEXMBX02.xlnx.xilinx.com>
 <6a718bb8-f827-8b7f-ac10-f924cbc5e463@arm.com>
 <8520D5D51A55D047800579B094147198263A79AC@XAP-PVEXMBX02.xlnx.xilinx.com>
 <d8bc6283-8b37-76d6-8ff1-0847ee015380@arm.com>
In-Reply-To: <d8bc6283-8b37-76d6-8ff1-0847ee015380@arm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> On 09/12/16 02:07, Bharat Kumar Gogada wrote:
> >> On 08/12/16 18:33, Bharat Kumar Gogada wrote:
> >>>> On 08/12/16 15:29, Bharat Kumar Gogada wrote:
> >>>>> 218:         61          0          0          0     GICv2  81 Leve=
l     mmc0
> >>>>> 219:          0          0          0          0     GICv2 187 Leve=
l     arm-smmu global
> fault
> >>>>> 220:        471          0          0          0     GICv2  53 Leve=
l     xuartps
> >>>>> 223:          0          0          0          0     GICv2 154 Leve=
l     fd4c0000.dma
> >>>>> 224:          3          0          0          0     dummy   1 Edge=
      ath9k
> >>>>
> >>>> What is this "dummy" controller? And if that's supposed to be a
> >>>> legacy interrupt from the PCI device, it has the wrong trigger.
> >>>
> >>> Yes it is for legacy interrupt, wrong trigger means ?
> >>
> >> Aren't legacy interrupts supposed to be *level* triggered, and not edg=
e?
> >>
> > Yes agreed.
> > For legacy interrupts im using irq_set_chained_handler_and_data so the
> > irq line between bridge and GIC Will not be shown here. The above how
> > is virq for legacy, which is given by kernel, not sure why its state is=
 set to edge.
>=20
> Well, you should try and find out. Edge triggering for legacy interrupts =
is a real
> bug, and I don't think it has anything to do with arm64 (despite what the=
 subject
> says).
>=20
Thanks Marc. Here is the ARM32 bit log for cat /proc/interrupts,=20
Here also it shows edge but still scan works successfully.
root@:~#cat /proc/interrupts=20
           CPU0       CPU1      =20
 16:          1          0     GIC-0  27 Edge      gt
 17:          0          0     GIC-0  43 Level     ttc_clockevent
 18:       3049       1170     GIC-0  29 Edge      twd
 21:         43          0     GIC-0  39 Level     f8007100.adc
141:        462          0     GIC-0  57 Level     cdns-i2c
143:          0          0     GIC-0  35 Level     f800c000.ocmc
144:       1259          0     GIC-0  82 Level     xuartps
145:          3          0     GIC-0  51 Level     e000d000.spi
146:          0          0     GIC-0  54 Level     eth0
147:         54          0     GIC-0  56 Level     mmc0
148:          0          0     GIC-0  45 Level     f8003000.dmac
149:          0          0     GIC-0  46 Level     f8003000.dmac
150:          0          0     GIC-0  47 Level     f8003000.dmac
151:          0          0     GIC-0  48 Level     f8003000.dmac
152:          0          0     GIC-0  49 Level     f8003000.dmac
153:          0          0     GIC-0  72 Level     f8003000.dmac
154:          0          0     GIC-0  73 Level     f8003000.dmac
155:          0          0     GIC-0  74 Level     f8003000.dmac
156:          0          0     GIC-0  75 Level     f8003000.dmac
157:          0          0     GIC-0  40 Level     f8007000.devcfg
163:          0          0     GIC-0  53 Level     e0002000.usb
164:          0          0     GIC-0  41 Edge      f8005000.watchdog
165:        158          0     GIC-0  61 Level     xilinx-pcie
166:        122         18     dummy   1 Edge      ath9k
IPI1:          0          0  Timer broadcast interrupts
IPI2:       1101       2349  Rescheduling interrupts
IPI3:         34         20  Function call interrupts
IPI4:          0          0  CPU stop interrupts
IPI5:          0          0  IRQ work interrupts
IPI6:          0          0  completion interrupts

root@Xilinx-ZC706-2016_3:~# iw dev wlnan0 scan
BSS d8:c7:c8:26:6a:72(on wlan0)
	TSF: 349496494967 usec (4d, 01:04:56)
	freq: 2412
	beacon interval: 100 TUs
	capability: ESS ShortPreamble ShortSlotTime (0x0421)
	signal: -47.00 dBm
	last seen: 2170 ms ago
.....
....

Thanks & Regards,
Bharat
