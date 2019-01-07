Return-Path: <SRS0=70A0=PP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905DDC43387
	for <linux-pci@archiver.kernel.org>; Mon,  7 Jan 2019 21:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53C0F2147C
	for <linux-pci@archiver.kernel.org>; Mon,  7 Jan 2019 21:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AJQy9X3q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbfAGVv7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 7 Jan 2019 16:51:59 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43099 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfAGVv7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Jan 2019 16:51:59 -0500
Received: by mail-lj1-f196.google.com with SMTP id q2-v6so1643592lji.10
        for <linux-pci@vger.kernel.org>; Mon, 07 Jan 2019 13:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hGGntOKsoK2Kl5JY3mfBQBzGdF45VbDEwqW9bOL9iU4=;
        b=AJQy9X3qLFdpD3UTpWiKWdwxfc8x4JhJpwenV7M9feg4McXpZR1+J6VFmV5E6ON7XV
         P3nEJ1gcNTMZ9/RU3IGOE9Ojw1jzzNQYzyHHhfCXoZg8e5FDYVypIYsn4nhdj9c4NwF8
         FEv1W81kAOF27SJQxhyAdTf1yWOD8Sx2bv4K8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hGGntOKsoK2Kl5JY3mfBQBzGdF45VbDEwqW9bOL9iU4=;
        b=ERaJ4Tv+wihQuvTviy0DK7A3y5zTgw+MJ6HvDsp5RwKDc1sZbA+gU8T57DCvpmt7mo
         do6GMFkOHT4jM/5qNBvyVanv+d+VI+puMkV5qe2CJMLJqx1jouTv4lX50dZv7YgsWuRp
         SvvzfFT7AkL15lbc653tcB52wkMhgUQHHwarYdHc+8Odixgyn/UbTPWZb7ofE95GpfC5
         RS/pcPqMXKZPfy+iJblsN5ilxXMmHqzIyVLq4gwsY7sIjybPokXO25M3QfPYOFVGLZkc
         QnRqu/Egsw9y7Ocr0+zZBJlDkjfKuadiE6+W30ArwqO3J3nSTxo9CDv69CkMIiss2qND
         L63Q==
X-Gm-Message-State: AJcUukf1Es+o0wOO1zcQkBQFFPTQWnZsSHWmtujSgq0+fvIeRuE0sKnF
        uUYfotKCijpyLLnibTFuwfGduQ==
X-Google-Smtp-Source: ALg8bN7GAqHu2RBffncmcrtGR1yepAlOLP4XqS5LabxIZvw6P6nUZJDYB8O3ZdfdTF8JTJ8vZoTq2Q==
X-Received: by 2002:a2e:8446:: with SMTP id u6-v6mr39258850ljh.74.1546897916234;
        Mon, 07 Jan 2019 13:51:56 -0800 (PST)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id q21-v6sm13879196ljc.5.2019.01.07.13.51.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 13:51:55 -0800 (PST)
Date:   Mon, 7 Jan 2019 22:51:53 +0100
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
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
Message-ID: <20190107215153.GA22120@centauri.lan>
References: <cover.1545066805.git.gustavo.pimentel@synopsys.com>
 <20181217222107.GA14261@centauri.lan>
 <e3266ef0-bff0-cb91-8f64-43d8a8e4d66a@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3266ef0-bff0-cb91-8f64-43d8a8e4d66a@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 18, 2018 at 10:36:58AM +0000, Gustavo Pimentel wrote:
> Hi,
> 
> On 17/12/2018 22:21, Niklas Cassel wrote:
> > On Mon, Dec 17, 2018 at 06:19:32PM +0100, Gustavo Pimentel wrote:
> >> Add Synopsys eDMA IP driver (version 0) to Linux kernel. This IP is generally
> >> distributed with Synopsys PCIe EndPoint IP (depends of the use and licensing
> >> agreement), which supports:
> >>  - legacy and unroll modes
> >>  - 16 independent and concurrent channels (8 write + 8 read)
> >>  - supports linked list (scatter-gather) transfer
> >>  - each linked list descriptor can transfer from 1 byte to 4 Gbytes
> >>  - PCIe EndPoint glue-logic
> >>
> >> Gustavo Pimentel (6):
> >>   dmaengine: Add Synopsys eDMA IP core driver
> >>   dmaengine: Add Synopsys eDMA IP version 0 support
> >>   dmaengine: Add Synopsys eDMA IP version 0 debugfs support
> >>   PCI: Add Synopsys endpoint EDDA Device id
> >>   dmaengine: Add Synopsys eDMA IP PCIe glue-logic
> >>   MAINTAINERS: Add Synopsys eDMA IP driver maintainer
> > 
> > Hello Gustavo,
> > 
> > Nice to see support for the embedded DMA controller used in the DWC PCIe
> > controller.
> 
> Yes, I included you because you were from the beginning one of those who
> requested this feature. :)

Hello Gustavo,

sorry for the delayed response, I took an extra long christmas vacation :)

Unfortunately, it was my previous employer (Axis) who was interested in this.
Right now I am simply looking at this patch series out of my own curiosity :)

(snip)

> > The eDMA can be used both while the PCIe controller is in EP and RC mode,
> > right?
> 
> For now I can not give this certainty. My setup only have the eDMA on the EP
> side and has the eDMA mapped on PCI BAR, which allows me to configure it through
> PCI.

Ok, I looked at the databook, and it does mention support for both modes.

Perhaps the cover letter could mention more clearly that this is just for eDMA
on the EP side. (Since the IP seems to support eDMA for both RC and EP side.)

(snip)

> > Do you have any benchmarks to share? (Perhaps with different buffer sizes).
> 
> I'm currently working on the dw-edma-test driver (similar to dmatest driver)
> that supports DEV_TO_MEM and MEM_TO_DEV directions instead of MEM_TO_MEM
> (dmatest), and adapted to WRITE and READ channels with multiple threads. After
> finishing this driver I'll able to do some benchmarks and comparisons. :)
> 
> Given your enthusiasm, when I'm finished we could do some brainstorm and define
> some test cases / benchmarks, what do you think?

I might have the enthusiasm, but I don't have the expertise to come up with
some relevant use-cases :p

> 
> > Not sure what we will see, lower CPU utilization but more IRQs?
> 
> Probably yes. Let me explain you
> 
> With this implementation, you can transfer several chunks (a chunk is linked
> list of burst elements).
> 
> Each burst basically defines the source, destination addresses and size to
> transfer (from 1 Byte to 4 GB).
> 
> This linked list will be written on EP's RAM (mapped on a PCI BAR) which the HW
> block will consume it. The linked list size is dependent of this EP's RAM size,
> i.e. 8 KB will allow 340 elements (bursts).
> 
> On my currently setup I'm testing the driver implementation like this:
>  - 4 chunks
>  - each chunk is composed by 340 elements (bursts)
>  - each burst have a transfer size of 100 bytes (can be up to 4GB and the size
> can be also different for each burst)
> 
> Chunk #0
>        |--> Burst #0 --> ... --> Burst #339 -> IRQ (Reload new linked list)
> Chunk #1
>        |--> Burst #0 --> ... --> Burst #339 -> IRQ (Reload new linked list)
> Chunk #2
>        |--> Burst #0 --> ... --> Burst #339 -> IRQ (Reload new linked list)
> Chunk #3
>        |--> Burst #0 --> ... --> Burst #34 -> IRQ (End transfer)
> 
> In total I'm writing ((4 * 340) + 35) * 100 = 139500 Bytes <=> 136 KB

This is a nice explaination, and it probably belongs in the cover letter,
and/or commit message, and/or somewhere in Documentation/, and/or as a
comment in the source code.

(snip)

> I'm dividing this patch series like this:
> 
>  - eDMA core + eDMA core v0 driver (implementing the interface with DMAengine
> controller APIs and the interface with the eDMA HW block)
> 
>  - eDMA PCIe glue-logic driver (attaches to EP and provides memory access to
> eDMA core driver), for now is attach to Synopsys Vendor and Device ID and has a
> platform data specific to our EP.
> 
>  - eDMA Test driver (is a sample driver which aims to test the eDMA, but also
> provides a example how an customer driver would use the eDMA driver, through the
> DMAengine client APIs) (under developing, I hope to make it available before
> xmas :))
> 
> Sounds logic?

This definitely belongs in the cover letter :)

> 
> > 
> > I have a board that has a CC_DMA_ENABLE set, so if you give me some
> > detailed instructions how to test, I might be able to provide you with a
> > Tested-by.
> 
> Ok, let me just finish the eDMA test and append it to the patch series.
> I'm happy to help you with this. :)

The hardware I currently have access to (Qualcomm hardware), hasn't
implemented the software support for running the PCIe controller in endpoint
mode yet.
This means that I won't be able to help you with testing this series.
Sorry for that. (I wanted to help out here, promise :p).

Hopefully there is someone else who has this IP configured with
CC_DMA_ENABLE + has EP support implemented, who can help you out :)


Kind regards,
Niklas
