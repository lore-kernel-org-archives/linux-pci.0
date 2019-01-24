Return-Path: <SRS0=Sdll=QA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CFDC282C3
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 13:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08384218A2
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 13:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbfAXNoa (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 24 Jan 2019 08:44:30 -0500
Received: from mga18.intel.com ([134.134.136.126]:52919 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727556AbfAXNoa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Jan 2019 08:44:30 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jan 2019 05:44:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,516,1539673200"; 
   d="scan'208";a="314464052"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga005.fm.intel.com with SMTP; 24 Jan 2019 05:44:26 -0800
Received: by lahna (sSMTP sendmail emulation); Thu, 24 Jan 2019 15:44:26 +0200
Date:   Thu, 24 Jan 2019 15:44:26 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kedar A Dongre <kedar.a.dongre@intel.com>,
        Peter Wu <peter@lekensteyn.nl>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3] PCI: Blacklist power management of Gigabyte X299
 DESIGNARE EX PCIe ports
Message-ID: <20190124134426.GN14577@lahna.fi.intel.com>
References: <20190124131227.45612-1-mika.westerberg@linux.intel.com>
 <20190124132542.wqofwg7bswnn5g3j@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124132542.wqofwg7bswnn5g3j@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 24, 2019 at 02:25:42PM +0100, Lukas Wunner wrote:
> On Thu, Jan 24, 2019 at 04:12:27PM +0300, Mika Westerberg wrote:
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -2501,6 +2501,23 @@ void pci_config_pm_runtime_put(struct pci_dev *pdev)
> >  		pm_runtime_put_sync(parent);
> >  }
> >  
> > +static const struct dmi_system_id bridge_d3_blacklist[] = {
> > +	{
> > +		/*
> > +		 * Gigabyte X299 root port is not marked as hotplug
> > +		 * capable which allows Linux to power manage it.
> > +		 * However, this confuses the BIOS SMI handler so don't
> > +		 * power manage root ports on that system.
> > +		 */
> > +		.ident = "X299 DESIGNARE EX-CF",
> > +		.matches = {
> > +			DMI_MATCH(DMI_BOARD_VENDOR, "Gigabyte Technology Co., Ltd."),
> > +			DMI_MATCH(DMI_BOARD_NAME, "X299 DESIGNARE EX-CF"),
> > +		},
> > +	},
> > +	{ }
> > +};
> 
> Unfortunately this doesn't take my comment voiced Jan 8 into account:
> 
>    "Please constrain either the blacklist entry for the Gigabyte mainboard
>     or the blacklist check itself to x86 using IS_ENABLED() or #ifdef to
>     avoid code bloat on other arches."
>     https://patchwork.kernel.org/patch/10750549/#22408911

I tried to take it into account based on what you said:

  Please constrain either the blacklist entry for the Gigabyte mainboard

so I constrained it to Gigabyte motherboard using DMI entry. Maybe I
misunderstood you. Sorry about that.

> Note that CONFIG_DMI may be enabled on arm64 and ia64 which have no use
> for this quirk.  It's generally undesirable to have arch-specific quirks
> in generic code and folks running Linux on memory-constrained mips routers
> have complained before that quirks.c contains too much code unrelated to
> their arch.

I understand that but you end up with code looking as ugly as this:

  if (IS_ENABLED(CONFIG_X86) && dmi_check_system(bridge_d3_blacklist))
  	return false;

just to save a function call and and couple of bytes from kernel data. I
would rather prefer readability in this case. But no problem doing the
above if that's the way Bjorn likes to have it.
