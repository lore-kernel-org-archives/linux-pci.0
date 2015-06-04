Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1433391238-19471-6-git-send-email-jiang.liu@linux.intel.com>
References: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
	<1433391238-19471-6-git-send-email-jiang.liu@linux.intel.com>
Date: Thu, 4 Jun 2015 08:20:12 +0200
Message-ID: <CABxcv==Gg7GOzyo5kAEC5ezQpsTMPo=Bi0H4rfRUY5iQJ4oSTQ@mail.gmail.com>
Subject: Re: [RFT v2 05/48] gpio: Use irq_desc_get_xxx() to avoid redundant
 lookup of irq_desc
From: Javier Martinez Canillas <javier@dowhile0.org>
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Ray Jui <rjui@broadcom.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Alexandre Courbot <gnurou@gmail.com>,
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
	bcm-kernel-feedback-list@broadcom.com,
	Linux GPIO List <linux-gpio@vger.kernel.org>,
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Jiang,

On Thu, Jun 4, 2015 at 6:13 AM, Jiang Liu <jiang.liu@linux.intel.com> wrote:
> Use irq_desc_get_xxx() to avoid redundant lookup of irq_desc while we
> already have a pointer to corresponding irq_desc.
>
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/gpio/gpio-bcm-kona.c   |    2 +-
>  drivers/gpio/gpio-dwapb.c      |    2 +-
>  drivers/gpio/gpio-mvebu.c      |    2 +-
>  drivers/gpio/gpio-mxc.c        |    6 +++---
>  drivers/gpio/gpio-mxs.c        |    2 +-
>  drivers/gpio/gpio-omap.c       |    2 +-

For gpio-omap:

Acked-by: Javier Martinez Canillas <javier@dowhile0.org>

Best regards,
Javier
