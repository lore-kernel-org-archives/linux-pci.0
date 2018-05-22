Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:36709 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751106AbeEVJOk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 May 2018 05:14:40 -0400
Date: Tue, 22 May 2018 11:14:35 +0200
From: Simon Horman <horms@verge.net.au>
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 3/4] PCI: rcar: Add missing irq_dispose_mapping() into
 failpath
Message-ID: <20180522091434.yciqidu46kodxpw4@verge.net.au>
References: <20180521131123.2009-1-marek.vasut+renesas@gmail.com>
 <20180521131123.2009-3-marek.vasut+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180521131123.2009-3-marek.vasut+renesas@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 21, 2018 at 03:11:22PM +0200, Marek Vasut wrote:
> The rcar_pcie_get_resources() is another misnomer with a side effect.
> The function does not only get resources, but also maps MSI IRQs via
> irq_of_parse_and_map(). In case anything fails afterward, the IRQ
> mapping must be disposed through irq_dispose_mapping() which is not
> done.
> 
> This patch handles irq_of_parse_and_map() failures in by disposing
> of the mapping in rcar_pcie_get_resources() as well as in probe.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-renesas-soc@vger.kernel.org
> ---
>  drivers/pci/host/pcie-rcar.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
