Return-Path: <SRS0=fcTa=YO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9D8CA9EAF
	for <linux-pci@archiver.kernel.org>; Mon, 21 Oct 2019 13:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 383A52166E
	for <linux-pci@archiver.kernel.org>; Mon, 21 Oct 2019 13:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbfJUNiU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 21 Oct 2019 09:38:20 -0400
Received: from mga01.intel.com ([192.55.52.88]:42893 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728812AbfJUNiU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Oct 2019 09:38:20 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Oct 2019 06:38:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,323,1566889200"; 
   d="scan'208";a="209445645"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 21 Oct 2019 06:38:15 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 21 Oct 2019 16:38:14 +0300
Date:   Mon, 21 Oct 2019 16:38:14 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Stuart Hayes <stuart.w.hayes@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Austin Bolen <austin_bolen@dell.com>, keith.busch@intel.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, lukas@wunner.de
Subject: Re: [PATCH v3 1/3] PCI: pciehp: Add support for disabling in-band
 presence
Message-ID: <20191021133814.GJ2819@lahna.fi.intel.com>
References: <20191017193256.3636-1-stuart.w.hayes@gmail.com>
 <20191017193256.3636-2-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017193256.3636-2-stuart.w.hayes@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 17, 2019 at 03:32:54PM -0400, Stuart Hayes wrote:
> From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> 
> The presence detect state (PDS) is normally a logical or of in-band and
> out-of-band presence. As of PCIe 4.0, there is the option to disable
> in-band presence so that the PDS bit always reflects the state of the
> out-of-band presence.
> 
> The recommendation of the PCIe spec is to disable in-band presence
> whenever supported.
> 
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
