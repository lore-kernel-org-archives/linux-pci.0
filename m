Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:55636 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154AbaGKHHW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 11 Jul 2014 03:07:22 -0400
From: Jingoo Han <jg1.han@samsung.com>
To: 'Thierry Reding' <thierry.reding@gmail.com>,
	'Bjorn Helgaas' <bhelgaas@google.com>
Cc: 'Thomas Petazzoni' <thomas.petazzoni@free-electrons.com>,
	'Jason Cooper' <jason@lakedaemon.net>,
	'Stephen Warren' <swarren@wwwdotorg.org>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-tegra@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>
References: <1405061938-2191-1-git-send-email-thierry.reding@gmail.com>
 <1405061938-2191-2-git-send-email-thierry.reding@gmail.com>
In-reply-to: <1405061938-2191-2-git-send-email-thierry.reding@gmail.com>
Subject: Re: [PATCH 2/2] PCI: tegra: Fix license string
Date: Fri, 11 Jul 2014 16:07:21 +0900
Message-id: <004301cf9cd6$c22ae840$4680b8c0$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, July 11, 2014 3:59 PM, Thierry Reding wrote:
> 
> From: Thierry Reding <treding@nvidia.com>
> 
> The proper MODULE_LICENSE() string for the GPL v2 is "GPL v2", not
> "GPLv2".
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Reviewed-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

> ---
>  drivers/pci/host/pci-tegra.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> index 7df5aaf58921..14ec5b2c69e0 100644
> --- a/drivers/pci/host/pci-tegra.c
> +++ b/drivers/pci/host/pci-tegra.c
> @@ -1742,4 +1742,4 @@ module_platform_driver(tegra_pcie_driver);
> 
>  MODULE_AUTHOR("Thierry Reding <treding@nvidia.com>");
>  MODULE_DESCRIPTION("NVIDIA Tegra PCIe driver");
> -MODULE_LICENSE("GPLv2");
> +MODULE_LICENSE("GPL v2");
> --
> 2.0.1

