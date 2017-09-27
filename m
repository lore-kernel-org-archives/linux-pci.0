Return-Path: <SRS0=24fv=A4=linaro.org=linus.walleij@kernel.org>
Return-Path: <SRS0=24fv=A4=linaro.org=linus.walleij@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170926191639.GO15970@bhelgaas-glaptop.roam.corp.google.com>
References: <20170908124503.4491-1-linus.walleij@linaro.org> <20170926191639.GO15970@bhelgaas-glaptop.roam.corp.google.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 27 Sep 2017 15:25:53 +0200
Message-ID: <CACRpkdYeo667tTsis-5ZLz-bK-87Ygd3ziD2qH_2KXWf+Oq=mA@mail.gmail.com>
Subject: Re: [PATCH 1/2 v4] PCI: v3: Update the device tree bindings
To: Bjorn Helgaas <helgaas@kernel.org>, Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-pci <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 26, 2017 at 9:16 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Fri, Sep 08, 2017 at 02:45:02PM +0200, Linus Walleij wrote:
>> The bindings for the V3 Semiconductor PCI bridge are a tad bit outdated
>> and predates the more formal format we have adopted for the bindings.
>>
>> Update them a bit so it is easier to read, and add the Integrator AP-
>> specific compatible so we can detect that we are running on that specific
>> platform.
>>
>> Add a second register bank for the configuration memory area. The
>> device tree specs does specify a memory range for configuration
>> space but it is not applicable to custom accessors like this. Instead
>> follow the pattern from the Versatile PCI adapter and simply add
>> a second register bank for this memory.
>>
>> Cc: devicetree@vger.kernel.org
>> Cc: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
>> Acked-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> Applied both to pci/host-v3-semi for v4.15, thanks!

Oh it fails to build right now (as the zeroday builder noticed)
since it is using Marc Gonzalez new helper for DMA ranges
parsing.

If Marc's patches are getting applied they will solve the issue
so I wouldn't care in that case.

Yours,
Linus Walleij
