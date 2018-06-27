Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57948 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753398AbeF0Kmc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 Jun 2018 06:42:32 -0400
Date: Wed, 27 Jun 2018 11:44:12 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Alan Douglas <adouglas@cadence.com>
Cc: bhelgaas@google.com, kishon@ti.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.com,
        cyrille.pitchen@free-electrons.com
Subject: Re: [RESEND PATCH 0/4] PCI: cadence: Host and EP driver updates for
 PHY and power management
Message-ID: <20180627104412.GA8048@red-moon>
References: <1526995569-5481-1-git-send-email-adouglas@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1526995569-5481-1-git-send-email-adouglas@cadence.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 22, 2018 at 02:26:09PM +0100, Alan Douglas wrote:
> This is a series of patches for the cadence PCIe host and EP drivers, to:
>  - Add optional list of generic PHYs to host and EP drivers
>  - Add PHY bindings to devicetree
>  - Add Power Management ops, which will enable/disable PHYs if present
>  - Update cdns_pcie_writel function signature
> 
> Changes in v2:
>     Split commit into four patches
>     Re-based on v4.17-rc1
Alan,

can I drop this series ? It looks like it has been superseded by
a new posting:

https://patchwork.ozlabs.org/project/linux-pci/list/?series=51816

Thanks,
Lorenzo

> Alan Douglas (4):
>   PCI: cadence: Update cdns_pcie_writel function signature
>   PCI: cadence: Add generic PHY support to host and EP drivers
>   dt-bindings: PCI: cadence: Add DT bindings for optional PHYs
>   PCI: cadence: Add Power Management ops for host and EP
> 
>  .../devicetree/bindings/pci/cdns,cdns-pcie-ep.txt  |   4 +
>  .../bindings/pci/cdns,cdns-pcie-host.txt           |   2 +
>  drivers/pci/cadence/pcie-cadence-ep.c              |  15 ++-
>  drivers/pci/cadence/pcie-cadence-host.c            |  34 ++++++
>  drivers/pci/cadence/pcie-cadence.c                 | 123 +++++++++++++++++++++
>  drivers/pci/cadence/pcie-cadence.h                 |  13 ++-
>  6 files changed, 189 insertions(+), 2 deletions(-)
> 
> -- 
> 2.2.2
> 
