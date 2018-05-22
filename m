Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:36751 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751106AbeEVJQw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 May 2018 05:16:52 -0400
Date: Tue, 22 May 2018 11:16:48 +0200
From: Simon Horman <horms@verge.net.au>
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 4/4] PCI: rcar: Teardown MSI setup if rcar_pcie_enable()
 fails
Message-ID: <20180522091647.jn7rbdq2kvfzbbw2@verge.net.au>
References: <20180521131123.2009-1-marek.vasut+renesas@gmail.com>
 <20180521131123.2009-4-marek.vasut+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180521131123.2009-4-marek.vasut+renesas@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 21, 2018 at 03:11:23PM +0200, Marek Vasut wrote:
> If the rcar_pcie_enable() fails and MSIs are enabled, the setup done in
> rcar_pcie_enable_msi() is never undone. Add a function to tear down the
> MSI setup by disabling the MSI handling in the PCIe block, deallocating
> the pages requested for the MSIs and zapping the IRQ mapping.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-renesas-soc@vger.kernel.org
> ---
>  drivers/pci/host/pcie-rcar.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
