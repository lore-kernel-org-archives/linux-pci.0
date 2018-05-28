Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:56053 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753994AbeE1Iv1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 May 2018 04:51:27 -0400
Date: Mon, 28 May 2018 10:51:23 +0200
From: Simon Horman <horms@verge.net.au>
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v4 2/6] PCI: rcar: Add missing irq_dispose_mapping() into
 failpath
Message-ID: <20180528085122.oufttjzjk6yqe6ts@verge.net.au>
References: <20180524143624.26718-1-marek.vasut+renesas@gmail.com>
 <20180524143624.26718-3-marek.vasut+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180524143624.26718-3-marek.vasut+renesas@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 24, 2018 at 04:36:20PM +0200, Marek Vasut wrote:
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
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-renesas-soc@vger.kernel.org


Acked-by: Simon Horman <horms+renesas@verge.net.au>
