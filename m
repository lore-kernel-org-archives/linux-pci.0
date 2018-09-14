Return-Path: <SRS0=PQBU=L4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3B3FC6182
	for <linux-pci@archiver.kernel.org>; Fri, 14 Sep 2018 08:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 881322147E
	for <linux-pci@archiver.kernel.org>; Fri, 14 Sep 2018 08:07:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 881322147E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbeINNU0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 14 Sep 2018 09:20:26 -0400
Received: from mga02.intel.com ([134.134.136.20]:17390 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727804AbeINNU0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Sep 2018 09:20:26 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Sep 2018 01:06:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,372,1531810800"; 
   d="scan'208";a="262552993"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga005.fm.intel.com with SMTP; 14 Sep 2018 01:06:22 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 14 Sep 2018 11:06:21 +0300
Date:   Fri, 14 Sep 2018 11:06:21 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sakari Ailus <sakari.ailus@iki.fi>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 01/10] PCI: Do not skip power managed bridges in
 pci_enable_wake()
Message-ID: <20180914080621.GT14465@lahna.fi.intel.com>
References: <20180913143322.77953-1-mika.westerberg@linux.intel.com>
 <20180913143322.77953-2-mika.westerberg@linux.intel.com>
 <153688100.j3IOAyprJL@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153688100.j3IOAyprJL@aspire.rjw.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
Message-ID: <20180914080621.OEaVk1rYYgilJvN5p1N4rb_Qp9ir3C1Xwgra2lClC-o@z>

On Thu, Sep 13, 2018 at 04:33:39PM +0200, Rafael J. Wysocki wrote:
> On Thursday, September 13, 2018 4:33:13 PM CEST Mika Westerberg wrote:
> > Commit baecc470d5fd ("PCI / PM: Skip bridges in pci_enable_wake()")
> > changed pci_enable_wake() so that all bridges are skipped when wakeup is
> > enabled (or disabled) with the reasoning that bridges can only signal
> > wakeup on behalf of their subordinate devices.
> > 
> > However, there are bridges that can signal wakeup itself. For example
> > PCIe downstream and root ports supporting hotplug may signal wakeup upon
> > hotplug event.
> > 
> > For this reason change pci_enable_wake() so that it skips all bridges
> > except those that we power manage (->bridge_d3 is set). Those are the
> > ones that can go into low power states and may need to signal wakeup.
> > 
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> >  drivers/pci/pci.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 29ff9619b5fa..1af6f1887986 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -2133,10 +2133,13 @@ static int __pci_enable_wake(struct pci_dev *dev, pci_power_t state, bool enable
> >  	int ret = 0;
> >  
> >  	/*
> > -	 * Bridges can only signal wakeup on behalf of subordinate devices,
> > -	 * but that is set up elsewhere, so skip them.
> > +	 * Bridges that are not power-manageable directly only signal
> > +	 * wakeup on behalf of subordinate devices which is set up
> > +	 * elsewhere, so skip them. However, bridges that are
> > +	 * power-manageable may signal wakeup for themselves (for example,
> > +	 * on a hotplug event) and they need to be covered here.
> >  	 */
> > -	if (pci_has_subordinate(dev))
> > +	if (!pci_power_manageable(dev))
> >  		return 0;
> >  
> >  	/* Don't do the same thing twice in a row for one device. */
> > 
> 
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thanks!

For some reason this patch never hit the mailing lists (others did).
Since you kept the whole context people should still be able to review
it. I can resend this patch as well.
