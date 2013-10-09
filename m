Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:38691 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757071Ab3JIJtw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 9 Oct 2013 05:49:52 -0400
Date: Wed, 9 Oct 2013 11:49:48 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Pratyush Anand' <pratyush.anand@st.com>,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	'Thierry Reding' <thierry.reding@gmail.com>,
	'Jason Cooper' <jason@lakedaemon.net>,
	'Andrew Lunn' <andrew@lunn.ch>,
	'Gregory Clement' <gregory.clement@free-electrons.com>,
	'Kishon Vijay Abraham I' <kishon@ti.com>,
	'Shawn Guo' <shawn.guo@linaro.org>,
	'Sean Cross' <xobs@kosagi.com>
Subject: Re: [PATCH] PCI: designware: Make dw_pcie_rd_own_conf(), etc.,
 static
Message-ID: <20131009114948.397578bf@skate>
In-Reply-To: <001d01cec48f$8faf2270$af0d6750$%han@samsung.com>
References: <20131008000435.12954.92136.stgit@bhelgaas-glaptop.roam.corp.google.com>
	<CAErSpo6KauiOBXh3QOS9=6QC_bjQqTgiDtnCAo1eb0d=uKgo-A@mail.gmail.com>
	<20131008060643.GA13048@pratyush-vbox>
	<001d01cec48f$8faf2270$af0d6750$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Jingoo Han,

On Wed, 09 Oct 2013 10:33:30 +0900, Jingoo Han wrote:

> ./drivers/pci/host/pci-mvebu.c
> @@ -243,14 +243,7 @@ static int mvebu_pcie_hw_rd_conf(struct mvebu_pcie_port *port,
>         writel(PCIE_CONF_ADDR(bus->number, devfn, where),
>                port->base + PCIE_CONF_ADDR_OFF);
> 
> -       *val = readl(port->base + PCIE_CONF_DATA_OFF);
> -
> -       if (size == 1)
> -               *val = (*val >> (8 * (where & 3))) & 0xff;
> -       else if (size == 2)
> -               *val = (*val >> (8 * (where & 3))) & 0xffff;
> -
> -       return PCIBIOS_SUCCESSFUL;
> +       return cfg_read(port->base + PCIE_CONF_DATA_OFF, where, size, val);
>  }

The cfg_read() name looks too generic to me to be globally exported in
the kernel, but provided a more specific name is used, I'm fine with
using that in the PCIe mvebu driver.

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
