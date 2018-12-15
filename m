Return-Path: <SRS0=lgj/=OY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E97C43387
	for <linux-pci@archiver.kernel.org>; Sat, 15 Dec 2018 10:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19BC1206C2
	for <linux-pci@archiver.kernel.org>; Sat, 15 Dec 2018 10:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbeLOKDQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 15 Dec 2018 05:03:16 -0500
Received: from verein.lst.de ([213.95.11.211]:52525 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728731AbeLOKDQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 15 Dec 2018 05:03:16 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id BE86568D7F; Sat, 15 Dec 2018 11:03:14 +0100 (CET)
Date:   Sat, 15 Dec 2018 11:03:14 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Remove unused attr variable in pci_dma_configure
Message-ID: <20181215100314.GA1122@lst.de>
References: <20181215014900.10308-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181215014900.10308-1-natechancellor@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Thanks, applied.

FYI, this was my editing of Robins patch that I though I had undone
again, but only half so.  Sorry.
