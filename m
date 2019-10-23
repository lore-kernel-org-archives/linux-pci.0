Return-Path: <SRS0=O4f2=YQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA2FCA9EB6
	for <linux-pci@archiver.kernel.org>; Wed, 23 Oct 2019 09:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD6D7205C9
	for <linux-pci@archiver.kernel.org>; Wed, 23 Oct 2019 09:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390380AbfJWJp1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 23 Oct 2019 05:45:27 -0400
Received: from mga18.intel.com ([134.134.136.126]:4809 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390165AbfJWJp1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Oct 2019 05:45:27 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 02:45:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,220,1569308400"; 
   d="scan'208";a="209890269"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 23 Oct 2019 02:45:23 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 23 Oct 2019 12:45:22 +0300
Date:   Wed, 23 Oct 2019 12:45:22 +0300
From:   "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>
Subject: Re: [PATCH 0/1] Add support for setting MMIO PREF hotplug bridge size
Message-ID: <20191023094522.GT2819@lahna.fi.intel.com>
References: <PSXP216MB01832E0DD8892B52A3FA2589806B0@PSXP216MB0183.KORP216.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PSXP216MB01832E0DD8892B52A3FA2589806B0@PSXP216MB0183.KORP216.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 23, 2019 at 08:36:59AM +0000, Nicholas Johnson wrote:
> This patch adds support for two new kernel parameters. This patch has
> been in the making for quite some time, and has changed several times
> based on feedback.
> 
> I realised I was making the mistake of putting it as part of my
> Thunderbolt patch series. Although the other patches in the series are
> very important for my goal, I realised that they are just a heap of
> patches that are not Thunderbolt-specific. The only thing that is
> Thunderbolt-related is the intended use case.
> 
> I hope that posting this alone can ease the difficulty of reviewing it.
> 
> Nicholas Johnson (1):
>   PCI: Add hp_mmio_size and hp_mmio_pref_size parameters
> 
>  .../admin-guide/kernel-parameters.txt         |  9 ++++++-
>  drivers/pci/pci.c                             | 17 ++++++++++---
>  drivers/pci/pci.h                             |  3 ++-
>  drivers/pci/setup-bus.c                       | 25 +++++++++++--------
>  4 files changed, 38 insertions(+), 16 deletions(-)

If you want to add cover letter in the "normal way" so that threading is
preserved you can do something like 'git format-patch --cover-letter ...',
then edit the 0000-...patch and send it along with the other patches
using git send-email.
