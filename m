Return-Path: <SRS0=mL0v=MY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68AEC67872
	for <linux-pci@archiver.kernel.org>; Fri, 12 Oct 2018 16:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B55022098A
	for <linux-pci@archiver.kernel.org>; Fri, 12 Oct 2018 16:24:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B55022098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbeJLX54 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Oct 2018 19:57:56 -0400
Received: from mga02.intel.com ([134.134.136.20]:58651 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728874AbeJLX54 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Oct 2018 19:57:56 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Oct 2018 09:24:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,373,1534834800"; 
   d="scan'208";a="78317998"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga008.fm.intel.com with ESMTP; 12 Oct 2018 09:24:40 -0700
Date:   Fri, 12 Oct 2018 10:21:42 -0600
From:   Keith Busch <keith.busch@intel.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH] PCI/P2PDMA: Fix freeing dev_pagemap on error
Message-ID: <20181012162142.GA15490@localhost.localdomain>
References: <20181012155219.15360-1-keith.busch@intel.com>
 <7fa9a510-9197-a07d-958d-8b23e39cc288@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fa9a510-9197-a07d-958d-8b23e39cc288@deltatee.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 12, 2018 at 09:58:14AM -0600, Logan Gunthorpe wrote:
> On 2018-10-12 9:52 a.m., Keith Busch wrote:
> > The devres_free() API is only to be used after the resource has been
> > unlinked from the device tracking it. Calling this functino directly will
> > hit a kernel BUG_ON. This patch fixes this to use the managed resource
> > release function, devm_kfree().
> > 
> > Fixes: 1380472e7b855 ("PCI/P2PDMA: Support peer-to-peer memory")
> > Cc: Logan Gunthorpe <logang@deltatee.com>
> > Signed-off-by: Keith Busch <keith.busch@intel.com>
> 
> Oops, yes, nice catch! Thanks!

Yeah, I hit the bug after an nvme controller reset. The nvme driver
tries to add its CMB memory a second time, and it's correctly detected
as an error by devm_memremap_pages(), but I'm also thinking nvme should
have known better too.

Anyway, this patch (its v2, really) is the simple error handling fix,
but there will be a follow up nvme patch to avoid the error in the first
place. :)
