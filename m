Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:55724 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750984AbeEAF4M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 May 2018 01:56:12 -0400
Date: Tue, 1 May 2018 07:55:53 +0200
From: Simon Horman <horms@verge.net.au>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v2 0/5] Add R8A77980 PCIe support & some driver cleanups
Message-ID: <20180501055553.3zh4ygux7aqvkmvs@verge.net.au>
References: <26e803ca-06b6-28c5-b87c-fc639b322d6f@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <26e803ca-06b6-28c5-b87c-fc639b322d6f@cogentembedded.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Apr 08, 2018 at 08:57:13PM +0300, Sergei Shtylyov wrote:
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

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
