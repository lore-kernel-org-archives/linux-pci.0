Return-Path: <SRS0=ChyX=OI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F05FC43441
	for <linux-pci@archiver.kernel.org>; Thu, 29 Nov 2018 19:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0050220868
	for <linux-pci@archiver.kernel.org>; Thu, 29 Nov 2018 19:30:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0050220868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbeK3Ggs (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 30 Nov 2018 01:36:48 -0500
Received: from mga04.intel.com ([192.55.52.120]:27056 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbeK3Ggs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Nov 2018 01:36:48 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Nov 2018 11:30:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,295,1539673200"; 
   d="scan'208";a="116604676"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga004.fm.intel.com with SMTP; 29 Nov 2018 11:30:13 -0800
Received: by lahna (sSMTP sendmail emulation); Thu, 29 Nov 2018 21:30:12 +0200
Date:   Thu, 29 Nov 2018 21:30:12 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Alex_Gagniuc@dellteam.com
Cc:     mr.nuke.me@gmail.com, bhelgaas@google.com, Austin.Bolen@dell.com,
        keith.busch@intel.com, Shyam.Iyer@dell.com, lukas@wunner.de,
        okaya@codeaurora.org, rafael.j.wysocki@intel.com,
        poza@codeaurora.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: pciehp: Report degraded links via link bandwidth
 notification
Message-ID: <20181129193012.GE3078@lahna.fi.intel.com>
References: <20181129000829.14751-1-mr.nuke.me@gmail.com>
 <20181129160625.GC3078@lahna.fi.intel.com>
 <9f76adf7315842cb82375eeaad0a0563@ausx13mps321.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f76adf7315842cb82375eeaad0a0563@ausx13mps321.AMER.DELL.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 29, 2018 at 07:00:58PM +0000, Alex_Gagniuc@Dellteam.com wrote:
> >> +	if (link_status & PCI_EXP_LNKSTA_LBMS) {
> >> +		if (pdev->subordinate && pdev->subordinate->self)
> >> +			endpoint = pdev->subordinate->self;
> > 
> > Hmm, I thought pdev->subordinate->self == pdev, no?
> 
> That makes no sense, but I think you're right. I'm trying to get to the 
> other end of the PCIe link. Is there a simple way to do that? (other 
> than convoluted logic that all leads to the same mistake)

AFAIK you should be able to find the other end by looking at the
pdev->subordinate->devices list. Not sure if there is a simpler way,
though.
