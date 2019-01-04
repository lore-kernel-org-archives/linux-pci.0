Return-Path: <SRS0=mKou=PM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2387FC43387
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 18:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFE6D218D8
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 18:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbfADSPa (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 4 Jan 2019 13:15:30 -0500
Received: from verein.lst.de ([213.95.11.211]:41118 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbfADSPa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Jan 2019 13:15:30 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id DF2E168D93; Fri,  4 Jan 2019 19:15:28 +0100 (CET)
Date:   Fri, 4 Jan 2019 19:15:28 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <keith.busch@intel.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/4] nvme-pci: Set tagset nr_maps just once
Message-ID: <20190104181528.GA25651@lst.de>
References: <20190103210954.11129-1-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190103210954.11129-1-keith.busch@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 03, 2019 at 02:09:51PM -0700, Keith Busch wrote:
> The driver overwrites the intermediate nr_map assignments to
> HCTX_MAX_TYPES, so remove those unnecessary temporary settings.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>

Actually the more complex calculation is the right one here.
I've just merged a patch from Jianchao to remove the other line.
