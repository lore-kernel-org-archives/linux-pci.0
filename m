Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:56101 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754002AbeE1IyB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 May 2018 04:54:01 -0400
Date: Mon, 28 May 2018 10:53:57 +0200
From: Simon Horman <horms@verge.net.au>
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v4 5/6] PCI: rcar: Remove IRQ mappings in
 rcar_pcie_enable_msi failpath
Message-ID: <20180528085357.ca65f23mdrftaeu6@verge.net.au>
References: <20180524143624.26718-1-marek.vasut+renesas@gmail.com>
 <20180524143624.26718-6-marek.vasut+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180524143624.26718-6-marek.vasut+renesas@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 24, 2018 at 04:36:23PM +0200, Marek Vasut wrote:
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
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-renesas-soc@vger.kernel.org

Acked-by: Simon Horman <horms+renesas@verge.net.au>
