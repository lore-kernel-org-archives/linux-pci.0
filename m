Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A6FC4338F
	for <linux-pci@archiver.kernel.org>; Mon, 23 Aug 2021 07:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E86CE61245
	for <linux-pci@archiver.kernel.org>; Mon, 23 Aug 2021 07:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235115AbhHWHr6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 23 Aug 2021 03:47:58 -0400
Received: from mga03.intel.com ([134.134.136.65]:4988 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234940AbhHWHr5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 23 Aug 2021 03:47:57 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10084"; a="217081329"
X-IronPort-AV: E=Sophos;i="5.84,344,1620716400"; 
   d="scan'208";a="217081329"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 00:47:14 -0700
X-IronPort-AV: E=Sophos;i="5.84,344,1620716400"; 
   d="scan'208";a="683056883"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 00:47:13 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mI4fj-00ChVg-Q3; Mon, 23 Aug 2021 10:47:07 +0300
Date:   Mon, 23 Aug 2021 10:47:07 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [pci:pci/misc 7/7] include/linux/pci.h:1725:54: error: parameter
 name omitted
Message-ID: <YSNSe4JqIqi8pREU@smile.fi.intel.com>
References: <202108211050.dQMdCDWM-lkp@intel.com>
 <YSNPtLQ5q1poPb6x@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSNPtLQ5q1poPb6x@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 23, 2021 at 10:35:16AM +0300, Andy Shevchenko wrote:
> On Sat, Aug 21, 2021 at 10:44:06AM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/misc
> > head:   81e2ce35df9102989cefe180f41d78dd7fb8c9b9
> > commit: 81e2ce35df9102989cefe180f41d78dd7fb8c9b9 [7/7] PCI: Sync __pci_register_driver() stub for CONFIG_PCI=n
> > config: i386-tinyconfig (attached as .config)
> > compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> > reproduce (this is a W=1 build):
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?id=81e2ce35df9102989cefe180f41d78dd7fb8c9b9
> >         git remote add pci https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
> >         git fetch --no-tags pci pci/misc
> >         git checkout 81e2ce35df9102989cefe180f41d78dd7fb8c9b9
> >         # save the attached .config to linux build tree
> >         mkdir build_dir
> >         make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/kernel/
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> 
> For the record, I copied a prototype from the other one.
> If we need to fix, we need to fix them both.
> 
> I'll cook the patch.

Seem Bjorn fixed this inline, thanks!

-- 
With Best Regards,
Andy Shevchenko


