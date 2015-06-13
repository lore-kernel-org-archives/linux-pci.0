Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 13 Jun 2015 22:15:16 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Jiang Liu <jiang.liu@linux.intel.com>
cc: Julia Lawall <julia.lawall@lip6.fr>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Kevin Cernekee <cernekee@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [RFC v1 14/25] genirq: Kill the first parameter 'irq' of
 irq_flow_handler_t
In-Reply-To: <557C5F29.7010301@linux.intel.com>
Message-ID: <alpine.DEB.2.02.1506132214310.2020@localhost6.localdomain6>
References: <1432116013-25902-1-git-send-email-jiang.liu@linux.intel.com> <1432116013-25902-15-git-send-email-jiang.liu@linux.intel.com> <alpine.DEB.2.11.1505201724260.4225@nanos> <555CA834.7080807@linux.intel.com> <alpine.DEB.2.11.1505201750280.4225@nanos>
 <alpine.DEB.2.10.1506131059180.2486@hadrien> <alpine.DEB.2.11.1506131130490.3786@nanos> <alpine.DEB.2.10.1506131603151.2314@hadrien> <alpine.DEB.2.10.1506131652380.2314@hadrien> <557C5F29.7010301@linux.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The following are the cases that require some manual attention, either 
because the handler is a local variable or because it is some other kind 
of expression.

julia

Local variable: arch/x86/kernel/apic/io_apic.c:932 hdl
Local variable: arch/sparc/kernel/leon_kernel.c:232 flow_handler
Local variable: arch/sparc/kernel/leon_kernel.c:257 flow_handler
Local variable: arch/powerpc/platforms/52xx/mpc52xx_pic.c:199 handler
Local variable: arch/powerpc/platforms/52xx/mpc52xx_pic.c:364 hndlr
Local variable: arch/powerpc/sysdev/qe_lib/qe_ic.c:377 high_handler
Local variable: arch/powerpc/sysdev/qe_lib/qe_ic.c:372 low_handler
Local variable: arch/mips/cavium-octeon/octeon-irq.c:69 handler
Local variable: arch/mips/alchemy/common/irq.c:494 handler
Local variable: arch/mips/alchemy/common/irq.c:706 hdl
Local variable: arch/blackfin/mach-common/ints-priority.c:693 handle
Local variable: arch/tile/kernel/irq.c:239 handle
Local variable: arch/m68k/kernel/ints.c:124 handle
Local variable: drivers/irqchip/irq-clps711x.c:152 handler
Local variable: drivers/gpio/gpio-ep93xx.c:211 handler
Local variable: drivers/gpio/gpiolib.c:447 parent_handler
Local variable: drivers/pinctrl/intel/pinctrl-cherryview.c:1328 handler
Local variable: kernel/irq/irqdomain.c:946 handler
Local variable: kernel/irq/irqdomain.c:1251 handler
Local variable: kernel/irq/chip.c:787 handle
Arbitrary expression: arch/ia64/kernel/iosapic.c:613 trigger == IOSAPIC_EDGE ? handle_edge_irq : handle_level_irq
Arbitrary expression: arch/powerpc/sysdev/mpic.c:1669 & mpic_cascade
Arbitrary expression: arch/mips/dec/ioasic-irq.c:111 1 << ( i - base ) & IO_IRQ_DMA_INFO ? handle_edge_irq : handle_fasteoi_irq
Arbitrary expression: drivers/irqchip/irq-or1k-pic.c:131 pic -> handle
Arbitrary expression: drivers/iio/industrialio-trigger.c:449 & handle_simple_irq
Arbitrary expression: drivers/gpio/gpio-sta2x11.c:347 ct -> handler
Arbitrary expression: drivers/gpio/gpiolib.c:482 chip -> irq_handler
Arbitrary expression: drivers/pinctrl/samsung/pinctrl-s3c24xx.c:517 handlers [ i ]
Arbitrary expression: drivers/pinctrl/samsung/pinctrl-s3c64xx.c:734 s3c64xx_eint0_handlers [ i ]
Arbitrary expression: drivers/staging/iio/iio_dummy_evgen.c:89 & handle_simple_irq
Arbitrary expression: kernel/irq/generic-chip.c:461 ct -> handler
Arbitrary expression: kernel/irq/msi.c:167 info -> handler
