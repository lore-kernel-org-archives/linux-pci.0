Return-Path: <SRS0=aHqq=C2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CCBC43461
	for <linux-pci@archiver.kernel.org>; Thu, 17 Sep 2020 18:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EFEC221EE
	for <linux-pci@archiver.kernel.org>; Thu, 17 Sep 2020 18:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbgIQSml (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 17 Sep 2020 14:42:41 -0400
Received: from verein.lst.de ([213.95.11.211]:57039 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728715AbgIQQy6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Sep 2020 12:54:58 -0400
X-Greylist: delayed 557 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 12:54:42 EDT
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1B12468BEB; Thu, 17 Sep 2020 18:45:15 +0200 (CEST)
Date:   Thu, 17 Sep 2020 18:45:14 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org,
        Russell King <linux@armlinux.org.uk>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-sh@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        linux-usb@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        linux-pci@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: support range based offsets in dma-direct v3
Message-ID: <20200917164514.GA5982@lst.de>
References: <20200916061500.1970090-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916061500.1970090-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I've pulled this into the dma-mapping for-next tree.  Thanks Jim and
everyone helping out!
