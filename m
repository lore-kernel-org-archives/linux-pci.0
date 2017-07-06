Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yb0-f176.google.com ([209.85.213.176]:35894 "EHLO
        mail-yb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750896AbdGFOjl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jul 2017 10:39:41 -0400
Date: Thu, 6 Jul 2017 09:39:36 -0500
From: Rob Herring <robh@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: PCI: rockchip: Add vpcie12v-supply for
 Rockchip PCIe controller
Message-ID: <20170706143936.bl5yrrvseiq6fbu5@rob-hp-laptop>
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
> ---
> 
>  Documentation/devicetree/bindings/pci/rockchip-pcie.txt | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
