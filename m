Return-Path: <SRS0=w1cP=EM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39597C55ABD
	for <linux-pci@archiver.kernel.org>; Fri,  6 Nov 2020 09:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0CCC22210
	for <linux-pci@archiver.kernel.org>; Fri,  6 Nov 2020 09:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgKFJzI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 6 Nov 2020 04:55:08 -0500
Received: from mga11.intel.com ([192.55.52.93]:37431 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbgKFJzH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Nov 2020 04:55:07 -0500
IronPort-SDR: CyyA18A+knp1nnxQDxPTqsTuXufyP94J5uhjPTL4bcY0rcC1jZ4KI/CrH59UTv9u6AzQvnFMKP
 JjgoiuyFpMjQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9796"; a="166016534"
X-IronPort-AV: E=Sophos;i="5.77,456,1596524400"; 
   d="scan'208";a="166016534"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 01:55:07 -0800
IronPort-SDR: ItqUkJw9RF9GYZyuckx+5O8DuuQdLJsdqhUJ19/UnweeGK3dazttW6bzfZcAArHJR1yehrFCy4
 BNzaCxqVtKXA==
X-IronPort-AV: E=Sophos;i="5.77,456,1596524400"; 
   d="scan'208";a="354677345"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 01:55:05 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kayTX-004Ir3-Sw; Fri, 06 Nov 2020 11:56:07 +0200
Date:   Fri, 6 Nov 2020 11:56:07 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        johan@kernel.org, linux-usb@vger.kernel.org,
        alberto.vignani@fastwebnet.it
Subject: Re: [PATCH v1 1/2] PCI: Disable MSI for Pericom PCIe-USB adapter
Message-ID: <20201106095607.GE4077@smile.fi.intel.com>
References: <20201105180644.42862-1-andriy.shevchenko@linux.intel.com>
 <add5a26bd1feb562867a46206ad7cd796b88b65c.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <add5a26bd1feb562867a46206ad7cd796b88b65c.camel@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 05, 2020 at 08:46:03PM +0000, David Woodhouse wrote:
> On Thu, 2020-11-05 at 20:06 +0200, Andy Shevchenko wrote:
> > Pericom PCIe-USB adapter ambiguously advertises MSI, but documentation says
> > "The MSI Function is not implemented on this device." in the chapters 7.3.27,
> > 7.3.29-7.3.31.
> 
> I don't think it can be ambiguous, surely? Either it does advertise it,
> or it doesn't. It doesn't just give you subtle hints that it *might*
> support MSI, but it isn't sure...

I will drop the word from commit message, thanks!


-- 
With Best Regards,
Andy Shevchenko


