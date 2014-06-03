Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:61936 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932308AbaFCP7q (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 3 Jun 2014 11:59:46 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Rob Herring <robherring2@gmail.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Grant Likely <grant.likely@linaro.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Magnus Damm <damm@opensource.se>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	SH-Linux <linux-sh@vger.kernel.org>,
	Phil Edworthy <phil.edworthy@renesas.com>
Subject: Re: [PATCH v3] of/irq: provide more wrappers for !CONFIG_OF
Date: Tue, 03 Jun 2014 17:59:39 +0200
Message-ID: <5369122.ehEoyIekqa@wuerfel>
In-Reply-To: <CAL_JsqJpP2sEkPC4DUFWTNutjFhUBiKZfNVSpiKHFPfsJzTf6w@mail.gmail.com>
References: <16771871.sfJG2itVJN@wuerfel> <CAL_JsqJpP2sEkPC4DUFWTNutjFhUBiKZfNVSpiKHFPfsJzTf6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 03 June 2014 10:40:34 Rob Herring wrote:
> > diff --git a/include/linux/of.h b/include/linux/of.h
> > index 196b34c..7c29e6c 100644
> > --- a/include/linux/of.h
> > +++ b/include/linux/of.h
> > @@ -511,6 +511,9 @@ static inline struct device_node *of_get_cpu_node(int cpu,
> >         return NULL;
> >  }
> >
> > +static inline int of_n_addr_cells(struct device_node *np) { return 0; }
> > +static inline int of_n_size_cells(struct device_node *np) { return 0; }
> 
> I'm fine with the rest, but I think these should always be used within
> some higher level function.

Can you apply the rest already?

> I can't seem to find where this is used by rcar. BTW, why does rcar
> pci DT support fail to have any ranges property?
> 
> Looking at one use in mvebu pci only confirms my position. An
> of_for_each_ranges helper would be useful in that case.

It's currently in the pci-next, the code using this looks like 

+static int pci_dma_range_parser_init(struct of_pci_range_parser *parser,
+                                    struct device_node *node)
+{
+       const int na = 3, ns = 2;
+       int rlen;
+
+       parser->node = node;
+       parser->pna = of_n_addr_cells(node);
+       parser->np = parser->pna + na + ns;
+
+       parser->range = of_get_property(node, "dma-ranges", &rlen);
+       if (!parser->range)
+               return -ENOENT;
+
+       parser->end = parser->range + rlen / sizeof(__be32);
+       return 0;
+}
+
+static int rcar_pcie_parse_map_dma_ranges(struct rcar_pcie *pcie,
+                                         struct device_node *np)
+{
+       struct of_pci_range range;
+       struct of_pci_range_parser parser;
+       int index = 0;
+       int err;
+
+       if (pci_dma_range_parser_init(&parser, np))
+               return -EINVAL;
+
+       /* Get the dma-ranges from DT */
+       for_each_of_pci_range(&parser, &range) {
+               u64 end = range.cpu_addr + range.size - 1;
+               dev_dbg(pcie->dev, "0x%08x 0x%016llx..0x%016llx -> 0x%016llx\n",
+                       range.flags, range.cpu_addr, end, range.pci_addr);
+
+               err = rcar_pcie_inbound_ranges(pcie, &range, &index);
+               if (err)
+                       return err;
+       }
+
+       return 0;
+}

Should the first function just be moved into of-pci.c?

	Arnd

