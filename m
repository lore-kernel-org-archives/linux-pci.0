Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9EC3EFD1C;
	Thu, 19 Mar 2026 17:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773942401; cv=none; b=XTy4NVcMcbqReFnFxrWQgTjgAQuWS8W8l86RjSy9GYMG+JiddvvMnJyH9Sew3XPaE3htvjTcDuqDKipV+GBCgsEJCQTHMJI37ZA/an9EZfdjP6lE73AjvGX+gC0NHRe8aHnPlXAXfUSX0YnzPe62OxOqomP+yRUxolkYF2Mkz80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773942401; c=relaxed/simple;
	bh=oYbbBUCdNMxN8aY9xh1JRb5blOS0KtnLS5UQvJq/5JE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Ejn+Dn5+9IQbccBuRgbbWMn86qXh85vzl+Qgro1uKV2ZNwzJgJiBvm4soOGVCi2E0r3UOBZKDb45n8IBnDDqky1QW+jDFBX/f262ZjUl0iQKP6m+gj6XOkcYVDwQcGk2W10sdrK6EA0xAQPmTjkMPLlxtENbIu24mQI74sbQ63U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s+XD7wZM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+XD7wZM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9987EC19424;
	Thu, 19 Mar 2026 17:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773942400;
	bh=oYbbBUCdNMxN8aY9xh1JRb5blOS0KtnLS5UQvJq/5JE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=s+XD7wZMp2TGAbweGQ0FR5ygC0x8wiAIuTHpxWpZDOOr1CH9UTyPXeupsLv6icOQE
	 gpJyLnBCLVGzAcBaP6+jkhYR1u5ExvcjibyK6fCQJUwWTQ6HWeUUzclEuVX44w2kNe
	 ojsKGULadySB8bt+DFgdNyFvCYmSs+GcnvA3FeUwmRV9WMzpwUftXhmgCV1yFb77qN
	 Cf1TArn5wo5vrvCPxCCtEsbPxXQeaSY6ECtjyzX77XIv4B8ezydNEgjhA27HyyF55k
	 Qiwzmpm5mNCbnUT0SDo1/p8CJNi4fgQ9DXsvztQFtLb3vPWxCSet03gLKYHvZ0WeWk
	 LC1kl6MVT/2Mg==
Date: Thu, 19 Mar 2026 12:46:39 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jon Hunter <jonathanh@nvidia.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 4/5] PCI: tegra: Add Tegra264 support
Message-ID: <20260319174639.GA515667@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319160110.2131954-5-thierry.reding@kernel.org>

On Thu, Mar 19, 2026 at 05:01:08PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Add a driver for the PCIe controller found on NVIDIA Tegra264 SoCs. The
> driver is very small, with its main purpose being to set up the address
> translation registers and then creating a standard PCI host using ECAM.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/pci/controller/Kconfig         |   8 +
>  drivers/pci/controller/Makefile        |   1 +
>  drivers/pci/controller/pcie-tegra264.c | 506 +++++++++++++++++++++++++
>  3 files changed, 515 insertions(+)
>  create mode 100644 drivers/pci/controller/pcie-tegra264.c
> 
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index e72ac6934379..36abee65eca1 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -257,6 +257,14 @@ config PCI_TEGRA
>  	  Say Y here if you want support for the PCIe host controller found
>  	  on NVIDIA Tegra SoCs.

Should the PCI_TEGRA menu item ("NVIDIA Tegra PCIe controller") and
this text be clarified somehow to make them clearly separate?

> +config PCIE_TEGRA264
> +	bool "NVIDIA Tegra264 PCIe controller"
> +	depends on ARCH_TEGRA || COMPILE_TEST
> +	depends on PCI_MSI
> +	help
> +	  Say Y here if you want support for the PCIe host controller found
> +	  on NVIDIA Tegra264 SoCs.

> + * PCIe host controller driver for Tegra264 SoC
> + *
> + * Author: Manikanta Maddireddy <mmaddireddy@nvidia.com>

Manikanta doesn't appear in the signed-off-by or other tags above.
Not really an issue for me; just a question of whether this is
accurate.

> +#define PCIE_LINK_UP_DELAY	10000	/* 10 msec */
> +#define PCIE_LINK_UP_TIMEOUT	1000000	/* 1 s */

Use something from drivers/pci/pci.h if possible.  If not, please add
units suffixes to the name, e.g., it looks like these are in "_US".

PCIE_LINK_WAIT_MAX_RETRIES and PCIE_LINK_WAIT_SLEEP_MS look like
they're used in similar ways in other drivers.

> +/* XAL registers */
> +#define XAL_RC_ECAM_BASE_HI			0x00
> +#define XAL_RC_ECAM_BASE_LO			0x04
> +#define XAL_RC_ECAM_BUSMASK			0x08
> +#define XAL_RC_IO_BASE_HI			0x0c
> ...
> +#define XTL_RC_MGMT_CLOCK_CONTROL		0x47C

Inconsistent use of upper/lower-case hex with above.

> +struct tegra264_pcie {
> +	struct device *dev;
> +	bool link_state;

"link_state" being true/false doesn't read quite right because
true/false isn't a "state".  I guess true means "link is up"?

> +static int tegra264_pcie_parse_dt(struct tegra264_pcie *pcie)
> +{
> +	int err;
> +
> +	pcie->wake_gpio = devm_gpiod_get_optional(pcie->dev, "nvidia,pex-wake",
> +						  GPIOD_IN);
> +	if (IS_ERR(pcie->wake_gpio))
> +		return PTR_ERR(pcie->wake_gpio);
> +
> +	if (pcie->wake_gpio) {
> +		device_init_wakeup(pcie->dev, true);
> +
> +		err = gpiod_to_irq(pcie->wake_gpio);
> +		if (err < 0) {
> +			dev_err(pcie->dev, "failed to get wake IRQ: %d\n", err);

Does %pe work here (and below)?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/core-api/printk-formats.rst?id=v6.19#n96

> +static void tegra264_pcie_bpmp_set_rp_state(struct tegra264_pcie *pcie)
> +{
> +	struct tegra_bpmp_message msg;
> +	struct mrq_pcie_request req;
> +	int err;
> +
> +	memset(&req, 0, sizeof(req));

I think "struct mrq_pcie_request req = {}" is equivalent, also for
msg.  No real preference from me.

> +static void tegra264_pcie_init(struct tegra264_pcie *pcie)
> +{
> +	u32 value;
> +
> +	if (!tegra_is_silicon()) {
> +		dev_info(pcie->dev,
> +			 "skipping link state for PCIe #%u in simulation\n",
> +			 pcie->ctl_id);
> +		pcie->link_state = true;
> +		return;
> +	}
> +
> +	/* Poll every 10 msec for 1 sec to link up */
> +	readl_poll_timeout(pcie->ecam + XTL_RC_PCIE_CFG_LINK_CONTROL_STATUS,
> +		value, value & XTL_RC_PCIE_CFG_LINK_CONTROL_STATUS_DLL_ACTIVE,
> +		PCIE_LINK_UP_DELAY, PCIE_LINK_UP_TIMEOUT);
> +
> +	if (value & XTL_RC_PCIE_CFG_LINK_CONTROL_STATUS_DLL_ACTIVE) {
> +		/* Per PCIe r5.0, 6.6.1 wait for 100ms after DLL up */
> +		msleep(100);

Looks like possibly PCIE_RESET_CONFIG_WAIT_MS?

> +		dev_info(pcie->dev, "PCIe #%u link is up (speed: %d)\n",
> +			 pcie->ctl_id, (value & 0xf0000) >> 16);
> +		pcie->link_state = true;
> +		tegra264_pcie_icc_set(pcie);
> +	} else {
> +		dev_info(pcie->dev, "PCIe #%u link is down\n", pcie->ctl_id);
> +
> +		value = readl(pcie->xtl + XTL_RC_MGMT_CLOCK_CONTROL);
> +
> +		/** Set link state only when link fails and no hot-plug feature is present */

/* (not /**), and wrap to fit in 78 columns.

> +		if ((value & XTL_RC_MGMT_CLOCK_CONTROL_PEX_CLKREQ_I_N_PIN_USE_CONV_TO_PRSNT) == 0) {
> +			dev_info(pcie->dev,
> +				 "PCIe #%u link is down and not hotplug-capable, turning off\n",
> +				 pcie->ctl_id);
> +			tegra264_pcie_bpmp_set_rp_state(pcie);
> +			pcie->link_state = false;
> +		} else {
> +			pcie->link_state = true;
> +		}
> +	}
> +}
> +
> +static int tegra264_pcie_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct pci_host_bridge *bridge;
> +	struct tegra264_pcie *pcie;
> +	struct resource_entry *bus;
> +	struct resource *res;
> +	int err;
> +
> +	bridge = devm_pci_alloc_host_bridge(dev, sizeof(struct tegra264_pcie));
> +	if (!bridge) {
> +		dev_err(dev, "failed to allocate host bridge\n");
> +		return -ENOMEM;

Looks like this and others below could use:

  if (!bridge)
    return dev_err_probe(dev, -ENOMEM, "failed ...");

> +static const struct dev_pm_ops tegra264_pcie_pm_ops = {
> +	.resume_noirq = tegra264_pcie_resume_noirq,
> +	.suspend_noirq = tegra264_pcie_suspend_noirq,
> +};

Should this use DEFINE_NOIRQ_DEV_PM_OPS() or similar to avoid warnings
when CONFIG_PM_SLEEP, etc are not enabled?

> +static const struct of_device_id tegra264_pcie_of_match[] = {
> +	{
> +		.compatible = "nvidia,tegra264-pcie",
> +	},
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, tegra264_pcie_of_match);
> +
> +static struct platform_driver tegra264_pcie_driver = {
> +	.probe = tegra264_pcie_probe,
> +	.remove = tegra264_pcie_remove,
> +	.driver = {
> +		.name = "tegra264-pcie",
> +		.pm = &tegra264_pcie_pm_ops,
> +		.of_match_table = tegra264_pcie_of_match,
> +	},
> +};
> +module_platform_driver(tegra264_pcie_driver);
> +
> +MODULE_AUTHOR("Manikanta Maddireddy <mmaddireddy@nvidia.com>");
> +MODULE_DESCRIPTION("NVIDIA Tegra264 PCIe host controller driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.52.0
> 
