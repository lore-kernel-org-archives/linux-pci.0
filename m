Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:59221 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755356Ab3JIBeb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 Oct 2013 21:34:31 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MUD00I2HOBVNP40@mailout4.samsung.com> for
 linux-pci@vger.kernel.org; Wed, 09 Oct 2013 10:33:31 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Pratyush Anand' <pratyush.anand@st.com>,
	'Bjorn Helgaas' <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	'Thierry Reding' <thierry.reding@gmail.com>,
	'Jason Cooper' <jason@lakedaemon.net>,
	'Thomas Petazzoni' <thomas.petazzoni@free-electrons.com>,
	'Andrew Lunn' <andrew@lunn.ch>,
	'Gregory Clement' <gregory.clement@free-electrons.com>,
	'Kishon Vijay Abraham I' <kishon@ti.com>,
	'Shawn Guo' <shawn.guo@linaro.org>,
	'Sean Cross' <xobs@kosagi.com>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <20131008000435.12954.92136.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <CAErSpo6KauiOBXh3QOS9=6QC_bjQqTgiDtnCAo1eb0d=uKgo-A@mail.gmail.com>
 <20131008060643.GA13048@pratyush-vbox>
In-reply-to: <20131008060643.GA13048@pratyush-vbox>
Subject: Re: [PATCH] PCI: designware: Make dw_pcie_rd_own_conf(), etc., static
Date: Wed, 09 Oct 2013 10:33:30 +0900
Message-id: <001d01cec48f$8faf2270$af0d6750$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, October 08, 2013 3:07 PM, Pratyush Anand wrote:
> On Tue, Oct 08, 2013 at 08:07:24AM +0800, Bjorn Helgaas wrote:
> > On Mon, Oct 7, 2013 at 6:04 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> > > The following variables and functions are used only in pcie-designware.c,
> > > so make them static:
> > ...
> > > diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> > > index c10e9ac..900e875 100644
> > > --- a/drivers/pci/host/pcie-designware.c
> > > +++ b/drivers/pci/host/pcie-designware.c
> > > @@ -64,7 +64,7 @@
> > >
> > >  static struct hw_pci dw_pci;
> > >
> > > -unsigned long global_io_offset;
> > > +static unsigned long global_io_offset;
> >
> > While you're looking at this, I think "cfg_read()" and "cfg_write()"
> > are too generic to be global symbols.  I don't know if it would make
> > sense to rename them "dw_cfg_read()", pass around pointers in a
> > structure or what.
> 
> In fact cfg_read, cfg_write & sys_to_pcie should go to common library,
> as you will find similar function in other files too.
> 

(+CC each PCIe host controller maintainer)

Yes, you're right. I think so, too. :-)

cfg_read, cfg_write & sys_to_pcie can go to common library.
I looked at pcie-designware.c, pci-tegra.c, & pci-mvebu.c.
These drivers can use common cfg_read(), cfg_write(), and sys_to_pcie().

For example, common cfg_read() can be used as below:
If there is no objection, I will send the patch.
However, I cannot decide which file is a good place for the common
cfg_read(), cfg_write(), and sys_to_pcie().

int cfg_read(void __iomem *addr, int where, int size, u32 *val)
{
        *val = readl(addr);

        if (size == 1)
                *val = (*val >> (8 * (where & 3))) & 0xff;
        else if (size == 2)
                *val = (*val >> (8 * (where & 3))) & 0xffff;
        else if (size != 4)
                return PCIBIOS_BAD_REGISTER_NUMBER;

        return PCIBIOS_SUCCESSFUL;
}

./drivers/pci/host/pci-mvebu.c
@@ -243,14 +243,7 @@ static int mvebu_pcie_hw_rd_conf(struct mvebu_pcie_port *port,
        writel(PCIE_CONF_ADDR(bus->number, devfn, where),
               port->base + PCIE_CONF_ADDR_OFF);

-       *val = readl(port->base + PCIE_CONF_DATA_OFF);
-
-       if (size == 1)
-               *val = (*val >> (8 * (where & 3))) & 0xff;
-       else if (size == 2)
-               *val = (*val >> (8 * (where & 3))) & 0xffff;
-
-       return PCIBIOS_SUCCESSFUL;
+       return cfg_read(port->base + PCIE_CONF_DATA_OFF, where, size, val);
 }


./drivers/pci/host/pci-tegra.c
@@ -462,14 +462,7 @@ static int tegra_pcie_read_conf(struct pci_bus *bus, unsigned int devfn,
                return PCIBIOS_DEVICE_NOT_FOUND;
        }

-       *value = readl(addr);
-
-       if (size == 1)
-               *value = (*value >> (8 * (where & 3))) & 0xff;
-       else if (size == 2)
-               *value = (*value >> (8 * (where & 3))) & 0xffff;
-
-       return PCIBIOS_SUCCESSFUL;
+       return cfg_read(addr, where, size, val);
 }

Best regards,
Jingoo Han

