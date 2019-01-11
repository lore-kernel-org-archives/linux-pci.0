Return-Path: <SRS0=/dOL=PT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E424FC43387
	for <linux-pci@archiver.kernel.org>; Fri, 11 Jan 2019 19:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC9C52084C
	for <linux-pci@archiver.kernel.org>; Fri, 11 Jan 2019 19:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547236386;
	bh=/RbIUTsicKRWGlJZW/bYousgfFP0ecwjHcGBKq7xITc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=J4lglxg69vUlgJBjcQ3NN/LYLHko+u6qsXJiUJyd6xcz4FePDiNL9L/0Y7Hu8nkXQ
	 YugwCjSijfzCxC18rDaQlWSb7MgZi9PmxBjvCRGg0iyOaAH0FwvoY9WkOxlw9WMqUJ
	 C6lUY5d2gr8AevDbI+9ymFf3rW/Rv+T9eE+FWL84=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731202AbfAKTxG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 11 Jan 2019 14:53:06 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33042 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729124AbfAKTxF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Jan 2019 14:53:05 -0500
Received: by mail-ot1-f65.google.com with SMTP id i20so14218095otl.0;
        Fri, 11 Jan 2019 11:53:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+2TD2oZRzwkC+aydOSsmZyCcfz+f8jQPAtzrx0HUfqM=;
        b=a4BsSpaw116QsIseM8+alOa3onzc+F4NyUu5xFcduDzX5bQ8YlbMvID48jHjJQ5g0I
         7QCTfuZfzie8x9WibB1JkYQRcAzunS1tVWloVEha2xHhYef/zOYWBE6dRjVbvnK/L1e1
         peMroP13s+jdKjTp5JIdQTBMh60BZamJ18wpn95uU3+KhYJuu/HV2g6/eDHrvEei7DnY
         nFIuU5P0IalM9RS8t8mhyd6XFRPOYh56VMwC6i/8Ewot3UP13kTDufVmVNeGZl+3wSn5
         EVU0itDL0bZJ3F+s6mDk8VkZDrYg9iIgigtuaIYqxZjums7JMCcJVNQjVo9H1Bz1t4Jv
         RAOw==
X-Gm-Message-State: AJcUukclI03BGECOCUxa+Zwthr3DTWIFoNHydB9N7BZDISMSrNfkbZ20
        dtb4J5Hvt67UTUxb+wX1UA==
X-Google-Smtp-Source: ALg8bN7EzkRi1yi2nyRqFZbexKquii1ImncHMr18M7iKOeoBY5A61qbjzYXDOgcIZKa7dSRptWs7WQ==
X-Received: by 2002:a9d:4f0e:: with SMTP id d14mr10995137otl.259.1547236384002;
        Fri, 11 Jan 2019 11:53:04 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l108sm35408545otc.23.2019.01.11.11.53.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 11:53:03 -0800 (PST)
Date:   Fri, 11 Jan 2019 13:53:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, devicetree@vger.kernel.org,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 4/4] PCI: imx6: Add support for i.MX8MQ
Message-ID: <20190111195302.GA18985@bogus>
References: <20190104165335.13205-1-andrew.smirnov@gmail.com>
 <20190104165335.13205-5-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190104165335.13205-5-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 04, 2019 at 08:53:35AM -0800, Andrey Smirnov wrote:
> Add code needed to support i.MX8MQ variant.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Leonard Crestez <leonard.crestez@nxp.com>
> Cc: "A.s. Dong" <aisheng.dong@nxp.com>
> Cc: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: Rob Herring <robh@kernel.org>,
> Cc: devicetree@vger.kernel.org,
> Cc: linux-imx@nxp.com
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  .../bindings/pci/fsl,imx6q-pcie.txt           |  3 +-
>  drivers/pci/controller/dwc/Kconfig            |  4 +-
>  drivers/pci/controller/dwc/pci-imx6.c         | 77 ++++++++++++++++++-
>  3 files changed, 79 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> index d514c1f2365f..920ca93870a8 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> @@ -9,6 +9,7 @@ Required properties:
>  	- "fsl,imx6sx-pcie",
>  	- "fsl,imx6qp-pcie"
>  	- "fsl,imx7d-pcie"
> +	- "fsl,imx8mq-pcie"
>  - reg: base address and length of the PCIe controller
>  - interrupts: A list of interrupt outputs of the controller. Must contain an
>    entry for each entry in the interrupt-names property.
> @@ -45,7 +46,7 @@ Additional required properties for imx6sx-pcie:
>    PCIE_PHY power domains
>  - power-domain-names: Must be "pcie", "pcie_phy"
>  
> -Additional required properties for imx7d-pcie:
> +Additional required properties for imx7d-pcie and imx8mq-pcie:
>  - power-domains: Must be set to a phandle pointing to PCIE_PHY power domain
>  - resets: Must contain phandles to PCIe-related reset lines exposed by SRC
>    IP block
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 6aafec3fad00..83ea318ad989 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -89,8 +89,8 @@ config PCI_EXYNOS
>  	select PCIE_DW_HOST
>  
>  config PCI_IMX6
> -	bool "Freescale i.MX6/7 PCIe controller"
> -	depends on SOC_IMX6Q || SOC_IMX7D || (ARM && COMPILE_TEST)
> +	bool "Freescale i.MX6/7/8 PCIe controller"
> +	depends on SOC_IMX6Q || SOC_IMX7D || (ARM64 && ARCH_MXC) || ((ARM || ARM64) && COMPILE_TEST)

Since you added the ifdef around the abort handler, I think you can drop 
"(ARM || ARM64)" and enable building other arches.

Rob
