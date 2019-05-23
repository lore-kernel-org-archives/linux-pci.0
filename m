Return-Path: <SRS0=jwu3=TX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB68C282DD
	for <linux-pci@archiver.kernel.org>; Thu, 23 May 2019 09:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9414720862
	for <linux-pci@archiver.kernel.org>; Thu, 23 May 2019 09:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfEWJnq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 23 May 2019 05:43:46 -0400
Received: from verein.lst.de ([213.95.11.211]:45528 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726309AbfEWJnp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 May 2019 05:43:45 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 9543F68B05; Thu, 23 May 2019 11:43:22 +0200 (CEST)
Date:   Thu, 23 May 2019 11:43:22 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Koenig, Christian" <Christian.Koenig@amd.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI/P2PDMA: Root complex whitelist should not apply
 when an IOMMU is present
Message-ID: <20190523094322.GA14986@lst.de>
References: <a98bff67-a76e-4ddc-a317-96f2bdc9af72@email.android.com> <97aa52fc-f062-acf1-0e0c-5a4d1d505777@deltatee.com> <b9e94126-8686-4306-77c3-bd0b96680775@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9e94126-8686-4306-77c3-bd0b96680775@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 23, 2019 at 08:12:18AM +0000, Koenig, Christian wrote:
> > Are you DMA-mapping the addresses outside the P2PDMA code? If so there's
> > a huge mismatch with the existing users of P2PDMA (nvme-fabrics). If
> > you're not dma-mapping then I can't see how it could work because the
> > IOMMU should reject any requests to access those addresses.
> 
> Well, we are using the DMA API (dma_map_resource) for this. If the P2P 
> code is not using this then I would rather say that the P2P code is 
> actually broken.
> 
> Adding Christoph as well, cause he is usually the one discussion stuff 
> like that with me.

Heh.  Actually dma_map_resource-ish APIs are the right thing to do,
but I'm not sure how you managed to be able to use it for PCIe P2P
yet, as it fails to account for any difference in the PCIe level
"physical" address with the hosts view of "physical" addresses.

Do these offsets now how up on AMD platforms?  Do you adjust for them
elsewhere?
