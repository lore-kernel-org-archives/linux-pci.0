Return-Path: <SRS0=NAiA=3C=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151ABC33CAD
	for <linux-pci@archiver.kernel.org>; Mon, 13 Jan 2020 14:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E29D7207FD
	for <linux-pci@archiver.kernel.org>; Mon, 13 Jan 2020 14:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgAMOMQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 13 Jan 2020 09:12:16 -0500
Received: from mga18.intel.com ([134.134.136.126]:29775 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbgAMOMQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Jan 2020 09:12:16 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jan 2020 06:12:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,429,1571727600"; 
   d="scan'208";a="244326005"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 13 Jan 2020 06:12:12 -0800
Received: by lahna (sSMTP sendmail emulation); Mon, 13 Jan 2020 16:12:12 +0200
Date:   Mon, 13 Jan 2020 16:12:12 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v1 0/3] PCI: Fix failure to assign BARs with alignment
 >1M with Thunderbolt
Message-ID: <20200113141212.GH2838@lahna.fi.intel.com>
References: <PSXP216MB0438243F9C310CC98AF402F3803C0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PSXP216MB0438243F9C310CC98AF402F3803C0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Mon, Jan 06, 2020 at 03:45:09PM +0000, Nicholas Johnson wrote:
> This patch series is split from from [0] to make sign-off easier.
> 
> I have found a way to change the arguments of 
> pci_bus_distribute_available_resources() without making any functional 
> changes. I think it turned out very well. I hope everybody agrees.
> 
> I have tested and looked over for mistakes for several days, but there 
> could still be mistakes. I have also changed the commit messages and 
> might not be clear enough yet.
> 
> Best to get it out there and get feedback or it will never happen.
> 
> Removed Reviewed-by tags from Mika Westerberg because some things have 
> changed.

In future it would be nice to spell out what exactly was changed since
the previous version so I don't have to dig that out and figure it out
myself.

This time it's fine :)
