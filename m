Return-Path: <SRS0=7uyK=MA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8910BC433F4
	for <linux-pci@archiver.kernel.org>; Tue, 18 Sep 2018 22:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34F22214C2
	for <linux-pci@archiver.kernel.org>; Tue, 18 Sep 2018 22:09:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34F22214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbeISDo3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 18 Sep 2018 23:44:29 -0400
Received: from mga11.intel.com ([192.55.52.93]:18085 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727690AbeISDo3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Sep 2018 23:44:29 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2018 15:09:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,391,1531810800"; 
   d="scan'208";a="258380530"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.44])
  by orsmga005.jf.intel.com with ESMTP; 18 Sep 2018 15:09:49 -0700
Date:   Tue, 18 Sep 2018 16:11:42 -0600
From:   Keith Busch <keith.busch@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>,
        "poza@codeaurora.org" <poza@codeaurora.org>,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHv2 15/20] PCI/pciehp: Fix powerfault detection order
Message-ID: <20180918221141.GA26372@localhost.localdomain>
References: <20180905203546.21921-1-keith.busch@intel.com>
 <20180905203546.21921-16-keith.busch@intel.com>
 <20180906193657.GH214747@bhelgaas-glaptop.roam.corp.google.com>
 <20180906195047.GD31024@localhost.localdomain>
 <20180907165352.GA250890@bhelgaas-glaptop.roam.corp.google.com>
 <20180907200332.GB250890@bhelgaas-glaptop.roam.corp.google.com>
 <20180907201819.GA1341@localhost.localdomain>
 <20180918214650.GG13616@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918214650.GG13616@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
Message-ID: <20180918221142.6Z9XTbKq74vostB__xjiGiKDZd54MRJwQlcifrv4jWo@z>

On Tue, Sep 18, 2018 at 02:46:50PM -0700, Bjorn Helgaas wrote:
> On Fri, Sep 07, 2018 at 02:18:19PM -0600, Keith Busch wrote:
> > On Fri, Sep 07, 2018 at 03:03:32PM -0500, Bjorn Helgaas wrote:
> > > I applied this to for-linus with the following changelog.  Let me know
> > > if I didn't understand this correctly.  I changed the comment in
> > > pciehp_power_on_slot() so it doesn't say "sticky" to avoid confusion
> > > with the PCI spec concept of sticky register bits (ROS, RWS, RW1CS).
> > 
> > Perfect! Thanks for queueing this up. I'll drop this one from the rest
> > of the series, which will need at least a v3 to fix a dumb mistake in
> > pointed out in review, and I'll get the order to better sense (or maybe
> > split into independent patch sets).
> 
> Are you still planning a v3?  I really want to get this in for v4.20
> and I think there's probably some integration to be done with Lukas'
> series (which I haven't applied yet either).
> 
> I rebased my branches to v4.19-rc4 to avoid a merge conflict Lukas
> pointed out.

I'll send something out today, and I think I'll split it into multiple
independent sets.

I had to trim down what this is trying to accomplish due to existing
deadlocking bugs I've found in testing: there are several circular
dependencies on tasks holding the single pci_rescan_remove_lock. I don't
think I'll be able to fix that in time for 4.20, but I'll send the parts
that I believe are an improvement that don't break anything else.
