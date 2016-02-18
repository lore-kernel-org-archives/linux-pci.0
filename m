Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 18 Feb 2016 13:20:38 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: "liudongdong (C)" <liudongdong3@huawei.com>
Cc: Tomasz Nowicki <tn@semihalf.com>, helgaas@kernel.org,
	arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com,
	rafael@kernel.org, hanjun.guo@linaro.org, okaya@codeaurora.org,
	jiang.liu@linux.intel.com, jchandra@broadcom.com,
	Stefano.Stabellini@eu.citrix.com, jcm@redhat.com,
	linaro-acpi@lists.linaro.org, linux-pci@vger.kernel.org,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	robert.richter@caviumnetworks.com, wangyijing@huawei.com,
	mw@semihalf.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [Linaro-acpi] [PATCH V5 01/15] ACPI: MCFG: Move mmcfg_list
 management to drivers/acpi
Message-ID: <20160218132038.GA13229@red-moon>
References: <1455630825-27253-1-git-send-email-tn@semihalf.com>
 <1455630825-27253-2-git-send-email-tn@semihalf.com>
 <56C5B83F.4010602@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56C5B83F.4010602@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 18, 2016 at 08:25:35PM +0800, liudongdong (C) wrote:

[...]

> >+/*
> >+ * Map a pci_mmcfg_region, can be overrriden by arch
> >+ */
> >+int __weak pci_mmconfig_map_resource(struct device *dev,
> >+	struct pci_mmcfg_region *mcfg)
> >+{
> >+	struct resource *tmp;
> >+	void __iomem *vaddr;
> >+
> >+	tmp = insert_resource_conflict(&iomem_resource, &mcfg->res);
> >+	if (tmp) {
> >+		dev_warn(dev, "MMCONFIG %pR conflicts with %s %pR\n",
> >+			&mcfg->res, tmp->name, tmp);
> >+		return -EBUSY;
> >+	}
> >+
> >+	vaddr =  ioremap(mcfg->res.start, resource_size(&mcfg->res));
               ^^
	       while at it, stray white space

> >+	if (!vaddr) {
> >+		release_resource(&mcfg->res);
> >+		return -ENOMEM;
> >+	}
> >+
> >+	mcfg->virt = vaddr;
> Here should be changed to
> 	mcfg->virt = vaddr - PCI_MMCFG_BUS_OFFSET(mcfg->start_bus);
> 
> or when pcie host "start_bus" is not 0, the configuraion access will be wrong.
Well spotted, thanks.

Lorenzo
