Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 20 May 2015 20:35:47 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC v1 01/25] ARM, irq: Use irq_desc_get_xxx() to avoid
 redundant lookup of irq_desc
Message-ID: <20150520193547.GU2067@n2100.arm.linux.org.uk>
References: <1432116013-25902-1-git-send-email-jiang.liu@linux.intel.com>
 <1432116013-25902-2-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1432116013-25902-2-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 20, 2015 at 05:59:49PM +0800, Jiang Liu wrote:
> diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
> index 5cc779c8e9c6..0d0844fa54c2 100644
> --- a/arch/arm/common/sa1111.c
> +++ b/arch/arm/common/sa1111.c
> @@ -200,7 +200,7 @@ static void
>  sa1111_irq_handler(unsigned int irq, struct irq_desc *desc)
>  {
>  	unsigned int stat0, stat1, i;
> -	struct sa1111 *sachip = irq_get_handler_data(irq);
> +	struct sa1111 *sachip = irq_desc_get_handler_data(desc);
>  	void __iomem *mapbase = sachip->base + SA1111_INTC;
>  
>  	stat0 = sa1111_readl(mapbase + SA1111_INTSTATCLR0);

For this one only,

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

Other maintainers are responsible for the others...

Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
