Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:44387 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423168AbeCBPKX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Mar 2018 10:10:23 -0500
Date: Fri, 2 Mar 2018 09:10:21 -0600
From: Rob Herring <robh@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 4/6] dt-bindings: PCI: rockchip: Rename
 rockchip-pcie.txt to rockchip-pcie-host.txt
Message-ID: <20180302151021.jkz4xxtiomikl5df@rob-hp-laptop>
References: <1519348503-243259-1-git-send-email-shawn.lin@rock-chips.com>
 <1519348623-243549-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1519348623-243549-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 23, 2018 at 09:17:03AM +0800, Shawn Lin wrote:
> Just make it more obvious that this documentation is referenced for
> adding Rockchip PCIe controller as root complex mode.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> ---
> 
> Changes in v2:
> - remove rockchip,rk3399-pcie-host compatible(Suggested by Rob)
> 
>  .../devicetree/bindings/pci/{rockchip-pcie.txt => rockchip-pcie-host.txt} | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename Documentation/devicetree/bindings/pci/{rockchip-pcie.txt => rockchip-pcie-host.txt} (100%)

Reviewed-by: Rob Herring <robh@kernel.org>
