Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36006 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751316AbdGQTpK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jul 2017 15:45:10 -0400
Date: Mon, 17 Jul 2017 14:45:08 -0500
From: Rob Herring <robh@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 6/7] dt-bindings: PCI: rockchip: convert to use per-lane
 PHY model
Message-ID: <20170717194508.3cvxs57ydwhk2mlr@rob-hp-laptop>
References: <1500276982-208439-1-git-send-email-shawn.lin@rock-chips.com>
 <1500277122-21835-1-git-send-email-shawn.lin@rock-chips.com>
 <1500277122-21835-2-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1500277122-21835-2-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 17, 2017 at 03:38:41PM +0800, Shawn Lin wrote:
> Deprecate legacy PHY model and encourage to use per-lane PHY
> model.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
>  .../devicetree/bindings/pci/rockchip-pcie.txt      | 25 ++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
