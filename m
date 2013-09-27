Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:60037 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754341Ab3I0TIe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 27 Sep 2013 15:08:34 -0400
Received: by mail-ie0-f174.google.com with SMTP id u16so4902864iet.33
        for <linux-pci@vger.kernel.org>; Fri, 27 Sep 2013 12:08:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <000001ceafab$5529e340$ff7da9c0$%han@samsung.com>
References: <000001ceafab$5529e340$ff7da9c0$%han@samsung.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 27 Sep 2013 13:08:13 -0600
Message-ID: <CAErSpo5ANE8hp40nVDpKZoX+9jOw-oEZkDZP+fEBu_p7EBVbTQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add maintainer entry for Samsung Exynos PCIe driver
To: Jingoo Han <jg1.han@samsung.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-samsung-soc@vger.kernel.org, Kukjin Kim <kgene@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 12, 2013 at 5:29 AM, Jingoo Han <jg1.han@samsung.com> wrote:
> Add myself as maintainer for Samsung Exynos PCIe driver.
>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Applied to my pci/host-exynos branch for v3.13.  Thanks!

> ---
>  MAINTAINERS |    6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6d0dabe..f00c469 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6346,6 +6346,12 @@ S:       Supported
>  F:     Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
>  F:     drivers/pci/host/pci-tegra.c
>
> +PCI DRIVER FOR SAMSUNG EXYNOS
> +M:     Jingoo Han <jg1.han@samsung.com>
> +L:     linux-pci@vger.kernel.org
> +S:     Maintained
> +F:     drivers/pci/host/pci-exynos.c
> +
>  PCMCIA SUBSYSTEM
>  P:     Linux PCMCIA Team
>  L:     linux-pcmcia@lists.infradead.org
> --
> 1.7.10.4
>
>
