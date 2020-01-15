Return-Path: <SRS0=Q3uD=3E=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E63C3F68F
	for <linux-pci@archiver.kernel.org>; Wed, 15 Jan 2020 14:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAAF92084D
	for <linux-pci@archiver.kernel.org>; Wed, 15 Jan 2020 14:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgAOO7i (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 15 Jan 2020 09:59:38 -0500
Received: from mga05.intel.com ([192.55.52.43]:48716 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726132AbgAOO7i (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Jan 2020 09:59:38 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jan 2020 06:59:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,322,1574150400"; 
   d="scan'208";a="253846045"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 15 Jan 2020 06:59:35 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 15 Jan 2020 16:59:34 +0200
Date:   Wed, 15 Jan 2020 16:59:34 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v1 4/4] PCI: Allow extend_bridge_window() to shrink
 resource if necessary
Message-ID: <20200115145934.GJ2838@lahna.fi.intel.com>
References: <PSXP216MB0438D3E2CFE64EBAA32AF691803C0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <20200107203435.GA137091@google.com>
 <PSXP216MB043869924730BFD3AA97B0A0803E0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <20200113162150.GO2838@lahna.fi.intel.com>
 <PSXP216MB043899E598E11CF7D4D9214380370@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PSXP216MB043899E598E11CF7D4D9214380370@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 15, 2020 at 02:51:02PM +0000, Nicholas Johnson wrote:
> Sorry, I was not meant to say you were not interested in getting it as 
> good as possible. At the time, you had a goal to achieve (which you did) 
> and at that point in time, it would not have been feasible to use 
> pci=hpmemsize or similar before my patches were applied:
> 
>   c13704f5685d ("PCI: Avoid double hpmemsize MMIO window assignment")
>   d7b8a217521c ("PCI: Add "pci=hpmmiosize" and "pci=hpmmioprefsize" parameters")
> 
> What I was trying to say was not that you were not interested, but more 
> that it was not a primary motivation for you at the time. Does this 
> sound more accurate? Poor wording on my behalf.

Yes, it does and no worries :-) Just wanted to clarify that one.
