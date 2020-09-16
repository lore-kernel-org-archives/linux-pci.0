Return-Path: <SRS0=aHqq=C2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0A1C433E2
	for <linux-pci@archiver.kernel.org>; Thu, 17 Sep 2020 00:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17658206C9
	for <linux-pci@archiver.kernel.org>; Thu, 17 Sep 2020 00:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbgIQAa0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 16 Sep 2020 20:30:26 -0400
Received: from kernel.crashing.org ([76.164.61.194]:41098 "EHLO
        kernel.crashing.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgIQAaZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Sep 2020 20:30:25 -0400
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Sep 2020 20:30:23 EDT
Received: from localhost (gate.crashing.org [63.228.1.57])
        (authenticated bits=0)
        by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 08GNxT6I030187
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 16 Sep 2020 18:59:32 -0500
Message-ID: <28082ccc715a9fba349ae6052d5c917ae02d40fa.camel@kernel.crashing.org>
Subject: Re: [PATCH] arm64: Enable PCI write-combine resources under sysfs
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Clint Sbisa <csbisa@amazon.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-arm-kernel@lists.infradead.org, will@kernel.org,
        catalin.marinas@arm.com, Leon Romanovsky <leon@kernel.org>
Date:   Thu, 17 Sep 2020 09:59:28 +1000
In-Reply-To: <20200916121226.GN1573713@nvidia.com>
References: <20200914143819.GC904879@nvidia.com>
         <375c478593945a416f3180c3773bcb5240d2e36c.camel@kernel.crashing.org>
         <1d6f2ceb8d3538c906a1fdb8cd3d4c74ccffa42e.camel@kernel.crashing.org>
         <20200914225740.GP904879@nvidia.com>
         <2b539df4c9ec703458e46da2fc879ee3b310b31c.camel@kernel.crashing.org>
         <20200915101831.GA2616@e121166-lin.cambridge.arm.com>
         <20200915110511.GQ904879@nvidia.com>
         <bcb95faafa72734478b942084a9d24a61ae9887f.camel@kernel.crashing.org>
         <20200915234006.GI1573713@nvidia.com>
         <701012f288231d0d0733bf1c2c8fdbd9caa074fd.camel@kernel.crashing.org>
         <20200916121226.GN1573713@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2020-09-16 at 09:12 -0300, Jason Gunthorpe wrote:
> > Also we could make this a variable rather than a constant and
> > choose
> > a more appropriate set of flags at boot time....
> 
> It is a function, so it could check the CPU ID for the known broken
> devices and block them.

Sure, I meant in the abstract way. It's not a hot path so it doesnt
have to be a static key.

> > > > Why would that be a regression ? 
> > > 
> > > Using the WC submission flow when it doesn't work costs something
> > > like
> > > 10% performance vs using the non-WC flow.
> > 
> > You mean the driver uses a different path to the HW which ahs that
> > overhead, not that MMIOs have that overhead right ?
> 
> The different path has overhead of doing extra useless MMIOs because
> they don't combine

I see. This might have to end up being a TX2 specific hack until the
end of times...

Cheers,
Ben.


