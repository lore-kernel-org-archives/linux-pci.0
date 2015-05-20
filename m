Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 20 May 2015 17:38:09 +0200 (CEST)
From: Hans Ulli Kroll <ulli.kroll@googlemail.com>
To: Jiang Liu <jiang.liu@linux.intel.com>
cc: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Russell King <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	Sascha Hauer <kernel@pengutronix.de>,
	Roland Stigge <stigge@antcom.de>,
	Tony Lindgren <tony@atomide.com>,
	Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Kukjin Kim <kgene@kernel.org>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org
Subject: Re: [RFC v1 15/25] genirq: Kill the first parameter 'irq' of
 irq_flow_handler_t
In-Reply-To: <1432116013-25902-16-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <alpine.LNX.2.00.1505201737250.26123@localhost>
References: <1432116013-25902-1-git-send-email-jiang.liu@linux.intel.com> <1432116013-25902-16-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Wed, 20 May 2015, Jiang Liu wrote:

> Now most IRQ flow handlers make no use of the first parameter 'irq'.
> And for those who do make use of 'irq', we could easily get the irq
> number through irq_desc->irq_data->irq. So kill the first parameter
> 'irq' of irq_flow_handler_t.
> 
> To ease review, I have split the changes into several parts, though
> they should be merge as one to support bisecting.
> 
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> ---
>  arch/arm/common/it8152.c               |    2 +-
>  arch/arm/common/locomo.c               |    3 ++-
>  arch/arm/common/sa1111.c               |    4 ++--
>  arch/arm/include/asm/hardware/it8152.h |    2 +-
>  arch/arm/include/asm/mach/irq.h        |    4 ++--
>  arch/arm/mach-dove/irq.c               |    5 +++--
>  arch/arm/mach-footbridge/isa-irq.c     |    4 ++--
>  arch/arm/mach-gemini/gpio.c            |    2 +-
>  arch/arm/mach-imx/3ds_debugboard.c     |    2 +-
>  arch/arm/mach-imx/mach-mx31ads.c       |    2 +-
>  arch/arm/mach-iop13xx/msi.c            |    2 +-
>  arch/arm/mach-lpc32xx/irq.c            |    4 ++--
>  arch/arm/mach-omap1/fpga.c             |    2 +-
>  arch/arm/mach-omap2/prm_common.c       |    2 +-
>  arch/arm/mach-pxa/balloon3.c           |    3 ++-
>  arch/arm/mach-pxa/cm-x2xx-pci.c        |    4 ++--
>  arch/arm/mach-pxa/lpd270.c             |    3 ++-
>  arch/arm/mach-pxa/pcm990-baseboard.c   |    1 +
>  arch/arm/mach-pxa/viper.c              |    3 ++-
>  arch/arm/mach-pxa/zeus.c               |    3 ++-
>  arch/arm/mach-rpc/ecard.c              |    2 +-
>  arch/arm/mach-s3c64xx/common.c         |    8 ++++----
>  arch/arm/mach-sa1100/neponset.c        |    2 +-
>  arch/arm/plat-orion/gpio.c             |    2 +-
>  24 files changed, 39 insertions(+), 32 deletions(-)
> 
> diff --git a/arch/arm/common/it8152.c b/arch/arm/common/it8152.c
> index 5114b68e99d5..aaa206181f92 100644
> --- a/arch/arm/common/it8152.c
> +++ b/arch/arm/common/it8152.c
> @@ -95,7 +95,7 @@ void it8152_init_irq(void)
>  	}
>  }
>  
> -void it8152_irq_demux(unsigned int irq, struct irq_desc *desc)
> +void it8152_irq_demux(struct irq_desc *desc)
>  {
>         int bits_pd, bits_lp, bits_ld;
>         int i;
> diff --git a/arch/arm/common/locomo.c b/arch/arm/common/locomo.c
> index 02af4a07ceca..99d4535d7cc6 100644
> --- a/arch/arm/common/locomo.c
> +++ b/arch/arm/common/locomo.c
> @@ -138,9 +138,10 @@ static struct locomo_dev_info locomo_devices[] = {
>  	},
>  };
>  
> -static void locomo_handler(unsigned int irq, struct irq_desc *desc)
> +static void locomo_handler(struct irq_desc *desc)
>  {
>  	struct locomo *lchip = irq_desc_get_chip_data(desc);
> +	unsigned int irq;
>  	int req, i;
>  
>  	/* Acknowledge the parent IRQ */
> diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
> index 0d0844fa54c2..762dfe7081f0 100644
> --- a/arch/arm/common/sa1111.c
> +++ b/arch/arm/common/sa1111.c
> @@ -197,7 +197,7 @@ static struct sa1111_dev_info sa1111_devices[] = {
>   * will call us again if there are more interrupts to process.
>   */
>  static void
> -sa1111_irq_handler(unsigned int irq, struct irq_desc *desc)
> +sa1111_irq_handler(struct irq_desc *desc)
>  {
>  	unsigned int stat0, stat1, i;
>  	struct sa1111 *sachip = irq_desc_get_handler_data(desc);
> @@ -213,7 +213,7 @@ sa1111_irq_handler(unsigned int irq, struct irq_desc *desc)
>  	sa1111_writel(stat1, mapbase + SA1111_INTSTATCLR1);
>  
>  	if (stat0 == 0 && stat1 == 0) {
> -		do_bad_IRQ(irq, desc);
> +		do_bad_IRQ(desc);
>  		return;
>  	}
>  
> diff --git a/arch/arm/include/asm/hardware/it8152.h b/arch/arm/include/asm/hardware/it8152.h
> index d36a73d7c0e8..076777ff3daa 100644
> --- a/arch/arm/include/asm/hardware/it8152.h
> +++ b/arch/arm/include/asm/hardware/it8152.h
> @@ -106,7 +106,7 @@ extern void __iomem *it8152_base_address;
>  struct pci_dev;
>  struct pci_sys_data;
>  
> -extern void it8152_irq_demux(unsigned int irq, struct irq_desc *desc);
> +extern void it8152_irq_demux(struct irq_desc *desc);
>  extern void it8152_init_irq(void);
>  extern int it8152_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin);
>  extern int it8152_pci_setup(int nr, struct pci_sys_data *sys);
> diff --git a/arch/arm/include/asm/mach/irq.h b/arch/arm/include/asm/mach/irq.h
> index 2092ee1e1300..4703e00283db 100644
> --- a/arch/arm/include/asm/mach/irq.h
> +++ b/arch/arm/include/asm/mach/irq.h
> @@ -23,10 +23,10 @@ extern int show_fiq_list(struct seq_file *, int);
>  /*
>   * This is for easy migration, but should be changed in the source
>   */
> -#define do_bad_IRQ(irq,desc)				\
> +#define do_bad_IRQ(desc)				\
>  do {							\
>  	raw_spin_lock(&desc->lock);			\
> -	handle_bad_irq(irq, desc);			\
> +	handle_bad_irq(desc);			\
>  	raw_spin_unlock(&desc->lock);			\
>  } while(0)
>  
> diff --git a/arch/arm/mach-dove/irq.c b/arch/arm/mach-dove/irq.c
> index 4a5a7aedcb76..30140cbdb249 100644
> --- a/arch/arm/mach-dove/irq.c
> +++ b/arch/arm/mach-dove/irq.c
> @@ -69,13 +69,14 @@ static struct irq_chip pmu_irq_chip = {
>  	.irq_ack	= pmu_irq_ack,
>  };
>  
> -static void pmu_irq_handler(unsigned int irq, struct irq_desc *desc)
> +static void pmu_irq_handler(struct irq_desc *desc)
>  {
>  	unsigned long cause = readl(PMU_INTERRUPT_CAUSE);
> +	unsigned int irq;
>  
>  	cause &= readl(PMU_INTERRUPT_MASK);
>  	if (cause == 0) {
> -		do_bad_IRQ(irq, desc);
> +		do_bad_IRQ(desc);
>  		return;
>  	}
>  
> diff --git a/arch/arm/mach-footbridge/isa-irq.c b/arch/arm/mach-footbridge/isa-irq.c
> index c3a0abbc9049..f78e46662447 100644
> --- a/arch/arm/mach-footbridge/isa-irq.c
> +++ b/arch/arm/mach-footbridge/isa-irq.c
> @@ -88,12 +88,12 @@ static struct irq_chip isa_hi_chip = {
>  };
>  
>  static void
> -isa_irq_handler(unsigned int irq, struct irq_desc *desc)
> +isa_irq_handler(struct irq_desc *desc)
>  {
>  	unsigned int isa_irq = *(unsigned char *)PCIIACK_BASE;
>  
>  	if (isa_irq < _ISA_IRQ(0) || isa_irq >= _ISA_IRQ(16)) {
> -		do_bad_IRQ(isa_irq, desc);
> +		do_bad_IRQ(desc);
>  		return;
>  	}
>  
> diff --git a/arch/arm/mach-gemini/gpio.c b/arch/arm/mach-gemini/gpio.c
> index f8cb5710d6ee..713f655bcc74 100644
> --- a/arch/arm/mach-gemini/gpio.c
> +++ b/arch/arm/mach-gemini/gpio.c
> @@ -126,7 +126,7 @@ static int gpio_set_irq_type(struct irq_data *d, unsigned int type)
>  	return 0;
>  }
>  
> -static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
> +static void gpio_irq_handler(struct irq_desc *desc)
>  {
>  	unsigned int port = (unsigned int)irq_desc_get_handler_data(desc);
>  	unsigned int gpio_irq_no, irq_stat;
> diff --git a/arch/arm/mach-imx/3ds_debugboard.c b/arch/arm/mach-imx/3ds_debugboard.c
> index 134377352966..d93d3337b579 100644
> --- a/arch/arm/mach-imx/3ds_debugboard.c
> +++ b/arch/arm/mach-imx/3ds_debugboard.c
> @@ -85,7 +85,7 @@ static struct platform_device smsc_lan9217_device = {
>  	.resource = smsc911x_resources,
>  };
>  
> -static void mxc_expio_irq_handler(u32 irq, struct irq_desc *desc)
> +static void mxc_expio_irq_handler(struct irq_desc *desc)
>  {
>  	u32 imr_val;
>  	u32 int_valid;
> diff --git a/arch/arm/mach-imx/mach-mx31ads.c b/arch/arm/mach-imx/mach-mx31ads.c
> index d08c37c696f6..07aef418a0e1 100644
> --- a/arch/arm/mach-imx/mach-mx31ads.c
> +++ b/arch/arm/mach-imx/mach-mx31ads.c
> @@ -154,7 +154,7 @@ static inline void mxc_init_imx_uart(void)
>  	imx31_add_imx_uart0(&uart_pdata);
>  }
>  
> -static void mx31ads_expio_irq_handler(u32 irq, struct irq_desc *desc)
> +static void mx31ads_expio_irq_handler(struct irq_desc *desc)
>  {
>  	u32 imr_val;
>  	u32 int_valid;
> diff --git a/arch/arm/mach-iop13xx/msi.c b/arch/arm/mach-iop13xx/msi.c
> index 9f89e76dfbb9..f6235b28578c 100644
> --- a/arch/arm/mach-iop13xx/msi.c
> +++ b/arch/arm/mach-iop13xx/msi.c
> @@ -91,7 +91,7 @@ static void (*write_imipr[])(u32) = {
>  	write_imipr_3,
>  };
>  
> -static void iop13xx_msi_handler(unsigned int irq, struct irq_desc *desc)
> +static void iop13xx_msi_handler(struct irq_desc *desc)
>  {
>  	int i, j;
>  	unsigned long status;
> diff --git a/arch/arm/mach-lpc32xx/irq.c b/arch/arm/mach-lpc32xx/irq.c
> index 9ecb8f9c4ef5..f361fed99105 100644
> --- a/arch/arm/mach-lpc32xx/irq.c
> +++ b/arch/arm/mach-lpc32xx/irq.c
> @@ -370,7 +370,7 @@ static struct irq_chip lpc32xx_irq_chip = {
>  	.irq_set_wake = lpc32xx_irq_wake
>  };
>  
> -static void lpc32xx_sic1_handler(unsigned int irq, struct irq_desc *desc)
> +static void lpc32xx_sic1_handler(struct irq_desc *desc)
>  {
>  	unsigned long ints = __raw_readl(LPC32XX_INTC_STAT(LPC32XX_SIC1_BASE));
>  
> @@ -383,7 +383,7 @@ static void lpc32xx_sic1_handler(unsigned int irq, struct irq_desc *desc)
>  	}
>  }
>  
> -static void lpc32xx_sic2_handler(unsigned int irq, struct irq_desc *desc)
> +static void lpc32xx_sic2_handler(struct irq_desc *desc)
>  {
>  	unsigned long ints = __raw_readl(LPC32XX_INTC_STAT(LPC32XX_SIC2_BASE));
>  
> diff --git a/arch/arm/mach-omap1/fpga.c b/arch/arm/mach-omap1/fpga.c
> index 3c0e42219200..374bccf5ce24 100644
> --- a/arch/arm/mach-omap1/fpga.c
> +++ b/arch/arm/mach-omap1/fpga.c
> @@ -87,7 +87,7 @@ static void fpga_mask_ack_irq(struct irq_data *d)
>  	fpga_ack_irq(d);
>  }
>  
> -static void innovator_fpga_IRQ_demux(unsigned int irq, struct irq_desc *desc)
> +static void innovator_fpga_IRQ_demux(struct irq_desc *desc)
>  {
>  	u32 stat;
>  	int fpga_irq;
> diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
> index 7add7994dbfc..6cfc1e54d41f 100644
> --- a/arch/arm/mach-omap2/prm_common.c
> +++ b/arch/arm/mach-omap2/prm_common.c
> @@ -102,7 +102,7 @@ static void omap_prcm_events_filter_priority(unsigned long *events,
>   * dispatched accordingly. Clearing of the wakeup events should be
>   * done by the SoC specific individual handlers.
>   */
> -static void omap_prcm_irq_handler(unsigned int irq, struct irq_desc *desc)
> +static void omap_prcm_irq_handler(struct irq_desc *desc)
>  {
>  	unsigned long pending[OMAP_PRCM_MAX_NR_PENDING_REG];
>  	unsigned long priority_pending[OMAP_PRCM_MAX_NR_PENDING_REG];
> diff --git a/arch/arm/mach-pxa/balloon3.c b/arch/arm/mach-pxa/balloon3.c
> index d897292712eb..506365cdd58b 100644
> --- a/arch/arm/mach-pxa/balloon3.c
> +++ b/arch/arm/mach-pxa/balloon3.c
> @@ -496,8 +496,9 @@ static struct irq_chip balloon3_irq_chip = {
>  	.irq_unmask	= balloon3_unmask_irq,
>  };
>  
> -static void balloon3_irq_handler(unsigned int irq, struct irq_desc *desc)
> +static void balloon3_irq_handler(struct irq_desc *desc)
>  {
> +	unsigned int irq;
>  	unsigned long pending = __raw_readl(BALLOON3_INT_CONTROL_REG) &
>  					balloon3_irq_enabled;
>  	do {
> diff --git a/arch/arm/mach-pxa/cm-x2xx-pci.c b/arch/arm/mach-pxa/cm-x2xx-pci.c
> index d8f816c24a2f..3221ae15bef7 100644
> --- a/arch/arm/mach-pxa/cm-x2xx-pci.c
> +++ b/arch/arm/mach-pxa/cm-x2xx-pci.c
> @@ -29,12 +29,12 @@
>  void __iomem *it8152_base_address;
>  static int cmx2xx_it8152_irq_gpio;
>  
> -static void cmx2xx_it8152_irq_demux(unsigned int irq, struct irq_desc *desc)
> +static void cmx2xx_it8152_irq_demux(struct irq_desc *desc)
>  {
>  	/* clear our parent irq */
>  	desc->irq_data.chip->irq_ack(&desc->irq_data);
>  
> -	it8152_irq_demux(irq, desc);
> +	it8152_irq_demux(desc);
>  }
>  
>  void __cmx2xx_pci_init_irq(int irq_gpio)
> diff --git a/arch/arm/mach-pxa/lpd270.c b/arch/arm/mach-pxa/lpd270.c
> index eaee2c20b189..cbf00f51808f 100644
> --- a/arch/arm/mach-pxa/lpd270.c
> +++ b/arch/arm/mach-pxa/lpd270.c
> @@ -120,9 +120,10 @@ static struct irq_chip lpd270_irq_chip = {
>  	.irq_unmask	= lpd270_unmask_irq,
>  };
>  
> -static void lpd270_irq_handler(unsigned int irq, struct irq_desc *desc)
> +static void lpd270_irq_handler(struct irq_desc *desc)
>  {
>  	unsigned long pending;
> +	unsigned int irq;
>  
>  	pending = __raw_readw(LPD270_INT_STATUS) & lpd270_irq_enabled;
>  	do {
> diff --git a/arch/arm/mach-pxa/pcm990-baseboard.c b/arch/arm/mach-pxa/pcm990-baseboard.c
> index 2897da2a5df6..0d8331f8536e 100644
> --- a/arch/arm/mach-pxa/pcm990-baseboard.c
> +++ b/arch/arm/mach-pxa/pcm990-baseboard.c
> @@ -287,6 +287,7 @@ static struct irq_chip pcm990_irq_chip = {
>  static void pcm990_irq_handler(unsigned int irq, struct irq_desc *desc)
>  {
>  	unsigned long pending;
> +	unsigned int irq;
>  
>  	pending = ~pcm990_cpld_readb(PCM990_CTRL_INTSETCLR);
>  	pending &= pcm990_irq_enabled;
> diff --git a/arch/arm/mach-pxa/viper.c b/arch/arm/mach-pxa/viper.c
> index de3b08073fe7..bd52fb914d6a 100644
> --- a/arch/arm/mach-pxa/viper.c
> +++ b/arch/arm/mach-pxa/viper.c
> @@ -276,9 +276,10 @@ static inline unsigned long viper_irq_pending(void)
>  			viper_irq_enabled_mask;
>  }
>  
> -static void viper_irq_handler(unsigned int irq, struct irq_desc *desc)
> +static void viper_irq_handler(struct irq_desc *desc)
>  {
>  	unsigned long pending;
> +	unsigned int irq;
>  
>  	pending = viper_irq_pending();
>  	do {
> diff --git a/arch/arm/mach-pxa/zeus.c b/arch/arm/mach-pxa/zeus.c
> index ac2ae5c71ab4..7ffff0b424c2 100644
> --- a/arch/arm/mach-pxa/zeus.c
> +++ b/arch/arm/mach-pxa/zeus.c
> @@ -105,9 +105,10 @@ static inline unsigned long zeus_irq_pending(void)
>  	return __raw_readw(ZEUS_CPLD_ISA_IRQ) & zeus_irq_enabled_mask;
>  }
>  
> -static void zeus_irq_handler(unsigned int irq, struct irq_desc *desc)
> +static void zeus_irq_handler(struct irq_desc *desc)
>  {
>  	unsigned long pending;
> +	unsigned int irq;
>  
>  	pending = zeus_irq_pending();
>  	do {
> diff --git a/arch/arm/mach-rpc/ecard.c b/arch/arm/mach-rpc/ecard.c
> index fcb1d59f7aec..b7074cd5ebfd 100644
> --- a/arch/arm/mach-rpc/ecard.c
> +++ b/arch/arm/mach-rpc/ecard.c
> @@ -552,7 +552,7 @@ static void ecard_check_lockup(struct irq_desc *desc)
>  }
>  
>  static void
> -ecard_irq_handler(unsigned int irq, struct irq_desc *desc)
> +ecard_irq_handler(struct irq_desc *desc)
>  {
>  	ecard_t *ec;
>  	int called = 0;
> diff --git a/arch/arm/mach-s3c64xx/common.c b/arch/arm/mach-s3c64xx/common.c
> index 16547f2641a3..5c9ca33f61e5 100644
> --- a/arch/arm/mach-s3c64xx/common.c
> +++ b/arch/arm/mach-s3c64xx/common.c
> @@ -389,22 +389,22 @@ static inline void s3c_irq_demux_eint(unsigned int start, unsigned int end)
>  	}
>  }
>  
> -static void s3c_irq_demux_eint0_3(unsigned int irq, struct irq_desc *desc)
> +static void s3c_irq_demux_eint0_3(struct irq_desc *desc)
>  {
>  	s3c_irq_demux_eint(0, 3);
>  }
>  
> -static void s3c_irq_demux_eint4_11(unsigned int irq, struct irq_desc *desc)
> +static void s3c_irq_demux_eint4_11(struct irq_desc *desc)
>  {
>  	s3c_irq_demux_eint(4, 11);
>  }
>  
> -static void s3c_irq_demux_eint12_19(unsigned int irq, struct irq_desc *desc)
> +static void s3c_irq_demux_eint12_19(struct irq_desc *desc)
>  {
>  	s3c_irq_demux_eint(12, 19);
>  }
>  
> -static void s3c_irq_demux_eint20_27(unsigned int irq, struct irq_desc *desc)
> +static void s3c_irq_demux_eint20_27(struct irq_desc *desc)
>  {
>  	s3c_irq_demux_eint(20, 27);
>  }
> diff --git a/arch/arm/mach-sa1100/neponset.c b/arch/arm/mach-sa1100/neponset.c
> index af868d258e66..cc73c885d6a1 100644
> --- a/arch/arm/mach-sa1100/neponset.c
> +++ b/arch/arm/mach-sa1100/neponset.c
> @@ -166,7 +166,7 @@ static struct sa1100_port_fns neponset_port_fns = {
>   * ensure that the IRQ signal is deasserted before returning.  This
>   * is rather unfortunate.
>   */
> -static void neponset_irq_handler(unsigned int irq, struct irq_desc *desc)
> +static void neponset_irq_handler(struct irq_desc *desc)
>  {
>  	struct neponset_drvdata *d = irq_desc_get_handler_data(desc);
>  	unsigned int irr;
> diff --git a/arch/arm/plat-orion/gpio.c b/arch/arm/plat-orion/gpio.c
> index caba04340619..dc91cfa5483f 100644
> --- a/arch/arm/plat-orion/gpio.c
> +++ b/arch/arm/plat-orion/gpio.c
> @@ -407,7 +407,7 @@ static int gpio_irq_set_type(struct irq_data *d, u32 type)
>  	return 0;
>  }
>  
> -static void gpio_irq_handler(unsigned irq, struct irq_desc *desc)
> +static void gpio_irq_handler(struct irq_desc *desc)
>  {
>  	struct orion_gpio_chip *ochip = irq_desc_get_handler_data(desc);
>  	u32 cause, type;
> -- 
> 1.7.10.4
> 
> 

for the mach-gemini part

Signed-off-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>

