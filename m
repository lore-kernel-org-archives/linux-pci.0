Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161115AbdEWUkn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 May 2017 16:40:43 -0400
Date: Tue, 23 May 2017 15:40:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] pci: ftpci100: add clock bindings
Message-ID: <20170523204041.GB15055@bhelgaas-glaptop.roam.corp.google.com>
References: <20170515172312.1722-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170515172312.1722-1-linus.walleij@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 15, 2017 at 07:23:12PM +0200, Linus Walleij wrote:
> The Faraday FTPCI100 controller has two clock ports, PCLK and PCICLK.
> We add bindings for these two clocks so we can assign them in the device
> tree.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied both (with Rob's ack on the first) to pci/host-faraday for v4.13,
thanks!

> ---
>  Documentation/devicetree/bindings/pci/faraday,ftpci100.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/faraday,ftpci100.txt b/Documentation/devicetree/bindings/pci/faraday,ftpci100.txt
> index 35d4a979bb7b..89a84f8aa621 100644
> --- a/Documentation/devicetree/bindings/pci/faraday,ftpci100.txt
> +++ b/Documentation/devicetree/bindings/pci/faraday,ftpci100.txt
> @@ -30,6 +30,13 @@ Mandatory properties:
>    128MB, 256MB, 512MB, 1GB or 2GB in size. The memory should be marked as
>    pre-fetchable.
>  
> +Optional properties:
> +- clocks: when present, this should contain the peripheral clock (PCLK) and the
> +  PCI clock (PCICLK). If these are not present, they are assumed to be
> +  hard-wired enabled and always on. The PCI clock will be 33 or 66 MHz.
> +- clock-names: when present, this should contain "PCLK" for the peripheral
> +  clock and "PCICLK" for the PCI-side clock.
> +
>  Mandatory subnodes:
>  - For "faraday,ftpci100" a node representing the interrupt-controller inside the
>    host bridge is mandatory. It has the following mandatory properties:
> -- 
> 2.9.3
> 
