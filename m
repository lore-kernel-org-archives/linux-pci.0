Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: Panic in quirk_usb_early_handoff
To: Robin Murphy <robin.murphy@arm.com>, linux-usb
 <linux-usb@vger.kernel.org>, Linux ARM
 <linux-arm-kernel@lists.infradead.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <4b2a7606-de27-c8ad-1530-958dd5d12233@free.fr>
 <45e38a07-e8da-80e4-36bb-31e471f02004@free.fr>
 <3c5bd8f5-468f-d25e-08a9-8944ee419096@free.fr>
 <38b8c9be-724b-0cfc-a941-76f2c62e1c58@arm.com>
 <491b40db-dc07-2a8e-9bc4-07b86f990600@free.fr>
 <377ce76b-5397-5a02-6bae-7d961b7e9242@arm.com>
From: Mason <slash.tmp@free.fr>
Message-ID: <9b0e6a06-7c50-1ac3-a687-db0afae38509@free.fr>
Date: Mon, 6 Mar 2017 15:56:31 +0100
MIME-Version: 1.0
In-Reply-To: <377ce76b-5397-5a02-6bae-7d961b7e9242@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Alan Stern <stern@rowland.harvard.edu>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 06/03/2017 15:30, Robin Murphy wrote:

> On 06/03/17 12:42, Mason wrote:
>
>> $ arm-linux-gnueabihf-addr2line -i -e vmlinux c039fe44
>> arch/arm/include/asm/io.h:119
>>
>> In other words, readl()
>> Not as helpful as expected...
> 
> I guess your toolchain isn't generating whatever debug info that -i uses
> to show where it was actually inlined, shame.

I used gcc-linaro-5.3.1-2016.05-x86_64_arm-linux-gnueabihf
Is that too old?

Might the issue come from my kernel config?

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
CONFIG_DEBUG_INFO_SPLIT=y
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_GDB_SCRIPTS is not set
CONFIG_ENABLE_WARN_DEPRECATED=y
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=1024
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_READABLE_ASM is not set
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_DEBUG_FS is not set
# CONFIG_HEADERS_CHECK is not set
# CONFIG_DEBUG_SECTION_MISMATCH is not set
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# CONFIG_MAGIC_SYSRQ is not set
CONFIG_DEBUG_KERNEL=y


> Put together, if I'm skimming unfamiliar XHCI code and docs correctly,
> this would imply that a supposed read of the HCC Parameters register
> claimed that the extended capabilities register was at offset 0x29f8
> into a 0x2000-long BAR. That does suggest that whatever's being accessed
> through that ioremap() isn't actually the contents of BAR 0 at all (said
> field should apparently read as 0x140 representing an offset of 0x500).
> You're not still trying have your PCI host controller place its
> MEM-space window over the top of system RAM, are you? Otherwise, I'd be
> inclined to double check that your config space accesses and resource
> assignment are producing sane values.

It looks like the current PCI framework doesn't expect platforms to
multiplex config space and MEM space :-(

[    0.994011] OF: PCI: host bridge /soc/pcie@50000000 ranges:
[    0.999721] OF: PCI: Parsing ranges property...
[    1.004386] OF: PCI:   MEM 0x50000000..0x5fffffff -> 0x00000000
[    1.010471] pci-host-generic 50000000.pcie:
		can't claim ECAM area [mem 0x50000000-0x5fffffff]:
		address conflict with /soc/pcie@50000000 [mem 0x50000000-0x5fffffff]
[    1.025265] pci-host-generic: probe of 50000000.pcie failed with error -16

		pcie@50000000 {
			compatible = "pci-host-ecam-generic";
			reg = <0x50000000 0x10000000>;
			device_type = "pci";
			#size-cells = <2>;
			#address-cells = <3>;
			#interrupt-cells = <1>;
			ranges = <0x02000000 0x0 0x0  0x50000000  0x0 0x10000000>;
		};

Regards.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
