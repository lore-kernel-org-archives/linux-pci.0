Return-Path: <SRS0=pnr2=P3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8F0C61CE8
	for <linux-pci@archiver.kernel.org>; Sat, 19 Jan 2019 16:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 419C6208E4
	for <linux-pci@archiver.kernel.org>; Sat, 19 Jan 2019 16:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbfASQV5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 19 Jan 2019 11:21:57 -0500
Received: from mga17.intel.com ([192.55.52.151]:9176 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728460AbfASQV5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 19 Jan 2019 11:21:57 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jan 2019 08:21:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,496,1539673200"; 
   d="scan'208";a="292829259"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga005.jf.intel.com with ESMTP; 19 Jan 2019 08:21:52 -0800
Received: from andy by smile with local (Exim 4.92-RC4)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gktNY-0002Kq-76; Sat, 19 Jan 2019 18:21:52 +0200
Date:   Sat, 19 Jan 2019 18:21:52 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     Jose Abreu <jose.abreu@synopsys.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Joao Pinto <joao.pinto@synopsys.com>,
        Luis de Oliveira <luis.oliveira@synopsys.com>,
        Vitor Soares <vitor.soares@synopsys.com>,
        Nelson Costa <nelson.costa@synopsys.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>
Subject: Re: [RFC v3 1/7] dmaengine: Add Synopsys eDMA IP core driver
Message-ID: <20190119162152.GE9170@smile.fi.intel.com>
References: <cover.1547230339.git.gustavo.pimentel@synopsys.com>
 <d2b6e8bed0c5077425b913e551794ed126d74fb2.1547230339.git.gustavo.pimentel@synopsys.com>
 <e374b2fe-23bd-0bc5-be17-abced19bb4f7@synopsys.com>
 <c28eb503-d17f-5551-a03d-55dad36d0494@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c28eb503-d17f-5551-a03d-55dad36d0494@synopsys.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 16, 2019 at 11:53:00AM +0000, Gustavo Pimentel wrote:
> On 16/01/2019 10:21, Jose Abreu wrote:
> > On 1/11/2019 6:33 PM, Gustavo Pimentel wrote:

> >> +	/* Free irqs */
> > 
> > But devm will automatically free it, no ?
> 
> Yes, it shouldn't be there. I'll remove it.

It depends. If the driver is using tasklets it must free it explicitly like this.

P.S. devm_*_irq() is quite doubtful to have in the first place.
	
-- 
With Best Regards,
Andy Shevchenko


