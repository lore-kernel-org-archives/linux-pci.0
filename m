Return-Path: <SRS0=Ym/o=Y5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5641BC17461
	for <linux-pci@archiver.kernel.org>; Tue,  5 Nov 2019 13:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 379C1222C2
	for <linux-pci@archiver.kernel.org>; Tue,  5 Nov 2019 13:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388454AbfKENCZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 5 Nov 2019 08:02:25 -0500
Received: from mga05.intel.com ([192.55.52.43]:14644 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388008AbfKENCZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Nov 2019 08:02:25 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2019 05:02:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,271,1569308400"; 
   d="scan'208";a="212537047"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 05 Nov 2019 05:02:22 -0800
Received: by lahna (sSMTP sendmail emulation); Tue, 05 Nov 2019 15:02:21 +0200
Date:   Tue, 5 Nov 2019 15:02:21 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 0/5] PCI: PM: Cleanups related to power state changes
Message-ID: <20191105130221.GX2552@lahna.fi.intel.com>
References: <2771503.n70vfTtcVb@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2771503.n70vfTtcVb@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 05, 2019 at 11:11:57AM +0100, Rafael J. Wysocki wrote:
> Hi,
> 
> This series rearranges some PCI power management code to make it somewhat
> easier to follow and explicitly consolidate the power-up (transitions to
> D0) code path.
> 
> It is not intended to change the functionality of the code.

The whole series looks good to me,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
