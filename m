Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: Regression: 442ec4c04d1: PCI: dwc: all: Split struct pcie_port
 into host-only and core structures
To: Peter Senna Tschudin <peter.senna@collabora.com>
References: <20170508150224.GA7458@collabora.com>
 <967686bf-5f1b-29aa-ee2f-b976addbe98f@ti.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <1d5b46a7-b8ed-f58d-0064-bb19f664cd5c@ti.com>
Date: Mon, 8 May 2017 21:20:36 +0530
MIME-Version: 1.0
In-Reply-To: <967686bf-5f1b-29aa-ee2f-b976addbe98f@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Jesper Nilsson <jesper.nilsson@axis.com>, Joao Pinto <Joao.Pinto@synopsys.com>,
 Richard Zhu <hongxing.zhu@nxp.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Jingoo Han <jingoohan1@gmail.com>, Pratyush Anand <pratyush.anand@gmail.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Stanimir Varbanov <svarbanov@mm-sol.com>,
 Minghuan Lian <minghuan.Lian@freescale.com>,
 Zhou Wang <wangzhou1@hisilicon.com>, Murali Karicheri <m-karicheri2@ti.com>,
 Niklas Cassel <niklas.cassel@axis.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Mingkai Hu <mingkai.hu@freescale.com>, Roy Zang <tie-fei.zang@freescale.com>,
 linux-arm-kernel@lists.infradead.org, Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Monday 08 May 2017 09:09 PM, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Monday 08 May 2017 08:32 PM, Peter Senna Tschudin wrote:
>> Hello Kishon,
>>
>> Our iMX6 hardware (imx6q-b850v3.dts) is not booting with latest
>> linux-next and I could bisect until:
>>
>> commit 442ec4c04d1235f8c664a74004dae54a7a574d18
>> Author: Kishon Vijay Abraham I <kishon@ti.com>
>> Date:   Wed Feb 15 18:48:14 2017 +0530
>>
>>     PCI: dwc: all: Split struct pcie_port into host-only and core structures
>>
>> Which seem to be causing our issues. Our device (imx6q-b850v3.dts) boots
>> fine with 4.10, and also boots if we disable pcie with:
>>
>> diff --git a/arch/arm/boot/dts/imx6q-b850v3.dts b/arch/arm/boot/dts/imx6q-b850v3.dts
>> index 2c1e98e..e655fd7 100644
>> --- a/arch/arm/boot/dts/imx6q-b850v3.dts
>> +++ b/arch/arm/boot/dts/imx6q-b850v3.dts
>> @@ -212,3 +212,8 @@
>>                 };
>>         };
>>  };
>> +
>> +&pcie {
>> +        status = "disabled";
>> +};
>>
>> But otherwise our system freezes while initializing PCI, see dmesg with
>> some more information. Is this something specific of our system/dt or
>> can this be a bug that is affecting others as well?
> 
> Haven't seen this in dra7xx. I've tried with few ethernet PCIe cards and also a
> PCIe-to-PCI bridge.

Can you enable PCI_DEBUG and share the logs?

Thanks
Kishon

>>
>> Kind Regards,
>>
>> Peter
>>
>> Starting kernel ...
>>
>> Uncompressing Linux... done, booting the kernel.
> .
> .
> <snip>
> .
> .
>> [    0.501998] OF: PCI: host bridge /soc/pcie@1ffc000 ranges:
>> [    0.507275] OF: PCI:    IO 0x01f80000..0x01f8ffff -> 0x00000000
>> [    0.513202] OF: PCI:   MEM 0x01000000..0x01efffff -> 0x01000000
>> [    0.739697] imx6q-pcie 1ffc000.pcie: link up
>> [    0.741115] imx6q-pcie 1ffc000.pcie: Link: Gen2 disabled
>> [    0.746421] imx6q-pcie 1ffc000.pcie: Link up, Gen1
>> [    0.751343] imx6q-pcie 1ffc000.pcie: PCI host bridge to bus 0000:00
>> [    0.757475] pci_bus 0000:00: root bus resource [bus 00-ff]
>> [    0.762974] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
>> [    0.769128] pci_bus 0000:00: root bus resource [mem 0x01000000-0x01efffff]
>> [    0.776052] pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400
>> [    0.782044] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x000fffff]
>> [    0.788279] pci 0000:00:00.0: reg 0x38: [mem 0x00000000-0x0000ffff pref]
>> [    0.795041] pci 0000:00:00.0: supports D1
>> [    0.798971] pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
>> [    0.805503] PCI: bus0: Fast back to back transfers disabled
>> [    0.811079] pci 0000:01:00.0: [10b5:8605] type 01 class 0x060400
> 
> I could see a couple of device detected [16c3:abcd and [10b5:8605]. What other
> devices are connected?
>> [    0.817034] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00003fff]
>> [    0.823778] pci 0000:01:00.0: supports D1 D2
>> [    0.827418] pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
>> [    0.859773] PCI: bus1: Fast back to back transfers disabled
>> [    0.862502] pci 0000:01:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
>> [    0.870810] pci_bus 0000:02: busn_res: can not insert [bus 02-ff] under [bus 01] (conflicts with (null) [bus 01])
> 
> Do you get the above message in the working scenario?
>> [    0.880800] Unhandled fault: external abort on non-linefetch (0x1008) at 0xf0a40000
>> [    0.888416] pgd = 80004000
>> [    0.891112] [f0a40000] *pgd=7e01d811, *pte=01f40243, *ppte=01f40013
>> [    0.897384] Internal error: : 1008 [#1] SMP ARM
>> [    0.901903] Modules linked in:
>> [    0.904951] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.11.0-next-20170508-dirty #106
>> [    0.912775] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
>> [    0.919302] task: ee908000 task.stack: ee906000
>> [    0.923836] PC is at dw_pcie_read+0x60/0x8c
>> [    0.928005] LR is at dw_pcie_rd_conf+0x188/0x1e0
>> [    0.932616] pc : [<804125b8>]    lr : [<80413308>]    psr: 60000093
>> [    0.932616] sp : ee907af0  ip : ee907b00  fp : ee907afc
>> [    0.944096] r10: 00000000  r9 : eea28b10  r8 : 00000000
>> [    0.949317] r7 : 00000000  r6 : 00000000  r5 : f0a40000  r4 : eea28b28
>> [    0.955840] r3 : 00000000  r2 : ee907b6c  r1 : 00000004  r0 : f0a40000
>> [    0.962368] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
>> [    0.969589] Control: 10c5387d  Table: 1000404a  DAC: 00000051
>> [    0.975330] Process swapper/0 (pid: 1, stack limit = 0xee906210)
>> [    0.981333] Stack: (0xee907af0 to 0xee908000)
>> [    0.985686] 7ae0:                                     ee907b54 ee907b00 80413308 80412564
>> [    0.993864] 7b00: 01f40000 00000000 02000000 00000000 00040000 804126ec 01f40000 00000000
>> [    1.002041] 7b20: 804126ec 00000004 ee907b44 80413180 ee907bd4 60000013 00000000 00000002
>> [    1.010220] 7b40: 00000000 eeb1be00 ee907b8c ee907b58 803f3eac 8041318c ee907b6c 80412564
>> [    1.018397] 7b60: 00000000 00000000 ee907b84 00000000 00000000 00000000 ee907bd4 0000ea60
>> [    1.026577] 7b80: ee907bcc ee907b90 803f6598 803f3e40 eea28b10 00000000 ee907bfc 80400974
>> [    1.034754] 7ba0: 00000000 00000000 eeb1be00 00000000 00000000 00000002 00000000 00000001
>> [    1.042932] 7bc0: ee907bf4 ee907bd0 803f7f08 803f6570 ee907bfc 80db80b4 00000008 eeb1be00
>> [    1.051109] 7be0: eea16000 00000000 ee907c14 ee907bf8 803f7fec 803f7ec4 00000008 eeb1be00
>> [    1.059287] 7c00: eea16000 00000002 ee907c3c ee907c18 803f902c 803f7f88 eeb1bc00 eeb1be00
>> [    1.067466] 7c20: eea16000 00000001 00000002 00000000 ee907c94 ee907c40 803f8d58 803f9008
>> [    1.075643] 7c40: 8010e080 802097c8 80a57698 00000001 00000000 00000000 00000000 00000000
>> [    1.083821] 7c60: 00000001 00ff0201 ee907c94 eea16000 eeb1bc00 eeb1bc14 00000001 00000001
>> [    1.091999] 7c80: 00000001 00000001 ee907cbc ee907c98 803f9088 803f8ab4 eeb1ba00 eeb1bc00
>> [    1.100177] 7ca0: eea15c00 00000000 00000001 00000001 ee907d14 ee907cc0 803f8ca0 803f9008
>> [    1.108355] 7cc0: 8010e080 802097c8 80a57698 00000000 00000000 00000000 00000000 00000000
>> [    1.116533] 7ce0: 00000001 00010100 ee907d14 eea15c00 eeb1ba00 eeb1ba14 00000000 00000000
>> [    1.124712] 7d00: ee803e10 00000000 ee907d3c ee907d18 803f9088 803f8ab4 00000000 eeb1ba00
>> [    1.132890] 7d20: 80d308b4 ee907d70 ee907d70 ee803e10 ee907d5c ee907d40 803f92d4 803f9008
>> [    1.141069] 7d40: ee907d70 80d308b4 eea28b28 80d3082c ee907da4 ee907d60 80413d20 803f9274
>> [    1.149247] 7d60: ee907d70 80d308b4 8016f3bc eefd9ef8 ee907d70 ee907d70 ee803e00 00000000
>> [    1.157425] 7d80: eea28b10 ee803e10 ee01a490 ee803e00 eefd9ef8 80c00660 ee907ddc ee907da8
>> [    1.165603] 7da0: 8041479c 80413adc 00010080 80a886e4 ee01a490 ee803e10 ee803e10 80d308fc
>> [    1.173781] 7dc0: 00000000 00000000 80d308fc 00000000 ee907df4 ee907de0 804e10e8 8041441c
>> [    1.181959] 7de0: 80dc0d30 ee803e10 ee907e1c ee907df8 804df498 804e10b0 ee803e10 80d308fc
>> [    1.190136] 7e00: ee803e44 00000000 00000000 80c6a83c ee907e3c ee907e20 804df610 804df2b4
>> [    1.198313] 7e20: 00000000 80d308fc 804df53c 00000000 ee907e64 ee907e40 804dd74c 804df548
>> [    1.206493] 7e40: ee947058 ee8f8434 ee94706c 80d308fc ee01a380 80d40850 ee907e74 ee907e68
>> [    1.214669] 7e60: 804def1c 804dd6dc ee907e9c ee907e78 804dea5c 804def00 80a88880 ee907e88
>> [    1.222848] 7e80: 80d308fc ffffe000 80c6a834 80b29414 ee907eb4 ee907ea0 804dfe9c 804de958
>> [    1.231026] 7ea0: 80c2c07c ffffe000 ee907ec4 ee907eb8 804e1090 804dfe20 ee907edc ee907ec8
>> [    1.239204] 7ec0: 80c2c0bc 804e105c 80a58f90 ffffe000 ee907f4c ee907ee0 80101c78 80c2c088
>> [    1.247383] 7ee0: 80c00684 803b9664 80b2a200 000000b9 ee907f4c ee907f00 80142b54 80c0066c
>> [    1.255559] 7f00: 8015ddd4 00000006 00000006 00000000 80b29414 80ab8644 efffea30 efffea38
>> [    1.263739] 7f20: 00000000 00000006 80d7f000 80c99e94 80d7f000 80c6a834 80b29414 000000b9
>> [    1.271916] 7f40: ee907f94 ee907f50 80c00eb0 80101c38 00000006 00000006 00000000 80c00660
>> [    1.280093] 7f60: 00000000 00000007 8088ee80 00000000 8088ee80 00000000 00000000 00000000
>> [    1.288272] 7f80: 00000000 00000000 ee907fac ee907f98 8088ee98 80c00d88 00000000 8088ee80
>> [    1.296450] 7fa0: 00000000 ee907fb0 801080f8 8088ee8c 00000000 00000000 00000000 00000000
>> [    1.304627] 7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>> [    1.312805] 7fe0: 00000000 00000000 00000000 00000000 00000013 00000000 ffffffff ffffffff
>> [    1.320978] Backtrace:
>> [    1.323425] [<80412558>] (dw_pcie_read) from [<80413308>] (dw_pcie_rd_conf+0x188/0x1e0)
>> [    1.331433] [<80413180>] (dw_pcie_rd_conf) from [<803f3eac>] (pci_bus_read_config_dword+0x78/0xa0)
>> [    1.340387]  r10:eeb1be00 r9:00000000 r8:00000002 r7:00000000 r6:60000013 r5:ee907bd4
>> [    1.348210]  r4:80413180
>> [    1.350744] [<803f3e34>] (pci_bus_read_config_dword) from [<803f6598>] (pci_bus_read_dev_vendor_id+0x34/0x104)
>> [    1.360740]  r6:0000ea60 r5:ee907bd4 r4:00000000
>> [    1.365358] [<803f6564>] (pci_bus_read_dev_vendor_id) from [<803f7f08>] (pci_scan_single_device+0x50/0xc4)
>> [    1.375011]  r10:00000001 r9:00000000 r8:00000002 r7:00000000 r6:00000000 r5:eeb1be00
>> [    1.382835]  r4:00000000
>> [    1.385366] [<803f7eb8>] (pci_scan_single_device) from [<803f7fec>] (pci_scan_slot+0x70/0x118)
>> [    1.393975]  r7:00000000 r6:eea16000 r5:eeb1be00 r4:00000008
>> [    1.399634] [<803f7f7c>] (pci_scan_slot) from [<803f902c>] (pci_scan_child_bus+0x30/0x108)
>> [    1.407895]  r7:00000002 r6:eea16000 r5:eeb1be00 r4:00000008
>> [    1.413551] [<803f8ffc>] (pci_scan_child_bus) from [<803f8d58>] (pci_scan_bridge+0x2b0/0x554)
>> [    1.422078]  r9:00000000 r8:00000002 r7:00000001 r6:eea16000 r5:eeb1be00 r4:eeb1bc00
>> [    1.429820] [<803f8aa8>] (pci_scan_bridge) from [<803f9088>] (pci_scan_child_bus+0x8c/0x108)
>> [    1.438261]  r10:00000001 r9:00000001 r8:00000001 r7:00000001 r6:eeb1bc14 r5:eeb1bc00
>> [    1.446085]  r4:eea16000
>> [    1.448612] [<803f8ffc>] (pci_scan_child_bus) from [<803f8ca0>] (pci_scan_bridge+0x1f8/0x554)
>> [    1.457138]  r9:00000001 r8:00000001 r7:00000000 r6:eea15c00 r5:eeb1bc00 r4:eeb1ba00
>> [    1.464881] [<803f8aa8>] (pci_scan_bridge) from [<803f9088>] (pci_scan_child_bus+0x8c/0x108)
>> [    1.473321]  r10:00000000 r9:ee803e10 r8:00000000 r7:00000000 r6:eeb1ba14 r5:eeb1ba00
>> [    1.481145]  r4:eea15c00
>> [    1.483675] [<803f8ffc>] (pci_scan_child_bus) from [<803f92d4>] (pci_scan_root_bus_msi+0x6c/0xd4)
>> [    1.492549]  r9:ee803e10 r8:ee907d70 r7:ee907d70 r6:80d308b4 r5:eeb1ba00 r4:00000000
>> [    1.500292] [<803f9268>] (pci_scan_root_bus_msi) from [<80413d20>] (dw_pcie_host_init+0x250/0x4f8)
>> [    1.509249]  r5:80d3082c r4:eea28b28
>> [    1.512822] [<80413ad0>] (dw_pcie_host_init) from [<8041479c>] (imx6_pcie_probe+0x38c/0x540)
>> [    1.521259]  r10:80c00660 r9:eefd9ef8 r8:ee803e00 r7:ee01a490 r6:ee803e10 r5:eea28b10
>> [    1.529083]  r4:00000000
>> [    1.531619] [<80414410>] (imx6_pcie_probe) from [<804e10e8>] (platform_drv_probe+0x44/0x7c)
>> [    1.539963]  r9:00000000 r8:80d308fc r7:00000000 r6:00000000 r5:80d308fc r4:ee803e10
>> [    1.547709] [<804e10a4>] (platform_drv_probe) from [<804df498>] (really_probe+0x1f0/0x294)
>> [    1.555967]  r5:ee803e10 r4:80dc0d30
>> [    1.559540] [<804df2a8>] (really_probe) from [<804df610>] (__driver_attach+0xd4/0xd8)
>> [    1.567367]  r9:80c6a83c r8:00000000 r7:00000000 r6:ee803e44 r5:80d308fc r4:ee803e10
>> [    1.575113] [<804df53c>] (__driver_attach) from [<804dd74c>] (bus_for_each_dev+0x7c/0xb0)
>> [    1.583286]  r7:00000000 r6:804df53c r5:80d308fc r4:00000000
>> [    1.588945] [<804dd6d0>] (bus_for_each_dev) from [<804def1c>] (driver_attach+0x28/0x30)
>> [    1.596945]  r6:80d40850 r5:ee01a380 r4:80d308fc
>> [    1.601560] [<804deef4>] (driver_attach) from [<804dea5c>] (bus_add_driver+0x110/0x220)
>> [    1.609564] [<804de94c>] (bus_add_driver) from [<804dfe9c>] (driver_register+0x88/0x104)
>> [    1.617652]  r7:80b29414 r6:80c6a834 r5:ffffe000 r4:80d308fc
>> [    1.623311] [<804dfe14>] (driver_register) from [<804e1090>] (__platform_driver_register+0x40/0x54)
>> [    1.632353]  r5:ffffe000 r4:80c2c07c
>> [    1.635931] [<804e1050>] (__platform_driver_register) from [<80c2c0bc>] (imx6_pcie_init+0x40/0x54)
>> [    1.644890] [<80c2c07c>] (imx6_pcie_init) from [<80101c78>] (do_one_initcall+0x4c/0x17c)
>> [    1.652983] [<80101c2c>] (do_one_initcall) from [<80c00eb0>] (kernel_init_freeable+0x134/0x1f4)
>> [    1.661675]  r8:000000b9 r7:80b29414 r6:80c6a834 r5:80d7f000 r4:80c99e94
>> [    1.668385] [<80c00d7c>] (kernel_init_freeable) from [<8088ee98>] (kernel_init+0x18/0x124)
>> [    1.676641]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:8088ee80
>> [    1.684464]  r4:00000000
>> [    1.687000] [<8088ee80>] (kernel_init) from [<801080f8>] (ret_from_fork+0x14/0x3c)
>> [    1.694558]  r5:8088ee80 r4:00000000
>> [    1.698131] Code: ee073f9a e1a00003 e5821000 e89da800 (e5901000)
>> [    1.704224] ---[ end trace dc8f87ab88f61701 ]---
>> [    1.708894] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
>> [    1.708894]
>> [    1.717974] CPU1: stopping
>> [    1.720663] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D         4.11.0-next-20170508-dirty #106
>> [    1.729705] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
>> [    1.736230] Backtrace:
>> [    1.738676] [<8010c7d0>] (dump_backtrace) from [<8010cad4>] (show_stack+0x20/0x24)
>> [    1.746239]  r7:00000001 r6:60000193 r5:00000000 r4:80d2f200
>> [    1.751902] [<8010cab4>] (show_stack) from [<803b1970>] (dump_stack+0x94/0xb0)
>> [    1.759120] [<803b18dc>] (dump_stack) from [<8010f708>] (handle_IPI+0x28c/0x334)
>> [    1.766510]  r7:00000001 r6:80ca1e0c r5:ee92df38 r4:80d7f310
>> [    1.772167] [<8010f47c>] (handle_IPI) from [<801015a4>] (gic_handle_irq+0xa8/0xc4)
>> [    1.779735]  r10:80d0432c r9:f4000100 r8:80d2f648 r7:ee92df38 r6:000003ff r5:000003eb
>> [    1.787561]  r4:f400010c r3:00000000
>> [    1.791134] [<801014fc>] (gic_handle_irq) from [<80894a6c>] (__irq_svc+0x6c/0x90)
>> [    1.798609] Exception stack(0xee92df38 to 0xee92df80)
>> [    1.803657] df20:                                                       0000062c 6e329000
>> [    1.811839] df40: 00000000 8011bd60 ee92c000 00000000 80d03cf8 80d03cac 80d16f9f 80a5d91c
>> [    1.820016] df60: 00000000 ee92df94 ee92df98 ee92df88 80108a00 80108a04 60000013 ffffffff
>> [    1.828194]  r10:00000000 r9:ee92c000 r8:80d16f9f r7:ee92df6c r6:ffffffff r5:60000013
>> [    1.836019]  r4:80108a04
>> [    1.838552] [<801089c4>] (arch_cpu_idle) from [<8089424c>] (default_idle_call+0x30/0x3c)
>> [    1.846647] [<8089421c>] (default_idle_call) from [<8015ed88>] (do_idle+0xc4/0x14c)
>> [    1.854296] [<8015ecc4>] (do_idle) from [<8015f09c>] (cpu_startup_entry+0x28/0x2c)
>> [    1.861864]  r9:412fc09a r8:1000406a r7:80d7f320 r6:10c0387d r5:00000001 r4:00000087
>> [    1.869609] [<8015f074>] (cpu_startup_entry) from [<8010f1ec>] (secondary_start_kernel+0x148/0x174)
>> [    1.878656] [<8010f0a4>] (secondary_start_kernel) from [<1010196c>] (0x1010196c)
>> [    1.886046]  r5:00000051 r4:7e92006a
>> [    1.889619] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
>> [    1.889619]
>>
> 
> -Kishon
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
