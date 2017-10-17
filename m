Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Dexuan Cui <decui@microsoft.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
CC: "x86@kernel.org" <x86@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        Josh Poulson <jopoulso@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Simon Xiao <sixiao@microsoft.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        "Mihai Costache (Cloudbase Solutions SRL)" <v-micos@microsoft.com>,
        Jork Loeser <Jork.Loeser@microsoft.com>
Subject: RE: [patch 3/3] x86/vector/msi: Select
 CONFIG_GENERIC_IRQ_RESERVATION_MODE
Date: Tue, 17 Oct 2017 18:59:27 +0000
Message-ID: <KL1P15301MB000624AF90FB90B39BE84160BF4C0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
References: <20171017075456.694047687@linutronix.de>
 <20171017075600.527569354@linutronix.de>
In-Reply-To: <20171017075600.527569354@linutronix.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> From: Thomas Gleixner [mailto:tglx@linutronix.de]
> Sent: Tuesday, October 17, 2017 12:55 AM
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -95,7 +95,7 @@ config X86
>  	select GENERIC_IRQ_MATRIX_ALLOCATOR	if X86_LOCAL_APIC
>  	select GENERIC_IRQ_MIGRATION		if SMP
>  	select GENERIC_IRQ_PROBE
> -	select GENERIC_IRQ_SHOW
> +	select GENERIC_IRQ_RESERVATION_MODE
>  	select GENERIC_PENDING_IRQ		if SMP
>  	select GENERIC_SMP_IDLE_THREAD
>  	select GENERIC_STRNCPY_FROM_USER

Hi Thomas,
It looks you removed GENERIC_IRQ_SHOW by accident?

I got this build error:
...
  LD      vmlinux.o
  MODPOST vmlinux.o
fs/proc/interrupts.o:(.rodata+0x118): undefined reference to `show_interrup=
ts'
Makefile:1000: recipe for target 'vmlinux' failed
make: *** [vmlinux] Error 1

Adding GENERIC_IRQ_SHOW back can fix the build failure, and with the
pachset Hyper-V PCI pass-through can work fine.

Thanks,
-- Dexuan
