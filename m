Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8606C433EF
	for <linux-pci@archiver.kernel.org>; Thu, 21 Apr 2022 05:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384461AbiDUFih (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 21 Apr 2022 01:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345361AbiDUFif (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Apr 2022 01:38:35 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6EC1208F
        for <linux-pci@vger.kernel.org>; Wed, 20 Apr 2022 22:35:46 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id E370268B05; Thu, 21 Apr 2022 07:35:42 +0200 (CEST)
Date:   Thu, 21 Apr 2022 07:35:42 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH] PCI/docs: Fix references to DMA set mask function
Message-ID: <20220421053542.GA20623@lst.de>
References: <165048747271.2959320.13475081883467312497.stgit@omen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165048747271.2959320.13475081883467312497.stgit@omen>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 20, 2022 at 02:45:05PM -0600, Alex Williamson wrote:
> The function is dma_set_mask(), fix a missed instance of the old
> pci_set_dma_mask() and a reference to a function that doesn't exist.

Thanks, looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
