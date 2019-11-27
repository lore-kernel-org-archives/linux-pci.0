Return-Path: <SRS0=kckM=ZT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A7DC43141
	for <linux-pci@archiver.kernel.org>; Wed, 27 Nov 2019 11:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6F7720722
	for <linux-pci@archiver.kernel.org>; Wed, 27 Nov 2019 11:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfK0LuO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 27 Nov 2019 06:50:14 -0500
Received: from mga14.intel.com ([192.55.52.115]:6425 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbfK0LuO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 Nov 2019 06:50:14 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2019 03:50:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,249,1571727600"; 
   d="scan'208";a="217370860"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 27 Nov 2019 03:50:11 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 27 Nov 2019 13:50:10 +0200
Date:   Wed, 27 Nov 2019 13:50:10 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Daniel Drake <drake@endlessm.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        rafael.j.wysocki@intel.com, linux@endlessm.com,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: add generic quirk function for increasing
 D3hot delay
Message-ID: <20191127115010.GA11621@lahna.fi.intel.com>
References: <20191127053836.31624-1-drake@endlessm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191127053836.31624-1-drake@endlessm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 27, 2019 at 01:38:35PM +0800, Daniel Drake wrote:
> Separate the D3 delay increase functionality out of quirk_radeon_pm() into
> its own function so that it can be shared with other quirks, including
> the AMD Ryzen XHCI quirk that will be introduced in a followup commit.
> 
> Tweak the function name and message to indicate more clearly that the
> delay relates to a D3hot-to-D0 transition.
> 
> Signed-off-by: Daniel Drake <drake@endlessm.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
