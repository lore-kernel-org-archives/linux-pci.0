Return-Path: <SRS0=Zps5=ZA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261CFFA372C
	for <linux-pci@archiver.kernel.org>; Fri,  8 Nov 2019 11:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07074222C2
	for <linux-pci@archiver.kernel.org>; Fri,  8 Nov 2019 11:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731870AbfKHLIV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:08:21 -0500
Received: from mga17.intel.com ([192.55.52.151]:30290 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731299AbfKHLIU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Nov 2019 06:08:20 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Nov 2019 03:08:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,281,1569308400"; 
   d="scan'208";a="193133483"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007.jf.intel.com with ESMTP; 08 Nov 2019 03:08:18 -0800
Received: from andy by smile with local (Exim 4.93-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iT27m-0002HX-2h; Fri, 08 Nov 2019 13:08:18 +0200
Date:   Fri, 8 Nov 2019 13:08:18 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Alex G." <mr.nuke.me@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: Re: [PATCH v1] PCI: pciehp: Refactor infinite loop in pcie_poll_cmd()
Message-ID: <20191108110818.GC32742@smile.fi.intel.com>
References: <20191011090230.81080-1-andriy.shevchenko@linux.intel.com>
 <20191107151536.GA32742@smile.fi.intel.com>
 <a11f53df-911a-3eee-6bda-01322550f1d4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a11f53df-911a-3eee-6bda-01322550f1d4@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 07, 2019 at 11:21:12AM -0600, Alex G. wrote:
> 
> Hi Andy,
> On 11/7/19 9:15 AM, Andy Shevchenko wrote:
> > On Fri, Oct 11, 2019 at 12:02:30PM +0300, Andy Shevchenko wrote:
> > > Infinite timeout loops are hard to read.
> 
> Why do you find infinite timeout loops hard to read? I personally find that
> emphasizing the common case to be more redable. An ideal loop for me would
> look like:
> 
> 	do {
> 		do_stuff();

> 		if (timeout) {

Invariant conditional inside loop? okay...

> 			complain();
> 			break()
> 		}
> 	} while (what_we_expect_has_not_happened());

-- 
With Best Regards,
Andy Shevchenko


