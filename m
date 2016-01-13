Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH V2 11/23] arm64, pci: Remove useless boot time IRQ
 assignment when booting with DT.
To: David Daney <ddaney@caviumnetworks.com>
References: <1450278993-12664-1-git-send-email-tn@semihalf.com>
 <1450278993-12664-12-git-send-email-tn@semihalf.com>
 <20160112135023.GC3601@red-moon> <56952619.7010602@semihalf.com>
 <56953E33.6030003@caviumnetworks.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, matt@masarand.com,
	bhelgaas@google.com, arnd@arndb.de, will.deacon@arm.com,
	catalin.marinas@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org,
	okaya@codeaurora.org, jiang.liu@linux.intel.com,
	Stefano.Stabellini@eu.citrix.com,
	robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, tglx@linutronix.de, wangyijing@huawei.com,
	Suravee.Suthikulpanit@amd.com, msalter@redhat.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linaro-acpi@lists.linaro.org, jchandra@broadcom.com, jcm@redhat.com
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <56961C2B.3030600@semihalf.com>
Date: Wed, 13 Jan 2016 10:43:07 +0100
MIME-Version: 1.0
In-Reply-To: <56953E33.6030003@caviumnetworks.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12.01.2016 18:56, David Daney wrote:
> On 01/12/2016 08:13 AM, Tomasz Nowicki wrote:
>> On 12.01.2016 14:50, Lorenzo Pieralisi wrote:
>>> On Wed, Dec 16, 2015 at 04:16:21PM +0100, Tomasz Nowicki wrote:
>>>> In order to probe PCIe host controller when booting with DT,
>>>> ARM64 is using drivers which defer IRQ assignment to device
>>>> enable time. It means that boot time DT specific irq map initialization
>>>> is always overridden, so lets remove that code.
>>>>
>>>> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
>>>> ---
>>>>   arch/arm64/kernel/pci.c | 10 ----------
>>>>   1 file changed, 10 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
>>>> index 023b983..f7948f5 100644
>>>> --- a/arch/arm64/kernel/pci.c
>>>> +++ b/arch/arm64/kernel/pci.c
>>>> @@ -51,16 +51,6 @@ int pcibios_enable_device(struct pci_dev *dev, int
>>>> mask)
>>>>       return pci_enable_resources(dev, mask);
>>>>   }
>>>>
>>>> -/*
>>>> - * Try to assign the IRQ number from DT when adding a new device
>>>> - */
>>>> -int pcibios_add_device(struct pci_dev *dev)
>>>> -{
>>>> -    dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
>>>> -
>>>> -    return 0;
>>>> -}
>>>> -
>
> How was this tested?  Or in other words, what PCI devices that use
> legacy INT{A,B,C,D} interrupts were used in testing this patch?
>

I used QEMU and e1000 NIC:

sudo ./qemu/aarch64-softmmu/qemu-system-aarch64 -smp 1 -m 1024 -M virt 
-cpu cortex-a57 -nographic -device 
e1000,netdev=net1,mac=52:54:00:12:34:56 -netdev 
type=tap,ifname=tun1,id=net1,script=no,downscript=no -drive 
file=qemu/ubuntu.img,id=root,if=none,format=raw -device 
virtio-blk-device,drive=root -kernel linux-aarch64/arch/arm64/boot/Image 
-append "console=ttyAMA0 earlycon=pl011,0x9000000 rw root=/dev/vda"

root@ubuntu:~# ifconfig
eth0      Link encap:Ethernet  HWaddr 52:54:00:12:34:56
           inet addr:10.0.0.48  Bcast:10.0.255.255  Mask:255.255.0.0
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:107 errors:0 dropped:0 overruns:0 frame:0
           TX packets:32 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:1000
           RX bytes:18087 (18.0 KB)  TX bytes:3818 (3.8 KB)

root@ubuntu:~# cat /proc/interrupts
            CPU0
  39:        280       GIC  36 Level     eth0

root@ubuntu:~# lspci -vvv
00:00.0 Host bridge: Red Hat, Inc. Device 0008
         Subsystem: Red Hat, Inc Device 1100
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-

00:01.0 Ethernet controller: Intel Corporation 82540EM Gigabit Ethernet 
Controller (rev 03)
         Subsystem: Red Hat, Inc QEMU Virtual Machine
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0
         Interrupt: pin A routed to IRQ 39
         Region 0: Memory at 10040000 (32-bit, non-prefetchable) [size=128K]
         Region 1: I/O ports at 1000 [size=64]
         [virtual] Expansion ROM at 10000000 [disabled] [size=256K]
         Kernel driver in use: e1000

Any specific concern w.r.t. this patch?

Tomasz
