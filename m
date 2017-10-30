Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kapsi.fi ([91.232.154.25]:33796 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752141AbdJ3KAD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Oct 2017 06:00:03 -0400
Subject: Re: [PATCH V2 07/12] PCI: tegra: Disable AFI dynamic clock gating
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        thierry.reding@gmail.com, bhelgaas@google.com,
        jonathanh@nvidia.com, vidyas@nvidia.com
References: <1509337143-25963-1-git-send-email-mmaddireddy@nvidia.com>
 <1509337143-25963-8-git-send-email-mmaddireddy@nvidia.com>
Cc: linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        kthota@nvidia.com
From: Mikko Perttunen <cyndis@kapsi.fi>
Message-ID: <7414bac3-6643-048d-cc34-77b95681274f@kapsi.fi>
Date: Mon, 30 Oct 2017 12:00:01 +0200
MIME-Version: 1.0
In-Reply-To: <1509337143-25963-8-git-send-email-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 30.10.2017 06:18, Manikanta Maddireddy wrote:
> When there are 32 outstanding writes from AFI to memory, the outstanding
> write counter overflows and indicates that there are "0" outstanding write
> transactions. This outstanding write counter is used to generate IDLE
> signal to dynamically gate the AFI clock.
>
> When memory controller is under heavy load, its possible that write
> completions will come back to AFI after long delay and AFI write counter
> overflows. AFI clock gets gated even when there are outstanding
> transactions towards memory controller resutling in system hang.
>
> Disable dynamic clock gating of AFI clock to avoid system hang.
>
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> V2:
> * no change in this patch
>
>  drivers/pci/host/pci-tegra.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> index bf615c5e6b78..75b408b32b8b 100644
> --- a/drivers/pci/host/pci-tegra.c
> +++ b/drivers/pci/host/pci-tegra.c
> @@ -103,8 +103,9 @@
>  #define AFI_MSI_EN_VEC6		0xa4
>  #define AFI_MSI_EN_VEC7		0xa8
>
> -#define AFI_CONFIGURATION		0xac
> -#define  AFI_CONFIGURATION_EN_FPCI	(1 << 0)
> +#define AFI_CONFIGURATION			0xac
> +#define  AFI_CONFIGURATION_EN_FPCI		(1 << 0)
> +#define  AFI_CONFIGURATION_CLKEN_OVERRIDE	(1 << 31)
>
>  #define AFI_FPCI_ERROR_MASKS	0xb0
>
> @@ -1057,9 +1058,10 @@ static int tegra_pcie_enable_controller(struct tegra_pcie *pcie)
>  		}
>  	}
>
> -	/* finally enable PCIe */
> +	/* Disable AFI dynamic clock gating and enable PCIe */
>  	value = afi_readl(pcie, AFI_CONFIGURATION);
> -	value |= AFI_CONFIGURATION_EN_FPCI;
> +	value |= (AFI_CONFIGURATION_EN_FPCI |
> +			AFI_CONFIGURATION_CLKEN_OVERRIDE);
>  	afi_writel(pcie, value, AFI_CONFIGURATION);
>
>  	value = AFI_INTR_EN_INI_SLVERR | AFI_INTR_EN_INI_DECERR |
>

Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
