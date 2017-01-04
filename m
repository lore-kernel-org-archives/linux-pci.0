Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35473 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032277AbdADUVj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Jan 2017 15:21:39 -0500
From: "Jingoo Han" <jingoohan1@gmail.com>
To: "'Jaehoon Chung'" <jh80.chung@samsung.com>,
        <linux-pci@vger.kernel.org>
Cc: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>, <kgene@kernel.org>,
        <krzk@kernel.org>, <kishon@ti.com>, <vivek.gautam@codeaurora.org>,
        <pankaj.dubey@samsung.com>, <alim.akhtar@samsung.com>,
        <cpgs@samsung.com>
References: <20170104123435.30740-1-jh80.chung@samsung.com> <CGME20170104123436epcas1p1a729583c3c2307d8539a186f1050ea98@epcas1p1.samsung.com> <20170104123435.30740-3-jh80.chung@samsung.com>
In-Reply-To: <20170104123435.30740-3-jh80.chung@samsung.com>
Subject: Re: [PATCH V2 2/5] phy: phy-exynos-pcie: Add support for Exynos PCIe phy
Date: Wed, 4 Jan 2017 15:21:31 -0500
Message-ID: <000501d266c8$23d63960$6b82ac20$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, January 4, 2017 7:35 AM, Jaehoon Chung wrote:
> 
> This patch supports to use Generic Phy framework for Exynos PCIe phy.
> When Exynos that supported the pcie want to use the PCIe,
> it needs to control the phy resgister.
> But it should be more complex to control in their own PCIe device drivers.
> 
> Currently, there is an exynos5440 case to support the pcie.
> So this driver is based on Exynos5440 PCIe.
> In future, will support the Other exynos SoCs likes exynos5433, exynos7.
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>

Reviewed-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han

> ---
> Changelog on V2:
> - Not include the codes relevant to pci-exynos.
> - Remove the getting child node.
> 
>  drivers/phy/Kconfig           |   9 ++
>  drivers/phy/Makefile          |   1 +
>  drivers/phy/phy-exynos-pcie.c | 280
> ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 290 insertions(+)
>  create mode 100644 drivers/phy/phy-exynos-pcie.c
> 

