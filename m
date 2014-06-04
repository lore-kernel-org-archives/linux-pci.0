Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:65333 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728AbaFDKRy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 Jun 2014 06:17:54 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Rob Herring <robherring2@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Grant Likely <grant.likely@linaro.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Magnus Damm <damm@opensource.se>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	SH-Linux <linux-sh@vger.kernel.org>
Subject: Re: [PATCH v3] of/irq: provide more wrappers for !CONFIG_OF
Date: Wed, 04 Jun 2014 12:17:41 +0200
Message-ID: <27348137.JzbR0JR6FS@wuerfel>
In-Reply-To: <538EEDB7.8050600@codethink.co.uk>
References: <16771871.sfJG2itVJN@wuerfel> <CAL_JsqJpP2sEkPC4DUFWTNutjFhUBiKZfNVSpiKHFPfsJzTf6w@mail.gmail.com> <538EEDB7.8050600@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 04 June 2014 10:58:15 Ben Dooks wrote:
> On 03/06/14 16:40, Rob Herring wrote:
> > On Tue, Jun 3, 2014 at 9:47 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> >> This replaces "[PATCH v2] of/irq: provide int of_irq_parse_and_map_pci
> >> wrapper", since now the same driver requires additional interfaces.
> >> We still want to be able to build the driver with CONFIG_OF disabled,
> >> but now we need three functions instead of just one.
> >>
> >> Rob, Grant, can you apply this as a bug fix, or provide comments?
> >>
> >> diff --git a/include/linux/of.h b/include/linux/of.h
> >> index 196b34c..7c29e6c 100644
> >> --- a/include/linux/of.h
> >> +++ b/include/linux/of.h
> >> @@ -511,6 +511,9 @@ static inline struct device_node *of_get_cpu_node(int cpu,
> >>         return NULL;
> >>  }
> >>
> >> +static inline int of_n_addr_cells(struct device_node *np) { return 0; }
> >> +static inline int of_n_size_cells(struct device_node *np) { return 0; }
> > 
> > I'm fine with the rest, but I think these should always be used within
> > some higher level function.
> > 
> > I can't seem to find where this is used by rcar. BTW, why does rcar
> > pci DT support fail to have any ranges property?
> 
> I think the driver provides all the necessary PCI information
> internally as it started off as a platform-driver.

Actually it gets the memory resource from the 'reg' property instead
of parsing the 'ranges' property, which of course is not compliant
with the generic PCI binding.

It also sets up an I/O resource that is located at the same location
as the memory resource, which is just a bug but might be used to
work around problems of the PCI core when no I/O resource is present.

I think that should be fixed.

I also see that the ranges parser in the pcie-rcar driver still gets
I/O space wrong, we should probably move that to a common range
parser once the arm64 pci implementation is in place and we can
share more of the common helpers.

	Arnd
