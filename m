Return-Path: <SRS0=wh2u=NR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DCFC32789
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 17:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8466320862
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 17:21:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8466320862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389260AbeKGCrU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 6 Nov 2018 21:47:20 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37678 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388987AbeKGCrU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Nov 2018 21:47:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C61B8A78;
        Tue,  6 Nov 2018 09:21:07 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B7763F5C0;
        Tue,  6 Nov 2018 09:21:05 -0800 (PST)
Date:   Tue, 6 Nov 2018 17:21:00 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Keith Busch <keith.busch@intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/12] error handling and pciehp maintenance
Message-ID: <20181106172100.GA22063@e107981-ln.cambridge.arm.com>
References: <20180918235848.26694-1-keith.busch@intel.com>
 <20181004214015.GK120535@bhelgaas-glaptop.roam.corp.google.com>
 <20181004221137.GB21834@localhost.localdomain>
 <20181005173145.GL120535@bhelgaas-glaptop.roam.corp.google.com>
 <20181008161847.GA30971@localhost.localdomain>
 <20181106163400.GA21193@e107981-ln.cambridge.arm.com>
 <20181106164751.GA6217@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106164751.GA6217@localhost.localdomain>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 06, 2018 at 09:47:52AM -0700, Keith Busch wrote:
> On Tue, Nov 06, 2018 at 04:34:08PM +0000, Lorenzo Pieralisi wrote:
> > The question is whether we really need to dynamically patch the kernel
> > with ftrace to achieve what that patch does.
> > 
> > Furthermore, it would also be good to report what bugs we are actually
> > fixing, from what you are writing falling back to the current method if
> > !DYNAMIC_FTRACE_WITH_REGS is broken in many ways and I would start with
> > fixing the current behaviour with something that does not depend on arch
> > features that may not even be implemented.
> 
> There are two problems with the current method:
> 
>   1. It may dereference pci_dev after it was freed
>   2. The pci_dev's children inherit its fake pci_bus's ops on
>      enumeration
> 
> Both result in kernel panic.

That's my point, current test module is not robust, I wanted to ask if
there is a way to fix it that does not depend on arch features, because
if there is a dependency that is not met we are still not fixing the
current code, using it as a fallback can still create issues.

> The dynamic kernel patch just seemed like a cool way to inject errors
> without messing with the driver's structures. But if there's a more
> elegant way to do it, I'm all for it.

If you have a simple reproducer for the bugs I am happy to help you test
it (I can also apply arm64 DYNAMIC_FTRACE_WITH_REGS patches and test that
new code path if that's the final direction we are taking).

Thanks,
Lorenzo
