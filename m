Return-Path: <SRS0=kgfr=QU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E161C282C2
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 18:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05D35222CF
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 18:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389467AbfBMSKr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:10:47 -0500
Received: from mga11.intel.com ([192.55.52.93]:42827 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727937AbfBMSKr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Feb 2019 13:10:47 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2019 10:10:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,366,1544515200"; 
   d="scan'208";a="126202694"
Received: from araj-mobl1.jf.intel.com ([10.7.201.26])
  by orsmga003.jf.intel.com with ESMTP; 13 Feb 2019 10:10:46 -0800
Date:   Wed, 13 Feb 2019 10:10:46 -0800
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Busch, Keith" <keith.busch@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>
Subject: Re: [PATCH v2 2/2] iommu/vt-d: Enable PASID only if device expects
 PASID  in PRG Response.
Message-ID: <20190213181046.GA16999@araj-mobl1.jf.intel.com>
References: <cover.1549915780.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <787d13ae22ae07c708b06180241f4f2b71031f84.1549915780.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19C93AD90@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19C93AD90@SHSMSX104.ccr.corp.intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 13, 2019 at 12:26:33AM -0800, Tian, Kevin wrote:
> > 
> > diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> > index 1457f931218e..af2e4a011787 100644
> > --- a/drivers/iommu/intel-iommu.c
> > +++ b/drivers/iommu/intel-iommu.c
> > @@ -1399,7 +1399,8 @@ static void iommu_enable_dev_iotlb(struct
> > device_domain_info *info)
> >  	   undefined. So always enable PASID support on devices which
> >  	   have it, even if we can't yet know if we're ever going to
> >  	   use it. */
> > -	if (info->pasid_supported && !pci_enable_pasid(pdev, info-
> > >pasid_supported & ~1))
> > +	if (info->pasid_supported && pci_prg_resp_pasid_required(pdev)
> > &&
> > +	    !pci_enable_pasid(pdev, info->pasid_supported & ~1))
> >  		info->pasid_enabled = 1;
> 
> Above logic looks problematic. As Dave commented in another thread,
> PRI and PASID are orthogonal capabilities. Especially with introduction
> of VT-d scalable mode, PASID will be used alone even w/o PRI...
> 
> Why not doing the check when PRI is actually enabled? At that point
> you can fail the request if above condition is false. 
> 

That makes sense. 
