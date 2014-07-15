Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:35413 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752881AbaGOWvd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Jul 2014 18:51:33 -0400
Received: by mail-ie0-f171.google.com with SMTP id at1so79636iec.16
        for <linux-pci@vger.kernel.org>; Tue, 15 Jul 2014 15:51:32 -0700 (PDT)
Date: Tue, 15 Jul 2014 16:51:29 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Stephen Warren <swarren@wwwdotorg.org>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: mvebu: Fix license string
Message-ID: <20140715225129.GA22303@google.com>
References: <1405061938-2191-1-git-send-email-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1405061938-2191-1-git-send-email-thierry.reding@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 11, 2014 at 08:58:57AM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The proper MODULE_LICENSE() string for the GPL v2 is "GPL v2", not
> "GPLv2".
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Applied with Jingoo's reviewed-by and Thomas' ack to pci/host-mvebu
for v3.17, thanks!

I'll also post similar patches for drivers/pci/host/pci-host-generic.c and
drivers/pci/host/pcie-rcar.c, the only other occurrences of "GPLv2" in
drivers/pci.

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
