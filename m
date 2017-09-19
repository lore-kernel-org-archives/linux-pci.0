Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLGhQQOt_Ads2+JpVW=gRDOi141iEh-aWLFmTkg9p62XQ@mail.gmail.com>
References: <20170911200805.3363318-1-arnd@arndb.de> <CAL_JsqLGhQQOt_Ads2+JpVW=gRDOi141iEh-aWLFmTkg9p62XQ@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 19 Sep 2017 09:02:59 +0200
Message-ID: <CAMuHMdWQu8HVp2jc2qcs=vUuiBNdOMm96qSgTpJSNqTtm2gO5A@mail.gmail.com>
Subject: Re: [PATCH 1/2] [RESEND] of: provide of_n_{addr,size}_cells wrappers
 for !CONFIG_OF
To: Rob Herring <robh+dt@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Magnus Damm <damm@opensource.se>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        SH-Linux <linux-sh@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Rob,

On Mon, Sep 18, 2017 at 11:28 PM, Rob Herring <robh+dt@kernel.org> wrote:
> On Mon, Sep 11, 2017 at 3:07 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> The pci-rcar driver is enabled for compile tests, and this has
>> shown that the driver cannot build without CONFIG_OF,
>> following the inclusion of f8f2fe7355fb "PCI: rcar: Use new OF
>> interrupt mapping when possible":
>>
>> drivers/pci/host/pcie-rcar.c: In function 'pci_dma_range_parser_init':
>> drivers/pci/host/pcie-rcar.c:1039:2: error: implicit declaration of function 'of_n_addr_cells' [-Werror=implicit-function-declaration]
>>   parser->pna = of_n_addr_cells(node);
>>   ^
>> As pointed out by Ben Dooks and Geert Uytterhoeven, this is actually
>> supposed to build fine, which we can achieve if we make the
>> declaration of of_irq_parse_and_map_pci conditional on CONFIG_OF
>> and provide an empty inline function otherwise, as we do for
>> a lot of other of interfaces.
>>
>> This lets us build the rcar_pci driver again without CONFIG_OF
>> for build testing. All platforms using this driver select OF,
>> so this doesn't change anything for the users.
>
> Sorry, I keep missing this. It's a flaw in my mail filtering...
>
> There's a patch series[1] to factor out pci_dma_range_parser_init of
> the driver which should also fix this. I'd prefer not to take this
> because ideally all address parsing should be within the DT core code.
>
> Rob
>
> [1] https://patchwork.kernel.org/patch/9927541/

Yes, that looks like a better solution.

(For those who didn't see the rest of the series: of_pci_dma_range_parser_init()
 in provided in of/address.c, and does have a dummy)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
