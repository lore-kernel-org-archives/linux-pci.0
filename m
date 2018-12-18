Return-Path: <SRS0=EJXn=O3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676B6C43387
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 10:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 223572184A
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 10:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="FxL/HFKi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbeLRKl0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 18 Dec 2018 05:41:26 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:36758 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbeLRKl0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Dec 2018 05:41:26 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 0F73F10C1D4A;
        Tue, 18 Dec 2018 02:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1545129685; bh=GD/WZPHjMh3ekw3L9QRAOGGpGfA9qIbLoF63h7CedoE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=FxL/HFKivpWchAB/YstnTP0s4SyQE4LRxWNlCPZdxV6T+xQkUJyO081G8ozvfgoRj
         2TRyu8jG4Rb/ZYiZP1v5IUN32fOdxb+PdcO8PsNN1hrZwRLUIDOWhoa255fBp1B2vc
         bTfqxnoeBdZSgHC60xF72eB3GEZNxnXipo1LlBJLzu7l++v8T7dp0v8I/tUjoem0og
         1rCpEBiNaARsxyEw7R3WJJF031zOON9k8ISWCnMuoCens5c33mgxpP933qk/yQgbT0
         DrDnSgrQY/Trb8HkUhAn6KU9SESYC1WXHQnG9IOgkcEyPNnj1gY9+4Z7EM4jWK5U/+
         yIEaZc+4Oo4Gg==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id F1070329B;
        Tue, 18 Dec 2018 02:41:23 -0800 (PST)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 18 Dec 2018 02:41:23 -0800
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 18 Dec 2018 11:41:21 +0100
Received: from [10.107.25.131] (10.107.25.131) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 18 Dec 2018 11:41:21 +0100
Subject: Re: [RFC v2 0/6] dmaengine: Add Synopsys eDMA IP driver (version 0)
To:     Niklas Cassel <niklas.cassel@linaro.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Kishon Vijay Abraham I" <kishon@ti.com>,
        Joao Pinto <joao.pinto@synopsys.com>,
        Jose Abreu <jose.abreu@synopsys.com>,
        Luis Oliveira <luis.oliveira@synopsys.com>,
        Vitor Soares <vitor.soares@synopsys.com>,
        Nelson Costa <nelson.costa@synopsys.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>
References: <cover.1545066805.git.gustavo.pimentel@synopsys.com>
 <20181217222107.GA14261@centauri.lan>
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <e3266ef0-bff0-cb91-8f64-43d8a8e4d66a@synopsys.com>
Date:   Tue, 18 Dec 2018 10:36:58 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181217222107.GA14261@centauri.lan>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.25.131]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 17/12/2018 22:21, Niklas Cassel wrote:
> On Mon, Dec 17, 2018 at 06:19:32PM +0100, Gustavo Pimentel wrote:
>> Add Synopsys eDMA IP driver (version 0) to Linux kernel. This IP is generally
>> distributed with Synopsys PCIe EndPoint IP (depends of the use and licensing
>> agreement), which supports:
>>  - legacy and unroll modes
>>  - 16 independent and concurrent channels (8 write + 8 read)
>>  - supports linked list (scatter-gather) transfer
>>  - each linked list descriptor can transfer from 1 byte to 4 Gbytes
>>  - PCIe EndPoint glue-logic
>>
>> Gustavo Pimentel (6):
>>   dmaengine: Add Synopsys eDMA IP core driver
>>   dmaengine: Add Synopsys eDMA IP version 0 support
>>   dmaengine: Add Synopsys eDMA IP version 0 debugfs support
>>   PCI: Add Synopsys endpoint EDDA Device id
>>   dmaengine: Add Synopsys eDMA IP PCIe glue-logic
>>   MAINTAINERS: Add Synopsys eDMA IP driver maintainer
> 
> Hello Gustavo,
> 
> Nice to see support for the embedded DMA controller used in the DWC PCIe
> controller.

Yes, I included you because you were from the beginning one of those who
requested this feature. :)

> 
> Some kind of documentation in Documentation/ would be nice.

Yes, I thought so too, but under of DOCUMENTATION folder doesn't have anything
related with DMA drivers implementations either on topic of DMA or PCI.

I thought maybe putting on the dw-edma folder but that doesn't follow the
standard documentation flow.

> 
> 
> The eDMA can be used both while the PCIe controller is in EP and RC mode,
> right?

For now I can not give this certainty. My setup only have the eDMA on the EP
side and has the eDMA mapped on PCI BAR, which allows me to configure it through
PCI.

> I guess that this support is only to use the eDMA for RC mode?

For now this driver runs on the RC side (host/CPU) and configures the eDMA EP.
I've some plans to support eDMA configuration but on the EP side. I'm guessing
that also typical use case.

> 
> Do you have any benchmarks to share? (Perhaps with different buffer sizes).

I'm currently working on the dw-edma-test driver (similar to dmatest driver)
that supports DEV_TO_MEM and MEM_TO_DEV directions instead of MEM_TO_MEM
(dmatest), and adapted to WRITE and READ channels with multiple threads. After
finishing this driver I'll able to do some benchmarks and comparisons. :)

Given your enthusiasm, when I'm finished we could do some brainstorm and define
some test cases / benchmarks, what do you think?

> Not sure what we will see, lower CPU utilization but more IRQs?

Probably yes. Let me explain you

With this implementation, you can transfer several chunks (a chunk is linked
list of burst elements).

Each burst basically defines the source, destination addresses and size to
transfer (from 1 Byte to 4 GB).

This linked list will be written on EP's RAM (mapped on a PCI BAR) which the HW
block will consume it. The linked list size is dependent of this EP's RAM size,
i.e. 8 KB will allow 340 elements (bursts).

On my currently setup I'm testing the driver implementation like this:
 - 4 chunks
 - each chunk is composed by 340 elements (bursts)
 - each burst have a transfer size of 100 bytes (can be up to 4GB and the size
can be also different for each burst)

Chunk #0
       |--> Burst #0 --> ... --> Burst #339 -> IRQ (Reload new linked list)
Chunk #1
       |--> Burst #0 --> ... --> Burst #339 -> IRQ (Reload new linked list)
Chunk #2
       |--> Burst #0 --> ... --> Burst #339 -> IRQ (Reload new linked list)
Chunk #3
       |--> Burst #0 --> ... --> Burst #34 -> IRQ (End transfer)

In total I'm writing ((4 * 340) + 35) * 100 = 139500 Bytes <=> 136 KB

> Have you thought about doing IRQ coalescing?

No. I'm only focus to implement the driver for now. After the implementation and
the benchmarks, maybe we could think about it. :)

> 
> Usually we need dmas and dma-names in device tree, however, maybe that
> isn't needed here, since it is an embedded DMA controller.
> Don't we even need/want a DT property in the PCIe node, that says if we
> want to enable the eDMA or not?

That will be necessary in the future when we have eDMA in RC or when we
implement the driver to control the eDMA on the EP side.

> 
> Usually a PCIe EP driver will call pci_ioremap_bar() and then use
> readl()/writel() directly.
> But since we now need to setup a DMA transfer, and wait for an IRQ,
> how does this work?

I gave a brief explanation in a previous comment in this email (see info about
the chunks and bursts)

I'm dividing this patch series like this:

 - eDMA core + eDMA core v0 driver (implementing the interface with DMAengine
controller APIs and the interface with the eDMA HW block)

 - eDMA PCIe glue-logic driver (attaches to EP and provides memory access to
eDMA core driver), for now is attach to Synopsys Vendor and Device ID and has a
platform data specific to our EP.

 - eDMA Test driver (is a sample driver which aims to test the eDMA, but also
provides a example how an customer driver would use the eDMA driver, through the
DMAengine client APIs) (under developing, I hope to make it available before
xmas :))

Sounds logic?

> 
> I have a board that has a CC_DMA_ENABLE set, so if you give me some
> detailed instructions how to test, I might be able to provide you with a
> Tested-by.

Ok, let me just finish the eDMA test and append it to the patch series.
I'm happy to help you with this. :)

Thanks!

Gustavo

> 
> 
> Kind regards,
> Niklas
> 
> 
>>
>>  MAINTAINERS                              |   7 +
>>  drivers/dma/Kconfig                      |   2 +
>>  drivers/dma/Makefile                     |   1 +
>>  drivers/dma/dw-edma/Kconfig              |  18 +
>>  drivers/dma/dw-edma/Makefile             |   7 +
>>  drivers/dma/dw-edma/dw-edma-core.c       | 845 +++++++++++++++++++++++++++++++
>>  drivers/dma/dw-edma/dw-edma-core.h       | 147 ++++++
>>  drivers/dma/dw-edma/dw-edma-pcie.c       | 258 ++++++++++
>>  drivers/dma/dw-edma/dw-edma-v0-core.c    | 361 +++++++++++++
>>  drivers/dma/dw-edma/dw-edma-v0-core.h    |  26 +
>>  drivers/dma/dw-edma/dw-edma-v0-debugfs.c | 357 +++++++++++++
>>  drivers/dma/dw-edma/dw-edma-v0-debugfs.h |  24 +
>>  drivers/dma/dw-edma/dw-edma-v0-regs.h    | 145 ++++++
>>  drivers/misc/pci_endpoint_test.c         |   2 +-
>>  include/linux/dma/edma.h                 |  43 ++
>>  include/linux/pci_ids.h                  |   1 +
>>  16 files changed, 2243 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/dma/dw-edma/Kconfig
>>  create mode 100644 drivers/dma/dw-edma/Makefile
>>  create mode 100644 drivers/dma/dw-edma/dw-edma-core.c
>>  create mode 100644 drivers/dma/dw-edma/dw-edma-core.h
>>  create mode 100644 drivers/dma/dw-edma/dw-edma-pcie.c
>>  create mode 100644 drivers/dma/dw-edma/dw-edma-v0-core.c
>>  create mode 100644 drivers/dma/dw-edma/dw-edma-v0-core.h
>>  create mode 100644 drivers/dma/dw-edma/dw-edma-v0-debugfs.c
>>  create mode 100644 drivers/dma/dw-edma/dw-edma-v0-debugfs.h
>>  create mode 100644 drivers/dma/dw-edma/dw-edma-v0-regs.h
>>  create mode 100644 include/linux/dma/edma.h
>>
>> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>> Cc: Vinod Koul <vkoul@kernel.org>
>> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Cc: Russell King <rmk+kernel@armlinux.org.uk>
>> Cc: Eugeniy Paltsev <paltsev@synopsys.com>
>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: Kishon Vijay Abraham I <kishon@ti.com>
>> Cc: Niklas Cassel <niklas.cassel@linaro.org>
>> Cc: Joao Pinto <jpinto@synopsys.com>
>> Cc: Jose Abreu <jose.abreu@synopsys.com>
>> Cc: Luis Oliveira <lolivei@synopsys.com>
>> Cc: Vitor Soares <vitor.soares@synopsys.com>
>> Cc: Nelson Costa <nelson.costa@synopsys.com>
>> Cc: Pedro Sousa <pedrom.sousa@synopsys.com>
>>
>> -- 
>> 2.7.4
>>

