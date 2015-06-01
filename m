Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <556C62C5.2040107@linux.intel.com>
Date: Mon, 01 Jun 2015 21:48:53 +0800
From: Jiang Liu <jiang.liu@linux.intel.com>
MIME-Version: 1.0
To: Linus Walleij <linus.walleij@linaro.org>
CC: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Ray Jui <rjui@broadcom.com>,
	Alexandre Courbot <gnurou@gmail.com>,
	Javier Martinez Canillas <javier@dowhile0.org>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Kevin Hilman <khilman@deeprootsystems.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Michal Simek <michal.simek@xilinx.com>,
	=?UTF-8?B?U8O2cmVuIEJyaW5rbWFubg==?= <soren.brinkmann@xilinx.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	Linux-OMAP <linux-omap@vger.kernel.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC v1 05/25] gpio: Use irq_desc_get_xxx() to avoid redundant
 lookup of irq_desc
References: <1432116013-25902-1-git-send-email-jiang.liu@linux.intel.com>	<1432116013-25902-6-git-send-email-jiang.liu@linux.intel.com> <CACRpkdZfWK5H+gRD6inX31Ouq1XCvq7CneNDJV8x0iihXHzWjw@mail.gmail.com>
In-Reply-To: <CACRpkdZfWK5H+gRD6inX31Ouq1XCvq7CneNDJV8x0iihXHzWjw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/6/1 20:45, Linus Walleij wrote:
> On Wed, May 20, 2015 at 11:59 AM, Jiang Liu <jiang.liu@linux.intel.com> wrote:
> 
>> Use irq_desc_get_xxx() to avoid redundant lookup of irq_desc while we
>> already have a pointer to corresponding irq_desc.
>>
>> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Are there dependencies on this patch or can I just apply it
> directly to the GPIO tree?
Hi Linus,
	Thanks for review.
	There's a very long dependency list of this patch set,
so it would be safer to merge this patch set altogether through
the irq tree if that works:)
Thanks!
Gerry

> 
> Yours,
> Linus Walleij
> 
