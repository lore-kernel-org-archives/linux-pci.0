Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750825AbdE3VjK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 May 2017 17:39:10 -0400
Date: Tue, 30 May 2017 16:39:08 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] pci: use proper name for the R-Car SoC
Message-ID: <20170530213908.GD14896@bhelgaas-glaptop.roam.corp.google.com>
References: <20170528093051.11816-1-wsa+renesas@sang-engineering.com>
 <20170528093051.11816-6-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170528093051.11816-6-wsa+renesas@sang-engineering.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, May 28, 2017 at 11:30:48AM +0200, Wolfram Sang wrote:
> It is 'R-Car', not 'RCar'. No code or binding changes, only descriptive text.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> I suggest this trivial patch should be picked individually per susbsystem.
> 
>  Documentation/devicetree/bindings/pci/rcar-pci.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied with Geert and Simon's acks to pci/host-rcar for v4.13, thanks!

> 
> diff --git a/Documentation/devicetree/bindings/pci/rcar-pci.txt b/Documentation/devicetree/bindings/pci/rcar-pci.txt
> index 34712d6fd25376..bd27428dda619d 100644
> --- a/Documentation/devicetree/bindings/pci/rcar-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/rcar-pci.txt
> @@ -1,4 +1,4 @@
> -* Renesas RCar PCIe interface
> +* Renesas R-Car PCIe interface
>  
>  Required properties:
>  compatible: "renesas,pcie-r8a7779" for the R8A7779 SoC;
> -- 
> 2.11.0
> 
