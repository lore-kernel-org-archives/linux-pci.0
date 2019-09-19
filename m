Return-Path: <SRS0=ZNYH=XO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEEAC49ED7
	for <linux-pci@archiver.kernel.org>; Thu, 19 Sep 2019 06:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 841EA21848
	for <linux-pci@archiver.kernel.org>; Thu, 19 Sep 2019 06:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387872AbfISGpq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 19 Sep 2019 02:45:46 -0400
Received: from mga02.intel.com ([134.134.136.20]:21861 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387869AbfISGpq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Sep 2019 02:45:46 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2019 23:45:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,522,1559545200"; 
   d="scan'208";a="202224618"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 18 Sep 2019 23:45:41 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 19 Sep 2019 09:45:41 +0300
Date:   Thu, 19 Sep 2019 09:45:40 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Use minimum window alignment when calculating
 memory window size
Message-ID: <20190919064540.GC28281@lahna.fi.intel.com>
References: <20190812144144.2646-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812144144.2646-1-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 12, 2019 at 05:41:44PM +0300, Mika Westerberg wrote:
> There is an issue in Linux PCI resource allocation that if we remove an
> existing device that was initially configured by the BIOS and then issue
> rescan, it will not fit in to the memory space allocated by the BIOS
> even if it originally it fit there just fine.

Any comments on this?
