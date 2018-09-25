Return-Path: <SRS0=zVIF=MH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94851C43382
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 05:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37A772145D
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 05:32:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37A772145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbeIYLiZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 25 Sep 2018 07:38:25 -0400
Received: from ozlabs.org ([203.11.71.1]:42129 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbeIYLiZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Sep 2018 07:38:25 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42K8pm6Y4Nz9s47;
        Tue, 25 Sep 2018 15:32:32 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Guenter Roeck <linux@roeck-us.net>, Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 4/4] dma-mapping: clear dev->dma_ops in arch_teardown_dma_ops
In-Reply-To: <20180922150119.GA14761@roeck-us.net>
References: <20180827084711.23407-1-hch@lst.de> <20180827084711.23407-5-hch@lst.de> <20180922150119.GA14761@roeck-us.net>
Date:   Tue, 25 Sep 2018 15:32:30 +1000
Message-ID: <87r2hi3zwx.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Guenter Roeck <linux@roeck-us.net> writes:
> Hi,
>
> On Mon, Aug 27, 2018 at 10:47:11AM +0200, Christoph Hellwig wrote:
>> There is no reason to leave the per-device dma_ops around when
>> deconfiguring a device, so move this code from arm64 into the
>> common code.
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
>
> This patch causes various ppc images to crash in -next due to NULL
> DMA ops in dma_alloc_attrs().

I finally remembered where you autobuilder is :)

https://kerneltests.org/builders/qemu-ppc-next/builds/970/steps/qemubuildcommand_1/logs/stdio

Looks like mac99 at least is failing.

Just reproduced it on my setup.

> Looking into the code, the macio driver tries to instantiate on
> the 0000:f0:0d.0 PCI address (the driver maps to all Apple PCI IDs)
> and fails. This results in a call to arch_teardown_dma_ops(). Later,
> the same device pointer is used to instantiate ohci-pci, which
> crashes in probe because the dma_ops pointer has been cleared.
>
> I don't claim to fully understand the code, but to me it looks like
> the pci device is allocated and waiting for a driver to attach to.
> See arch/powerpc/kernel/pci_of_scan.c:of_create_pci_dev().
> If attaching a driver (here: macio) fails, the same device pointer
> is then reused for the next matching driver until a match is found
> and the device is successfully instantiated. Of course this fails
> quite badly if the device pointer has been scrubbed after the first
> failure.
>
> I don't know if this is generic PCI behavior or ppc specific.
> I am copying pci and ppc maintainers for additional input.

I would guess this is some PPC special sauce  O_o

Will have a look.

cheers
