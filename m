Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:37437 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932644Ab3FSBNY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jun 2013 21:13:24 -0400
From: Jingoo Han <jg1.han@samsung.com>
To: 'Arnd Bergmann' <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org,
	'Thomas Petazzoni' <thomas.petazzoni@free-electrons.com>,
	'Jason Gunthorpe' <jgunthorpe@obsidianresearch.com>,
	linux-samsung-soc@vger.kernel.org,
	'Siva Reddy Kallam' <siva.kallam@samsung.com>,
	'Surendranath Gurivireddy Balla' <suren.reddy@samsung.com>,
	linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	'Thierry Reding' <thierry.reding@avionic-design.de>,
	linux-kernel@vger.kernel.org,
	'Grant Likely' <grant.likely@secretlab.ca>,
	'Kukjin Kim' <kgene.kim@samsung.com>,
	'Thomas Abraham' <thomas.abraham@linaro.org>,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	'Andrew Murray' <andrew.murray@arm.com>,
	Jingoo Han <jg1.han@samsung.com>
References: <000b01ce6839$0f0455d0$2d0d0170$@samsung.com>
 <7174350.I5qK0sQfHM@wuerfel> <000001ce6bd7$50146e60$f03d4b20$@samsung.com>
 <201306181556.47656.arnd@arndb.de>
In-reply-to: <201306181556.47656.arnd@arndb.de>
Subject: Re: [PATCH V5 1/3] pci: Add PCIe driver for Samsung Exynos
Date: Wed, 19 Jun 2013 10:13:16 +0900
Message-id: <002401ce6c8a$2dd1e4a0$8975ade0$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, June 18, 2013 10:57 PM, Arnd Bergmann wrote:
> On Tuesday 18 June 2013, Jingoo Han wrote:
> > On Monday, June 17, 2013 9:45 PM, Arnd Bergmann wrote:
> > > On Monday 17 June 2013 18:45:52 Jingoo Han wrote:
> > > > On Friday, June 14, 2013 9:54 PM, Arnd Bergmann wrote:
> > > > >

[.....]

> >
> > I will remove a 'remove' callback. Is it OK?
> > Or what should I do?
> 
> I think you should keep the remove function, but add a comment explaining that
> you don't allow module unload and that in order to allow it, the remove function
> will have to remove all pci buses and devices under the host bridge.

Then, do you mean the following?

static int __exit exynos_pcie_remove(struct platform_device *pdev)
{
	struct pcie_port *pp = platform_get_drvdata(pdev);

	clk_disable_unprepare(pp->bus_clk);
	clk_disable_unprepare(pp->clk);

	return 0;
}

static struct platform_driver exynos_pcie_driver = {
	.remove	= __exit_p(exynos_pcie_remove),

[.....]

/* Exynos PCIe driver does not allow module unload */

static int __init pcie_init(void)
{
	hook_fault_code(16 + 6, exynos_pcie_abort, SIGBUS, 0,
			"imprecise external abort");

	platform_driver_probe(&exynos_pcie_driver, exynos_pcie_probe);

	return 0;
}
subsys_initcall(pcie_init);

MODULE_AUTHOR("Jingoo Han <jg1.han@samsung.com>");
MODULE_DESCRIPTION("Samsung PCIe host controller driver");
MODULE_LICENSE("GPLv2");


> 
> 	Arnd
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

