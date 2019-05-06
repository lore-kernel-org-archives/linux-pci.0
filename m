Return-Path: <SRS0=GEr7=TG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC9DC04AAA
	for <linux-pci@archiver.kernel.org>; Mon,  6 May 2019 08:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC97E20830
	for <linux-pci@archiver.kernel.org>; Mon,  6 May 2019 08:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfEFIWm (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 6 May 2019 04:22:42 -0400
Received: from mga18.intel.com ([134.134.136.126]:16902 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725861AbfEFIWm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 May 2019 04:22:42 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 May 2019 01:22:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,437,1549958400"; 
   d="scan'208";a="137280310"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga007.jf.intel.com with ESMTP; 06 May 2019 01:22:38 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hNYtR-0007wx-FR; Mon, 06 May 2019 11:22:37 +0300
Date:   Mon, 6 May 2019 11:22:37 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Frederick Lawler <fred@fredlawl.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mika.westerberg@linux.intel.com,
        lukas@wunner.de, keith.busch@intel.com, mr.nuke.me@gmail.com,
        liudongdong3@huawei.com, thesven73@gmail.com
Subject: Re: [PATCH v2 1/9] PCI/AER: Cleanup dmesg logs
Message-ID: <20190506082237.GH9224@smile.fi.intel.com>
References: <20190503035946.23608-1-fred@fredlawl.com>
 <20190503035946.23608-2-fred@fredlawl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503035946.23608-2-fred@fredlawl.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 02, 2019 at 10:59:38PM -0500, Frederick Lawler wrote:
> Cleanup dmesg logs.

> @@ -1380,7 +1380,6 @@ static int aer_probe(struct pcie_device *dev)
>  
>  	rpc = devm_kzalloc(device, sizeof(struct aer_rpc), GFP_KERNEL);
>  	if (!rpc) {
> -		dev_printk(KERN_DEBUG, device, "alloc AER rpc failed\n");
>  		return -ENOMEM;
>  	}

When you will do a next version consider to drop no needed {} above.

-- 
With Best Regards,
Andy Shevchenko


