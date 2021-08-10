Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D57EC4338F
	for <linux-pci@archiver.kernel.org>; Tue, 10 Aug 2021 16:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1D3760EBC
	for <linux-pci@archiver.kernel.org>; Tue, 10 Aug 2021 16:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229474AbhHJRAN (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 10 Aug 2021 13:00:13 -0400
Received: from foss.arm.com ([217.140.110.172]:59590 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229778AbhHJRAM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Aug 2021 13:00:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F99E6D;
        Tue, 10 Aug 2021 09:59:50 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 892B03F718;
        Tue, 10 Aug 2021 09:59:49 -0700 (PDT)
Date:   Tue, 10 Aug 2021 17:59:43 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v1 1/2] PCI: dwc: Clean up Kconfig dependencies
 (PCIE_DW_HOST)
Message-ID: <20210810165943.GA18920@lpieralisi>
References: <20210623140103.47818-1-andriy.shevchenko@linux.intel.com>
 <20210805135234.GA22410@lpieralisi>
 <YQwTWoLys3wX75gY@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQwTWoLys3wX75gY@smile.fi.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 05, 2021 at 07:35:38PM +0300, Andy Shevchenko wrote:
> On Thu, Aug 05, 2021 at 02:52:34PM +0100, Lorenzo Pieralisi wrote:
> > On Wed, Jun 23, 2021 at 05:01:02PM +0300, Andy Shevchenko wrote:
> > > First of all, the "depends on" is no-op in the selectable options.
> > > Second, no need to repeat menu dependencies (PCI).
> 
> > Define which specific "depends on" you are referring to.
> 
> I didn't get this because it stands right. It's in general.

Ok, understood what you meant now - I read it as if you were referring
to a specific Kconfig entry that this patch is fixing.

Maybe:

"The "depends on" Kconfig construct is a no-op in options that
are selected and therefore has no effect. Remove it.".


> I can be more specific since it's in align with the code,
> though.
> 
> All the rest I agree with.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
