Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:51930 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751817AbdK3MlT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Nov 2017 07:41:19 -0500
Date: Thu, 30 Nov 2017 12:41:49 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com, robh+dt@kernel.org,
        frowand.list@gmail.com, bhelgaas@google.com, rjw@rjwysocki.net,
        tglx@linutronix.de, vidyas@nvidia.com, kthota@nvidia.com,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 04/10] ARM: tegra: EXPORT tegra_cpuidle_pcie_irqs_in_use()
Message-ID: <20171130124149.GB12096@red-moon>
References: <1511538800-8275-1-git-send-email-mmaddireddy@nvidia.com>
 <1511538800-8275-5-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1511538800-8275-5-git-send-email-mmaddireddy@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 24, 2017 at 09:23:14PM +0530, Manikanta Maddireddy wrote:
> EXPORT tegra_cpuidle_pcie_irqs_in_use() to allow Tegra PCIe driver to be
> compiled as loadable kernel module.
> 
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
>  arch/arm/mach-tegra/cpuidle.c | 1 +
>  1 file changed, 1 insertion(+)

You should find a way to remove this call and the corresponding
drivers->arch dependency, not to export it by spreading it even
further.

Lorenzo

> diff --git a/arch/arm/mach-tegra/cpuidle.c b/arch/arm/mach-tegra/cpuidle.c
> index 316563141add..7d7e6d3ce32d 100644
> --- a/arch/arm/mach-tegra/cpuidle.c
> +++ b/arch/arm/mach-tegra/cpuidle.c
> @@ -57,3 +57,4 @@ void tegra_cpuidle_pcie_irqs_in_use(void)
>  		break;
>  	}
>  }
> +EXPORT_SYMBOL(tegra_cpuidle_pcie_irqs_in_use);
> -- 
> 2.1.4
> 
