Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09EEC4338F
	for <linux-pci@archiver.kernel.org>; Mon,  2 Aug 2021 15:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA82D610A0
	for <linux-pci@archiver.kernel.org>; Mon,  2 Aug 2021 15:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234401AbhHBPLB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 2 Aug 2021 11:11:01 -0400
Received: from mga07.intel.com ([134.134.136.100]:15468 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233976AbhHBPLB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Aug 2021 11:11:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10064"; a="277240914"
X-IronPort-AV: E=Sophos;i="5.84,289,1620716400"; 
   d="scan'208";a="277240914"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 08:10:51 -0700
X-IronPort-AV: E=Sophos;i="5.84,289,1620716400"; 
   d="scan'208";a="466330039"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 08:10:47 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 02 Aug 2021 18:10:45 +0300
Date:   Mon, 2 Aug 2021 18:10:45 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Sanjay R Mehta <Sanju.Mehta@amd.com>
Cc:     andreas.noever@gmail.com, michael.jamet@intel.com,
        bhelgaas@google.com, YehezkelShB@gmail.com,
        Basavaraj.Natikar@amd.com, linux-usb@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/4] Add support for AMD USB4 and bug fixes
Message-ID: <YQgK9fQoI35P0yLf@lahna>
References: <1627909100-83338-1-git-send-email-Sanju.Mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1627909100-83338-1-git-send-email-Sanju.Mehta@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Sanjay,

On Mon, Aug 02, 2021 at 07:58:16AM -0500, Sanjay R Mehta wrote:
> From: Sanjay R Mehta <sanju.mehta@amd.com>
> 
> This series adds support for AMD USB4 host router and
> some general USB4 bug fixes.

Nice to see AMD support being added! :) I have few comments on the
series. I'll comment on the separate patches.

In general looks already good.

> 
> Sanjay R Mehta (4):
>   PCI: Add AMD USB4 host router device IDs
>   thunderbolt: Handle INTR when Disable ISR auto clear bit set
>   thunderbolt: Fix adapter init handling during switch add
>   thunderbolt: Fix port linking by checking all adapters
> 
>  drivers/thunderbolt/nhi.c    | 30 +++++++++++++++++++++++++++++-
>  drivers/thunderbolt/switch.c |  5 +++--
>  include/linux/pci_ids.h      |  2 ++
>  include/linux/thunderbolt.h  |  1 +
>  4 files changed, 35 insertions(+), 3 deletions(-)
> 
> -- 
> 2.7.4
