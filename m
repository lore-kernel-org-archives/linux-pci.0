Return-Path: <SRS0=pnr2=P3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB7F8C61CE4
	for <linux-pci@archiver.kernel.org>; Sat, 19 Jan 2019 15:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A19E52054F
	for <linux-pci@archiver.kernel.org>; Sat, 19 Jan 2019 15:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbfASPp2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 19 Jan 2019 10:45:28 -0500
Received: from mga06.intel.com ([134.134.136.31]:54463 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728260AbfASPp1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 19 Jan 2019 10:45:27 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jan 2019 07:45:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,496,1539673200"; 
   d="scan'208";a="115928429"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga007.fm.intel.com with ESMTP; 19 Jan 2019 07:45:23 -0800
Received: from andy by smile with local (Exim 4.92-RC4)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gksoE-00022K-B5; Sat, 19 Jan 2019 17:45:22 +0200
Date:   Sat, 19 Jan 2019 17:45:22 +0200
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
Message-ID: <20190119154522.GD9170@smile.fi.intel.com>
References: <cover.1547230339.git.gustavo.pimentel@synopsys.com>
 <a70d096e96f34cd9ea773da519965076d74d12ec.1547230339.git.gustavo.pimentel@synopsys.com>
 <20190111194705.GU9170@smile.fi.intel.com>
 <916f319b-9e45-6d78-4ecc-850feda84bb3@synopsys.com>
 <20190115054358.GB9170@smile.fi.intel.com>
 <9b887e39-9de3-2285-f3b4-174a72e6c4d3@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b887e39-9de3-2285-f3b4-174a72e6c4d3@synopsys.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 15, 2019 at 12:48:34PM +0000, Gustavo Pimentel wrote:
> On 15/01/2019 05:43, Andy Shevchenko wrote:
> > On Mon, Jan 14, 2019 at 11:38:02AM +0000, Gustavo Pimentel wrote:
> >> On 11/01/2019 19:47, Andy Shevchenko wrote:
> >>> On Fri, Jan 11, 2019 at 07:33:41PM +0100, Gustavo Pimentel wrote:

> >>>> +static bool disable_msix;
> >>>> +module_param(disable_msix, bool, 0644);
> >>>> +MODULE_PARM_DESC(disable_msix, "Disable MSI-X interrupts");
> >>>
> >>> Why?!
> >>> We are no allow new module parameters without very strong arguments.
> >>
> >> Since this is a reference driver and might be used to test customized HW
> >> solutions, I added this parameter to allow the possibility to test the solution
> >> forcing the MSI feature binding. This is required specially if who will test
> >> this solution has a Root Complex with both features available (MSI and MSI-X),
> >> because the Kernel will give always preference to MSI-X binding (assuming that
> >> the EP has also both features available).
> > 
> > Yes, you may do it for testing purposes, but it doesn't fit the kernel standards.
> 
> Ok, but how should I proceed? May I leave it or substitute by another way to do
> it? If so, how?
> As I said, the intended is to be only used for this test case, on normal
> operation the parameter it should be always false.

Keep out-of-tree patch for your needs.

> >>>> +	if (!pdata) {
> >>>> +		dev_err(dev, "%s missing data structure\n", pci_name(pdev));
> >>>> +		return -EFAULT;
> >>>> +	}
> >>>
> >>> Useless check.
> >>
> >> Why? It's just a precaution, isn't it a good practice always to think of the
> >> worst case?
> > 
> > You just can put an implicit requirement of pdata rather than doing this
> 
> Ok, how can I do it? What I should add to the code to force that?

Not adding, removing. That's what I put before.

> 
> > useless check. I don't believe it would make sense to have NULL pdata for the
> > driver since it wouldn't be functional anyhow.
> 
> Yes, you're right without pdata the driver can't do anything.

-- 
With Best Regards,
Andy Shevchenko


