Return-Path: <SRS0=nrie=AC=linaro.org=linus.walleij@kernel.org>
Return-Path: <SRS0=nrie=AC=linaro.org=linus.walleij@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170822190940.GD6948@bhelgaas-glaptop.roam.corp.google.com>
References: <20170809141455.22220-1-linus.walleij@linaro.org> <20170822190940.GD6948@bhelgaas-glaptop.roam.corp.google.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 1 Sep 2017 14:06:10 +0200
Message-ID: <CACRpkdZ1z3wxAGOm2xnjjTo9y0nKVk4vKsMJ54xwcr_x2f9L6A@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] PCI: v3: Update the device tree bindings
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 22, 2017 at 9:09 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Wed, Aug 09, 2017 at 04:14:54PM +0200, Linus Walleij wrote:
>> The bindings for the V3 Semiconductor PCI bridge are a tad bit outdated
>> and predates the more formal format we have adopted for the bindings.
>> Update them a bit so it is easier to read, and add the Integrator AP-
>> specific compatible so we can detect that we are running on that specific
>> platform.
>>
>> Acked-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
(...)
>> -- reg: should contain the base address of the V3 adapter.
>> +Required properties:
>> +- compatible: should be one of:
>> +  "v3,v360epc-pci"
>> +  "arm,integrator-ap-pci", "v3,v360epc-pci"
>> +- reg: should contain the base address of the V3 host bridge.
>
> Does this need some sort of comment about how the non-pref and pref mem
> windows need to be 256Mb and adjacent?  I think the driver makes some
> unverified assumptions about them.

Yeah that is how I understand that it works as well. I will document
this in the binding.

Yours,
Linus Walleij
