Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55914 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751787AbcGYUQR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 25 Jul 2016 16:16:17 -0400
Date: Mon, 25 Jul 2016 15:16:13 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Joao Pinto <Joao.Pinto@synopsys.com>
Cc: jingoohan1@gmail.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, jszhang@marvell.com,
	CARLOS.PALMINHA@synopsys.com, MiguelFalcao.Sousa@synopsys.com
Subject: Re: [PATCH v2 2/2] pcie-designware: add core version
Message-ID: <20160725201613.GA15939@localhost>
References: <cover.1469193895.git.jpinto@synopsys.com>
 <17d796c59a2b63a494d1695a4d04ed6fc9f93c0c.1469193895.git.jpinto@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17d796c59a2b63a494d1695a4d04ed6fc9f93c0c.1469193895.git.jpinto@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 22, 2016 at 02:29:39PM +0100, Joao Pinto wrote:
> 
> Signed-off-by: Joao Pinto <jpinto@synopsys.com>
> ---
> changes v1->v2:
> - Nothing changed. Just to keep up the patch set version.
> 
>  drivers/pci/host/pcie-designware.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 9135725..3e4c600 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -34,6 +34,10 @@
>  #define LINK_WAIT_IATU_MIN		9000
>  #define LINK_WAIT_IATU_MAX		10000
>  
> +/* Core version (available from core 4.70) */
> +#define PCIE_CORE_VERSION		0x8F8
> +#define PCIE_CORE_VERSION_480A		0x3438302a

This should add a use of these symbols at the same time.  There's no
point if adding things that aren't used.

>  /* Synopsys specific PCIE configuration registers */
>  #define PCIE_PORT_LINK_CONTROL		0x710
>  #define PORT_LINK_MODE_MASK		(0x3f << 16)
> -- 
> 1.8.1.5
> 
