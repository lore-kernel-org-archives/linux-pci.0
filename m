Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE8BC6FD18
	for <linux-pci@archiver.kernel.org>; Tue, 28 Mar 2023 17:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjC1Rey (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 28 Mar 2023 13:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjC1Rex (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Mar 2023 13:34:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D645BCC32;
        Tue, 28 Mar 2023 10:34:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F96EB81088;
        Tue, 28 Mar 2023 17:34:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3829C433EF;
        Tue, 28 Mar 2023 17:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680024890;
        bh=NpcKLBiXcnX+TXsKDkKuw4AU292PgDU3fhrS8tUmPeo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=P3/uhuIZHi9u4gsVH741PzbVjSrz30ouF2h3mkMwHzoyGsy0mJAhWh9qnPeEIDljF
         BbpJm2eQTryGeLip03/gsoaxlvqz8dW8y1ZsRaDaMrNA1cu+7AImIsFacbUh1rVkXV
         c0vFi1004jYmmABGW6YfkQbd6T+qLfnLqA5bwY+ESikuA2F7dZk1Rus3fOYVuoBBb8
         ArbIDubXggRqJuphnI/VkqIyXvOnq9fy8By0w+h5O31H9EiCSlLEQd9kbtq7eE1B8M
         XjBG23Jy1tkq2UoxQHLquk9CLnwNTNgNmSc4bfHUlCDlsy6UWBPomrx48Gj68Hz2Hp
         qXuqMaOoyCc+w==
Date:   Tue, 28 Mar 2023 12:34:48 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Cai Huoqing <cai.huoqing@linux.dev>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI/P2PDMA: Fix the comments on pci_p2pmem_find_many()
Message-ID: <20230328173448.GA2952425@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328110610.3824-1-cai.huoqing@linux.dev>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 28, 2023 at 07:06:10PM +0800, Cai Huoqing wrote:
> Remove pci_p2pmem_dma() reference,
> because pci_p2pmem_dma() method is already removed.

AFAICT, pci_p2pmem_dma() *never* existed.  I suppose it was a typo,
and pci_p2pdma_distance_many() was intended?

I'm happy to either merge this patch (with an updated commit log) to
remove the comment text or merge a patch correct the comment text.

I just don't want to merge this with a commit log that says we removed
the pci_p2pmem_dma() method when it never actually existed.

> Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
> ---
> v1->v2:
>   1.remove pci_p2pmem_dma() reference directly instead of
>     using pci_p2pdma_map_segment().
> 
> v1 link:
>   https://lore.kernel.org/lkml/eea970cd-d781-9d4c-e020-9086505a4ba7@deltatee.com/
> 
>  drivers/pci/p2pdma.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 9e8205572830..6cd98ffca198 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -746,8 +746,7 @@ EXPORT_SYMBOL_GPL(pci_has_p2pmem);
>  
>  /**
>   * pci_p2pmem_find_many - find a peer-to-peer DMA memory device compatible with
> - *	the specified list of clients and shortest distance (as determined
> - *	by pci_p2pmem_dma())
> + *	the specified list of clients and shortest distance
>   * @clients: array of devices to check (NULL-terminated)
>   * @num_clients: number of client devices in the list
>   *
> -- 
> 2.34.1
> 
