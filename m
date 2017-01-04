Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35123 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754510AbdADPRR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Jan 2017 10:17:17 -0500
Date: Wed, 4 Jan 2017 09:17:14 -0600
From: Rob Herring <robh@kernel.org>
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        bhelgaas@google.com, mark.rutland@arm.com, kgene@kernel.org,
        krzk@kernel.org, kishon@ti.com, jingoohan1@gmail.com,
        vivek.gautam@codeaurora.org, pankaj.dubey@samsung.com,
        alim.akhtar@samsung.com, cpgs@samsung.com
Subject: Re: [PATCH V2 1/5] Documetation: samsung-phy: add the
 exynos-pcie-phy binding
Message-ID: <20170104151714.k7irwwtcjwehbctc@rob-hp-laptop>
References: <20170104123435.30740-1-jh80.chung@samsung.com>
 <CGME20170104123436epcas1p1d3d840e4ade396a60ce690b09d486990@epcas1p1.samsung.com>
 <20170104123435.30740-2-jh80.chung@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170104123435.30740-2-jh80.chung@samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 04, 2017 at 09:34:31PM +0900, Jaehoon Chung wrote:
> Adds the exynos-pcie-phy binding for Exynos PCIe PHY.
> This is for using generic PHY framework.
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
> Changelog on V2:
> - Remove the child node.
> - Add 2nd address to the parent reg prop.
> 
>  Documentation/devicetree/bindings/phy/samsung-phy.txt | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
