Return-Path: <SRS0=VZwk=S6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661BEC43219
	for <linux-pci@archiver.kernel.org>; Sun, 28 Apr 2019 15:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D1132067C
	for <linux-pci@archiver.kernel.org>; Sun, 28 Apr 2019 15:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfD1Pnr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 28 Apr 2019 11:43:47 -0400
Received: from mga03.intel.com ([134.134.136.65]:34607 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbfD1Pnr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 28 Apr 2019 11:43:47 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Apr 2019 08:43:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,406,1549958400"; 
   d="scan'208";a="146559425"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga007.fm.intel.com with ESMTP; 28 Apr 2019 08:43:44 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hKlxr-0005kA-KA; Sun, 28 Apr 2019 18:43:39 +0300
Date:   Sun, 28 Apr 2019 18:43:39 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     fred@fredlawl.com
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mika.westerberg@linux.intel.com,
        lukas@wunner.de, keith.busch@intel.com, mr.nuke.me@gmail.com,
        liudongdong3@huawei.com, thesven73@gmail.com
Subject: Re: [PATCH 1/4] PCI: Replace dev_*() printk wrappers with pci_*()
 printk wrappers
Message-ID: <20190428154339.GT9224@smile.fi.intel.com>
References: <20190427191304.32502-1-fred@fredlawl.com>
 <20190427191304.32502-2-fred@fredlawl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190427191304.32502-2-fred@fredlawl.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Apr 27, 2019 at 02:13:01PM -0500, fred@fredlawl.com wrote:
> From: Frederick Lawler <fred@fredlawl.com>
> 
> Replace remaining instances of dev_*() printk wrappers with pci_*()
> printk wrappers. No functional change intended.

> -		pci_printk(KERN_DEBUG, parent, "can't find device of ID%04x\n",
> -			   e_info->id);
> +		pci_dbg(parent, "can't find device of ID%04x\n", e_info->id);

These are not equivalent.

> -		dev_printk(KERN_DEBUG, device, "alloc AER rpc failed\n");
> +		pci_dbg(pdev, "alloc AER rpc failed\n");

Ditto.

> -		dev_printk(KERN_DEBUG, device, "request AER IRQ %d failed\n",
> -			   dev->irq);
> +		pci_dbg(pdev, "request AER IRQ %d failed\n", dev->irq);

Ditto.

And so on.

-- 
With Best Regards,
Andy Shevchenko


