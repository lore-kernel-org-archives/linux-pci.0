Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 2 Jan 2018 09:37:24 -0600
From: Rob Herring <robh@kernel.org>
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-pci@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@kernel.org, krzk@kernel.org, jingoohan1@gmail.com,
        mark.rutland@arm.com, kgene@kernel.org, lorenzo.pieralisi@arm.com
Subject: Re: [PATCH] PCI: exynos: remove the deprecated phy codes
Message-ID: <20180102153724.mbywsog6z4qe2d6m@rob-hp-laptop>
References: <CGME20171227094329epcas1p2a7b0a0f6130db4361592d8966d5ecb85@epcas1p2.samsung.com>
 <20171227094327.5671-1-jh80.chung@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171227094327.5671-1-jh80.chung@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 27, 2017 at 06:43:27PM +0900, Jaehoon Chung wrote:
> pci-exynos had updated to use the PHY framework.
> (drivers/phy/samsung/phy-exynos-pcie.c)
> Removed the depreccated codes relevant to phy in pci-exynos.c.
> Instead, use the phy-exynos-pcie.c file.
> 
> Modified the binding documentation.
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  .../bindings/pci/samsung,exynos5440-pcie.txt       |  58 ++----
>  drivers/pci/dwc/pci-exynos.c                       | 219 ++-------------------
>  2 files changed, 22 insertions(+), 255 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
