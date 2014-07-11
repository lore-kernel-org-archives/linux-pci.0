Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:21937 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154AbaGKHGT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 11 Jul 2014 03:06:19 -0400
From: Jingoo Han <jg1.han@samsung.com>
To: 'Thierry Reding' <thierry.reding@gmail.com>,
	'Bjorn Helgaas' <bhelgaas@google.com>
Cc: 'Thomas Petazzoni' <thomas.petazzoni@free-electrons.com>,
	'Jason Cooper' <jason@lakedaemon.net>,
	'Stephen Warren' <swarren@wwwdotorg.org>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-tegra@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>
References: <1405061938-2191-1-git-send-email-thierry.reding@gmail.com>
In-reply-to: <1405061938-2191-1-git-send-email-thierry.reding@gmail.com>
Subject: Re: [PATCH 1/2] PCI: mvebu: Fix license string
Date: Fri, 11 Jul 2014 16:06:16 +0900
Message-id: <004201cf9cd6$9beeda10$d3cc8e30$%han@samsung.com>
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
>  drivers/pci/host/pci-mvebu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
> index ce23e0f076b6..a8c6f1a92e0f 100644
> --- a/drivers/pci/host/pci-mvebu.c
> +++ b/drivers/pci/host/pci-mvebu.c
> @@ -1094,4 +1094,4 @@ module_platform_driver(mvebu_pcie_driver);
> 
>  MODULE_AUTHOR("Thomas Petazzoni <thomas.petazzoni@free-electrons.com>");
>  MODULE_DESCRIPTION("Marvell EBU PCIe driver");
> -MODULE_LICENSE("GPLv2");
> +MODULE_LICENSE("GPL v2");
> --
> 2.0.1
> 
> --

