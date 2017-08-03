Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33426 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751791AbdHCXmP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2017 19:42:15 -0400
Date: Thu, 3 Aug 2017 18:42:12 -0500
From: Rob Herring <robh@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: v3: Update the device tree bindings
Message-ID: <20170803234212.fqqvtckrohibqiqa@rob-hp-laptop>
References: <20170731084451.19736-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170731084451.19736-1-linus.walleij@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 31, 2017 at 10:44:51AM +0200, Linus Walleij wrote:
> The bindings for the V3 Semiconductor PCI bridge are a tad bit outdated
> and predates the more formal format we have adopted for the bindings.
> Update them a bit so it is easier to read, and add the Integrator AP-
> specific compatible so we can detect that we are running on that specific
> platform.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../devicetree/bindings/pci/v3-v360epc-pci.txt        | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
