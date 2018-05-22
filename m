Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:36690 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750733AbeEVJNi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 May 2018 05:13:38 -0400
Date: Tue, 22 May 2018 11:13:34 +0200
From: Simon Horman <horms@verge.net.au>
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 2/4] PCI: rcar: Pull bus clock enable/disable from
 rcar_pcie_get_resources()
Message-ID: <20180522091333.nxqks542za4gz4h2@verge.net.au>
References: <20180521131123.2009-1-marek.vasut+renesas@gmail.com>
 <20180521131123.2009-2-marek.vasut+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180521131123.2009-2-marek.vasut+renesas@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 21, 2018 at 03:11:21PM +0200, Marek Vasut wrote:
> The rcar_pcie_get_resources() is another misnomer with a side effect.
> The function does not only get resources, but also enables/disables bus
> clock. This is forgotten in the probe() function though and if anything
> in probe() fails after rcar_pcie_get_resources() is called, the bus
> clock are never disabled.
> 
> This patch pulls the clock handling out of the rcar_pcie_get_resources()
> and enables clock after all the resources were requested. Moreover, this
> patch also always disables the clock in case of failure.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-renesas-soc@vger.kernel.org

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
