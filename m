Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:36653 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933722AbeBLORo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Feb 2018 09:17:44 -0500
Date: Mon, 12 Feb 2018 08:17:42 -0600
From: Rob Herring <robh@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 6/6] dt-bindings: PCI: rockchip: Add DT bindings for
 Rockchip PCIe endpoint controller
Message-ID: <20180212141742.ism3xnohyonp6pi3@rob-hp-laptop>
References: <1517971650-61555-1-git-send-email-shawn.lin@rock-chips.com>
 <1517971826-65350-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1517971826-65350-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 07, 2018 at 10:50:26AM +0800, Shawn Lin wrote:
> This patch documents the DT bindings for the Rockchip PCIe controller
> when configured in endpoint mode.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> ---
> 
>  .../devicetree/bindings/pci/rockchip-pcie-ep.txt   | 60 ++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/rockchip-pcie-ep.txt

Reviewed-by: Rob Herring <robh@kernel.org>
