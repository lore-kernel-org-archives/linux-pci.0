Return-Path: <SRS0=/keI=R5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80191C43381
	for <linux-pci@archiver.kernel.org>; Tue, 26 Mar 2019 15:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F7872070D
	for <linux-pci@archiver.kernel.org>; Tue, 26 Mar 2019 15:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729800AbfCZP6r (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 26 Mar 2019 11:58:47 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39016 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbfCZP6r (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Mar 2019 11:58:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 464001596;
        Tue, 26 Mar 2019 08:58:46 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E6143F614;
        Tue, 26 Mar 2019 08:58:43 -0700 (PDT)
Date:   Tue, 26 Mar 2019 15:58:37 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Jonathan Chocron <jonnyc@amazon.com>, linux-pci@vger.kernel.org,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        vaerov@amazon.com, benh@kernel.crashing.org, alisaidi@amazon.com,
        zeev@amazon.com, ronenk@amazon.com, barakw@amazon.com,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Zhou Wang <wangzhou1@hisilicon.com>
Subject: Re: [PATCH v2] PCI: al: Add Amazon Annapurna Labs PCIe host
 controller driver
Message-ID: <20190326155837.GA8820@e107981-ln.cambridge.arm.com>
References: <1553512040-4453-1-git-send-email-jonnyc@amazon.com>
 <1553594455-30436-1-git-send-email-jonnyc@amazon.com>
 <20190326121727.GA4171@e107981-ln.cambridge.arm.com>
 <07838dad0e0cdb14c42080ef19c11829f72c8814.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07838dad0e0cdb14c42080ef19c11829f72c8814.camel@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 26, 2019 at 01:24:41PM +0000, David Woodhouse wrote:
> On Tue, 2019-03-26 at 12:17 +0000, Lorenzo Pieralisi wrote:
> > [+Zhou, Gustavo]
> > 
> > On Tue, Mar 26, 2019 at 12:00:55PM +0200, Jonathan Chocron wrote:
> > > Adding support for Amazon's Annapurna Labs PCIe driver.
> > > The HW controller is based on DesignWare's IP.
> > > 
> > > The HW doesn't support accessing the Root Port's config space via
> > > ECAM, so we obtain its base address via an AMZN0001 device.
> > > 
> > > Furthermore, the DesignWare PCIe controller doesn't filter out
> > > config transactions sent to devices 1 and up on its bus, so they
> > > are filtered by the driver.
> > > All subordinate buses do support ECAM access.
> > > 
> > > Implementing specific PCI config access functions involves:
> > >  - Adding an init function to obtain the Root Port's base address
> > >    from an AMZN0001 device.
> > >  - Adding a new entry in the mcfg quirk array
> > > 
> > > Co-developed-by: Vladimir Aerov <vaerov@amazon.com>
> > > Signed-off-by: Jonathan Chocron <jonnyc@amazon.com>
> > > Signed-off-by: Vladimir Aerov <vaerov@amazon.com>
> > > Reviewed-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > > Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
> > 
> > Review tags should be given on public mailing lists for public
> > review and I have not seen them (they were already there in v1) so
> > you should drop them.
> 
> We did that internally. You really don't want me telling engineers to
> post to the list *first* without running things by me to get the basics
> right. Not to start with, at least.

Hi David,

I am obviously in favour of internal review and I do not question it was
carried out internally, I just kindly ask developers to drop review tags
given internally when going to public mailing lists - I understand it is
churn for you but I prefer them to be given explicitly.

Thanks !
Lorenzo

> Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
> 
> 
> > > Changes from v1:
> > >   - Fix commit message comments (incl. using AMZN0001
> > >     instead of PNP0C02)
> > >   - Use the usual multi-line comment style
> > > 
> > >  MAINTAINERS                          |  6 +++
> > >  drivers/acpi/pci_mcfg.c              | 12 +++++
> > >  drivers/pci/controller/dwc/Makefile  |  1 +
> > >  drivers/pci/controller/dwc/pcie-al.c | 93 ++++++++++++++++++++++++++++++++++++
> > >  include/linux/pci-ecam.h             |  1 +
> > >  5 files changed, 113 insertions(+)
> > >  create mode 100644 drivers/pci/controller/dwc/pcie-al.c
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 32d444476a90..7a17017f9f82 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -11769,6 +11769,12 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/
> > >  S:	Supported
> > >  F:	drivers/pci/controller/
> > >  
> > > +PCIE DRIVER FOR ANNAPURNA LABS
> > > +M:	Jonathan Chocron <jonnyc@amazon.com>
> > > +L:	linux-pci@vger.kernel.org
> > > +S:	Maintained
> > > +F:	drivers/pci/controller/dwc/pcie-al.c
> > 
> > I do not think we need a maintainer file for that see below, and
> > actually this quirk should be handled by DWC maintainers since it is a
> > DWC quirk, not a platform one.
> 
> Many of the others already have this, it seems.
> 
> It's also fine to drop it, and include it when we add the rest of the
> Alpine SOC support and a MAINTAINERS entry for that.
> 


