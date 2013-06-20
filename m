Return-Path: <linux-kernel-owner@vger.kernel.org>
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
 <201306181556.47656.arnd@arndb.de>
 <002401ce6c8a$2dd1e4a0$8975ade0$@samsung.com>
 <201306191443.09598.arnd@arndb.de>
In-reply-to: <201306191443.09598.arnd@arndb.de>
Subject: Re: [PATCH V5 1/3] pci: Add PCIe driver for Samsung Exynos
Date: Thu, 20 Jun 2013 15:41:42 +0900
Message-id: <00be01ce6d81$39743950$ac5cabf0$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, June 19, 2013 9:43 PM, Arnd Bergmann wrote:
> On Wednesday 19 June 2013, Jingoo Han wrote:
> > Then, do you mean the following?
> >
> > static int __exit exynos_pcie_remove(struct platform_device *pdev)
> > {
> >         struct pcie_port *pp = platform_get_drvdata(pdev);
> >
> >         clk_disable_unprepare(pp->bus_clk);
> >         clk_disable_unprepare(pp->clk);
> >
> >         return 0;
> > }
> >
> > static struct platform_driver exynos_pcie_driver = {
> >         .remove = __exit_p(exynos_pcie_remove),
> >
> > [.....]
> >
> > /* Exynos PCIe driver does not allow module unload */
> >
> > static int __init pcie_init(void)
> > {
> >         hook_fault_code(16 + 6, exynos_pcie_abort, SIGBUS, 0,
> >                         "imprecise external abort");
> >
> >         platform_driver_probe(&exynos_pcie_driver, exynos_pcie_probe);
> >
> >         return 0;
> > }
> > subsys_initcall(pcie_init);
> >
> > MODULE_AUTHOR("Jingoo Han <jg1.han@samsung.com>");
> > MODULE_DESCRIPTION("Samsung PCIe host controller driver");
> > MODULE_LICENSE("GPLv2");
> >
> 
> Yes, this looks good. I would probably use platform_driver_register
> rather than platform_driver_probe, but that is your choice. using
> platform_driver_probe() mean you cannot deal with deferred probing.

Hi Arnd,

Thank you for your reply. :)
I will send PATCH v6, soon.
I really appreciate your comments.

Hi Thomas Abraham, Kukjin Kim,
Thank you for your support.
It is very helpful.


Best regards,
Jingoo Han


