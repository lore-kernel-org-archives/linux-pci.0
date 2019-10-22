Return-Path: <SRS0=T8Fm=YP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93C3CA9EA0
	for <linux-pci@archiver.kernel.org>; Tue, 22 Oct 2019 09:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B4A820B7C
	for <linux-pci@archiver.kernel.org>; Tue, 22 Oct 2019 09:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731533AbfJVJmi (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 22 Oct 2019 05:42:38 -0400
Received: from mga17.intel.com ([192.55.52.151]:5823 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731469AbfJVJmh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Oct 2019 05:42:37 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2019 02:42:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,326,1566889200"; 
   d="scan'208";a="209636379"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 22 Oct 2019 02:42:33 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 22 Oct 2019 12:42:32 +0300
Date:   Tue, 22 Oct 2019 12:42:32 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Alex G." <mr.nuke.me@gmail.com>
Cc:     Stuart Hayes <stuart.w.hayes@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Austin Bolen <austin_bolen@dell.com>, keith.busch@intel.com,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, lukas@wunner.de
Subject: Re: [PATCH v3 3/3] PCI: pciehp: Add dmi table for in-band presence
 disabled
Message-ID: <20191022094232.GE2819@lahna.fi.intel.com>
References: <20191017193256.3636-1-stuart.w.hayes@gmail.com>
 <20191017193256.3636-4-stuart.w.hayes@gmail.com>
 <20191021134729.GL2819@lahna.fi.intel.com>
 <f4ace3ab-1b39-8a82-4cb6-a7a5d3bfbc72@gmail.com>
 <d41c69c6-fa7b-d271-95e0-bf6e51b981ec@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d41c69c6-fa7b-d271-95e0-bf6e51b981ec@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 21, 2019 at 07:13:32PM -0500, Alex G. wrote:
> I think it's clearer if this is explained in a comment. That it doesn't
> break anything, and we're okay this applies to all hotplug ports, even those
> that are not in front of an NVMe backplane.

I agree.
