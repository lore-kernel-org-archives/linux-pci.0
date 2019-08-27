Return-Path: <SRS0=srx4=WX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12137C3A5A3
	for <linux-pci@archiver.kernel.org>; Tue, 27 Aug 2019 23:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5D0721883
	for <linux-pci@archiver.kernel.org>; Tue, 27 Aug 2019 23:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566947224;
	bh=WE4QEs46+F0AXHLzxSkuwUCWzJwNYQIvdKGLoOjedEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nf6yqD/0GdPk+KxakwWc2ntH9OPGYdumThtTx/WLfS2EpdSuB60OWl1BNIPamqaUM
	 SZp0tsXRdrXOMtsR8T47bzewsst4Rg46geBoB3XQ22I79JveWyv8y2gsPwl6po+fzc
	 Ll3Xv9hpxjiYYMYTUWskZTuvZb7c6dCDf158Nmdc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbfH0XHE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 27 Aug 2019 19:07:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:39314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbfH0XHE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Aug 2019 19:07:04 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09904214DA;
        Tue, 27 Aug 2019 23:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566947222;
        bh=WE4QEs46+F0AXHLzxSkuwUCWzJwNYQIvdKGLoOjedEQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nbk0GzfVvfIDS2w248ZujPEbSU7RmkyFzJLmfCKhInfK7r2zQ1n5pr30kuzojc1n1
         iUk/K5GEwiUWMu8ikTnYZfkz7SG2Df3/BexhC7K6iOIijWSxbH3ARYdCgKerqaJMQE
         RkwKbTq8PTfLbZU2WoVQnFT0U0cpKug0xXpfRtHE=
Date:   Tue, 27 Aug 2019 18:06:59 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof Wilczynski <kw@linux.com>
Cc:     Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] PCI: Fix misspelled words.
Message-ID: <20190827230659.GF9987@google.com>
References: <20190819115306.27338-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819115306.27338-1-kw@linux.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 19, 2019 at 01:53:06PM +0200, Krzysztof Wilczynski wrote:
> Fix misspelled words in include/linux/pci.h, drivers/pci/Kconfig,
> and in the documentation for Freescale i.MX6 and Marvell Armada 7K/8K
> PCIe interfaces.  No functional change intended.
> 
> Related commit 96291d565550 ("PCI: Fix typos and whitespace errors").
> 
> Signed-off-by: Krzysztof Wilczynski <kw@linux.com>

Applied with Thomas' ack and Rob's reviewed-by to pci/trivial for
v5.4, thanks!

> ---
>  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt | 2 +-
>  Documentation/devicetree/bindings/pci/pci-armada8k.txt   | 2 +-
>  drivers/pci/Kconfig                                      | 2 +-
>  include/linux/pci.h                                      | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> index a7f5f5afa0e6..de4b2baf91e8 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> @@ -50,7 +50,7 @@ Additional required properties for imx7d-pcie and imx8mq-pcie:
>  - power-domains: Must be set to a phandle pointing to PCIE_PHY power domain
>  - resets: Must contain phandles to PCIe-related reset lines exposed by SRC
>    IP block
> -- reset-names: Must contain the following entires:
> +- reset-names: Must contain the following entries:
>  	       - "pciephy"
>  	       - "apps"
>  	       - "turnoff"
> diff --git a/Documentation/devicetree/bindings/pci/pci-armada8k.txt b/Documentation/devicetree/bindings/pci/pci-armada8k.txt
> index 9e3fc15e1af8..1aaa09254001 100644
> --- a/Documentation/devicetree/bindings/pci/pci-armada8k.txt
> +++ b/Documentation/devicetree/bindings/pci/pci-armada8k.txt
> @@ -11,7 +11,7 @@ Required properties:
>  - reg-names:
>     - "ctrl" for the control register region
>     - "config" for the config space region
> -- interrupts: Interrupt specifier for the PCIe controler
> +- interrupts: Interrupt specifier for the PCIe controller
>  - clocks: reference to the PCIe controller clocks
>  - clock-names: mandatory if there is a second clock, in this case the
>     name must be "core" for the first clock and "reg" for the second
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 2ab92409210a..46f4912a370d 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -170,7 +170,7 @@ config PCI_P2PDMA
>  
>  	  Many PCIe root complexes do not support P2P transactions and
>  	  it's hard to tell which support it at all, so at this time,
> -	  P2P DMA transations must be between devices behind the same root
> +	  P2P DMA transactions must be between devices behind the same root
>  	  port.
>  
>  	  If unsure, say N.
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 463486016290..5a89854bd3cb 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -961,7 +961,7 @@ resource_size_t pcibios_align_resource(void *, const struct resource *,
>  				resource_size_t,
>  				resource_size_t);
>  
> -/* Weak but can be overriden by arch */
> +/* Weak but can be overridden by arch */
>  void pci_fixup_cardbus(struct pci_bus *);
>  
>  /* Generic PCI functions used internally */
> -- 
> 2.22.0
> 
