Return-Path: <SRS0=JkSV=SE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0252DC4360F
	for <linux-pci@archiver.kernel.org>; Tue,  2 Apr 2019 16:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3C2E2133D
	for <linux-pci@archiver.kernel.org>; Tue,  2 Apr 2019 16:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730749AbfDBQIn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:08:43 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53726 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731671AbfDBQIW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Apr 2019 12:08:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81684374;
        Tue,  2 Apr 2019 09:08:21 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 71B633F721;
        Tue,  2 Apr 2019 09:08:20 -0700 (PDT)
Date:   Tue, 2 Apr 2019 17:08:14 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bharat Kumar Gogada <bharatku@xilinx.com>
Cc:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: xilinx-nwl: Fix Multi MSI data programming
Message-ID: <20190402160814.GA30068@e107981-ln.cambridge.arm.com>
References: <1552304759-5394-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <BN6PR02MB2772BFC74C01857BA58FB5C7A5550@BN6PR02MB2772.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN6PR02MB2772BFC74C01857BA58FB5C7A5550@BN6PR02MB2772.namprd02.prod.outlook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 01, 2019 at 05:00:40PM +0000, Bharat Kumar Gogada wrote:
> Hi All,
> 
> Please let me know if anyone has any inputs on this.
> 
> Regards,
> Bharat
> > 
> > The current Multi MSI data programming fails if multiple end points
> > requesting MSI and multi MSI are connected with switch, i.e the current
> > multi MSI data being given is not considering the number of vectors being
> > requested in case of multi MSI.
> > Due to this if multiple end points are connected and requesting MSI and
> > multi MSI combination, the multi MSI data is ending up using wrong MSI
> > data, which might be used by different device.
> > 
> > Fix Multi MSI data programming with required alignment by using number
> > of vectors being requested.

I still do not understand what you mean I am sorry. An example is worth
two thousand words, I would start with that as it stands this commit
log does not provide any information on what you are actually fixing.

Lorenzo

> > Fixes: ab597d35ef11 ("PCI: xilinx-nwl: Add support for Xilinx NWL PCIe Host
> > Controller")
> > Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> > ---
> > V2:
> >  - Added more description of fix
> > ---
> >  drivers/pci/controller/pcie-xilinx-nwl.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c
> > b/drivers/pci/controller/pcie-xilinx-nwl.c
> > index 81538d7..36669c5 100644
> > --- a/drivers/pci/controller/pcie-xilinx-nwl.c
> > +++ b/drivers/pci/controller/pcie-xilinx-nwl.c
> > @@ -484,7 +484,7 @@ static int nwl_irq_domain_alloc(struct irq_domain
> > *domain, unsigned int virq,
> > 
> >  	mutex_lock(&msi->lock);
> >  	bit = bitmap_find_next_zero_area(msi->bitmap, INT_PCI_MSI_NR, 0,
> > -					 nr_irqs, 0);
> > +					 nr_irqs, nr_irqs - 1);
> >  	if (bit >= INT_PCI_MSI_NR) {
> >  		mutex_unlock(&msi->lock);
> >  		return -ENOSPC;
> > --
> > 2.7.4
> 
