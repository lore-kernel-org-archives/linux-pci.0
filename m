Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.135]:58487 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753787AbbKWKAQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 23 Nov 2015 05:00:16 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Bjorn Andersson <bjorn.andersson@sonymobile.com>
Subject: Re: [PATCH v3 1/6] PCI: designware: remove wrong io_base assignment
Date: Mon, 23 Nov 2015 10:59:36 +0100
Message-ID: <6048361.Am0T3g77Bd@wuerfel>
In-Reply-To: <44d133d5ebd4f7b9e8b817aa8bae12f690e70000.1448270813.git.stanimir.varbanov@linaro.org>
References: <cover.1448270813.git.stanimir.varbanov@linaro.org> <44d133d5ebd4f7b9e8b817aa8bae12f690e70000.1448270813.git.stanimir.varbanov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday 23 November 2015 11:28:58 Stanimir Varbanov wrote:
> The io_base is used to keep the cpu physical address parsed
> from ranges dt property. After issue pci_remap_iospace the
> io_base has been assigned with io->start, which is not correct
> cause io->start is a PCI bus address.
> 
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  drivers/pci/host/pcie-designware.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 540f077c37ea..02a7452bdf23 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -440,7 +440,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  					 ret, pp->io);
>  				continue;
>  			}
> -			pp->io_base = pp->io->start;
>  			break;
>  		case IORESOURCE_MEM:
>  			pp->mem = win->res;

I was surprised to see such an obvious bug here, as we had spent a lot of
time trying to get it right. However, it broke only recently and it's
worth mentioning what commit did it, so

Fixes: 0021d22b73d6 ("PCI: designware: Use of_pci_get_host_bridge_resources() to parse DT")
Reviewed-by: Arnd Bergmann <arnd@arndb.de>

The bug is present in 4.4-rc1 and we should get your fix merged into 4.4
as well, while all the other patches in your series are presumably for 4.5.

	Arnd
