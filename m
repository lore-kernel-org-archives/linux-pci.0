Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:64009 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030845AbaLLRa2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 12 Dec 2014 12:30:28 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Stanimir Varbanov <svarbanov@mm-sol.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Kumar Gala <galak@codeaurora.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Grant Likely <grant.likely@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 4/5] PCI: qcom: Add Qualcomm PCIe controller driver
Date: Fri, 12 Dec 2014 18:30:03 +0100
Message-ID: <2577563.x0mEZJNVDQ@wuerfel>
In-Reply-To: <1418404441-5518-5-git-send-email-svarbanov@mm-sol.com>
References: <1418404441-5518-1-git-send-email-svarbanov@mm-sol.com> <1418404441-5518-5-git-send-email-svarbanov@mm-sol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 12 December 2014 19:14:00 Stanimir Varbanov wrote:
> The PCIe driver reuse the Designware common code for host
> and MSI initialization, and also program the Qualcomm
> application specific registers.
> 
> Signed-off-by: Stanimir Varbanov <svarbanov@mm-sol.com>

Looks nice!

> +static int
> +qcom_pcie_rd_own_conf(struct pcie_port *pp, int where, int size, u32 *val)
> +{
> +	if (where == PCI_CLASS_REVISION && size == 4) {
> +		*val = readl(pp->dbi_base + PCI_CLASS_REVISION);
> +		*val &= ~(0xffff << 16);
> +		*val |= PCI_CLASS_BRIDGE_PCI << 16;
> +		return PCIBIOS_SUCCESSFUL;
> +	}
> +
> +	return dw_pcie_cfg_read(pp->dbi_base + (where & ~0x3), where,
> +				size, val);
> +}

Could you add a comment here to explain what this is for?

> +static int __init qcom_pcie_probe(struct platform_device *pdev)
> +{

I think it's a bug to mark this function as __init. It breaks
deferred probing and detaching/reattaching the device trough sysfs.

After you fix that, you can remove the __refdata below.

> +static struct platform_driver __refdata qcom_pcie_driver = {
> +	.probe = qcom_pcie_probe,
> +	.remove = qcom_pcie_remove,
> +	.driver = {
> +		.name = "qcom-pcie",
> +		.of_match_table = qcom_pcie_match,
> +	},
> +};

	Arnd
