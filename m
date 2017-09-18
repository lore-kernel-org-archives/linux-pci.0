Return-Path: <robh+dt@kernel.org>
Return-Path: <robh+dt@kernel.org>
MIME-Version: 1.0
In-Reply-To: <26b17bd9-232f-b992-68ac-3b5a7752ba54@free.fr>
References: <7b7278f4-7639-62b3-8a35-e6f7f9afa998@sigmadesigns.com>
 <8452c9ca-7131-cf43-d35c-afc4252844f0@arm.com> <4b93964c-49eb-efbf-f6b2-956c67694182@sigmadesigns.com>
 <86efs3wesi.fsf@arm.com> <20170824170445.GO31858@bhelgaas-glaptop.roam.corp.google.com>
 <e2d48341-3ab1-f80a-b044-ff7dcc059ed4@sigmadesigns.com> <CAKv+Gu8ksqfBgXUTitDOB8O6Ke5Swkp2Agdt=3F0KJ130uUkBw@mail.gmail.com>
 <e381170c-e462-01cd-12db-30773005602b@free.fr> <871so09j6g.fsf@arm.com>
 <acdef092-3fb9-4338-5199-a458ac2439c7@free.fr> <4954977e-46fd-8d54-ec76-db2134d3073a@arm.com>
 <26b17bd9-232f-b992-68ac-3b5a7752ba54@free.fr>
From: Rob Herring <robh+dt@kernel.org>
Date: Mon, 18 Sep 2017 16:30:16 -0500
Message-ID: <CAL_JsqK7XayjJcCYhicuqGqKN8N6+P=9tDrs_m7K3YiOBHDAHA@mail.gmail.com>
Subject: Re: [PATCH v10] PCI: tango: Add MSI controller support
To: Mason <slash.tmp@free.fr>
Cc: Robin Murphy <robin.murphy@arm.com>, Frank Rowand <frowand.list@gmail.com>,
	Marc Zyngier <marc.zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>, Bjorn Helgaas <helgaas@kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
	Marc Gonzalez <Marc_Gonzalez@sigmadesigns.com>, Linus Walleij <linus.walleij@linaro.org>,
	Phil Edworthy <phil.edworthy@renesas.com>, Ray Jui <ray.jui@broadcom.com>,
	Andrew Murray <amurray@embedded-bits.co.uk>, Liviu Dudau <liviu.dudau@arm.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 28, 2017 at 11:13 AM, Mason <slash.tmp@free.fr> wrote:
> On 25/08/2017 17:25, Robin Murphy wrote:
>
>> If your host controller driver needs to discover its windows from DT to
>> configure *itself*, it needs to parse dma-ranges itself; see pcie-iproc,
>> pcie-rcar, pcie-xgene, etc. for examples.
>
> $ git grep '"dma-ranges"' drivers/pci/host
> drivers/pci/host/pci-ftpci100.c:        parser->range = of_get_property(node, "dma-ranges", &rlen);
> drivers/pci/host/pci-rcar-gen2.c:       parser->range = of_get_property(node, "dma-ranges", &rlen);
> drivers/pci/host/pci-xgene.c:   parser->range = of_get_property(node, "dma-ranges", &rlen);
> drivers/pci/host/pcie-iproc.c:  parser->range = of_get_property(node, "dma-ranges", &rlen);
> drivers/pci/host/pcie-rcar.c:   parser->range = of_get_property(node, "dma-ranges", &rlen);
>
> These 5 drivers are using the same function: pci_dma_range_parser_init
>
> pci-ftpci100.c:         d3c68e0a7e34a (Linus Walleij     2017-03-12
> pci-rcar-gen2.c:        8d598cabf50d8 (Phil Edworthy     2015-11-03
> pci-xgene.c:            5f6b6ccdbe1cd (Tanmay Inamdar    2014-10-01
> pcie-iproc.c:           dd9d4e7498de3 (Ray Jui           2016-10-31
> pcie-rcar.c:            c25da4778803b (Phil Edworthy     2014-05-12
>
> which seems to be a copy of of_pci_range_parser_init
> with "ranges" changed to "dma-ranges"
>
> drivers/of/address.c    29b635c00f3eb (Andrew Murray     2013-05-16
>
> Perhaps pci_dma_range_parser_init() can be factorized?
>
> Rob, Frank, what do you think of the patch below?

I thought I had commented (maybe that was on IRC), but looks fine.

This series should also fix a build failure on rcar with !OF, so can
you send a proper patch?

Rob
