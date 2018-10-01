Return-Path: <SRS0=/qR3=MN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98331C43143
	for <linux-pci@archiver.kernel.org>; Mon,  1 Oct 2018 15:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69310208D9
	for <linux-pci@archiver.kernel.org>; Mon,  1 Oct 2018 15:12:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69310208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbeJAVuv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Oct 2018 17:50:51 -0400
Received: from mga09.intel.com ([134.134.136.24]:58392 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728979AbeJAVuu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Oct 2018 17:50:50 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2018 08:12:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,328,1534834800"; 
   d="scan'208";a="93611239"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.44])
  by fmsmga004.fm.intel.com with ESMTP; 01 Oct 2018 08:12:33 -0700
Date:   Mon, 1 Oct 2018 09:14:51 -0600
From:   Keith Busch <keith.busch@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCHv4 08/12] PCI: ERR: Always use the first downstream port
Message-ID: <20181001151450.GB22508@localhost.localdomain>
References: <20180920162717.31066-1-keith.busch@intel.com>
 <20180920162717.31066-9-keith.busch@intel.com>
 <20180926220116.GJ28024@bhelgaas-glaptop.roam.corp.google.com>
 <20180926221924.GA17934@localhost.localdomain>
 <20180927225625.GB18434@bhelgaas-glaptop.roam.corp.google.com>
 <20180928154220.GA21996@localhost.localdomain>
 <20180928205034.GA119911@bhelgaas-glaptop.roam.corp.google.com>
 <20180928213523.GA22508@localhost.localdomain>
 <20180928232801.GB119911@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180928232801.GB119911@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 28, 2018 at 06:28:02PM -0500, Bjorn Helgaas wrote:
> On Fri, Sep 28, 2018 at 03:35:23PM -0600, Keith Busch wrote:
> > The assumption I'm making (which I think is a safe assumption with
> > general consensus) is that errors detected on an end point or an upstream
> > port happened because of something wrong with the link going upstream:
> > end devices have no other option, 
> 
> Is this really true?  It looks like "Internal Errors" (sec 6.2.9) may
> be unrelated to a packet or event (though they are supposed to be
> associated with a PCIe interface).
> 
> It says the only method of recovering is reset or hardware
> replacement.  It doesn't specify, but it seems like a FLR or similar
> reset might be appropriate and we may not have to reset the link.

That is an interesting case we might want to handle better. I've a couple
concerns to consider for implementing:

We don't know an ERR_FATAL occured for an internal reason until we read the
config register across the link, and the AER driver historically avoided
accessing potentially unhealthy links. I don't *think* it's harmful to
attempt reading the register, but we'd just need to check for an "all 1's"
completion before trusting the result.

The other issue with trying to use FLR is a device may not implement
it, so pci reset has fallback methods depending on the device's
capabilities. We can end up calling pci_parent_bus_reset(), which does the
same secondary bus reset that already happens as part of error recovery.
We'd just need to make sure affected devices and drivers have a chance
to be notified (which is the this patch's intention).
 
> Getting back to the changelog, "error handling can only run on
> bridges" clearly doesn't refer to the driver callbacks (since those
> only apply to endpoints).  Maybe "error handling" refers to the
> reset_link(), which can only be done on a bridge?

Yep, referring to how link reset_link is only sent from bridges.
 
> That would make sense to me, although the current code may be
> resetting more devices than necessary if Internal Errors can be
> handled without a link reset.

That sounds good, I'll test some scenarios out here.
