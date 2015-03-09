Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:62750 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024AbbCIXqI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Mar 2015 19:46:08 -0400
Message-ID: <54FE30B6.3070400@broadcom.com>
Date: Mon, 9 Mar 2015 16:45:58 -0700
From: Ray Jui <rjui@broadcom.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: Dmitry Torokhov <dtor@google.com>, Paul Bolle <pebolle@tiscali.nl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Anatol Pomazau <anatol@google.com>,
	Scott Branden <sbranden@broadcom.com>,
	<linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<bcm-kernel-feedback-list@broadcom.com>,
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] pci: iproc: Add Broadcom iProc PCIe support
References: <1425603699-13416-1-git-send-email-rjui@broadcom.com> <CAE_wzQ_Rq5u83UXOYRLShxuCzcgxA0BSPFZT4RmvDj8nfTSGcg@mail.gmail.com> <54F9EB42.3010804@broadcom.com> <2314573.X8TfIpVCUq@wuerfel>
In-Reply-To: <2314573.X8TfIpVCUq@wuerfel>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Arnd,

On 3/9/2015 5:35 AM, Arnd Bergmann wrote:
> On Friday 06 March 2015 10:00:34 Ray Jui wrote:
>>>
>>
>> Although I have not tested it, but to my best knowledge there shouldn't
>> be any technical issue by making the PCIe iProc driver a loadable module
>> and installing the module later after the kernel finishes booting.
>>
>> But I wonder why I haven't seen any PCIe host driver being allowed to be
>> compiled as module? Maybe there's no obvious benefit of doing that.
>> People typically opt to load slave devices as module but tend to keep
>> the bus or host devices compiled in.
>>
>> And to allow a PCI host driver to be compiled as module, some PCI
>> functions need to have their symbols exported:
>>
>> ERROR: "pci_common_swizzle" [drivers/pci/host/pcie-iproc.ko] undefined!
>> ERROR: "pci_fixup_irqs" [drivers/pci/host/pcie-iproc.ko] undefined!
>> ERROR: "pci_assign_unassigned_bus_resources"
>> [drivers/pci/host/pcie-iproc.ko] undefined!
>> ERROR: "pci_remove_root_bus" [drivers/pci/host/pcie-iproc.ko] undefined!
>> ERROR: "pci_stop_root_bus" [drivers/pci/host/pcie-iproc.ko] undefined!
>> ERROR: "pci_create_root_bus" [drivers/pci/host/pcie-iproc.ko] undefined!
>>
>> Maybe Bjorn can help to shed some light here? Should I go ahead and
>> export_symbol these PCI functions and make the iProc PCI driver "tristate"?
> 
> My best guess is that no loadable driver ever tried to use these and
> we should indeed just export them.

True. I can export those symbols.

> 
> The call to pci_assign_unassigned_bus_resources could be avoided by using
> pci_rescan_bus(), which would simplify the driver a little, but for
> some reason, nothing else uses that, so I'm not sure about it.
> 
> The pci_remove_root_bus/pci_stop_root_bus calls are rarely used anywhere
> else. Are they functional to the point where you could unload a pci
> host driver that is a loadable module? If so, that would be
> wonderful.

It is quite wonderful, :)

I added driver remove function support and tested it out. I'm able to
install/remove/install the iProc PCIe platform driver as a kernel
loadable module. pci_remove_root_bus/pci_stop_root_bus works fine. See
logs below.

-bash-3.2# insmod pcie-iproc-pltfm.ko
[   54.058546] PCI host bridge /pcie@18012000 ranges:
[   54.064584]    IO 0x28000000..0x2800ffff -> 0x00000000
[   54.071003]   MEM 0x20000000..0x23ffffff -> 0x20000000
[   54.330194] iproc-pcie 18012000.pcie: PCI host bridge to bus 0000:00
[   54.338138] pci_bus 0000:00: root bus resource [bus 00-ff]
[   54.344983] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[   54.352683] pci_bus 0000:00: root bus resource [mem
0x20000000-0x23ffffff]
[   54.361254] iproc-pcie 18012000.pcie: link: UP
[   54.367086] PCI: bus0: Fast back to back transfers disabled
[   54.374046] pci 0000:00:00.0: bridge configuration invalid ([bus
00-00]), reconfiguring
[   54.400237] PCI: bus1: Fast back to back transfers disabled
[   54.407274] pci 0000:00:00.0: BAR 8: assigned [mem 0x20000000-0x200fffff]
[   54.415766] pci 0000:01:00.0: BAR 1: assigned [mem 0x20000000-0x2007ffff]
[   54.424241] pci 0000:01:00.0: BAR 6: assigned [mem
0x20080000-0x200bffff pref]
[   54.433245] pci 0000:01:00.0: BAR 0: assigned [mem 0x200c0000-0x200dffff]
[   54.441710] pci 0000:01:00.0: BAR 3: assigned [mem 0x200e0000-0x200e3fff]
[   54.450173] pci 0000:01:00.0: BAR 2: no space for [io  size 0x0020]
[   54.457979] pci 0000:01:00.0: BAR 2: failed to assign [io  size 0x0020]
[   54.466217] pci 0000:00:00.0: PCI bridge to [bus 01]
[   54.472404] pci 0000:00:00.0:   bridge window [mem 0x20000000-0x200fffff]
[   54.480945] pcieport 0000:00:00.0: enabling device (0140 -> 0142)
[   54.488767] e1000e 0000:01:00.0: enabling device (0140 -> 0142)
[   54.496315] e1000e 0000:01:00.0: Interrupt Throttling Rate (ints/sec)
set to dynamic conservative mode
[   54.507958] e1000e 0000:01:00.0 0000:01:00.0 (uninitialized): Failed
to initialize MSI-X interrupts.  Falling back to MSI interru.
[   54.522913] e1000e 0000:01:00.0 0000:01:00.0 (uninitialized): Failed
to initialize MSI interrupts.  Falling back to legacy interr.
[   54.643486] e1000e 0000:01:00.0 eth0: registered PHC clock
[   54.650379] e1000e 0000:01:00.0 eth0: (PCI Express:2.5GT/s:Width x1)
68:05:ca:28:19:e8
[   54.660254] e1000e 0000:01:00.0 eth0: Intel(R) PRO/1000 Network
Connection
[   54.668834] e1000e 0000:01:00.0 eth0: MAC: 3, PHY: 8, PBA No: E46981-008


-bash-3.2# rmmod pcie-iproc-pltfm
[   66.465834] e1000e 0000:01:00.0 eth0: removed PHC


-bash-3.2# insmod pcie-iproc-pltfm.ko
[   71.043195] PCI host bridge /pcie@18012000 ranges:
[   71.049235]    IO 0x28000000..0x2800ffff -> 0x00000000
[   71.055652]   MEM 0x20000000..0x23ffffff -> 0x20000000
[   71.315192] iproc-pcie 18012000.pcie: PCI host bridge to bus 0000:00
[   71.323135] pci_bus 0000:00: root bus resource [bus 00-ff]
[   71.329979] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[   71.337679] pci_bus 0000:00: root bus resource [mem
0x20000000-0x23ffffff]
[   71.346249] iproc-pcie 18012000.pcie: link: UP
[   71.352072] PCI: bus0: Fast back to back transfers disabled
[   71.375261] PCI: bus1: Fast back to back transfers disabled
[   71.382291] pci 0000:00:00.0: BAR 8: assigned [mem 0x20000000-0x200fffff]
[   71.390782] pci 0000:01:00.0: BAR 1: assigned [mem 0x20000000-0x2007ffff]
[   71.399258] pci 0000:01:00.0: BAR 6: assigned [mem
0x20080000-0x200bffff pref]
[   71.408263] pci 0000:01:00.0: BAR 0: assigned [mem 0x200c0000-0x200dffff]
[   71.416728] pci 0000:01:00.0: BAR 3: assigned [mem 0x200e0000-0x200e3fff]
[   71.425190] pci 0000:01:00.0: BAR 2: no space for [io  size 0x0020]
[   71.432996] pci 0000:01:00.0: BAR 2: failed to assign [io  size 0x0020]
[   71.441235] pci 0000:00:00.0: PCI bridge to [bus 01]
[   71.447422] pci 0000:00:00.0:   bridge window [mem 0x20000000-0x200fffff]
[   71.456125] pcieport 0000:00:00.0: Signaling PME through PCIe PME
interrupt
[   71.464812] pci 0000:01:00.0: Signaling PME through PCIe PME interrupt
[   71.473411] e1000e 0000:01:00.0: Interrupt Throttling Rate (ints/sec)
set to dynamic conservative mode
[   71.485069] e1000e 0000:01:00.0 0000:01:00.0 (uninitialized): Failed
to initialize MSI-X interrupts.  Falling back to MSI interru.
[   71.500025] e1000e 0000:01:00.0 0000:01:00.0 (uninitialized): Failed
to initialize MSI interrupts.  Falling back to legacy interr.
[   71.624549] e1000e 0000:01:00.0 eth0: registered PHC clock
[   71.631444] e1000e 0000:01:00.0 eth0: (PCI Express:2.5GT/s:Width x1)
68:05:ca:28:19:e8
[   71.641314] e1000e 0000:01:00.0 eth0: Intel(R) PRO/1000 Network
Connection
[   71.649894] e1000e 0000:01:00.0 eth0: MAC: 3, PHY: 8, PBA No: E46981-008

> 
> 	Arnd
> 

I'll submit patch series v4 with loadable module support.

Thanks,

Ray


