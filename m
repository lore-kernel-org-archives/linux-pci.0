Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34694 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753845AbeEOPv7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 May 2018 11:51:59 -0400
Date: Tue, 15 May 2018 16:51:53 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: bhelgaas@google.com, kishon@ti.com, jesper.nilsson@axis.com,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI: dwc: Use devm_ioremap_resource instead of
 devm_ioremap_resource
Message-ID: <20180515155153.GA966@e107981-ln.cambridge.arm.com>
References: <cover.1526319075.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1526319075.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 14, 2018 at 06:32:33PM +0100, Gustavo Pimentel wrote:
> This fix aims to replace the use of devm_ioremap() by
> devm_ioremap_resource() already discussed on [1]
> 
> Gustavo Pimentel (2):
>   PCI: dwc: artpec6: Use devm_ioremap_resource instead of devm_ioremap
>   PCI: dwc: dra7xx: Use devm_ioremap_resource instead of devm_ioremap
> 
>  drivers/pci/dwc/pci-dra7xx.c   | 18 +++++++++---------
>  drivers/pci/dwc/pcie-artpec6.c |  6 +++---
>  2 files changed, 12 insertions(+), 12 deletions(-)

Applied to pci/dwc for v4.18 with all required log tweaks, please
read Bjorn's guidelines below:

https://marc.info/?l=linux-pci&m=150905742808166&w=2

Thanks,
Lorenzo
