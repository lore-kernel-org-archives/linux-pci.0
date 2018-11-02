Return-Path: <SRS0=VxNY=NN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21B4C32789
	for <linux-pci@archiver.kernel.org>; Fri,  2 Nov 2018 16:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 627E720833
	for <linux-pci@archiver.kernel.org>; Fri,  2 Nov 2018 16:37:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 627E720833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbeKCBop (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 2 Nov 2018 21:44:45 -0400
Received: from mga02.intel.com ([134.134.136.20]:63286 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbeKCBop (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Nov 2018 21:44:45 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Nov 2018 09:37:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,456,1534834800"; 
   d="scan'208";a="104782618"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga001.fm.intel.com with ESMTP; 02 Nov 2018 09:37:02 -0700
Date:   Fri, 2 Nov 2018 10:34:46 -0600
From:   Keith Busch <keith.busch@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Jon Derrick <jonathan.derrick@intel.com>,
        linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Tyler Baicar <tbaicar@codeaurora.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI/AER: Option to leave System Error Interrupts
 as-is
Message-ID: <20181102163446.GA26410@localhost.localdomain>
References: <1540585146-31876-1-git-send-email-jonathan.derrick@intel.com>
 <20181029210651.GB13681@bhelgaas-glaptop.roam.corp.google.com>
 <20181102095300.GB14602@zn.tnic>
 <20181102161730.GA26392@localhost.localdomain>
 <20181102162623.GH14602@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181102162623.GH14602@zn.tnic>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 02, 2018 at 05:26:23PM +0100, Borislav Petkov wrote:
> On Fri, Nov 02, 2018 at 10:17:30AM -0600, Keith Busch wrote:
> > VMD acts a bit like a host-bus adapter. The firmware knows about the
> > adapter, but not about anything on the bus that it attaches to.
> > 
> > This "hybrid" approach is basically saying that the firmware knows about
> > the HBA, and it wants a chance to be notified of errors on the bus it
> > attaches to, but the firmware can't do anything about such errors.
> > 
> > The bus in this case is PCIe, where we have capable error handling in the
> > kernel driver, so we ultimately want the AER driver handling the errors.
> 
> Not a problem - GHES already knows about AER and calls into it for
> CPER_SEC_PCIE errors:
> 
> ghes_do_proc
> -> ghes_handle_aer
>   |-> aer_recover_queue

That requires firmware know about the PCIe domain that experienced an
error so that it can provide an appropriate CPER. That wouldn't be
possible for errors occuring within a VMD domain.
