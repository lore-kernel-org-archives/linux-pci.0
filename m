Return-Path: <SRS0=XN0A=QS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BC0C282CE
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 17:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DC04222A1
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 17:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ZYB2JbEg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730941AbfBKRhc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Feb 2019 12:37:32 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:36622 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730462AbfBKRhc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Feb 2019 12:37:32 -0500
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id B0E5124E0DA5;
        Mon, 11 Feb 2019 09:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1549906651; bh=EndiyRsfAstbrYbJQXbU6EJ45QOMrsiIXIwcKXTKjAE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=ZYB2JbEgzr0ZXUA+YK5ouPs/nk1s2J8/omg6zPE35EEr+Lcq/RKzCjtB5g/E5lXBP
         Od/9bG6HNtpKRgAdPGyC8505lVOgUD/OCgm3x/Svk9/DyiqpWqKA31uSK4ShbOsLcr
         rQyyqaTWHyIO5Wivsk2jMkpOscepOLlT04laCd9TTNXv28URxOkR3mYKsampbXCQB+
         yLqUyX+ACKFItBQIBte2cD2c4kfxqjA5uE7YcIpcn2XFZxKA5aA4thUuaHKmD8BvXH
         olxEZu46InaDLJOpOSpPZCKS5nhKEPyFmnjr7QsJy8RXWDkNYnDgsOT6bFyRgb+f+1
         cKXWZvjieePvw==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 4122BA0079;
        Mon, 11 Feb 2019 17:37:30 +0000 (UTC)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 11 Feb 2019 09:37:30 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 11 Feb 2019 18:37:28 +0100
Received: from [10.107.25.131] (10.107.25.131) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 11 Feb 2019 18:37:27 +0100
Subject: Re: [RFC v4 0/6] dmaengine: Add Synopsys eDMA IP driver (version 0)
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
CC:     Vinod Koul <vkoul@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Joao Pinto <joao.pinto@synopsys.com>,
        Jose Abreu <jose.abreu@synopsys.com>,
        Luis de Oliveira <luis.oliveira@synopsys.com>,
        "Vitor Soares" <vitor.soares@synopsys.com>,
        Nelson Costa <nelson.costa@synopsys.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>
References: <cover.1549904495.git.gustavo.pimentel@synopsys.com>
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <088d792c-a90a-8007-56da-2ea84bbbc6ff@synopsys.com>
Date:   Mon, 11 Feb 2019 17:32:27 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <cover.1549904495.git.gustavo.pimentel@synopsys.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.25.131]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi all,

On 11/02/2019 17:03, Gustavo Pimentel wrote:
> Add Synopsys eDMA IP driver (version 0 and for EP side only) to Linux
> kernel. This IP is generally distributed with Synopsys PCIe EndPoint IP
> (depends of the use and licensing agreement), which supports:
>  - legacy and unroll modes
>  - 16 independent and concurrent channels (8 write + 8 read)
>  - supports linked list (scatter-gather) transfer
>  - each linked list descriptor can transfer from 1 byte to 4 Gbytes
>  - supports cyclic transfer
>  - PCIe EndPoint glue-logic
> 
> This patch series contains: 
>  - eDMA core + eDMA core v0 driver (implements the interface with
>  DMAengine controller APIs and interfaces with eDMA HW block)
>  - eDMA PCIe glue-logic reference driver (attaches to Synopsys EP and
>  provides memory access to eDMA core driver)
> 
>   dmaengine: Add Synopsys eDMA IP core driver
>   dmaengine: Add Synopsys eDMA IP version 0 support
>   dmaengine: Add Synopsys eDMA IP version 0 debugfs support
>   PCI: Add Synopsys endpoint EDDA Device ID
>   dmaengine: Add Synopsys eDMA IP PCIe glue-logic
>   MAINTAINERS: Add Synopsys eDMA IP driver maintainer
> 
>  MAINTAINERS                              |    7 +
>  drivers/dma/Kconfig                      |    2 +
>  drivers/dma/Makefile                     |    1 +
>  drivers/dma/dw-edma/Kconfig              |   18 +
>  drivers/dma/dw-edma/Makefile             |    7 +
>  drivers/dma/dw-edma/dw-edma-core.c       | 1069 ++++++++++++++++++++++++++++++
>  drivers/dma/dw-edma/dw-edma-core.h       |  164 +++++
>  drivers/dma/dw-edma/dw-edma-pcie.c       |  227 +++++++
>  drivers/dma/dw-edma/dw-edma-v0-core.c    |  346 ++++++++++
>  drivers/dma/dw-edma/dw-edma-v0-core.h    |   26 +
>  drivers/dma/dw-edma/dw-edma-v0-debugfs.c |  359 ++++++++++
>  drivers/dma/dw-edma/dw-edma-v0-debugfs.h |   26 +
>  drivers/dma/dw-edma/dw-edma-v0-regs.h    |  156 +++++
>  drivers/misc/pci_endpoint_test.c         |    2 +-
>  include/linux/dma/edma.h                 |   43 ++
>  include/linux/pci_ids.h                  |    1 +
>  16 files changed, 2453 insertions(+), 1 deletion(-)
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

Disregard this patch series please. I have sent a new patch series (v5) fixing
missing stuff.

Regards,
Gustavo
