Return-Path: <SRS0=XSei=MI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C6EC43382
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 04:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B72AB21480
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 04:20:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B72AB21480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbeIZKbX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 26 Sep 2018 06:31:23 -0400
Received: from ozlabs.org ([203.11.71.1]:41605 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbeIZKbX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Sep 2018 06:31:23 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42Kl920wH1z9s4s;
        Wed, 26 Sep 2018 14:20:22 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christoph Hellwig <hch@lst.de>, Guenter Roeck <linux@roeck-us.net>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 4/4] dma-mapping: clear dev->dma_ops in arch_teardown_dma_ops
In-Reply-To: <20180925201619.GB8413@lst.de>
References: <20180827084711.23407-1-hch@lst.de> <20180827084711.23407-5-hch@lst.de> <20180922150119.GA14761@roeck-us.net> <20180925201619.GB8413@lst.de>
Date:   Wed, 26 Sep 2018 14:20:19 +1000
Message-ID: <87r2hgga9o.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Christoph Hellwig <hch@lst.de> writes:

> Looking at the code I think this commit is simply broken for
> architectures not using arch_setup_dma_ops, but instead setting up
> the dma ops through arch specific magic.

I arch_setup_dma_ops() called from of_dma_configure(), but
pci_dma_configure() doesn't call that for this device:

static int pci_dma_configure(struct device *dev)
{
	...
	if (IS_ENABLED(CONFIG_OF) && bridge->parent &&
	    bridge->parent->of_node) {
		ret = of_dma_configure(dev, bridge->parent->of_node, true);

bridge->parent is NULL.

So I don't think arch_setup_dma_ops() would help here?

> I'll revert the patch.

Thanks.

cheers
