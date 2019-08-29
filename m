Return-Path: <SRS0=34VT=WZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BF6C3A59F
	for <linux-pci@archiver.kernel.org>; Thu, 29 Aug 2019 14:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA1D220674
	for <linux-pci@archiver.kernel.org>; Thu, 29 Aug 2019 14:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfH2ONM (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 29 Aug 2019 10:13:12 -0400
Received: from verein.lst.de ([213.95.11.211]:46615 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726852AbfH2ONL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Aug 2019 10:13:11 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6E34F68B20; Thu, 29 Aug 2019 16:13:07 +0200 (CEST)
Date:   Thu, 29 Aug 2019 16:13:07 +0200
From:   "hch@lst.de" <hch@lst.de>
To:     "Derrick, Jonathan" <jonathan.derrick@intel.com>
Cc:     "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] x86/pci: Add a to_pci_sysdata helper
Message-ID: <20190829141307.GA18677@lst.de>
References: <20190828141443.5253-1-hch@lst.de> <20190828141443.5253-3-hch@lst.de> <809ad38b6aca8e828db7be6423cb03ac9208fb5a.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <809ad38b6aca8e828db7be6423cb03ac9208fb5a.camel@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 28, 2019 at 04:41:45PM +0000, Derrick, Jonathan wrote:
> > diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
> > index 6fa846920f5f..75fe28492290 100644
> > --- a/arch/x86/include/asm/pci.h
> > +++ b/arch/x86/include/asm/pci.h
> > @@ -35,12 +35,15 @@ extern int noioapicreroute;
> >  
> >  #ifdef CONFIG_PCI
> >  
> > +static inline struct pci_sysdata *to_pci_sysdata(struct pci_bus *bus)
> Can you make the argument const to avoid all the warnings from callers
> passing const struct pci_bus

Yes, I already fixed this up after getting a build bot warning for a
NUMA config (which seems to be the only one passing a const).
