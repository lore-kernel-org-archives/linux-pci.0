Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Daniel Axtens <dja@axtens.net>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v2 0/4] Allow non-legacy cards to be vgaarb default
Date: Wed, 19 Jul 2017 08:19:54 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E40B57B8A@FRAEML521-MBX.china.huawei.com>
References: <20170719021516.24718-1-dja@axtens.net>
In-Reply-To: <20170719021516.24718-1-dja@axtens.net>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "airlied@linux.ie" <airlied@linux.ie>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 "will.deacon@arm.com" <will.deacon@arm.com>, "Liuxinliang
 \(Matthew Liu\)" <z.liuxinliang@hisilicon.com>,
 "zourongrong@gmail.com" <zourongrong@gmail.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "daniel.vetter@intel.com" <daniel.vetter@intel.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Daniel many thanks for your patch

> -----Original Message-----
> From: Daniel Axtens [mailto:dja@axtens.net]
> Sent: 19 July 2017 03:15
> To: linux-pci@vger.kernel.org; linuxppc-dev@lists.ozlabs.org; linux-
> arm-kernel@lists.infradead.org
> Cc: benh@kernel.crashing.org; Liuxinliang (Matthew Liu);
> zourongrong@gmail.com; catalin.marinas@arm.com; will.deacon@arm.com;
> Gabriele Paoloni; bhelgaas@google.com; airlied@linux.ie;
> daniel.vetter@intel.com; alex.williamson@redhat.com; Daniel Axtens
> Subject: [PATCH v2 0/4] Allow non-legacy cards to be vgaarb default
> 
> [v2, in which I send the right patches. My apologies to you all.]
> 
> Hi all,
> 
> Previously I posted a patch that provided a quirk for a hibmc card
> behind a particular Huawei bridge that allowed it to be marked as the
> default device in the VGA arbiter.[0] This lead to some discussion.[1]
> It was broadly suggested that a more generic solution would be better,
> something in the style of powerpc's fixup_vga() quirk.
> 
> Here is my suggested solution:
> 
>  - Create a Kconfig option ARCH_WANT_VGA_ARB_FALLBACK and

In my opinion we could avoid depending on a Kernel config options.
I.e. we can have generic code that, after all PCI devs are enumerated:
1) check if we have a default vga device
2) if not check each registered PCI device and make default device the first
   one that is a VGA device, capable to respond to IO and MEM requests
   and that has a driver bound to it 

> 
>  - if an arch selects that option, install PCI_FIXUP_CLASS_ENABLE
>    hook. This hook fires when a card is enabled, which will require
>    that a driver has been bound.
> 
>  - if there is no default device when the hook fires, and the device
>    can control memory and I/O, mark it as default.

I am worried that the patchset you proposed has a race condition with the
VGA arbiter. In fact you see:
subsys_initcall(vga_arb_device_init) is not guaranteed to be called before
subsys_initcall(acpi_init)

acpi_init->acpi_scan_init->acpi_pci_root_init() at this stage the PCI enumeration
is done and as soon as a device is added the Kernel will look for a driver
to bind to it and therefore you quirk could be called before the VGA arbiter...
Do you agree?

What about modifying vgaarb.c to add a late_initcall() checking what I suggested
above?

Thanks
Gab

[...]

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
