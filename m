Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:55724 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424525AbeCBOJR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Mar 2018 09:09:17 -0500
Date: Fri, 2 Mar 2018 14:09:08 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Jianguo Sun <sunjianguo1@huawei.com>,
        Jiancheng Xue <xuejiancheng@hisilicon.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Add power control for pcie-histb driver
Message-ID: <20180302140908.GA15719@e107981-ln.cambridge.arm.com>
References: <1519953121-28218-1-git-send-email-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1519953121-28218-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 02, 2018 at 09:11:59AM +0800, Shawn Guo wrote:
> It adds power control support for pcie-histb driver, by utilizing
> regulator infrastructural.
> 
> Changes for v3:
>  - Incorporate Rob's ACK on bindings doc.
>  - Capitalize  the first word of patch subject to match drivers/pci
>    convention.
>  - Reword vpcie-supply description a bit as per Bjorn's suggestion.
> 
> Shawn Guo (2):
>   PCI: histb: Fix error path of histb_pcie_host_enable()
>   PCI: histb: Add an optional regulator for PCIe port power control
> 
>  .../bindings/pci/hisilicon-histb-pcie.txt          |  1 +
>  drivers/pci/dwc/pcie-histb.c                       | 28 ++++++++++++++++++----
>  2 files changed, 25 insertions(+), 4 deletions(-)

Series applied to pci/dwc for v4.17, thanks.

Lorenzo
