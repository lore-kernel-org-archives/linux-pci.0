Return-Path: <SRS0=v2Pr=LV=socionext.com=hayashi.kunihiko@kernel.org>
Return-Path: <SRS0=v2Pr=LV=socionext.com=hayashi.kunihiko@kernel.org>
Date: Fri, 07 Sep 2018 13:11:27 +0900
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH 2/2] pci: dwc: add UniPhier PCIe host controller support
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Jassi Brar <jaswinder.singh@linaro.org>
In-Reply-To: <20180906140926.GB214747@bhelgaas-glaptop.roam.corp.google.com>
References: <20180906103819.252A.4A936039@socionext.com> <20180906140926.GB214747@bhelgaas-glaptop.roam.corp.google.com>
Message-Id: <20180907131126.FACD.4A936039@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Thu, 6 Sep 2018 09:09:27 -0500 <helgaas@kernel.org> wrote:

> On Thu, Sep 06, 2018 at 10:38:20AM +0900, Kunihiko Hayashi wrote:
> > > > +++ b/drivers/pci/controller/dwc/pcie-uniphier.c
> > > > @@ -0,0 +1,464 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +//
> > > > +// PCI-express host controller driver for UniPhier SoCs
> > > > +// Copyright 2018 Socionext Inc.
> > > > +// Author: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > > 
> > > Use /* ... */ comments except for the SPDX line.
> > 
> > Okay, although I wondered which way to put, I'll replace the header next.
> 
> The easiest thing is to look at similar files already in the tree and
> follow their style.  The details are here:
> 
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst#n540
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/license-rules.rst#n74

Thanks for your advice.
Although I've found both styles in some sub-systems, these are helpful for me.

I replaced it in posted v2.

Thank you,

---
Best Regards,
Kunihiko Hayashi
