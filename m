Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35101 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751316AbdGQTqo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jul 2017 15:46:44 -0400
Date: Mon, 17 Jul 2017 14:46:42 -0500
From: Rob Herring <robh@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 7/7] Documentation: bindings: convert to use per-lane
 Rockchip PCIe PHY
Message-ID: <20170717194642.3d7khqzw7bzcn62i@rob-hp-laptop>
References: <1500276982-208439-1-git-send-email-shawn.lin@rock-chips.com>
 <1500277122-21835-1-git-send-email-shawn.lin@rock-chips.com>
 <1500277122-21835-3-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1500277122-21835-3-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 17, 2017 at 03:38:42PM +0800, Shawn Lin wrote:
> This patch deprecate the legacy PCIe PHY and encourage user
> to use per-lane PHY mode by setting #phy-cells to 1.

Can we have some consistency in the subjects? For this one: 
"dt-bindings: phy: ..."

> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
>  Documentation/devicetree/bindings/phy/rockchip-pcie-phy.txt | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
