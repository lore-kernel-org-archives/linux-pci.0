Return-Path: <SRS0=HN6g=PX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FCEC43387
	for <linux-pci@archiver.kernel.org>; Tue, 15 Jan 2019 05:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E29020656
	for <linux-pci@archiver.kernel.org>; Tue, 15 Jan 2019 05:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbfAOFoF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 15 Jan 2019 00:44:05 -0500
Received: from mga06.intel.com ([134.134.136.31]:36166 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727211AbfAOFoF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Jan 2019 00:44:05 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2019 21:44:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,480,1539673200"; 
   d="scan'208";a="108303389"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga006.jf.intel.com with ESMTP; 14 Jan 2019 21:44:00 -0800
Received: from andy by smile with local (Exim 4.92-RC4)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gjHW3-0000d6-07; Tue, 15 Jan 2019 07:43:59 +0200
Date:   Tue, 15 Jan 2019 07:43:58 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joao Pinto <joao.pinto@synopsys.com>,
        Jose Abreu <jose.abreu@synopsys.com>,
        Luis Oliveira <luis.oliveira@synopsys.com>,
        Vitor Soares <vitor.soares@synopsys.com>,
        Nelson Costa <nelson.costa@synopsys.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>
Subject: Re: [RFC v3 5/7] dmaengine: Add Synopsys eDMA IP PCIe glue-logic
Message-ID: <20190115054358.GB9170@smile.fi.intel.com>
References: <cover.1547230339.git.gustavo.pimentel@synopsys.com>
 <a70d096e96f34cd9ea773da519965076d74d12ec.1547230339.git.gustavo.pimentel@synopsys.com>
 <20190111194705.GU9170@smile.fi.intel.com>
 <916f319b-9e45-6d78-4ecc-850feda84bb3@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <916f319b-9e45-6d78-4ecc-850feda84bb3@synopsys.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 14, 2019 at 11:38:02AM +0000, Gustavo Pimentel wrote:
> On 11/01/2019 19:47, Andy Shevchenko wrote:
> > On Fri, Jan 11, 2019 at 07:33:41PM +0100, Gustavo Pimentel wrote:

> >> +static bool disable_msix;
> >> +module_param(disable_msix, bool, 0644);
> >> +MODULE_PARM_DESC(disable_msix, "Disable MSI-X interrupts");
> > 
> > Why?!
> > We are no allow new module parameters without very strong arguments.
> 
> Since this is a reference driver and might be used to test customized HW
> solutions, I added this parameter to allow the possibility to test the solution
> forcing the MSI feature binding. This is required specially if who will test
> this solution has a Root Complex with both features available (MSI and MSI-X),
> because the Kernel will give always preference to MSI-X binding (assuming that
> the EP has also both features available).

Yes, you may do it for testing purposes, but it doesn't fit the kernel standards.

> >> +	if (!pdata) {
> >> +		dev_err(dev, "%s missing data structure\n", pci_name(pdev));
> >> +		return -EFAULT;
> >> +	}
> > 
> > Useless check.
> 
> Why? It's just a precaution, isn't it a good practice always to think of the
> worst case?

You just can put an implicit requirement of pdata rather than doing this
useless check. I don't believe it would make sense to have NULL pdata for the
driver since it wouldn't be functional anyhow.

> >> +	/* Mapping PCI BAR regions */
> >> +	err = pcim_iomap_regions(pdev, BIT(pdata->rg_bar) |
> >> +				       BIT(pdata->ll_bar) |
> >> +				       BIT(pdata->dt_bar),
> >> +				 pci_name(pdev));
> >> +	if (err) {

> >> +		return err;
> >> +	}

> >> +	if (!pcim_iomap_table(pdev))
> >> +		return -EACCES;
> > 
> > Never happen condition. Thus useless.
> 
> pcim_iomap_table() can return NULL in case of allocation failure. Besides that,
> isn't it a good practice always to think of the worst case?

No, it can't in the conditions your have in the code. See above the lines I left.
If pcim_iomap_regions() successfully finished...

> >> +	dev_info(dev, "DesignWare eDMA PCIe driver loaded completely\n");
> > 
> > Useless.
> 
> It's helpful for bring up, I can pass it to dbg.

It just shows that someone didn't use existing tools and features. This message and similar are useless.
Hint: initcall_debug.

> >> +	dev_info(dev, "DesignWare eDMA PCIe driver unloaded completely\n");
> > 
> > Ditto.
> 
> It's helpful for bring up, I can pass it to dbg.

Ditto.

-- 
With Best Regards,
Andy Shevchenko


