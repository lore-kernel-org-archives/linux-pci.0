Return-Path: <SRS0=+gKf=SN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A67C10F13
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 05:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D07721841
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 05:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbfDKFTB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Apr 2019 01:19:01 -0400
Received: from verein.lst.de ([213.95.11.211]:32988 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbfDKFTB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Apr 2019 01:19:01 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 2E5AA67358; Thu, 11 Apr 2019 07:18:49 +0200 (CEST)
Date:   Thu, 11 Apr 2019 07:18:49 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Christoph Hellwig <hch@lst.de>,
        linux-pci@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCH 2/2] x86/pci: Clean up usage of X86_DEV_DMA_OPS
Message-ID: <20190411051849.GA26205@lst.de>
References: <20190410080220.21705-1-hch@lst.de> <20190410080220.21705-3-hch@lst.de> <20190410081617.GA54229@gmail.com> <20190410214500.GK256045@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410214500.GK256045@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 10, 2019 at 04:45:01PM -0500, Bjorn Helgaas wrote:
> [+cc Keith, Jonathan (VMD guys)]
> 
> I'm OK with this from a PCI perspective.  It would be nice if
> 
>   dma_domain_list
>   dma_domain_list_lock
>   add_dma_domain()
>   del_dma_domain()
>   set_dma_domain_ops()
> 
> could all be moved to vmd.c, since they're really only used there.

I have another patch to eventually kill that, but it will need a little
more prep work and thus be delayed to the next merge window.
