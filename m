Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33403 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932382AbdESBhl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 May 2017 21:37:41 -0400
Date: Thu, 18 May 2017 20:37:34 -0500
From: Rob Herring <robh@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] pci: ftpci100: add clock bindings
Message-ID: <20170519013734.rk22qe2doo4b5dpu@rob-hp-laptop>
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
> ---
>  Documentation/devicetree/bindings/pci/faraday,ftpci100.txt | 7 +++++++
>  1 file changed, 7 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
