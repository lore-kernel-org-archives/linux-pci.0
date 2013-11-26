Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:53695 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753565Ab3KZSJe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 26 Nov 2013 13:09:34 -0500
Date: Tue, 26 Nov 2013 11:09:30 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Jason Cooper' <jason@lakedaemon.net>,
	'Thomas Petazzoni' <thomas.petazzoni@free-electrons.com>,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	'Ezequiel Garcia' <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: PCI: mvebu: return NULL instead of ERR_PTR(ret)
Message-ID: <20131126180930.GC19852@obsidianresearch.com>
References: <001001ceb816$5d1aecc0$1750c640$%han@samsung.com>
 <20131125200256.GA7316@obsidianresearch.com>
 <001101ceea68$cb486220$61d92660$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <001101ceea68$cb486220$61d92660$%han@samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 26, 2013 at 02:31:44PM +0900, Jingoo Han wrote:

> Previously, I sent the patch in order to fix sparse warning as below:
> How about this?
> 
> static void __iomem *mvebu_pcie_map_registers(struct platform_device *pdev,
> 			struct device_node *np, struct mvebu_pcie_port *port)
> {
> 	struct resource regs;
> 	int ret = 0;
> 
> 	ret = of_address_to_resource(np, 0, &regs);
> 	if (ret)
> -		return ERR_PTR(ret);
> +		return (void __iomem *)ERR_PTR(ret);

You should probably ask the sparse folks for guidance 'git grep
iomem.*ERR_PTR' returns nothing, so this isn't an established pattern.

It seems like sparse should know that ERR_PTR functions can work with
any pointer no matter the type? IS_ERR_PTR will have the same problem
with implicitly dropping the iomem tag.

Regards,
Jason
