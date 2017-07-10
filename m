Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752158AbdGJUoi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Jul 2017 16:44:38 -0400
Date: Mon, 10 Jul 2017 15:44:33 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: PCI: rockchip: Add vpcie12v-supply for
 Rockchip PCIe controller
Message-ID: <20170710204433.GB5610@bhelgaas-glaptop.roam.corp.google.com>
References: <1498699288-63944-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1498699288-63944-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 29, 2017 at 09:21:28AM +0800, Shawn Lin wrote:
> PCIe connector provide a optional 12V power supply for high
> power downstream components, so we add this as a optional
> one if we need to control it.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Applied patches 1 & 2 with Rob's ack to pci/host-rockchip for v4.14,
thanks!

> ---
> 
>  Documentation/devicetree/bindings/pci/rockchip-pcie.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/rockchip-pcie.txt b/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
> index 1453a73..9b88959 100644
> --- a/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
> @@ -47,6 +47,7 @@ Optional Property:
>  	using 24MHz OSC for RC's PHY.
>  - ep-gpios: contain the entry for pre-reset gpio
>  - num-lanes: number of lanes to use
> +- vpcie12v-supply: The phandle to the 12v regulator to use for PCIe.
>  - vpcie3v3-supply: The phandle to the 3.3v regulator to use for PCIe.
>  - vpcie1v8-supply: The phandle to the 1.8v regulator to use for PCIe.
>  - vpcie0v9-supply: The phandle to the 0.9v regulator to use for PCIe.
> -- 
> 1.9.1
> 
> 
