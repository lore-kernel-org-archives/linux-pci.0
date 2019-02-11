Return-Path: <SRS0=XN0A=QS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79E3C169C4
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 19:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCFA72229F
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 19:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730267AbfBKTPw (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:15:52 -0500
Received: from mga03.intel.com ([134.134.136.65]:3980 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729130AbfBKTPv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Feb 2019 14:15:51 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2019 11:15:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,359,1544515200"; 
   d="scan'208";a="145967949"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.48])
  by fmsmga001.fm.intel.com with ESMTP; 11 Feb 2019 11:15:50 -0800
Date:   Mon, 11 Feb 2019 11:15:50 -0800
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Sinan Kaya <Okaya@kernel.org>
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, bhelgaas@google.com,
        joro@8bytes.org, dwmw2@infradead.org, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v1 1/2] PCI: ATS: Add function to check ATS page aligned
 request status.
Message-ID: <20190211191549.GA12090@otc-nc-03>
References: <cover.1549478584.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <91bfae8b1d4b424219e3ce3c1fc03559c73f1ae7.1549478584.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <5d55e369-355f-b710-0594-03465aa985da@kernel.org>
 <a5a29eee-2e33-ba0c-67a6-69983fd0796d@linux.intel.com>
 <32ec3293-28ea-8f0f-f801-0370b4cf0453@kernel.org>
 <351a1a1d-2517-5021-e7cd-99d700e17f4c@linux.intel.com>
 <815f2621-fc28-bff4-c300-cce7514cfe71@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <815f2621-fc28-bff4-c300-cce7514cfe71@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 08, 2019 at 11:49:55PM -0500, Sinan Kaya wrote:
> On 2/8/2019 8:02 PM, sathyanarayanan kuppuswamy wrote:
> >>This means that you should probably have some kind of version check
> >>here.
> >
> >There is no version field in ATS v1.0 spec. Also, If I follow the history
> >log in PCI spec, I think ATS if first added at v1.2. Please correct me if
> >I am wrong.
> 
> v1.2 was incorporated into PCIe spec at that time. However, the ATS spec
> is old and there could be some HW that could claim to be ATS compatible.
> I know AMD GPUs declare ATS capability.

It seems rather odd we have to check for ATS version.

I always assumed unspecified bits (Reserved) must be 0. We only check
this if ATS is enabled, and this particular bit wasn't given away for another
feature.

Is it really required to check for ATS version before consuming this?


> 
> See this ECN
> 
> https://composter.com.ua/documents/ats_r1.1_26Jan09.pdf
> 
> You need to validate the version field from ATS capability header to be
> 1 before reading this register.
> 
> See Table 5-1:  ATS Extended Capability Header
