Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:36710 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401AbaBDJKq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 4 Feb 2014 04:10:46 -0500
Received: by mail-we0-f169.google.com with SMTP id t61so3824553wes.14
        for <linux-pci@vger.kernel.org>; Tue, 04 Feb 2014 01:10:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAM9uW_6rrXrwEKSXBZd+B=WzyoFqjrBgrmXNk0u42JFuMcTJ=g@mail.gmail.com>
References: <CAM9uW_75p7rt4V82TysSKmVbsYYgWqYwgaecyHMa+q4kSRwzUw@mail.gmail.com>
 <CAErSpo472PpApvYf1oV5kyW24u7GJrzMhTtMw3TZ4A2pM7jZ9g@mail.gmail.com>
 <CAM9uW_7CB_E2Ok=BvVCVqyGTpKk9GX8HqN12B2m59Dj12ZW+HA@mail.gmail.com>
 <CAM9uW_56VQTui7ggin2kCHH=5JfS2SCm--T51azUZA3da8st9g@mail.gmail.com>
 <CAErSpo6MnY74S=jEemQ9xKDg0xik616MeNE67vROap3orQohGA@mail.gmail.com> <CAM9uW_6rrXrwEKSXBZd+B=WzyoFqjrBgrmXNk0u42JFuMcTJ=g@mail.gmail.com>
From: Kamel BOUHARA <k.bouhara@gmail.com>
Date: Tue, 4 Feb 2014 10:10:25 +0100
Message-ID: <CAM9uW_6ok-H1YpqUu3CgZ45aezi9rs+eDjCHBmd9-vO4jDjf4w@mail.gmail.com>
Subject: Re: PCIe trouble on imx6q
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	Zhu Richard-R65037 <r65037@freescale.com>,
	Shawn Guo <shawn.guo@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

2014-01-29 Kamel BOUHARA <k.bouhara@gmail.com>:
> 2014-01-29 Bjorn Helgaas <bhelgaas@google.com>:
>> [+cc linux-arm, Richard, Shawn (please keep the cc list)]
>>
>> On Wed, Jan 29, 2014 at 2:28 AM, Kamel BOUHARA <k.bouhara@gmail.com> wrote:
>>> ---------- Forwarded message ----------
>>> From: Kamel BOUHARA <k.bouhara@gmail.com>
>>> Date: 2014-01-29
>>> Subject: Re: PCIe trouble on imx6q
>>> To: Bjorn Helgaas <bhelgaas@google.com>
>>>
>>>
>>> 2014-01-28 Bjorn Helgaas <bhelgaas@google.com>:
>>>> [+cc Richard, Shawn, linux-arm-kernel (all from MAINTAINERS)]
>>>>
>>>> On Tue, Jan 28, 2014 at 1:02 AM, Kamel BOUHARA <k.bouhara@gmail.com> wrote:
>>>>> Hello,
>>>>>
>>>>> Im getting trouble with kernel 3.13 at boot time, the pcie link failed
>>>>> to get up with the following log:
>>>>> ------------[ cut here ]------------
>>>>> WARNING: CPU: 0 PID: 1 at drivers/gpio/gpiolib.c:159 gpio_to_desc+0x34/0x48()
>>>>> invalid GPIO -2
>>>>> Modules linked in:
>>>>> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.13.0+ #4
>>>>> Backtrace:
>>>>> [<8001217c>] (dump_backtrace) from [<80012460>] (show_stack+0x18/0x1c)
>>>>>  r6:802b9548 r5:00000000 r4:808d3060 r3:00000000
>>>>> [<80012448>] (show_stack) from [<806414fc>] (dump_stack+0x84/0x9c)
>>>>> [<80641478>] (dump_stack) from [<800289f8>] (warn_slowpath_common+0x70/0x94)
>>>>>  r5:00000009 r4:bf05bcb0
>>>>> [<80028988>] (warn_slowpath_common) from [<80028a54>]
>>>>> (warn_slowpath_fmt+0x38/0x40)
>>>>>  r8:01f00000 r7:00000000 r6:0011cc11 r5:808b68c0 r4:bf24fa30
>>>>> [<80028a20>] (warn_slowpath_fmt) from [<802b9548>] (gpio_to_desc+0x34/0x48)
>>>>>  r3:fffffffe r2:807d23fc
>>>>> [<802b9514>] (gpio_to_desc) from [<802d9de0>] (imx6_pcie_host_init+0x174/0x434)
>>>>> [<802d9c6c>] (imx6_pcie_host_init) from [<80886dbc>]
>>>>> (dw_pcie_host_init+0x348/0x41c)
>>>>>  r6:00000000 r5:808d52cc r4:00000020 r3:802d9c6c
>>>>> [<80886a74>] (dw_pcie_host_init) from [<808871d4>] (imx6_pcie_probe+0x320/0x3dc)
>>>>>  r10:00000000 r9:000000c4 r8:808d539c r7:bf7e3384 r6:bf24fa30 r5:bf135810
>>>>>  r4:bf24fa10
>>>>> [<80886eb4>] (imx6_pcie_probe) from [<8034b670>] (platform_drv_probe+0x20/0x50)
>>>>>  r8:808d539c r7:00000000 r6:00000000 r5:808d539c r4:bf135810
>>>>> [<8034b650>] (platform_drv_probe) from [<80349c74>]
>>>>> (driver_probe_device+0x118/0x234)
>>>>>  r5:bf135810 r4:80e526b8
>>>>> [<80349b5c>] (driver_probe_device) from [<80349e78>] (__driver_attach+0x9c/0xa0)
>>>>>  r8:80886e90 r7:00000000 r6:bf135844 r5:808d539c r4:bf135810 r3:00000000
>>>>> [<80349ddc>] (__driver_attach) from [<8034806c>] (bus_for_each_dev+0x68/0x9c)
>>>>>  r6:80349ddc r5:808d539c r4:00000000 r3:00000000
>>>>> [<80348004>] (bus_for_each_dev) from [<8034972c>] (driver_attach+0x20/0x28)
>>>>>  r6:808df6a8 r5:bf1f5e00 r4:808d539c
>>>>> [<8034970c>] (driver_attach) from [<803493b0>] (bus_add_driver+0x148/0x1f4)
>>>>> [<80349268>] (bus_add_driver) from [<8034a4c8>] (driver_register+0x80/0x100)
>>>>>  r7:8090e640 r6:8090e640 r5:00000005 r4:808d539c
>>>>> [<8034a448>] (driver_register) from [<8034b63c>]
>>>>> (__platform_driver_register+0x50/0x64)
>>>>>  r5:00000005 r4:808d5388
>>>>> [<8034b5ec>] (__platform_driver_register) from [<8034b6e0>]
>>>>> (platform_driver_probe+0x28/0xac)
>>>>> [<8034b6b8>] (platform_driver_probe) from [<80886ea8>]
>>>>> (imx6_pcie_init+0x18/0x24)
>>>>>  r5:00000005 r4:808aa104
>>>>> [<80886e90>] (imx6_pcie_init) from [<80008978>] (do_one_initcall+0x100/0x164)
>>>>> [<80008878>] (do_one_initcall) from [<8085ecc0>]
>>>>> (kernel_init_freeable+0x10c/0x1d0)
>>>>>  r10:8089e060 r9:000000c4 r8:8089e050 r7:8090e640 r6:8090e640 r5:00000005
>>>>>  r4:808aa104
>>>>> [<8085ebb4>] (kernel_init_freeable) from [<8063b67c>] (kernel_init+0x10/0x120)
>>>>>  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:8063b66c
>>>>>  r4:00000000
>>>>> [<8063b66c>] (kernel_init) from [<8000e9c8>] (ret_from_fork+0x14/0x2c)
>>>>>  r4:00000000 r3:ffffffff
>>>>> ---[ end trace b5e746dfc2398cd6 ]---
>>>>> ------------[ cut here ]------------
>>>>> WARNING: CPU: 0 PID: 1 at drivers/gpio/gpiolib.c:159 gpio_to_desc+0x34/0x48()
>>>>> invalid GPIO -2
>>>>> Modules linked in:
>>>>> CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W    3.13.0+ #4
>>>>> Backtrace:
>>>>> [<8001217c>] (dump_backtrace) from [<80012460>] (show_stack+0x18/0x1c)
>>>>>  r6:802b9548 r5:00000000 r4:808d3060 r3:00000000
>>>>> [<80012448>] (show_stack) from [<806414fc>] (dump_stack+0x84/0x9c)
>>>>> [<80641478>] (dump_stack) from [<800289f8>] (warn_slowpath_common+0x70/0x94)
>>>>>  r5:00000009 r4:bf05bcb0
>>>>> [<80028988>] (warn_slowpath_common) from [<80028a54>]
>>>>> (warn_slowpath_fmt+0x38/0x40)
>>>>>  r8:01f00000 r7:00000000 r6:0011cc11 r5:808b68c0 r4:bf24fa30
>>>>> [<80028a20>] (warn_slowpath_fmt) from [<802b9548>] (gpio_to_desc+0x34/0x48)
>>>>>  r3:fffffffe r2:807d23fc
>>>>> [<802b9514>] (gpio_to_desc) from [<802d9df8>] (imx6_pcie_host_init+0x18c/0x434)
>>>>> [<802d9c6c>] (imx6_pcie_host_init) from [<80886dbc>]
>>>>> (dw_pcie_host_init+0x348/0x41c)
>>>>>  r6:00000000 r5:808d52cc r4:00000020 r3:802d9c6c
>>>>> [<80886a74>] (dw_pcie_host_init) from [<808871d4>] (imx6_pcie_probe+0x320/0x3dc)
>>>>>  r10:00000000 r9:000000c4 r8:808d539c r7:bf7e3384 r6:bf24fa30 r5:bf135810
>>>>>  r4:bf24fa10
>>>>> [<80886eb4>] (imx6_pcie_probe) from [<8034b670>] (platform_drv_probe+0x20/0x50)
>>>>>  r8:808d539c r7:00000000 r6:00000000 r5:808d539c r4:bf135810
>>>>> [<8034b650>] (platform_drv_probe) from [<80349c74>]
>>>>> (driver_probe_device+0x118/0x234)
>>>>>  r5:bf135810 r4:80e526b8
>>>>> [<80349b5c>] (driver_probe_device) from [<80349e78>] (__driver_attach+0x9c/0xa0)
>>>>>  r8:80886e90 r7:00000000 r6:bf135844 r5:808d539c r4:bf135810 r3:00000000
>>>>> [<80349ddc>] (__driver_attach) from [<8034806c>] (bus_for_each_dev+0x68/0x9c)
>>>>>  r6:80349ddc r5:808d539c r4:00000000 r3:00000000
>>>>> [<80348004>] (bus_for_each_dev) from [<8034972c>] (driver_attach+0x20/0x28)
>>>>>  r6:808df6a8 r5:bf1f5e00 r4:808d539c
>>>>> [<8034970c>] (driver_attach) from [<803493b0>] (bus_add_driver+0x148/0x1f4)
>>>>> [<80349268>] (bus_add_driver) from [<8034a4c8>] (driver_register+0x80/0x100)
>>>>>  r7:8090e640 r6:8090e640 r5:00000005 r4:808d539c
>>>>> [<8034a448>] (driver_register) from [<8034b63c>]
>>>>> (__platform_driver_register+0x50/0x64)
>>>>>  r5:00000005 r4:808d5388
>>>>> [<8034b5ec>] (__platform_driver_register) from [<8034b6e0>]
>>>>> (platform_driver_probe+0x28/0xac)
>>>>> [<8034b6b8>] (platform_driver_probe) from [<80886ea8>]
>>>>> (imx6_pcie_init+0x18/0x24)
>>>>>  r5:00000005 r4:808aa104
>>>>> [<80886e90>] (imx6_pcie_init) from [<80008978>] (do_one_initcall+0x100/0x164)
>>>>> [<80008878>] (do_one_initcall) from [<8085ecc0>]
>>>>> (kernel_init_freeable+0x10c/0x1d0)
>>>>>  r10:8089e060 r9:000000c4 r8:8089e050 r7:8090e640 r6:8090e640 r5:00000005
>>>>>  r4:808aa104
>>>>> [<8085ebb4>] (kernel_init_freeable) from [<8063b67c>] (kernel_init+0x10/0x120)
>>>>>  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:8063b66c
>>>>>  r4:00000000
>>>>> [<8063b66c>] (kernel_init) from [<8000e9c8>] (ret_from_fork+0x14/0x2c)
>>>>>  r4:00000000 r3:ffffffff
>>>>> ---[ end trace b5e746dfc2398cd7 ]---
>>>>> imx6q-pcie 1ffc000.pcie: phy link never came up
>>>>> PCI host bridge to bus 0000:00
>>>>> pci_bus 0000:00: root bus resource [io  0x1000-0x10000]
>>>>> pci_bus 0000:00: root bus resource [mem 0x01000000-0x01efffff]
>>>>> pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
>>>>
>>>> Not related to the GPIO/link problem, but something's wrong here --
>>>> the host bridge driver should be telling us what bus numbers are
>>>> behind the host bridge.  Since it didn't, the PCI core had to guess.
>>>>
>>>>> PCI: bus0: Fast back to back transfers disabled
>>>>> PCI: bus1: Fast back to back transfers enabled
>>>>> pci 0000:00:00.0: BAR 0: assigned [mem 0x01000000-0x010fffff]
>>>>> pci 0000:00:00.0: BAR 6: assigned [mem 0x01100000-0x0110ffff pref]
>>>>> pci 0000:00:00.0: PCI bridge to [bus 01]
>>>>> pci 0000:00:00.0: PCI bridge to [bus 01]
>>>>>
>>>>> Please, any help is welcome.
>>>>> Regards,
>>>>> Kamel.B
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>> So I suppose, this is not a hardware issue rather a  bad configuration ?
>>> Maybe the following log from lspci will be helpful ?
>>
>> It looks like a configuration issue or an imx6q host bridge issue.  In
>> either case, it looks like something *before* we get to PCIe, so
>> something like your DT description of the host bridge is more likely
>> to be useful.
>>
>>> root@phyFLEX-i:~ lspci -vvv
>>> 00:00.0 PCI bridge: Device 16c3:abcd (rev 01) (prog-if 00 [Normal decode])
>>>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
>>> ParErr+ Stepping- SERR+ FastB2B- DisINTx+
>>>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
>>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>         Latency: 0, Cache Line Size: 64 bytes
>>>         Region 0: Memory at 01000000 (32-bit, non-prefetchable) [size=1M]
>>>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
>>>         I/O behind bridge: 0000f000-00000fff
>>>         Memory behind bridge: fff00000-000fffff
>>>         Prefetchable memory behind bridge: fff00000-000fffff
>>>         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
>>> <TAbort- <MAbort- <SERR- <PERR-
>>>         [virtual] Expansion ROM at 01100000 [disabled] [size=64K]
>>>         BridgeCtl: Parity+ SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
>>>                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>>>         Capabilities: [40] Power Management version 3
>>>                 Flags: PMEClk- DSI- D1+ D2- AuxCurrent=375mA
>>> PME(D0+,D1+,D2-,D3hot+,D3cold+)
>>>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>>>         Capabilities: [50] MSI: Mask+ 64bit+ Count=1/1 Enable+
>>>                 Address: 0000000090000000  Data: 0000
>>>                 Masking: 00000000  Pending: 00000000
>>>         Capabilities: [70] Express (v2) Root Port (Slot-), MSI 00
>>>                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s
>>> <64ns, L1 <1us
>>>                         ExtTag- RBE+ FLReset-
>>>                 DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+
>>> Unsupported+
>>>                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
>>>                         MaxPayload 128 bytes, MaxReadReq 512 bytes
>>>                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq-
>>> AuxPwr+ TransPend-
>>>                 LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1,
>>> Latency L0 <1us, L1 <8us
>>>                         ClockPM- Surprise- LLActRep+ BwNot-
>>>                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
>>>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>>>                 LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train-
>>> SlotClk+ DLActive- BWMgmt- ABWMgmt-
>>>                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal-
>>> PMEIntEna+ CRSVisible-
>>>                 RootCap: CRSVisible-
>>>                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>>>                 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ ARIFwd-
>>>                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
>>>                 LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance-
>>> SpeedDis-, Selectable De-emphasis: -6dB
>>>                          Transmit Margin: Normal Operating Range,
>>> EnterModifiedCompliance- ComplianceSOS-
>>>                          Compliance De-emphasis: -6dB
>>>                 LnkSta2: Current De-emphasis Level: -3.5dB
>>>         Capabilities: [100] Advanced Error Reporting
>>>                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
>>> UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>>>                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
>>> UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>>>                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
>>> UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>>>                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
>>>                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
>>>                 AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
>>>         Capabilities: [140] Virtual Channel <?>
>>>         Kernel driver in use: pcieport
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> Ok, actually I didn't get the host bridge set properly for my board,
> here is my DT:
>
>
> /dts-v1/;
> #include "imx6q-phytec-pfla02.dtsi"
>
> / {
>     model = "Phytec phyFLEX-i.MX6 Quad Carrier-Board";
>     compatible = "phytec,imx6q-pbab01", "phytec,imx6q-pfla02", "fsl,imx6q";
> };
>
> &fec {
>     status = "okay";
> };
>
> &uart4 {
>     status = "okay";
> };
>
> &usdhc2 {
>     status = "okay";
> };
>
> &usdhc3 {
>     status = "okay";
> };
>
> &pcie {
>   status = "okay";
> };
>
>
> Can you give me a example of host configuration ?
>
>
> BR, Kamel.B

I finally found that I missed the disable-gpio that has to be at high level:

&pcie {
    /*module  pfla02 rev1 */
#if 0
    reset-gpio = <&gpio2 23 0>; /* active low */
    wake-up-gpio = <&gpio1 7 0>;  /* active low */
    disable-gpio = <&gpio1 21 1>; /* active low, don't disable endpoint gpios */
#endif
#if 1
    /*module pfla02 rev2*/
    reset-gpio = <&gpio2 23 0>;
    wake-up-gpio = <&gpio1 7 0>;
    disable-gpio = <&gpio4 17 1>;
#endif
};

But Im still stuck on the bus ressource affectation, Bjorn Helgaas
said that normally it is auto affected by the host bridge driver ?
Is there a patch to fix this ?

imx6q-pcie 1ffc000.pcie: reset-gpio number is 55
imx6q-pcie 1ffc000.pcie: power-on-gpio number is -2
imx6q-pcie 1ffc000.pcie: wake-up-gpio number is 7
imx6q-pcie 1ffc000.pcie: disable-gpio number is 113
PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x1000-0x10000]
pci_bus 0000:00: root bus resource [mem 0x01000000-0x01efffff]
pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
PCI: bus0: Fast back to back transfers disabled
PCI: bus1: Fast back to back transfers disabled
pci 0000:00:00.0: BAR 0: assigned [mem 0x01000000-0x010fffff]
pci 0000:00:00.0: BAR 9: assigned [mem 0x01100000-0x011fffff pref]
pci 0000:00:00.0: BAR 6: assigned [mem 0x01200000-0x0120ffff pref]
pci 0000:01:00.0: BAR 0: assigned [mem 0x01100000-0x01100fff 64bit pref]
pci 0000:00:00.0: PCI bridge to [bus 01]
pci 0000:00:00.0:   bridge window [mem 0x01100000-0x011fffff pref]
pci 0000:00:00.0: PCI bridge to [bus 01]
pci 0000:00:00.0:   bridge window [mem 0x01100000-0x011fffff pref]

BR, Kamel B.
