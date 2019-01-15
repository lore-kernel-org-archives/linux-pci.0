Return-Path: <SRS0=HN6g=PX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB63C43387
	for <linux-pci@archiver.kernel.org>; Tue, 15 Jan 2019 05:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6CAF20656
	for <linux-pci@archiver.kernel.org>; Tue, 15 Jan 2019 05:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbfAOFph (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 15 Jan 2019 00:45:37 -0500
Received: from mga01.intel.com ([192.55.52.88]:15224 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727211AbfAOFph (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Jan 2019 00:45:37 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2019 21:45:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,480,1539673200"; 
   d="scan'208";a="106654907"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga007.jf.intel.com with ESMTP; 14 Jan 2019 21:45:32 -0800
Received: from andy by smile with local (Exim 4.92-RC4)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gjHXX-0000eC-HH; Tue, 15 Jan 2019 07:45:31 +0200
Date:   Tue, 15 Jan 2019 07:45:31 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Joao Pinto <joao.pinto@synopsys.com>,
        Jose Abreu <jose.abreu@synopsys.com>,
        Luis Oliveira <luis.oliveira@synopsys.com>,
        Vitor Soares <vitor.soares@synopsys.com>,
        Nelson Costa <nelson.costa@synopsys.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>
Subject: Re: [RFC v3 7/7] dmaengine: Add Synopsys eDMA IP test and sample
 driver
Message-ID: <20190115054531.GC9170@smile.fi.intel.com>
References: <cover.1547230339.git.gustavo.pimentel@synopsys.com>
 <cc195ac53839b318764c8f6502002cd6d933a923.1547230339.git.gustavo.pimentel@synopsys.com>
 <20190111194819.GV9170@smile.fi.intel.com>
 <2de7f43e-0702-9ab3-b24c-a1b212e18f7c@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2de7f43e-0702-9ab3-b24c-a1b212e18f7c@synopsys.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 14, 2019 at 11:44:22AM +0000, Gustavo Pimentel wrote:
> On 11/01/2019 19:48, Andy Shevchenko wrote:
> > On Fri, Jan 11, 2019 at 07:33:43PM +0100, Gustavo Pimentel wrote:
> >> Add Synopsys eDMA IP test and sample driver to be use for testing
> >> purposes and also as a reference for any developer who needs to
> >> implement and use Synopsys eDMA.
> >>
> >> This driver can be compile as built-in or external module in kernel.
> >>
> >> To enable this driver just select DW_EDMA_TEST option in kernel
> >> configuration, however it requires and selects automatically DW_EDMA
> >> option too.
> >>
> > 
> > Hmm... This doesn't explain what's wrong with dmatest module.
> 
> There isn't anything wrong with dmatest module, that I know of. In beginning I
> was planning to used it, however only works with MEM_TO_MEM transfers, that's
> why I created a similar module but for MEM_TO_DEV and DEV_TO_MEM with
> scatter-gather and cyclic transfers type for my use case. I don't know if can be
> applied to other cases, if that is feasible, I'm glad to share it.

What I'm trying to tell is that the dmatest driver would be nice to have such
capability.

-- 
With Best Regards,
Andy Shevchenko


