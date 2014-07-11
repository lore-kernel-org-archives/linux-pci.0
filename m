Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:33181 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751847AbaGKHYv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 11 Jul 2014 03:24:51 -0400
Date: Fri, 11 Jul 2014 09:24:47 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Stephen Warren <swarren@wwwdotorg.org>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: mvebu: Fix license string
Message-ID: <20140711092447.3b40f24a@free-electrons.com>
In-Reply-To: <1405061938-2191-1-git-send-email-thierry.reding@gmail.com>
References: <1405061938-2191-1-git-send-email-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Thierry Reding,

On Fri, 11 Jul 2014 08:58:57 +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The proper MODULE_LICENSE() string for the GPL v2 is "GPL v2", not
> "GPLv2".
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
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

Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
