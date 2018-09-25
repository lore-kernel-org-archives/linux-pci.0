Return-Path: <SRS0=zVIF=MH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A5EC43382
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 14:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28D5520880
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 14:15:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28D5520880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbeIYUXL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 25 Sep 2018 16:23:11 -0400
Received: from mga03.intel.com ([134.134.136.65]:36723 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729098AbeIYUXL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Sep 2018 16:23:11 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2018 07:15:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,302,1534834800"; 
   d="scan'208";a="93098375"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.44])
  by fmsmga001.fm.intel.com with ESMTP; 25 Sep 2018 07:15:27 -0700
Date:   Tue, 25 Sep 2018 08:17:33 -0600
From:   Keith Busch <keith.busch@intel.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 11/12] PCI/AER: Use managed resource allocations
Message-ID: <20180925141733.GA11657@localhost.localdomain>
References: <20180918235848.26694-1-keith.busch@intel.com>
 <20180918235848.26694-12-keith.busch@intel.com>
 <4fc055a6ead393b4adac20929291b7ca9ae959b6.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fc055a6ead393b4adac20929291b7ca9ae959b6.camel@kernel.crashing.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 25, 2018 at 11:13:42AM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2018-09-18 at 17:58 -0600, Keith Busch wrote:
> > This uses the managed device resource allocations for the service data
> > so that the aer driver doesn't need to manage it, further simplifying
> > this driver.
> 
> Just be careful (it migh be ok, I haven't audited everything, but I got
> bitten by something like that in the past) that the devm stuff will get
> disposed of in two cases:
> 
>  - The owner device going away (so far so good)
> 
>  - The owner device's driver being unbound
> 
> The latter is something not completely obvious, ie, even if the owner
> device still has held references, the successful completion of
> ->remove() on the driver will be followed by a cleanup of the managed
> stuff.
> 
> As I said, it might be ok in the AER case, but you might want to at
> least keep the set_service_data(dev, NULL) to make sure you don't leave
> a stale pointer there.

Yes, these resource methods should be considered carefully. I think
we're okay here, and didn't want to set service data to NULL for a
couple reasons:

 1. The service data and its device are released together, so the device
    is already out of scope before it could hold a stale pointer.

 2. It is possible the IRQ handler may be invoked after 'remove', but
    before the managed irq is torn down. Leaving the service data set
    while it is allocated removes a requirement to check for NULL on
    each interrupt.
