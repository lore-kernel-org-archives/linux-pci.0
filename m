Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1407860725-25202-7-git-send-email-Liviu.Dudau@arm.com>
References: <1407860725-25202-1-git-send-email-Liviu.Dudau@arm.com>
	<1407860725-25202-7-git-send-email-Liviu.Dudau@arm.com>
Date: Mon, 22 Sep 2014 14:47:16 +0200
Message-ID: <CACRpkdanh8vb2-jxVvhmYLXEcvaEKv+BCiom8sPkT3uX_dhG6g@mail.gmail.com>
Subject: Re: [PATCH v9 06/12] ARM: integrator: Correct usage of of_pci_range_to_resource()
From: Linus Walleij <linus.walleij@linaro.org>
To: Liviu Dudau <Liviu.Dudau@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Will Deacon <Will.Deacon@arm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Russell King <linux@arm.linux.org.uk>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Sinan Kaya <okaya@codeaurora.org>,
	Jingoo Han <jg1.han@samsung.com>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Suravee Suthikulanit <suravee.suthikulpanit@amd.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	linux-arch <linux-arch@vger.kernel.org>,
	Device Tree ML <devicetree@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	LAKML <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 12, 2014 at 6:25 PM, Liviu Dudau <Liviu.Dudau@arm.com> wrote:

> Previously, of_pci_range_to_resource() would return a resource
> that contained physical addresses of the IO space even if the
> IORESOURCE_IO flags mandate a logical port set of values. Now
> that the function has been fixed we need to update the drivers
> that were taking advantage of the old behaviour.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>

I guess you know what you're doing so:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

I expect this patch to go through the PCI tree or so? Or do you
expect me to funnel it?

Yours,
Linus Walleij
