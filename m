Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 24 Dec 2016 11:25:53 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Pankaj Dubey <pankaj.dubey@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        krzk@kernel.org, kgene@kernel.org, jingoohan1@gmail.com,
        bhelgaas@google.com, jh80.chung@samsung.com,
        alim.akhtar@samsung.com, sanath@samsung.com,
        Niyas Ahmed S T <niyas.ahmed@samsung.com>
Subject: Re: [PATCH] PCI: exynos: refactor exynos pcie driver
Message-ID: <20161224092553.GA4858@kozik-lap>
References: <CGME20161223105411epcas1p3727f726e757ec6c6d7bff04a9af40077@epcas1p3.samsung.com>
 <1482490587-13611-1-git-send-email-pankaj.dubey@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1482490587-13611-1-git-send-email-pankaj.dubey@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 23, 2016 at 04:26:27PM +0530, Pankaj Dubey wrote:
> From: Niyas Ahmed S T <niyas.ahmed@samsung.com>
> 
> Currently Exynos PCIe driver is only supported for Exynos5440 SoC.
> This patch does refactoring of Exynos PCIe driver to extend support
> for other Exynos SoC.
> 
> Following are the main changes done via this patch:
> 1) It adds separate structs for memory, clock resources.
> 2) It add exynos_pcie_ops struct which will allow us to support the
> differences in resources in different Exynos SoC.
> 
> No functional change intended.
> 
> Signed-off-by: Niyas Ahmed S T <niyas.ahmed@samsung.com>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
> This patch set is prepared on top of Krzysztof's for-next and
> PCIe driver cleanup patch [1] by Jaehoon Chung.
> 
> [1]: https://lkml.org/lkml/2016/12/19/44
> 
> 
>  drivers/pci/host/pci-exynos.c | 346 ++++++++++++++++++++++++++----------------
>  1 file changed, 217 insertions(+), 129 deletions(-)


(...)

  
> @@ -573,14 +660,15 @@ static int __exit exynos_pcie_remove(struct platform_device *pdev)
>  {
>  	struct exynos_pcie *exynos_pcie = platform_get_drvdata(pdev);
>  
> -	clk_disable_unprepare(exynos_pcie->bus_clk);
> -	clk_disable_unprepare(exynos_pcie->clk);
> +	if (exynos_pcie->ops && exynos_pcie->ops->deinit_clk_resources)
> +		exynos_pcie->ops->deinit_clk_resources(exynos_pcie);
>  
>  	return 0;
>  }
>  
>  static const struct of_device_id exynos_pcie_of_match[] = {
> -	{ .compatible = "samsung,exynos5440-pcie", },
> +	{	.compatible = "samsung,exynos5440-pcie",
> +		.data = &exynos5440_pcie_ops },

A nit, please put brackets in new lines, so:
	{
		...
	},


Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
I didn't do a thorough review, though.

Best regards,
Krzysztof
