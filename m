Return-Path: <SRS0=ZQO4=QM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1880DC282CB
	for <linux-pci@archiver.kernel.org>; Tue,  5 Feb 2019 23:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA1672073D
	for <linux-pci@archiver.kernel.org>; Tue,  5 Feb 2019 23:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfBEX5A (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 5 Feb 2019 18:57:00 -0500
Received: from mga17.intel.com ([192.55.52.151]:2258 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727524AbfBEX5A (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Feb 2019 18:57:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2019 15:56:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,337,1544515200"; 
   d="scan'208";a="131860291"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga002.jf.intel.com with ESMTP; 05 Feb 2019 15:56:59 -0800
Date:   Tue, 5 Feb 2019 15:58:59 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Allen Hubbe <allenbh@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>,
        Eric Pilmore <epilmore@gigaio.com>,
        iommu@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-ntb@googlegroups.com, David Woodhouse <dwmw2@infradead.org>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 1/9] iommu/vt-d: Allow interrupts from the entire bus
 for aliased devices
Message-ID: <20190205155859.0e96dd4f@jacob-builder>
In-Reply-To: <d097d98b-0b8b-5b29-c411-a5dc3949a3e7@deltatee.com>
References: <20190131185656.17972-1-logang@deltatee.com>
        <20190131185656.17972-2-logang@deltatee.com>
        <20190201164401.GT32526@8bytes.org>
        <398e6a0a-9cbd-c218-e20e-ed91f74a653d@deltatee.com>
        <20190205111939.6f91739e@jacob-builder>
        <d097d98b-0b8b-5b29-c411-a5dc3949a3e7@deltatee.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 5 Feb 2019 13:40:36 -0700
Logan Gunthorpe <logang@deltatee.com> wrote:

> On 2019-02-05 12:19 p.m., Jacob Pan wrote:
> > On Fri, 1 Feb 2019 10:27:29 -0700
> > Logan Gunthorpe <logang@deltatee.com> wrote:
> >   
> >> On 2019-02-01 9:44 a.m., Joerg Roedel wrote:  
> >>> On Thu, Jan 31, 2019 at 11:56:48AM -0700, Logan Gunthorpe
> >>> wrote:    
> >>>> @@ -394,6 +402,10 @@ static int set_msi_sid(struct irte *irte,
> >>>> struct pci_dev *dev) set_irte_sid(irte, SVT_VERIFY_BUS,
> >>>> SQ_ALL_16, PCI_DEVID(PCI_BUS_NUM(data.alias),
> >>>>  				       dev->bus->number));  
> > I guess devfn can be removed also. but that is separate cleanup.  
> 
> Actually, no, I've dug into this and we *do* need the devfn here but
> it's needlessly confusing. We should not be using PCI_DEVID() as we
> aren't actually representing a DEVID in this case...
> 
> According to the Intel VT-D spec, when using SVT_VERIFY_BUS, the MSB
> of the SID field represents the starting bus number and the LSB
> represents the end bus number. The requester id's bus number must
> then be within that range. The PCI_DEVID macro matches these
> semantics if you assume the devfn is the end bus, but doesn't really
> make sense here and just confuses the issue.
> 
> So the code was correct, I'll just try to clean it up to make it less
> confusing.
> 
you are right, thanks for explaining.
> Thanks,
> 
> Logan
