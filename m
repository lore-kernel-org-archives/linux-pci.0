Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:21690 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753033AbbETSzq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 20 May 2015 14:55:46 -0400
From: Robert Jarzmik <robert.jarzmik@free.fr>
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
Subject: Re: [RFC v1 15/25] genirq: Kill the first parameter 'irq' of irq_flow_handler_t
References: <1432116013-25902-1-git-send-email-jiang.liu@linux.intel.com>
	<1432116013-25902-16-git-send-email-jiang.liu@linux.intel.com>
Date: Wed, 20 May 2015 20:54:12 +0200
In-Reply-To: <1432116013-25902-16-git-send-email-jiang.liu@linux.intel.com>
	(Jiang Liu's message of "Wed, 20 May 2015 18:00:03 +0800")
Message-ID: <87mw0zhygb.fsf@belgarion.home>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Jiang Liu <jiang.liu@linux.intel.com> writes:

> diff --git a/arch/arm/mach-pxa/pcm990-baseboard.c b/arch/arm/mach-pxa/pcm990-baseboard.c
> index 2897da2a5df6..0d8331f8536e 100644
> --- a/arch/arm/mach-pxa/pcm990-baseboard.c
> +++ b/arch/arm/mach-pxa/pcm990-baseboard.c
> @@ -287,6 +287,7 @@ static struct irq_chip pcm990_irq_chip = {
>  static void pcm990_irq_handler(unsigned int irq, struct irq_desc *desc)
>  {
>  	unsigned long pending;
> +	unsigned int irq;
That doesn't look good, double irq definition.

Cheers.

-- 
Robert
