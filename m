Return-Path: <SRS0=td4J=AB=linaro.org=linus.walleij@kernel.org>
Return-Path: <SRS0=td4J=AB=linaro.org=linus.walleij@kernel.org>
MIME-Version: 1.0
In-Reply-To: <0d4313c7-6595-a7fb-680a-e231dc9c0902@sigmadesigns.com>
References: <f10055cc-4430-ff30-f892-3d3d6f24354c@sigmadesigns.com> <0d4313c7-6595-a7fb-680a-e231dc9c0902@sigmadesigns.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 31 Aug 2017 13:55:56 +0200
Message-ID: <CACRpkdZ-6dAJ2b+h0x0Shcfr8hsgp-xPa9vnPgm27gYt8Otk4w@mail.gmail.com>
Subject: Re: [PATCH 1/3] of/pci: Add dma-ranges parsing support
To: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Cc: Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>, Bjorn Helgaas <helgaas@kernel.org>,
	Marc Zyngier <marc.zyngier@arm.com>, linux-pci <linux-pci@vger.kernel.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>, Robin Murphy <robin.murphy@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
	Mason <slash.tmp@free.fr>, Andrew Murray <amurray@embedded-bits.co.uk>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>,
	DT <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 29, 2017 at 4:25 PM, Marc Gonzalez
<marc_gonzalez@sigmadesigns.com> wrote:

> Several host bridge drivers duplicate of_pci_range_parser_init()
> in order to parse their dma-ranges property.
>
> Provide of_pci_dma_range_parser_init() for that use-case.
>
> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>

Looks good to me.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
