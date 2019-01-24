Return-Path: <SRS0=Sdll=QA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52AFCC282C3
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 14:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27557218CD
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 14:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbfAXOR3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 24 Jan 2019 09:17:29 -0500
Received: from bmailout3.hostsharing.net ([176.9.242.62]:59477 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727596AbfAXOR3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Jan 2019 09:17:29 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id A0BE51019EC30;
        Thu, 24 Jan 2019 15:17:27 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 5312D495B; Thu, 24 Jan 2019 15:17:27 +0100 (CET)
Date:   Thu, 24 Jan 2019 15:17:27 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kedar A Dongre <kedar.a.dongre@intel.com>,
        Peter Wu <peter@lekensteyn.nl>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3] PCI: Blacklist power management of Gigabyte X299
 DESIGNARE EX PCIe ports
Message-ID: <20190124141727.22yy26pypwh5y5pl@wunner.de>
References: <20190124131227.45612-1-mika.westerberg@linux.intel.com>
 <20190124132542.wqofwg7bswnn5g3j@wunner.de>
 <20190124134426.GN14577@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124134426.GN14577@lahna.fi.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 24, 2019 at 03:44:26PM +0200, Mika Westerberg wrote:
> On Thu, Jan 24, 2019 at 02:25:42PM +0100, Lukas Wunner wrote:
> > On Thu, Jan 24, 2019 at 04:12:27PM +0300, Mika Westerberg wrote:
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -2501,6 +2501,23 @@ void pci_config_pm_runtime_put(struct pci_dev *pdev)
> > >  		pm_runtime_put_sync(parent);
> > >  }
> > >  
> > > +static const struct dmi_system_id bridge_d3_blacklist[] = {
> > > +	{
> > > +		/*
> > > +		 * Gigabyte X299 root port is not marked as hotplug
> > > +		 * capable which allows Linux to power manage it.
> > > +		 * However, this confuses the BIOS SMI handler so don't
> > > +		 * power manage root ports on that system.
> > > +		 */
> > > +		.ident = "X299 DESIGNARE EX-CF",
> > > +		.matches = {
> > > +			DMI_MATCH(DMI_BOARD_VENDOR, "Gigabyte Technology Co., Ltd."),
> > > +			DMI_MATCH(DMI_BOARD_NAME, "X299 DESIGNARE EX-CF"),
> > > +		},
> > > +	},
> > > +	{ }
> > > +};
> > 
> > Unfortunately this doesn't take my comment voiced Jan 8 into account:
> > 
> >    "Please constrain either the blacklist entry for the Gigabyte mainboard
> >     or the blacklist check itself to x86 using IS_ENABLED() or #ifdef to
> >     avoid code bloat on other arches."
> >     https://patchwork.kernel.org/patch/10750549/#22408911
> 
> I tried to take it into account based on what you said:
> 
>   Please constrain either the blacklist entry for the Gigabyte mainboard
> 
> so I constrained it to Gigabyte motherboard using DMI entry. Maybe I
> misunderstood you. Sorry about that.

What I meant is that you could encapsulate the struct dmi_system_id for
the Gigabyte mainboard in "#ifdef CONFIG_X86" / "#endif".


> > Note that CONFIG_DMI may be enabled on arm64 and ia64 which have no use
> > for this quirk.

The rationale for this sentence was that the compiler might be smart
enough to optimize bridge_d3_blacklist[] away if CONFIG_DMI is not
defined, but it might be defined on arm64 and ia64 so on those arches
you'd still be including an unnecessary DMI entry.

Granted those few bytes won't hurt, but people might come after you and
amend the blacklist, if the #ifdef is already in place they'll know to
add their entry within the #ifdef or add a new #ifdef if the quirk isn't
for x86, thus neatly keeping generic code free of arch-specific quirks.

Thanks,

Lukas
