Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:41555 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750992AbaFDJ6W (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 Jun 2014 05:58:22 -0400
Message-ID: <538EEDB7.8050600@codethink.co.uk>
Date: Wed, 04 Jun 2014 10:58:15 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
MIME-Version: 1.0
To: Rob Herring <robherring2@gmail.com>, Arnd Bergmann <arnd@arndb.de>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Grant Likely <grant.likely@linaro.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Magnus Damm <damm@opensource.se>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	SH-Linux <linux-sh@vger.kernel.org>
Subject: Re: [PATCH v3] of/irq: provide more wrappers for !CONFIG_OF
References: <16771871.sfJG2itVJN@wuerfel> <CAL_JsqJpP2sEkPC4DUFWTNutjFhUBiKZfNVSpiKHFPfsJzTf6w@mail.gmail.com>
In-Reply-To: <CAL_JsqJpP2sEkPC4DUFWTNutjFhUBiKZfNVSpiKHFPfsJzTf6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/06/14 16:40, Rob Herring wrote:
> On Tue, Jun 3, 2014 at 9:47 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> The pci-rcar driver is enabled for compile tests, and this has
>> now shown that the driver cannot build without CONFIG_OF,
>> following the inclusion of f8f2fe7355fb "PCI: rcar: Use new OF
>> interrupt mapping when possible":
>>
>> drivers/built-in.o: In function `rcar_pci_map_irq':
>> :(.text+0x1cc7c): undefined reference to `of_irq_parse_and_map_pci'
>> pci/host/pcie-rcar.c: In function 'pci_dma_range_parser_init':
>> pci/host/pcie-rcar.c:875:2: error: implicit declaration of function 'of_n_addr_cells' [-Werror=implicit-function-declaration]
>>
>> As pointed out by Ben Dooks and Geert Uytterhoeven, this is actually
>> supposed to build fine, which we can achieve if we make the
>> declaration of of_irq_parse_and_map_pci conditional on CONFIG_OF
>> and provide an empty inline function otherwise, as we do for
>> a lot of other of interfaces.
>>
>> This lets us build the rcar_pci driver again without CONFIG_OF
>> for build testing. All platforms using this driver select OF,
>> so this doesn't change anything for the users.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> Cc: devicetree@vger.kernel.org
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Grant Likely <grant.likely@linaro.org>
>> Cc: Lucas Stach <l.stach@pengutronix.de>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: Magnus Damm <damm@opensource.se>
>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>> Cc: Ben Dooks <ben.dooks@codethink.co.uk>
>> Cc: linux-pci@vger.kernel.org
>> Cc: linux-sh@vger.kernel.org
>> ----
>>
>> This replaces "[PATCH v2] of/irq: provide int of_irq_parse_and_map_pci
>> wrapper", since now the same driver requires additional interfaces.
>> We still want to be able to build the driver with CONFIG_OF disabled,
>> but now we need three functions instead of just one.
>>
>> Rob, Grant, can you apply this as a bug fix, or provide comments?
>>
>> diff --git a/include/linux/of.h b/include/linux/of.h
>> index 196b34c..7c29e6c 100644
>> --- a/include/linux/of.h
>> +++ b/include/linux/of.h
>> @@ -511,6 +511,9 @@ static inline struct device_node *of_get_cpu_node(int cpu,
>>         return NULL;
>>  }
>>
>> +static inline int of_n_addr_cells(struct device_node *np) { return 0; }
>> +static inline int of_n_size_cells(struct device_node *np) { return 0; }
> 
> I'm fine with the rest, but I think these should always be used within
> some higher level function.
> 
> I can't seem to find where this is used by rcar. BTW, why does rcar
> pci DT support fail to have any ranges property?

I think the driver provides all the necessary PCI information
internally as it started off as a platform-driver.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
