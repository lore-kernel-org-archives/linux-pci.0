Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:44078 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751121AbeECQWM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 May 2018 12:22:12 -0400
Date: Thu, 3 May 2018 17:22:04 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Simon Horman <horms@verge.net.au>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Add R8A77980 PCIe support & some driver cleanups
Message-ID: <20180503162204.GA25638@e107981-ln.cambridge.arm.com>
References: <26e803ca-06b6-28c5-b87c-fc639b322d6f@cogentembedded.com>
 <20180501055553.3zh4ygux7aqvkmvs@verge.net.au>
 <20180501105754.GC19391@e107981-ln.cambridge.arm.com>
 <0f5bc40e-a82b-4826-e711-19a83d0bffb7@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0f5bc40e-a82b-4826-e711-19a83d0bffb7@cogentembedded.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 03, 2018 at 06:26:43PM +0300, Sergei Shtylyov wrote:
> On 05/01/2018 01:57 PM, Lorenzo Pieralisi wrote:
> 
> >>> Hello!
> >>>
> >>> Here's a set of 5 patches against the 'pci/rcar' branch of Lorenzo Pieralisi's
> >>> 'pci.git' repo. These are the changes needed for better R-Car gen3 support
> >>> (namely for R8A77980 support) plus some PCIe driver re-factoring done in
> >>> the process...
> >>>
> >>> [1/5] pcie-rcar: poll PHYRDY in rcar_pcie_hw_init()
> >>> [2/5] pcie-rcar: remove PHYRDY polling from rcar_pcie_hw_init_h1()
> >>> [3/5] pcie-rcar: add R-Car gen3 PHY support
> >>> [4/5] pcie-rcar: factor out rcar_pcie_hw_init() call
> >>> [5/5] DT: pci: rcar-pci: document R8A77980 bindings
> >>
> >> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
> > 
> > Sergei, would you mind rebasing this series against my pci/rcar
> > branch please ?
> 
>    You mean against your updated 'pci/rcar' branch? (The patches were
>    against that branch in the 1st place, and they still do apply,
>    though with fuzz in one of the patches)...

Yes the current pci/rcar branch, thanks a lot.

Lorenzo
