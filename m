Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48692 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751687AbeACLmG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Jan 2018 06:42:06 -0500
Date: Wed, 3 Jan 2018 11:42:59 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-pci@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@kernel.org, robh+dt@kernel.org, krzk@kernel.org,
        jingoohan1@gmail.com, mark.rutland@arm.com, kgene@kernel.org
Subject: Re: [PATCH] PCI: exynos: remove the deprecated phy codes
Message-ID: <20180103114259.GA26554@red-moon>
References: <CGME20171227094329epcas1p2a7b0a0f6130db4361592d8966d5ecb85@epcas1p2.samsung.com>
 <20171227094327.5671-1-jh80.chung@samsung.com>
 <20180102163407.GA9887@e107981-ln.cambridge.arm.com>
 <adf86cd6-ba78-33d5-284f-a31e0e9bf13c@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <adf86cd6-ba78-33d5-284f-a31e0e9bf13c@samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 03, 2018 at 02:26:29PM +0900, Jaehoon Chung wrote:
> On 01/03/2018 01:34 AM, Lorenzo Pieralisi wrote:
> > On Wed, Dec 27, 2017 at 06:43:27PM +0900, Jaehoon Chung wrote:
> >> pci-exynos had updated to use the PHY framework.
> >> (drivers/phy/samsung/phy-exynos-pcie.c)
> >> Removed the depreccated codes relevant to phy in pci-exynos.c.
> >> Instead, use the phy-exynos-pcie.c file.
> >>
> >> Modified the binding documentation.
> >>
> >> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> >> ---
> >>  .../bindings/pci/samsung,exynos5440-pcie.txt       |  58 ++----
> >>  drivers/pci/dwc/pci-exynos.c                       | 219 ++-------------------
> >>  2 files changed, 22 insertions(+), 255 deletions(-)
> > 
> > I have updated the commit log to the patch below, please
> > check before I push it out.
> 
> Looks good to me. At next time, i will write the commit-msg more carefully.

No problem, applied to pci/dwc for v4.16, thanks.

Lorenzo
