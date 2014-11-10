Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:47961 "EHLO
	mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752264AbaKJGjy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 10 Nov 2014 01:39:54 -0500
Received: by mail-oi0-f51.google.com with SMTP id g201so5005488oib.10
        for <linux-pci@vger.kernel.org>; Sun, 09 Nov 2014 22:39:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <001f01cff983$deb4da20$9c1e8e60$%han@samsung.com>
References: <001f01cff983$deb4da20$9c1e8e60$%han@samsung.com>
Date: Mon, 10 Nov 2014 12:09:54 +0530
Message-ID: <CAKohpomrCHsWW40QSTWRYy7TbDN4miLR0+ZmQ6fO2K70pzUXHA@mail.gmail.com>
Subject: Re: [PATCH] PCI: spear: Add __init annotation to spear13xx_add_pcie_port()
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jingoo Han <jg1.han@samsung.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Mohit Kumar <mohit.kumar@st.com>,
	Pratyush Anand <pratyush.anand@st.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 6 November 2014 11:08, Jingoo Han <jg1.han@samsung.com> wrote:
> Add __init annotation to spear13xx_add_pcie_port(), because
> the spear13xx_add_pcie_port() is called only by spear13xx_pcie_probe()
> that was already marked as __init. Also, this patch fixes
> section mismatch warning.
>
> WARNING: drivers/pci/host/built-in.o(.text.unlikely+0x94): Section mismatch in reference from the function spear13xx_add_pcie_port()
> to the function .init.text:dw_pcie_host_init()
> The function spear13xx_add_pcie_port() references
> the function __init dw_pcie_host_init().
> This is often because spear13xx_add_pcie_port lacks a __init
> annotation or the annotation of dw_pcie_host_init is wrong.
>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
> This patch is based on the submitted patch "[PATCH V2] PCI:
> spear: Add spear13xx before add_pcie_port/pcie_initt".
>
>  drivers/pci/host/pcie-spear13xx.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/host/pcie-spear13xx.c b/drivers/pci/host/pcie-spear13xx.c
> index 63f869f..60f43cd 100644
> --- a/drivers/pci/host/pcie-spear13xx.c
> +++ b/drivers/pci/host/pcie-spear13xx.c
> @@ -269,8 +269,8 @@ static struct pcie_host_ops spear13xx_pcie_host_ops = {
>         .host_init = spear13xx_pcie_host_init,
>  };
>
> -static int spear13xx_add_pcie_port(struct pcie_port *pp,
> -                                  struct platform_device *pdev)
> +static int __init spear13xx_add_pcie_port(struct pcie_port *pp,
> +                                        struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
>         int ret;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
