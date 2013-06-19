Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:58276 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934022Ab3FSMnS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jun 2013 08:43:18 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH V5 1/3] pci: Add PCIe driver for Samsung Exynos
Date: Wed, 19 Jun 2013 14:43:09 +0200
Cc: linux-arm-kernel@lists.infradead.org,
	"'Thomas Petazzoni'" <thomas.petazzoni@free-electrons.com>,
	"'Jason Gunthorpe'" <jgunthorpe@obsidianresearch.com>,
	linux-samsung-soc@vger.kernel.org,
	"'Siva Reddy Kallam'" <siva.kallam@samsung.com>,
	"'Surendranath Gurivireddy Balla'" <suren.reddy@samsung.com>,
	linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	"'Thierry Reding'" <thierry.reding@avionic-design.de>,
	linux-kernel@vger.kernel.org,
	"'Grant Likely'" <grant.likely@secretlab.ca>,
	"'Kukjin Kim'" <kgene.kim@samsung.com>,
	"'Thomas Abraham'" <thomas.abraham@linaro.org>,
	"'Bjorn Helgaas'" <bhelgaas@google.com>,
	"'Andrew Murray'" <andrew.murray@arm.com>
References: <000b01ce6839$0f0455d0$2d0d0170$@samsung.com> <201306181556.47656.arnd@arndb.de> <002401ce6c8a$2dd1e4a0$8975ade0$@samsung.com>
In-Reply-To: <002401ce6c8a$2dd1e4a0$8975ade0$@samsung.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201306191443.09598.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 19 June 2013, Jingoo Han wrote:
> Then, do you mean the following?
> 
> static int __exit exynos_pcie_remove(struct platform_device *pdev)
> {
>         struct pcie_port *pp = platform_get_drvdata(pdev);
> 
>         clk_disable_unprepare(pp->bus_clk);
>         clk_disable_unprepare(pp->clk);
> 
>         return 0;
> }
> 
> static struct platform_driver exynos_pcie_driver = {
>         .remove = __exit_p(exynos_pcie_remove),
> 
> [.....]
> 
> /* Exynos PCIe driver does not allow module unload */
> 
> static int __init pcie_init(void)
> {
>         hook_fault_code(16 + 6, exynos_pcie_abort, SIGBUS, 0,
>                         "imprecise external abort");
> 
>         platform_driver_probe(&exynos_pcie_driver, exynos_pcie_probe);
> 
>         return 0;
> }
> subsys_initcall(pcie_init);
> 
> MODULE_AUTHOR("Jingoo Han <jg1.han@samsung.com>");
> MODULE_DESCRIPTION("Samsung PCIe host controller driver");
> MODULE_LICENSE("GPLv2");
> 

Yes, this looks good. I would probably use platform_driver_register
rather than platform_driver_probe, but that is your choice. using
platform_driver_probe() mean you cannot deal with deferred probing.

	Arnd
