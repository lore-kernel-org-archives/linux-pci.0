Return-Path: <SRS0=7Kzx=O2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B11C43387
	for <linux-pci@archiver.kernel.org>; Mon, 17 Dec 2018 22:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C051020874
	for <linux-pci@archiver.kernel.org>; Mon, 17 Dec 2018 22:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iimr8ji2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbeLQWVO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 Dec 2018 17:21:14 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38877 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728080AbeLQWVN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Dec 2018 17:21:13 -0500
Received: by mail-lj1-f194.google.com with SMTP id c19-v6so12456914lja.5
        for <linux-pci@vger.kernel.org>; Mon, 17 Dec 2018 14:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RTa1nzVpxh5Z6ahXXdB2kd+hcGwAyl5NoLrFmX2gqnk=;
        b=iimr8ji2WhQQW8nSaJpRW36AciCtv+jcp/c7H8WQARV7oLRlBUbGX8Ur0GHyKpvq70
         JSrAG8FHTwl73a+Jb98U/CmLyoAwxCISNItYGYIFIKUsEPjZoRavcr9tMLYz5zE5lJ8y
         cc+scVU/PXdr92KpjFR/i7fvfFmT/xnDchaPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RTa1nzVpxh5Z6ahXXdB2kd+hcGwAyl5NoLrFmX2gqnk=;
        b=FLsUT80PrGtv+tcbAVC8PybCn9FGoobHUyOTb8FREiqXwHG7T0utxYHzFJRovclI0C
         WFXyGdudA2VViL/FmXOUoc0rZg/8qEKmpTgAFa+XsxZuJq53bP9B6nHMTmmFjyBuuaUH
         p6XrXvZ7EdTox0hPu5S3Pu6Vy2h57tiaYTO26PNGRd0No6sKwtxy7OuBpGJ6SlBWZFLP
         7yZxXX4zqP2tdWVBCT30G166qtdZ/A79YrbnL2+EpiWfKaMbo+CCIV8QAAhcRJGpMF0X
         FczPj2p4uTRHHc0Lp2+7RK/Jp7kAqAlCxMSmoYqplJbAW5ck3ZxTsdFC4aPXnGwEyeLI
         pZZA==
X-Gm-Message-State: AA+aEWbun1M62O3t8sY3H42S7uhYnOBc+u16KA0t7IxWY605qhd7X8Zv
        rPLc7cEQKJlmqzQsvKdRjHdojA==
X-Google-Smtp-Source: AFSGD/Xmsmc/0GRJTPydXiWbfONYBfiQ4FORQCfK9iNQIrnPoJ7iv2gxmzRReaBNJo2r+qNhlD5r5A==
X-Received: by 2002:a2e:92ca:: with SMTP id k10-v6mr8400520ljh.63.1545085270372;
        Mon, 17 Dec 2018 14:21:10 -0800 (PST)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id q6sm2814863lfh.52.2018.12.17.14.21.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 14:21:09 -0800 (PST)
Date:   Mon, 17 Dec 2018 23:21:07 +0100
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Joao Pinto <joao.pinto@synopsys.com>,
        Jose Abreu <jose.abreu@synopsys.com>,
        Luis Oliveira <luis.oliveira@synopsys.com>,
        Vitor Soares <vitor.soares@synopsys.com>,
        Nelson Costa <nelson.costa@synopsys.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>
Subject: Re: [RFC v2 0/6] dmaengine: Add Synopsys eDMA IP driver (version 0)
Message-ID: <20181217222107.GA14261@centauri.lan>
References: <cover.1545066805.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1545066805.git.gustavo.pimentel@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 17, 2018 at 06:19:32PM +0100, Gustavo Pimentel wrote:
> Add Synopsys eDMA IP driver (version 0) to Linux kernel. This IP is generally
> distributed with Synopsys PCIe EndPoint IP (depends of the use and licensing
> agreement), which supports:
>  - legacy and unroll modes
>  - 16 independent and concurrent channels (8 write + 8 read)
>  - supports linked list (scatter-gather) transfer
>  - each linked list descriptor can transfer from 1 byte to 4 Gbytes
>  - PCIe EndPoint glue-logic
> 
> Gustavo Pimentel (6):
>   dmaengine: Add Synopsys eDMA IP core driver
>   dmaengine: Add Synopsys eDMA IP version 0 support
>   dmaengine: Add Synopsys eDMA IP version 0 debugfs support
>   PCI: Add Synopsys endpoint EDDA Device id
>   dmaengine: Add Synopsys eDMA IP PCIe glue-logic
>   MAINTAINERS: Add Synopsys eDMA IP driver maintainer

Hello Gustavo,

Nice to see support for the embedded DMA controller used in the DWC PCIe
controller.

Some kind of documentation in Documentation/ would be nice.


The eDMA can be used both while the PCIe controller is in EP and RC mode,
right?
I guess that this support is only to use the eDMA for RC mode?

Do you have any benchmarks to share? (Perhaps with different buffer sizes).
Not sure what we will see, lower CPU utilization but more IRQs?
Have you thought about doing IRQ coalescing?

Usually we need dmas and dma-names in device tree, however, maybe that
isn't needed here, since it is an embedded DMA controller.
Don't we even need/want a DT property in the PCIe node, that says if we
want to enable the eDMA or not?

Usually a PCIe EP driver will call pci_ioremap_bar() and then use
readl()/writel() directly.
But since we now need to setup a DMA transfer, and wait for an IRQ,
how does this work?

I have a board that has a CC_DMA_ENABLE set, so if you give me some
detailed instructions how to test, I might be able to provide you with a
Tested-by.


Kind regards,
Niklas


> 
>  MAINTAINERS                              |   7 +
>  drivers/dma/Kconfig                      |   2 +
>  drivers/dma/Makefile                     |   1 +
>  drivers/dma/dw-edma/Kconfig              |  18 +
>  drivers/dma/dw-edma/Makefile             |   7 +
>  drivers/dma/dw-edma/dw-edma-core.c       | 845 +++++++++++++++++++++++++++++++
>  drivers/dma/dw-edma/dw-edma-core.h       | 147 ++++++
>  drivers/dma/dw-edma/dw-edma-pcie.c       | 258 ++++++++++
>  drivers/dma/dw-edma/dw-edma-v0-core.c    | 361 +++++++++++++
>  drivers/dma/dw-edma/dw-edma-v0-core.h    |  26 +
>  drivers/dma/dw-edma/dw-edma-v0-debugfs.c | 357 +++++++++++++
>  drivers/dma/dw-edma/dw-edma-v0-debugfs.h |  24 +
>  drivers/dma/dw-edma/dw-edma-v0-regs.h    | 145 ++++++
>  drivers/misc/pci_endpoint_test.c         |   2 +-
>  include/linux/dma/edma.h                 |  43 ++
>  include/linux/pci_ids.h                  |   1 +
>  16 files changed, 2243 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/dma/dw-edma/Kconfig
>  create mode 100644 drivers/dma/dw-edma/Makefile
>  create mode 100644 drivers/dma/dw-edma/dw-edma-core.c
>  create mode 100644 drivers/dma/dw-edma/dw-edma-core.h
>  create mode 100644 drivers/dma/dw-edma/dw-edma-pcie.c
>  create mode 100644 drivers/dma/dw-edma/dw-edma-v0-core.c
>  create mode 100644 drivers/dma/dw-edma/dw-edma-v0-core.h
>  create mode 100644 drivers/dma/dw-edma/dw-edma-v0-debugfs.c
>  create mode 100644 drivers/dma/dw-edma/dw-edma-v0-debugfs.h
>  create mode 100644 drivers/dma/dw-edma/dw-edma-v0-regs.h
>  create mode 100644 include/linux/dma/edma.h
> 
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Russell King <rmk+kernel@armlinux.org.uk>
> Cc: Eugeniy Paltsev <paltsev@synopsys.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Niklas Cassel <niklas.cassel@linaro.org>
> Cc: Joao Pinto <jpinto@synopsys.com>
> Cc: Jose Abreu <jose.abreu@synopsys.com>
> Cc: Luis Oliveira <lolivei@synopsys.com>
> Cc: Vitor Soares <vitor.soares@synopsys.com>
> Cc: Nelson Costa <nelson.costa@synopsys.com>
> Cc: Pedro Sousa <pedrom.sousa@synopsys.com>
> 
> -- 
> 2.7.4
> 
