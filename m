Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] PCI: dra7xx: mark dra7xx_pcie_msi irq as IRQF_NO_THREAD
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Kishon Vijay Abraham I <kishon@ti.com>
References: <1446748990-27722-1-git-send-email-grygorii.strashko@ti.com>
 <563C6A7D.7040503@linutronix.de>
CC: Bjorn Helgaas <bhelgaas@google.com>, <tony@atomide.com>,
	<nsekhar@ti.com>, <linux-omap@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	Felipe Balbi <balbi@ti.com>
From: Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <563D06BF.5010707@ti.com>
Date: Fri, 6 Nov 2015 21:59:59 +0200
MIME-Version: 1.0
In-Reply-To: <563C6A7D.7040503@linutronix.de>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Sebastian,

On 11/06/2015 10:53 AM, Sebastian Andrzej Siewior wrote:
> On 11/05/2015 07:43 PM, Grygorii Strashko wrote:
>> diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
>> index 6589e7e..31460f4 100644
>> --- a/drivers/pci/host/pci-dra7xx.c
>> +++ b/drivers/pci/host/pci-dra7xx.c
>> @@ -302,8 +302,30 @@ static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
>>   		return -EINVAL;
>>   	}
>>   
>> +	/*
>> +	 * Mark dra7xx_pcie_msi IRQ as IRQF_NO_THREAD
>> +	 * On -RT and if kernel is booting with "threadirqs" cmd line parameter
>> +	 * the dra7xx_pcie_msi_irq_handler() will be forced threaded but,
>> +	 * in the same time, it's IRQ dispatcher and calls generic_handle_irq(),
>> +	 * which, in turn, will be resolved to handle_simple_irq() call.
>> +	 * The handle_simple_irq() expected to be called with IRQ disabled, as
>> +	 * result kernle will display warning:
>> +	 * "irq XXX handler YYY+0x0/0x14 enabled interrupts".
>> +	 *
>> +	 * Current DRA7 PCIe hw configuration supports 32 interrupts,
>> +	 * which cannot change because it's hardwired in silicon, and can assume
>> +	 * that only a few (most of the time it will be exactly ONE) of those
>> +	 * interrupts are pending at the same time. So, It's sane way to dial
>> +	 * with above issue by marking dra7xx_pcie_msi IRQ as IRQF_NO_THREAD.

I can remove below text.

>> +	 * if some platform will utilize a lot of MSI IRQs and will suffer
>> +	 * form -RT latencies degradation because of that - IRQF_NO_THREAD can
>> +	 * be removed and "Warning Annihilation" W/A can be applied [1]
>> +	 *
>> +	 * [1] https://lkml.org/lkml/2015/11/2/578
> 
> I don't think this novel is required. Also a reference to a patch which
> was not accepted is not a smart idea (since people might think they
> will improve their -RT latency by applying it without thinking).

Agree. Honestly, I don't like both these "solution"/W/A... :(
but have nothing better in mind.

> 
> Do you have any *real* numbers where you can say this patch does
> better/worse than what you suggester earlier? I'm simply asking because
> each gpio-irq multiplexing driver does the same thing.
> 

Indeed. And not only gpio :( Below you can find list of files which
contain "generic_handle_irq" and do not contain "irq_set_chained_handler"
(of course this list is inaccurate). [Addendum 1]

Regarding *real* numbers, I've tested it only on TI dra7-evm + pcie USB3 expander card
which generates legacy IRQ every 1 ms and didn't observe latency changes.
I'm not sure that I'd be able to test any scenario soon (next week), which will be
close to the potential "worst" case. Plus, I found acceptable assumption, that only
few pci irqs might be pending at the same time (at least for the reference Kernel code).
That's why I gave up without fight :(

Seems, I need explain why I'm trying to avoid using IRQF_NO_THREAD by all means
(I'm sorry, if below may sound dummy, and may be I'm overestimating/demonizing problem -
 my -RT experience is not really good [yet:)]).

- IRQF_NO_THREAD is the first considered option for such kind of issues.
  But: Now in LKML there are ~60 occurrences of IRQF_NO_THREAD - most of
  them are used by Arch code. And It's only used by 6 drivers (drivers/*) [Addendum 2].
  During past year, I've found only two threads related to IRQF_NO_THREAD
  and, in both cases, IRQF_NO_THREAD was added for arch specific IRQs which
  can't be threaded (https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-November/122659.html,
  https://lkml.org/lkml/2015/4/21/404).
  
- ARM UP system: TI's am437xx SoCs for example.
   Here everything is started from /drivers/irqchip/irq-gic.c -> gic_handle_irq()

  static void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
  {
	u32 irqstat, irqnr;
	struct gic_chip_data *gic = &gic_data[0];
	void __iomem *cpu_base = gic_data_cpu_base(gic);

	do {
		irqstat = readl_relaxed(cpu_base + GIC_CPU_INTACK);
		irqnr = irqstat & GICC_IAR_INT_ID_MASK;

		if (likely(irqnr > 15 && irqnr < 1021)) {
			if (static_key_true(&supports_deactivate))
				writel_relaxed(irqstat, cpu_base + GIC_CPU_EOI);
			handle_domain_irq(gic->domain, irqnr, regs);
			|- struct pt_regs *old_regs = set_irq_regs(regs);
*			|- irq_enter();

			|- generic_handle_irq(irq);
[1]			   //*** -RT: all IRQ are threaded (except SPI, timers,..) ***
			   |- handle_fasteoi_irq()
			      |- irq_default_primary_handler()
			      |- _irq_wake_thread(desc, action);

[2]			   //***  chained irqX ***
			   chained_irq_handler
			   |- chained_irq_enter(chip, desc);
			   |- handle IRQX.1
				|- generic_handle_irq(IRQX.1);
				   ...
			   |- handle IRQX.2
			   |- handle IRQX.n
			   |- chained_irq_exit(chip, desc);

[3]			   //*** IRQF_NO_THREAD irqY ***
			   |- handle_fasteoi_irq()
				|- driverY_hw_irq_handler()
				   |- handle IRQY.1
					|- generic_handle_irq(IRQY.1);
					...
			           |- handle IRQY.2
				   |- handle IRQY.n

*			|- irq_exit();
			|- set_irq_regs(old_regs);
			continue;
		}
		if (irqnr < 16) {
			writel_relaxed(irqstat, cpu_base + GIC_CPU_EOI);
			if (static_key_true(&supports_deactivate))
				writel_relaxed(irqstat, cpu_base + GIC_CPU_DEACTIVATE);
#ifdef CONFIG_SMP
			handle_IPI(irqnr, regs);
#endif
			continue;
		}
		break;
	} while (1);
  }

GIC IRQ handler gic_handle_irq() may process more than one IRQ without leaving HW IRQ mode
(during my experiments I saw up to 6 IRQs processed in one cycle).

As result, It was concluded, that having such current HW/SW and all IRQs forced threaded [1],
it will be potentially possible to predict system behavior, because gic_handle_irq() will
do the same things for most of processed IRQs.
But, once there will be chained [2] or IRQF_NO_THREAD [3] IRQs - complete unpredictability.

So, It was selected as goal to have all PPI IRQs (forced) threaded. And if someone
will require faster IRQ handling - IRQF_NO_THREAD can be always added, but it will
be custom solution then. 

I'd be appreciated for your comments - if above problem is not a problem.
Good - IRQF_NO_THREAD forever!

Thanks.
-- 
regards,
-grygorii


=== Addendum 1
x0174654@KBP1-T01-F55654:~/kernel.org/linux-master/linux$ grep -L irq_set_chained_handler $(grep -r -I -l generic_handle_irq drivers/*)
drivers/bcma/driver_gpio.c
drivers/clk/at91/pmc.c
drivers/gpio/gpio-lynxpoint.c
drivers/gpio/gpio-brcmstb.c
drivers/gpio/gpio-grgpio.c
drivers/gpio/gpio-etraxfs.c
drivers/gpio/gpio-omap.c
drivers/gpio/gpio-ml-ioh.c
drivers/gpio/gpio-dln2.c
drivers/gpio/gpio-rcar.c
drivers/gpio/gpio-pch.c
drivers/gpio/gpio-zx.c
drivers/gpio/gpio-tb10x.c
drivers/gpio/gpio-em.c
drivers/gpio/gpio-altera.c
drivers/gpio/gpio-omap.mod.c
drivers/gpio/gpio-zynq.c
drivers/gpio/gpio-pl061.c
drivers/gpio/gpio-vf610.c
drivers/gpio/gpio-xlp.c
drivers/gpio/gpio-intel-mid.c
drivers/gpio/gpio-sodaville.c
drivers/gpio/gpio-sta2x11.c
drivers/gpu/drm/msm/mdp/mdp5/mdp5_irq.c
drivers/iio/industrialio-trigger.c
drivers/irqchip/irq-renesas-irqc.c
drivers/irqchip/irq-ingenic.c
drivers/irqchip/irq-renesas-intc-irqpin.c
drivers/memory/omap-gpmc.c
drivers/mfd/db8500-prcmu.c
drivers/mfd/htc-i2cpld.c
drivers/parisc/superio.c
drivers/parisc/gsc.c
drivers/parisc/eisa.c
drivers/parisc/dino.c
drivers/pci/host/pcie-xilinx.c
drivers/pci/host/pci-keystone-dw.c
drivers/pci/host/pcie-rcar.c
drivers/pci/host/pci-dra7xx.c
drivers/pci/host/pcie-designware.c
drivers/pci/host/pci-tegra.c
drivers/pinctrl/qcom/pinctrl-msm.c
drivers/pinctrl/pinctrl-amd.c
drivers/pinctrl/samsung/pinctrl-exynos5440.c
drivers/pinctrl/nomadik/pinctrl-nomadik.c
drivers/pinctrl/sirf/pinctrl-atlas7.c
drivers/pinctrl/sirf/pinctrl-sirf.c
drivers/pinctrl/spear/pinctrl-plgpio.c
drivers/pinctrl/pinctrl-at91.c
drivers/pinctrl/bcm/pinctrl-bcm2835.c
drivers/pinctrl/bcm/pinctrl-cygnus-gpio.c
drivers/pinctrl/intel/pinctrl-cherryview.c
drivers/pinctrl/intel/pinctrl-baytrail.c
drivers/pinctrl/intel/pinctrl-intel.c
drivers/pinctrl/pinctrl-pistachio.c
drivers/pinctrl/pinctrl-coh901.c
drivers/platform/x86/intel_pmic_gpio.c
drivers/ssb/driver_gpio.c
drivers/xen/events/events_2l.c
drivers/xen/events/events_fifo.c

=== Addendum 2
dmar.c
irq-i8259.c
arm_pmu.c
pinctrl-single.c
mips_ejtag_fdc.c (2 matches)
octeon-wdt-main.c


