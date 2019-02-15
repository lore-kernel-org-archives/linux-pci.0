Return-Path: <SRS0=N/Da=QW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32035C10F06
	for <linux-pci@archiver.kernel.org>; Fri, 15 Feb 2019 09:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91C8A222F2
	for <linux-pci@archiver.kernel.org>; Fri, 15 Feb 2019 09:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392933AbfBOJiY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:38:24 -0500
Received: from mga01.intel.com ([192.55.52.88]:20949 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392843AbfBOJiY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 15 Feb 2019 04:38:24 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Feb 2019 01:38:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,372,1544515200"; 
   d="scan'208";a="144515891"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga004.fm.intel.com with SMTP; 15 Feb 2019 01:38:20 -0800
Received: by lahna (sSMTP sendmail emulation); Fri, 15 Feb 2019 11:38:20 +0200
Date:   Fri, 15 Feb 2019 11:38:20 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lukas Wunner <lukas@wunner.de>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] PCI: Fix runtime PME generation from D3hot
Message-ID: <20190215093820.GK2322@lahna.fi.intel.com>
References: <20190131170746.7604-1-mika.westerberg@linux.intel.com>
 <20190214212619.GO96272@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214212619.GO96272@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 14, 2019 at 03:26:19PM -0600, Bjorn Helgaas wrote:
> On Thu, Jan 31, 2019 at 08:07:44PM +0300, Mika Westerberg wrote:
> > Hi all,
> > 
> > Heiner reported [1] that runtime PME generation of his network card does
> > not work after commit 0e157e528604 ("PCI/PME: Implement runtime PM
> > callbacks") that landed in v4.20. Reverting the commit helps but it has
> > another drawback, which I originally tried to solve with the commit, that
> > the PCIe hierarchy wakes up immediately after being put into D3cold.
> > 
> > This series of two patches tries to fix both issues so that PME wakes up
> > from D3hot and that the hierarchy does not wake up immediately from D3cold.
> > 
> > The previous version of the series can be found here:
> > 
> >   https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1892241.html
> > 
> > Changes from the previous version:
> > 
> >   * Add tags from Heiner and Rafael
> >   * Update changelog to mention relevent PCIe spec sections
> >   * Add comment to pcie_disable_interrupt() explaining why and what is
> >     masked
> > 
> > [1] https://www.spinics.net/lists/linux-pci/msg79051.html
> > 
> > Mika Westerberg (2):
> >   Revert "PCI/PME: Implement runtime PM callbacks"
> >   PCI: pciehp: Disable Data Link Layer State Changed event on suspend
> 
> I tentatively applied these to pci/pm for v5.1.

Thanks!

> I suspect these should be marked for stable (v4.20+)?

Yes, I think it makes sense.

> I don't think the bugzilla in the second patch is directly relevant to
> that patch.  I'd like to update the patch with a more relevant
> bugzilla if you have or can open one?

I created a new one and included the link in my reply to the other
patch.
