Return-Path: <SRS0=VZwk=S6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3B9C43219
	for <linux-pci@archiver.kernel.org>; Sun, 28 Apr 2019 15:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7F042067D
	for <linux-pci@archiver.kernel.org>; Sun, 28 Apr 2019 15:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfD1Pzm (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 28 Apr 2019 11:55:42 -0400
Received: from mga01.intel.com ([192.55.52.88]:18403 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726744AbfD1Pzm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 28 Apr 2019 11:55:42 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Apr 2019 08:55:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,406,1549958400"; 
   d="scan'208";a="138184027"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga008.jf.intel.com with ESMTP; 28 Apr 2019 08:55:38 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hKm9Q-0005qR-JM; Sun, 28 Apr 2019 18:55:36 +0300
Date:   Sun, 28 Apr 2019 18:55:36 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     fred@fredlawl.com
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mika.westerberg@linux.intel.com,
        lukas@wunner.de, keith.busch@intel.com, mr.nuke.me@gmail.com,
        liudongdong3@huawei.com, thesven73@gmail.com
Subject: Re: [PATCH 3/4] PCI: pciehp: Remove unused macro definitions
Message-ID: <20190428155536.GU9224@smile.fi.intel.com>
References: <20190427191304.32502-1-fred@fredlawl.com>
 <20190427191304.32502-4-fred@fredlawl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190427191304.32502-4-fred@fredlawl.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Apr 27, 2019 at 02:13:03PM -0500, fred@fredlawl.com wrote:
> Now that all uses for the ctrl_*() printk wrappers are removed from
> files and replaces with pci_*() or pr_*() printk wrappers, remove the
> unused macro definitions. In addition to that, remove the MY_NAME macro.

>  extern bool pciehp_debug;

How it's used after all?

> -#define dbg(format, arg...)						\
> -do {									\
> -	if (pciehp_debug)						\
> -		printk(KERN_DEBUG "%s: " format, MY_NAME, ## arg);	\
> -} while (0)

> -#define ctrl_dbg(ctrl, format, arg...)					\
> -	do {								\
> -		if (pciehp_debug)					\
> -			dev_printk(KERN_DEBUG, &ctrl->pcie->device,	\
> -					format, ## arg);		\
> -	} while (0)

Besides ruining the pciehp_debug support this will make unequivalent behaviour.

-- 
With Best Regards,
Andy Shevchenko


