Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1433391238-19471-46-git-send-email-jiang.liu@linux.intel.com>
References: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
	<1433391238-19471-46-git-send-email-jiang.liu@linux.intel.com>
Date: Thu, 4 Jun 2015 08:20:55 +0200
Message-ID: <CABxcv==u4XqozhR9=aXohGKy-qV696Rv74GqsgeUh0KUEoByEA@mail.gmail.com>
Subject: Re: [RFT v2 45/48] genirq, gpio: Kill the first parameter 'irq' of irq_flow_handler_t
From: Javier Martinez Canillas <javier@dowhile0.org>
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Tien Hock Loh <thloh@altera.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	Ray Jui <rjui@broadcom.com>,
	David Cohen <david.a.cohen@linux.intel.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Kevin Hilman <khilman@deeprootsystems.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Michal Simek <michal.simek@xilinx.com>,
	=?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	Linux GPIO List <linux-gpio@vger.kernel.org>,
	bcm-kernel-feedback-list@broadcom.com,
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Jiang,

On Thu, Jun 4, 2015 at 6:13 AM, Jiang Liu <jiang.liu@linux.intel.com> wrote:
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
>  drivers/gpio/gpio-altera.c     |    6 ++----
>  drivers/gpio/gpio-bcm-kona.c   |    2 +-
>  drivers/gpio/gpio-davinci.c    |    2 +-
>  drivers/gpio/gpio-dwapb.c      |    2 +-
>  drivers/gpio/gpio-ep93xx.c     |    4 ++--
>  drivers/gpio/gpio-intel-mid.c  |    2 +-
>  drivers/gpio/gpio-lynxpoint.c  |    2 +-
>  drivers/gpio/gpio-mpc8xxx.c    |    2 +-
>  drivers/gpio/gpio-msic.c       |    2 +-
>  drivers/gpio/gpio-msm-v2.c     |    2 +-
>  drivers/gpio/gpio-mvebu.c      |    2 +-
>  drivers/gpio/gpio-mxc.c        |    4 ++--
>  drivers/gpio/gpio-mxs.c        |    2 +-
>  drivers/gpio/gpio-omap.c       |    2 +-

For gpio-omap:

Acked-by: Javier Martinez Canillas <javier@dowhile0.org>

Best regards,
Javier
