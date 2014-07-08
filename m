Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:40996 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750867AbaGHMnM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 Jul 2014 08:43:12 -0400
From: Jingoo Han <jg1.han@samsung.com>
To: 'Murali Karicheri' <m-karicheri2@ti.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: 'Santosh Shilimkar' <santosh.shilimkar@ti.com>,
	'Russell King' <linux@arm.linux.org.uk>,
	'Grant Likely' <grant.likely@linaro.org>,
	'Rob Herring' <robh+dt@kernel.org>,
	'Mohit Kumar' <mohit.kumar@st.com>,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	'Pratyush Anand' <pratyush.anand@st.com>,
	'Richard Zhu' <r65037@freescale.com>,
	'Kishon Vijay Abraham I' <kishon@ti.com>,
	'Marek Vasut' <marex@denx.de>, 'Arnd Bergmann' <arnd@arndb.de>,
	'Pawel Moll' <pawel.moll@arm.com>,
	'Mark Rutland' <mark.rutland@arm.com>,
	'Ian Campbell' <ijc+devicetree@hellion.org.uk>,
	'Kumar Gala' <galak@codeaurora.org>,
	'Randy Dunlap' <rdunlap@infradead.org>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <1404164720-11066-1-git-send-email-m-karicheri2@ti.com>
 <1404164720-11066-6-git-send-email-m-karicheri2@ti.com>
In-reply-to: <1404164720-11066-6-git-send-email-m-karicheri2@ti.com>
Subject: Re: [PATCH v3 5/5] PCI: add PCI controller for Keystone PCIe h/w
Date: Tue, 08 Jul 2014 21:43:06 +0900
Message-id: <000f01cf9aaa$2a59a6b0$7f0cf410$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, July 01, 2014 6:45 AM, Murali Karicheri wrote:
> 
> Keystone PCIe controller is based on v3.65 version of the
> designware h/w. Main differences are
> 	1. No ATU support
> 	2. Legacy and MSI irq functions are implemented in
> 	   application register space
> 	3. MSI interrupts are multiplexed over 8 IRQ lines to the Host
> 	   side.
> All of the Application register space handing code are organized into
> pci-keystone-dw.c and the functions are called from pci-keystone.c
> to implement PCI controller driver. Also add necessary DT documentation
> for the driver.
> 
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> 
> CC: Santosh Shilimkar <santosh.shilimkar@ti.com>
> CC: Russell King <linux@arm.linux.org.uk>
> CC: Grant Likely <grant.likely@linaro.org>
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Mohit Kumar <mohit.kumar@st.com>
> CC: Jingoo Han <jg1.han@samsung.com>
> CC: Bjorn Helgaas <bhelgaas@google.com>
> CC: Pratyush Anand <pratyush.anand@st.com>
> CC: Richard Zhu <r65037@freescale.com>
> CC: Kishon Vijay Abraham I <kishon@ti.com>
> CC: Marek Vasut <marex@denx.de>
> CC: Arnd Bergmann <arnd@arndb.de>
> CC: Pawel Moll <pawel.moll@arm.com>
> CC: Mark Rutland <mark.rutland@arm.com>
> CC: Ian Campbell <ijc+devicetree@hellion.org.uk>
> CC: Kumar Gala <galak@codeaurora.org>
> CC: Randy Dunlap <rdunlap@infradead.org>
> CC: Grant Likely <grant.likely@linaro.org>
> ---
>  .../devicetree/bindings/pci/pci-keystone.txt       |   69 +++
>  drivers/pci/host/Kconfig                           |    5 +
>  drivers/pci/host/Makefile                          |    1 +
>  drivers/pci/host/pci-keystone-dw.c                 |  523 ++++++++++++++++++++
>  drivers/pci/host/pci-keystone.c                    |  381 ++++++++++++++
>  drivers/pci/host/pci-keystone.h                    |   56 +++
>  6 files changed, 1035 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/pci-keystone.txt
>  create mode 100644 drivers/pci/host/pci-keystone-dw.c
>  create mode 100644 drivers/pci/host/pci-keystone.c
>  create mode 100644 drivers/pci/host/pci-keystone.h
> 

[.....]

> +
> +static int __init ks_pcie_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct device *dev = &pdev->dev;
> +	struct keystone_pcie *ks_pcie;
> +	struct pcie_port *pp;
> +	struct resource *res;
> +	void __iomem *reg_p;
> +	struct phy *phy;
> +	int ret = 0;
> +	u32 val;
> +
> +	ks_pcie = devm_kzalloc(&pdev->dev, sizeof(*ks_pcie),
> +				GFP_KERNEL);
> +	if (!ks_pcie) {
> +		dev_err(dev, "no memory for keystone pcie\n");
> +		return -ENOMEM;
> +	}
> +	pp = &ks_pcie->pp;
> +
> +	/* initialize SerDes Phy if present */
> +	phy = devm_phy_get(dev, "pcie-phy");
> +	if (phy)
> +		ret = phy_init(phy);

Why don't you check 'ret' value?
How about the following?

+	/* initialize SerDes Phy if present */
+	phy = devm_phy_get(dev, "pcie-phy");
+	if (!IS_ERR_OR_NULL(phy) {
+		ret = phy_init(phy);
+		if (ret <0)
+			return ret;
+	}


Best regards,
Jingoo Han

[....]


