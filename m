Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53272 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750820AbeEDNXD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 May 2018 09:23:03 -0400
Date: Fri, 4 May 2018 14:22:59 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: horms@verge.net.au, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3 0/5] Add R8A77980 PCIe support & some driver cleanups
Message-ID: <20180504132259.GB8759@e107981-ln.cambridge.arm.com>
References: <b98130a7-b128-9fc3-aee1-1a5a2590b320@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b98130a7-b128-9fc3-aee1-1a5a2590b320@cogentembedded.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 03, 2018 at 10:32:41PM +0300, Sergei Shtylyov wrote:
> Hello!
> 
> Here's a set of 5 patches against the 'pci/rcar' branch of Lorenzo Pieralisi's
> 'pci.git' repo. These are the changes needed for better R-Car gen3 support
> (namely for R8A77980 support) plus some PCIe driver re-factoring done in
> the process...
> 
> [1/5] pcie-rcar: poll PHYRDY in rcar_pcie_hw_init()
> [2/5] pcie-rcar: remove PHYRDY polling from rcar_pcie_hw_init_h1()
> [3/5] pcie-rcar: add R-Car gen3 PHY support
> [4/5] pcie-rcar: factor out rcar_pcie_hw_init() call
> [5/5] DT: pci: rcar-pci: document R8A77980 bindings

I applied the series, with some commit log changes, I can comment
on those please have a look at my updated pci/rcar branch.

Thanks,
Lorenzo
