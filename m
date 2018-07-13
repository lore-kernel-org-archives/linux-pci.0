Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34722 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728289AbeGMNPG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Jul 2018 09:15:06 -0400
Date: Fri, 13 Jul 2018 14:02:27 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Alan Douglas <adouglas@cadence.com>
Cc: bhelgaas@google.com, kishon@ti.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH 0/5] PCI: cadence: Host and EP driver updates for PHY and
 power management
Message-ID: <20180713130227.GA18515@red-moon>
References: <1529915453-4633-1-git-send-email-adouglas@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1529915453-4633-1-git-send-email-adouglas@cadence.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 25, 2018 at 09:30:48AM +0100, Alan Douglas wrote:
> This is a series of patches for the cadence PCIe host and EP drivers, to:
>  - Add optional list of generic PHYs to host and EP drivers
>  - Add PHY bindings to devicetree
>  - Add Power Management ops, which will enable/disable PHYs if present
>  - Add shutdown handler to host driver
>  - Update cdns_pcie_writel function signature
> 
> Changes in v3:
> 	Use devm_phy_optional_get() to get optional PHY
> 	Updated decription in DT bindings to cover use of single/multiple PHYs
> 	Split patch to add shutdown callback in separate patch
> 	Re-based on v4.18-rc1
> 
> Changes in v2:
> 	Split commit into four patches
> 	Re-based on v4.17-rc1
> 
> Alan Douglas (5):
>   PCI: cadence: Update cdns_pcie_writel function signature
>   PCI: cadence: Add generic PHY support to host and EP drivers
>   dt-bindings: PCI: cadence: Add DT bindings for optional PHYs
>   PCI: cadence: Add Power Management ops for host and EP
>   PCI: cadence: Add shutdown callback to host driver
> 
>  .../devicetree/bindings/pci/cdns,cdns-pcie-ep.txt  |    5 +
>  .../bindings/pci/cdns,cdns-pcie-host.txt           |    6 +
>  drivers/pci/controller/pcie-cadence-ep.c           |   15 +++-
>  drivers/pci/controller/pcie-cadence-host.c         |   33 +++++
>  drivers/pci/controller/pcie-cadence.c              |  123 ++++++++++++++++++++
>  drivers/pci/controller/pcie-cadence.h              |   13 ++-
>  6 files changed, 193 insertions(+), 2 deletions(-)

Applied to pci/cadence for v4.19, thank you very much.

Lorenzo
> 
