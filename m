Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20150729131936.GA6376@red-moon>
References: <1438080345-7233-1-git-send-email-lftan@altera.com>
	<1438080345-7233-4-git-send-email-lftan@altera.com>
	<20150729131936.GA6376@red-moon>
Date: Thu, 30 Jul 2015 01:51:17 +0800
Message-ID: <CAFiDJ5-=_5MJU7a8LofX=V2L1fkY2+2PemsaTPWyGBge7ReqHw@mail.gmail.com>
Subject: Re: [PATCH 3/6] pci:host: Add Altera PCIe host controller driver
From: Ley Foon Tan <lftan@altera.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Dinh Nguyen <dinguyen@opensource.altera.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 29, 2015 at 9:19 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Tue, Jul 28, 2015 at 11:45:42AM +0100, Ley Foon Tan wrote:
>
> [...]
>
>> +static int altera_pcie_parse_request_of_pci_ranges(struct altera_pcie *pcie)
>> +{
>> +       int err, res_valid = 0;
>> +       struct device *dev = &pcie->pdev->dev;
>> +       struct device_node *np = dev->of_node;
>> +       resource_size_t iobase;
>> +       struct resource_entry *win;
>> +       int offset = 0;
>> +
>> +       err = of_pci_get_host_bridge_resources(np, 0, 0xff, &pcie->resources,
>> +                                              &iobase);
>> +       if (err)
>> +               return err;
>
> On top of Rob's comments on ARM bios32 dependency removal (ie rewrite
> the driver so that it does not use pci_common_init_dev()), if you need IO
> access you have to map iobase, see pci_remap_iospace() in pci-host-generic.c
Thanks. We doesn't support I/O region.

Regards
Ley Foon
