Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Murali Karicheri <m-karicheri2@ti.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Rob Herring <robh+dt@kernel.org>,
	Santosh Shilimkar <santosh.shilimkar@ti.com>,
	Kumar Gala <galak@codeaurora.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: keystone: update to support multiple pci ports
Date: Fri, 05 Sep 2014 19:54:58 +0200
Message-ID: <7260053.FoBVhTXVfj@wuerfel>
In-Reply-To: <1409938782-31460-1-git-send-email-m-karicheri2@ti.com>
References: <1409938782-31460-1-git-send-email-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 05 September 2014 13:39:42 Murali Karicheri wrote:
> +
>         /* enable RC mode in devcfg */
>         val = readl(reg_p);
> -       val &= ~PCIE_MODE_MASK;
> -       val |= PCIE_RC_MODE;
> +       port_id <<= 1;
> +       val &= ~(PCIE_MODE_MASK << port_id);
> +       val |= (PCIE_RC_MODE << port_id);
>         writel(val, reg_p);
> +       devm_iounmap(dev, reg_p);
> +       devm_release_mem_region(dev, res->start, resource_size(res));

This looks like it's a shared register of some sort that doesn't
really belong into the registers of a particular port. Could it
be that it's actually for the PHY?

	Arnd
