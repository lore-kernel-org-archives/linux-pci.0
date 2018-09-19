Return-Path: <SRS0=bOp+=MB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143ABC433F4
	for <linux-pci@archiver.kernel.org>; Wed, 19 Sep 2018 20:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA40208A3
	for <linux-pci@archiver.kernel.org>; Wed, 19 Sep 2018 20:16:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBA40208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731540AbeITBzd (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 19 Sep 2018 21:55:33 -0400
Received: from mga03.intel.com ([134.134.136.65]:61639 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728111AbeITBzd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Sep 2018 21:55:33 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Sep 2018 13:15:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,395,1531810800"; 
   d="scan'208";a="92001201"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.44])
  by orsmga001.jf.intel.com with ESMTP; 19 Sep 2018 13:15:41 -0700
Date:   Wed, 19 Sep 2018 14:17:35 -0600
From:   Keith Busch <keith.busch@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCHv3 01/10] PCI/portdrv: Use subsys_init for service drivers
Message-ID: <20180919201735.GD28310@localhost.localdomain>
References: <20180918235702.26573-1-keith.busch@intel.com>
 <20180918235702.26573-2-keith.busch@intel.com>
 <20180919162846.GB243610@bhelgaas-glaptop.roam.corp.google.com>
 <20180919180003.GC28310@localhost.localdomain>
 <20180919194029.GA261184@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180919194029.GA261184@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
Message-ID: <20180919201735.JlGJFF2S0D5t0Cldu8wzzpyRt1gvcZSFRCUtnFVGobY@z>

On Wed, Sep 19, 2018 at 02:40:29PM -0500, Bjorn Helgaas wrote:
> On Wed, Sep 19, 2018 at 12:00:03PM -0600, Keith Busch wrote:
> > On Wed, Sep 19, 2018 at 11:28:46AM -0500, Bjorn Helgaas wrote:
> > > On Tue, Sep 18, 2018 at 05:56:53PM -0600, Keith Busch wrote:
> > > Since none of the service drivers can be modules, I don't think it
> > > buys us much to make their init functions initcalls.  Can we
> > > explicitly call them from the pcie_portdrv_probe() path?
> > 
> > It's actually during pcie_portdrv_init that the services need to be
> > initialized if we're going this way. Do you think the following is
> > better? The initialization order should be more clear to the reader at
> > the cost of more code than init call magic, but I'm okay having this
> > done either way.
> 
> Yes.  More code, less magic seems like the right tradeoff to me.

Sounds good. Will send a new version of the set using this method, plus
merging up to the current pci/hotplug and the documentation updates.
