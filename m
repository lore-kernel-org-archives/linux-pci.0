Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sn1nam02on0085.outbound.protection.outlook.com ([104.47.36.85]:34254
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932192AbcLICyd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Dec 2016 21:54:33 -0500
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: Bharat Kumar Gogada <bharatku@xilinx.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Janusz.Dziedzic@tieto.com" <Janusz.Dziedzic@tieto.com>,
        "rmanohar@qti.qualcomm.com" <rmanohar@qti.qualcomm.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "ath9k-devel@qca.qualcomm.com" <ath9k-devel@qca.qualcomm.com>
Subject: RE: ATH9 driver issues on ARM64
Date: Fri, 9 Dec 2016 02:39:43 +0000
Message-ID: <8520D5D51A55D047800579B094147198263A79ED@XAP-PVEXMBX02.xlnx.xilinx.com>
References: <8520D5D51A55D047800579B094147198263A7222@XAP-PVEXMBX02.xlnx.xilinx.com>
 <20161208145608.GA19822@bhelgaas-glaptop.roam.corp.google.com>
 <8520D5D51A55D047800579B094147198263A72F5@XAP-PVEXMBX02.xlnx.xilinx.com>
 <48ec7cdf-5a5f-bd4a-3ba2-a7bb294e161f@arm.com>
 <8520D5D51A55D047800579B094147198263A77C5@XAP-PVEXMBX02.xlnx.xilinx.com>
 <6a718bb8-f827-8b7f-ac10-f924cbc5e463@arm.com>
 <8520D5D51A55D047800579B094147198263A79AC@XAP-PVEXMBX02.xlnx.xilinx.com>
In-Reply-To: <8520D5D51A55D047800579B094147198263A79AC@XAP-PVEXMBX02.xlnx.xilinx.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> > >> On 08/12/16 15:29, Bharat Kumar Gogada wrote:
> > >>
> > >> Two things:
> > >>
> > >>> Here is the cat /proc/interrupts (after we do interface up):
> > >>>
> > >>> root@:~# ifconfig wlan0 up
> > >>> [ 1548.926601] IPv6: ADDRCONF(NETDEV_UP): wlan0: link is not ready
> > >>> root@Xilinx-ZCU102-2016_3:~# cat /proc/interrupts
> > >>>            CPU0       CPU1       CPU2       CPU3
> > >>>   1:          0          0          0          0     GICv2  29 Edge=
      arch_timer
> > >>>   2:      19873      20058      19089      17435     GICv2  30 Edge=
      arch_timer
> >
> > By the way, please use a recent kernel. Seeing edge here means you're
> > running with something that is a bit old (and broken). And since you
> > haven't even said what revision of the kernel you're using, hslping
> > you is not an easy task. tglx told you something similar about a week a=
go.
> >
> > >>>  12:          0          0          0          0     GICv2 156 Leve=
l     zynqmp-dma
> > >>>  13:          0          0          0          0     GICv2 157 Leve=
l     zynqmp-dma
> > >>>  14:          0          0          0          0     GICv2 158 Leve=
l     zynqmp-dma
> > >>>  15:          0          0          0          0     GICv2 159 Leve=
l     zynqmp-dma
> > >>>  16:          0          0          0          0     GICv2 160 Leve=
l     zynqmp-dma
> > >>>  17:          0          0          0          0     GICv2 161 Leve=
l     zynqmp-dma
> > >>>  18:          0          0          0          0     GICv2 162 Leve=
l     zynqmp-dma
> > >>>  19:          0          0          0          0     GICv2 163 Leve=
l     zynqmp-dma
> > >>>  20:          0          0          0          0     GICv2 164 Leve=
l     Mali_GP_MMU,
> > Mali_GP,
> > >> Mali_PP0_MMU, Mali_PP0, Mali_PP1_MMU, Mali_PP1
> > >>
> > >> I'm not even going to consider looking at something that is running
> > >> out of tree code. So please start things with a fresh kernel that
> > >> doesn't contain stuff we can't debug.
> > >>
> > > Ok will test with fresh kernel.
> > >
> > >>>  30:          0          0          0          0     GICv2  95 Leve=
l     eth0, eth0
> > >>> 206:        314          0          0          0     GICv2  49 Leve=
l     cdns-i2c
> > >>> 207:         40          0          0          0     GICv2  50 Leve=
l     cdns-i2c
> > >>> 209:          0          0          0          0     GICv2 150 Leve=
l     nwl_pcie:misc
> This irq line is handling miscellaneous interrupts this shows level trigg=
ered.
> > >>> 214:         12          0          0          0     GICv2  47 Leve=
l     ff0f0000.spi
> > >>> 215:          0          0          0          0     GICv2  58 Leve=
l     ffa60000.rtc
> > >>> 216:          0          0          0          0     GICv2  59 Leve=
l     ffa60000.rtc
> > >>> 217:          0          0          0          0     GICv2 165 Leve=
l     ahci-
> > ceva[fd0c0000.ahci]
> > >>> 218:         61          0          0          0     GICv2  81 Leve=
l     mmc0
> > >>> 219:          0          0          0          0     GICv2 187 Leve=
l     arm-smmu global
> fault
> > >>> 220:        471          0          0          0     GICv2  53 Leve=
l     xuartps
> > >>> 223:          0          0          0          0     GICv2 154 Leve=
l     fd4c0000.dma
> > >>> 224:          3          0          0          0     dummy   1 Edge=
      ath9k
> > >>
> > >> What is this "dummy" controller? And if that's supposed to be a
> > >> legacy interrupt from the PCI device, it has the wrong trigger.
> > >
> > > Yes it is for legacy interrupt, wrong trigger means ?
> >
> > Aren't legacy interrupts supposed to be *level* triggered, and not edge=
?
> >
> Yes agreed.
> For legacy interrupts im using irq_set_chained_handler_and_data so the ir=
q line
> between bridge and GIC Will not be shown here. The above how is virq for
> legacy, which is given by kernel, not sure why its state is set to edge.
>=20
>=20

Here I'm adding fresh kernel log: (using 4.6.0 kernel version)
root@Xilinx-ZCU102-2016_3:~# cat /proc/interrupts=20
           CPU0       CPU1       CPU2       CPU3      =20
  1:          0          0          0          0     GICv2  29 Edge      ar=
ch_timer
  2:       1368       1294       1655       2657     GICv2  30 Edge      ar=
ch_timer
 30:          0          0          0          0     GICv2  95 Level     et=
h0, eth0
206:        311          0          0          0     GICv2  49 Level     cd=
ns-i2c
207:         40          0          0          0     GICv2  50 Level     cd=
ns-i2c
209:          0          0          0          0     GICv2 150 Level     nw=
l_pcie:misc
214:          7          0          0          0     GICv2  47 Level     ff=
0f0000.spi
215:          0          0          0          0     GICv2  58 Level     ff=
a60000.rtc
216:          0          0          0          0     GICv2  59 Level     ff=
a60000.rtc
217:          0          0          0          0     GICv2 165 Level     ah=
ci-ceva[fd0c0000.ahci]
218:          0          0          0          0     GICv2  81 Level     mm=
c0
219:          0          0          0          0     GICv2 187 Level     ar=
m-smmu global fault
220:        126          0          0          0     GICv2  53 Level     xu=
artps
224:          3          0          0          0     dummy   1 Edge      at=
h9k
IPI0:      1293       1003        914        671       Rescheduling interru=
pts
IPI1:        77         78         25         55       Function call interr=
upts
IPI2:         0          0          0          0       CPU stop interrupts
IPI3:         0          0          0          0       Timer broadcast inte=
rrupts
IPI4:         0          0          0          0       IRQ work interrupts
IPI5:         0          0          0          0       CPU wake-up interrup=
ts


root@Xilinx-ZCU102-2016_3:~#iw dev wlan0 scan
[   95.869644] INFO: rcu_sched detected stalls on CPUs/tasks:
[   95.875051] 	0-...: (1 GPs behind) idle=3D659/140000000000001/0 softirq=
=3D1166/1166 fqs=3D257=20
[   95.883125] 	(detected by 3, t=3D5253 jiffies, g=3D217, c=3D216, q=3D54)
[   95.889108] Task dump for CPU 0:
[   95.892318] kworker/u8:0    R  running task        0     6      2 0x0000=
0002
[   95.899359] Workqueue: phy0 ieee80211_scan_work
[   95.903862] Call trace:
[   95.906299] [<ffffff8008086b14>] __switch_to+0x9c/0xd0
[   95.911417] [<ffffffc87b87fc00>] 0xffffffc87b87fc00
[  158.969641] INFO: rcu_sched detected stalls on CPUs/tasks:
[  158.975046] 	0-...: (1 GPs behind) idle=3D659/140000000000001/0 softirq=
=3D1166/1166 fqs=3D1028=20
[  158.983209] 	(detected by 3, t=3D21028 jiffies, g=3D217, c=3D216, q=3D54=
)
[  158.989278] Task dump for CPU 0:
[  158.992489] kworker/u8:0    R  running task        0     6      2 0x0000=
0002
[  158.999523] Workqueue: phy0 ieee80211_scan_work
[  159.004032] Call trace:
[  159.006467] [<ffffff8008086b14>] __switch_to+0x9c/0xd0
[  159.011588] [<ffffffc87b87fc00>] 0xffffffc87b87fc00


Thans & Regards,
Bharat
