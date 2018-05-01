Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45620 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751920AbeEAK57 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 May 2018 06:57:59 -0400
Date: Tue, 1 May 2018 11:57:55 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Simon Horman <horms@verge.net.au>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Add R8A77980 PCIe support & some driver cleanups
Message-ID: <20180501105754.GC19391@e107981-ln.cambridge.arm.com>
References: <26e803ca-06b6-28c5-b87c-fc639b322d6f@cogentembedded.com>
 <20180501055553.3zh4ygux7aqvkmvs@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180501055553.3zh4ygux7aqvkmvs@verge.net.au>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 01, 2018 at 07:55:53AM +0200, Simon Horman wrote:
> On Sun, Apr 08, 2018 at 08:57:13PM +0300, Sergei Shtylyov wrote:
> > Hello!
> > 
> > Here's a set of 5 patches against the 'pci/rcar' branch of Lorenzo Pieralisi's
> > 'pci.git' repo. These are the changes needed for better R-Car gen3 support
> > (namely for R8A77980 support) plus some PCIe driver re-factoring done in
> > the process...
> > 
> > [1/5] pcie-rcar: poll PHYRDY in rcar_pcie_hw_init()
> > [2/5] pcie-rcar: remove PHYRDY polling from rcar_pcie_hw_init_h1()
> > [3/5] pcie-rcar: add R-Car gen3 PHY support
> > [4/5] pcie-rcar: factor out rcar_pcie_hw_init() call
> > [5/5] DT: pci: rcar-pci: document R8A77980 bindings
> 
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

Sergei, would you mind rebasing this series against my pci/rcar
branch please ? I will apply it then.

Thanks,
Lorenzo
