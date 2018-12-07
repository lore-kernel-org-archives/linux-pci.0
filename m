Return-Path: <SRS0=SqGm=OQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80271C07E85
	for <linux-pci@archiver.kernel.org>; Fri,  7 Dec 2018 17:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 469672082D
	for <linux-pci@archiver.kernel.org>; Fri,  7 Dec 2018 17:05:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 469672082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbeLGRFW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 7 Dec 2018 12:05:22 -0500
Received: from verein.lst.de ([213.95.11.211]:36316 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbeLGRFV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Dec 2018 12:05:21 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id A2B5468AA6; Fri,  7 Dec 2018 18:05:19 +0100 (CET)
Date:   Fri, 7 Dec 2018 18:05:19 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     hch@lst.de, iommu@lists.linux-foundation.org,
        m.szyprowski@samsung.com, catalin.marinas@arm.com,
        will.deacon@arm.com, linux-arm-kernel@lists.infradead.org,
        rjw@rjwysocki.net, lenb@kernel.org, gregkh@linuxfoundation.org,
        bhelgaas@google.com, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Refactor dummy DMA ops
Message-ID: <20181207170519.GA26857@lst.de>
References: <cover.1544199754.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1544199754.git.robin.murphy@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

So I'd really prefer if we had a separate dummy.c file, like in
my take on your previous patch here:

http://git.infradead.org/users/hch/misc.git/commitdiff/e01adddc1733fa414dc16cd22e8f58be9b64a025

http://git.infradead.org/users/hch/misc.git/commitdiff/596bde76e5944a3f4beb8c2769067ca88dda127a

Otherwise this looks fine.  If you don't minde I'll take your patches,
apply the move to a separate file and merge it into the above tree.
