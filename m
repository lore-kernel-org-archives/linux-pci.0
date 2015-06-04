Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-id: <556FD9A9.8090704@samsung.com>
Date: Thu, 04 Jun 2015 13:52:57 +0900
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
MIME-version: 1.0
To: Jiang Liu <jiang.liu@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
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
	Simtec Linux Team <linux@simtec.co.uk>,
	Kukjin Kim <kgene@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org
Subject: Re: [RFT v2 36/48] genirq,
 arm: Kill the first parameter 'irq' of irq_flow_handler_t
References: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
 <1433391238-19471-37-git-send-email-jiang.liu@linux.intel.com>
In-reply-to: <1433391238-19471-37-git-send-email-jiang.liu@linux.intel.com>
Content-type: text/plain; charset=windows-1252
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04.06.2015 13:13, Jiang Liu wrote:
> Now most IRQ flow handlers make no use of the first parameter 'irq'.
> And for those who do make use of 'irq', we could easily get the irq
> number through irq_desc->irq_data->irq. So kill the first parameter
> 'irq' of irq_flow_handler_t.
> 
> To ease review, I have split the changes into several parts, though
> they should be merge as one to support bisecting.
> 
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> Signed-off-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>
> ---
>  arch/arm/common/it8152.c               |    2 +-
>  arch/arm/common/locomo.c               |    2 +-
>  arch/arm/common/sa1111.c               |    4 ++--
>  arch/arm/include/asm/hardware/it8152.h |    2 +-
>  arch/arm/include/asm/mach/irq.h        |    4 ++--
>  arch/arm/mach-dove/irq.c               |    4 ++--
>  arch/arm/mach-footbridge/isa-irq.c     |    4 ++--
>  arch/arm/mach-gemini/gpio.c            |    2 +-
>  arch/arm/mach-imx/3ds_debugboard.c     |    2 +-
>  arch/arm/mach-imx/mach-mx31ads.c       |    2 +-
>  arch/arm/mach-iop13xx/msi.c            |    2 +-
>  arch/arm/mach-lpc32xx/irq.c            |    4 ++--
>  arch/arm/mach-netx/generic.c           |    2 +-
>  arch/arm/mach-omap1/fpga.c             |    2 +-
>  arch/arm/mach-omap2/prm_common.c       |    2 +-
>  arch/arm/mach-pxa/balloon3.c           |    2 +-
>  arch/arm/mach-pxa/cm-x2xx-pci.c        |    4 ++--
>  arch/arm/mach-pxa/lpd270.c             |    2 +-
>  arch/arm/mach-pxa/pcm990-baseboard.c   |    2 +-
>  arch/arm/mach-pxa/viper.c              |    2 +-
>  arch/arm/mach-pxa/zeus.c               |    2 +-
>  arch/arm/mach-rpc/ecard.c              |    2 +-
>  arch/arm/mach-s3c24xx/bast-irq.c       |    3 +--
>  arch/arm/mach-s3c64xx/common.c         |    8 ++++----

For s3c24xx/s3c64xx:
Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
