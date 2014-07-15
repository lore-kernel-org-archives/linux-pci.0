Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:41690 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752881AbaGOWwE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Jul 2014 18:52:04 -0400
Received: by mail-ie0-f178.google.com with SMTP id tp5so82183ieb.9
        for <linux-pci@vger.kernel.org>; Tue, 15 Jul 2014 15:52:02 -0700 (PDT)
Date: Tue, 15 Jul 2014 16:51:59 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Stephen Warren <swarren@wwwdotorg.org>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: tegra: Fix license string
Message-ID: <20140715225159.GB22303@google.com>
References: <1405061938-2191-1-git-send-email-thierry.reding@gmail.com>
 <1405061938-2191-2-git-send-email-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1405061938-2191-2-git-send-email-thierry.reding@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 11, 2014 at 08:58:58AM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The proper MODULE_LICENSE() string for the GPL v2 is "GPL v2", not
> "GPLv2".
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Applied with Jingoo's reviewed-by to pci/host-tegra for v3.17, thanks!

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
> 
