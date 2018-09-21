Return-Path: <SRS0=H68a=MD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA820ECE567
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 17:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFFEC21550
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 17:01:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFFEC21550
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbeIUWvH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Sep 2018 18:51:07 -0400
Received: from mga02.intel.com ([134.134.136.20]:40908 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728149AbeIUWvH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Sep 2018 18:51:07 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Sep 2018 10:01:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,285,1534834800"; 
   d="scan'208";a="85502538"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.44])
  by orsmga003.jf.intel.com with ESMTP; 21 Sep 2018 10:00:37 -0700
Date:   Fri, 21 Sep 2018 11:02:34 -0600
From:   Keith Busch <keith.busch@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: Fix compile error with DPC disabled
Message-ID: <20180921170234.GA1496@localhost.localdomain>
References: <20180921142210.1191-1-keith.busch@intel.com>
 <20180921165729.GK224714@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180921165729.GK224714@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 21, 2018 at 11:57:29AM -0500, Bjorn Helgaas wrote:
> On Fri, Sep 21, 2018 at 08:22:10AM -0600, Keith Busch wrote:
> > The alternate functions when CONFIG_PCIE_DPC is not defined need to be
> > static inline.
> > 
> > Signed-off-by: Keith Busch <keith.busch@intel.com>
> 
> If you tell me which patch, I'll fold this into it so there's no bisection
> hole.

Thanks, I like that plan.

Fixes: d17964c0d81fc38c7 ("PCI/DPC: Save and restore config state")

https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=pci/hotplug&id=d17964c0d81fc38c733fc5281436d2b262306a33
 
> > ---
> >  drivers/pci/pci.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > index a244bd0c5ca7..eb3125decffe 100644
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -402,8 +402,8 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
> >  void pci_save_dpc_state(struct pci_dev *dev);
> >  void pci_restore_dpc_state(struct pci_dev *dev);
> >  #else
> > -void pci_save_dpc_state(struct pci_dev *dev) {}
> > -void pci_restore_dpc_state(struct pci_dev *dev) {}
> > +static inline void pci_save_dpc_state(struct pci_dev *dev) {}
> > +static inline void pci_restore_dpc_state(struct pci_dev *dev) {}
> >  #endif
> >  
> >  #ifdef CONFIG_PCI_ATS
> > -- 
> > 2.14.4
> > 
