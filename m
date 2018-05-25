Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:42959 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965291AbeEYKEs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 May 2018 06:04:48 -0400
Date: Fri, 25 May 2018 12:04:44 +0200
From: Simon Horman <horms@verge.net.au>
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] PCI: rcar: Remove IRQ mappings in rcar_pcie_enable_msi
 failpath
Message-ID: <20180525100444.2257mefqsxdhfvfs@verge.net.au>
References: <20180523105220.25518-1-marek.vasut+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180523105220.25518-1-marek.vasut+renesas@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 23, 2018 at 12:52:20PM +0200, Marek Vasut wrote:
> The rcar_pcie_enable_msi() creates IRQ mappings using irq_create_mapping()
> before requesting the IRQs using devm_request_irq(). If devm_request_irq()
> fails for some reason, rcar_pcie_enable_msi() does not remove the mapping.
> 
> Pull out the code for disposing IRQ mappings from rcar_pcie_teardown_msi()
> into a separate function and call it from both rcar_pcie_teardown_msi()
> and rcar_pcie_enable_msi() failpath to remove the mappings correctly.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-renesas-soc@vger.kernel.org

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
