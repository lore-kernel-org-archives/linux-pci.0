Return-Path: <SRS0=6VBI=NY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDDAC43441
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 15:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73ADA2251A
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 15:03:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73ADA2251A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730653AbeKNBBl (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 13 Nov 2018 20:01:41 -0500
Received: from mga05.intel.com ([192.55.52.43]:51601 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728718AbeKNBBl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Nov 2018 20:01:41 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2018 07:03:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,499,1534834800"; 
   d="scan'208";a="279454352"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga005.fm.intel.com with ESMTP; 13 Nov 2018 07:03:08 -0800
Date:   Tue, 13 Nov 2018 07:59:40 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>, Wei Zhang <wzhang@fb.com>
Subject: Re: [PATCHv4 next 0/3] Limiting pci access
Message-ID: <20181113145940.GA9827@localhost.localdomain>
References: <20161118232544.GI28386@localhost.localdomain>
 <20161123160906.GB16033@bhelgaas-glaptop.roam.corp.google.com>
 <20161128180214.GF2609@localhost.localdomain>
 <20161208175432.GA28827@bhelgaas-glaptop.roam.corp.google.com>
 <20161208193253.GK25959@localhost.localdomain>
 <20161212234226.GA7973@bhelgaas-glaptop.roam.corp.google.com>
 <20161213005547.GA12844@localhost.localdomain>
 <20161213205012.GA29950@bhelgaas-glaptop.roam.corp.google.com>
 <20161213231840.GD12113@localhost.localdomain>
 <20181113060510.GB182139@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113060510.GB182139@google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 12, 2018 at 10:05:11PM -0800, Bjorn Helgaas wrote:
> On Tue, Dec 13, 2016 at 06:18:40PM -0500, Keith Busch wrote:
> > It's the MSI-x masking that's our next highest contributor. Masking
> > vectors still requires non-posted commands, and since they're not
> > going through managed API accessors like config space uses, the
> > removed flag is needed for checking before doing significant MMIO.
> 
> Sorry for digging up this ancient history, but do you remember where
> this MSI-X masking with non-posted commands happens?  The masking is
> an MMIO write (posted) and there should only be a non-posted MMIO read
> if we use the msi_set_mask_bit() path.
> 
> I'm looking at this path:
> 
>   nvme_pci_disable
>     pci_free_irq_vectors
>       pci_disable_msix
>         pci_msix_shutdown
>           if (pci_dev_is_disconnected())    # added by 0170591bb067
>             return                          # (skip hw access)
>           for_each_pci_msi_entry(...)       # <-- loop
>             __pci_msix_desc_mask_irq
>               writel                        # <-- MMIO write
>           pci_read_config_word(PCI_MSIX_FLAGS)
>           pci_write_config_word(PCI_MSIX_FLAGS)
>         free_msi_irqs
> 
> whih only does MMIO *writes*, which I think are posted and do not
> require completion and should not cause timeouts.  That's wasted
> effort, I agree, but it doesn't seem like it should be a performance
> issue.
>
> So there must be another path, probably preceding this one (since
> pci_disable_msix() cleans everything up), that masks the vectors and
> does the non-posted reads?
> 
> The only places we do MMIO reads are msix_program_entries(), which is
> done at MSI-X enable time, and msi_set_mask_bit(), which is used in
> irq_chip.irq_mask() and irq_chip.irq_unmask() methods.  But I haven't
> figured out where that irq_chip path is used in a loop.

I must have thought masking was a read-modify-write operation. It looks
like we're using a cached value so only posted commands needed.
