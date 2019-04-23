Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E114C10F03
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 21:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57D44218D3
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 21:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556056423;
	bh=rW28kVv4LMKUF1U2h3RljhEk45vJXhBHc011jZSd4w8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TgLDTJ7b0Zj4HRsPJFhohqimzOe9ZCiqNSWG3dUVPppfVS+sdlMg+xV/sVEqWQDFI
	 q7rDz3QiHm6ILfOvLG48bDwe/EZKocvZpCutGTtYR3hknwFj7T3B+YEsjNzDplSRx3
	 rfRIZHTs1U3NWZijHrZjXNjAxB6NxTEcrJVj3maU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfDWVxm (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 17:53:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:50520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726665AbfDWVxm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Apr 2019 17:53:42 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92A52218D2;
        Tue, 23 Apr 2019 21:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556056421;
        bh=rW28kVv4LMKUF1U2h3RljhEk45vJXhBHc011jZSd4w8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mqXq8xw+We3C5jl/WXUt/jRI2zzXr126kfPZxd3FWwqdRFpFgHWty8EMdSHU893El
         8/oyz1vOTTvHiuys56zxF/3p8NY5qaaWSi6hx9PXNDI1K+ccVcuTurakmTBU9XzdlI
         FEjuGHVYc+PV44AnpcmZqwaeKCFRS0hF+bX8yrvY=
Date:   Tue, 23 Apr 2019 16:53:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alexander Fomichev <fomichev.ru@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux@yadro.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Subject: Re: [PATCH RESEND] PCI: disable runtime PM for PLX switches
Message-ID: <20190423215340.GH14616@google.com>
References: <20190415135903.wiyw34faiezdnbbs@yadro.com>
 <20190415141554.GL126710@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415141554.GL126710@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Rafael, linux-pm]

On Mon, Apr 15, 2019 at 09:15:54AM -0500, Bjorn Helgaas wrote:
> This says it's a resend, but I don't see a previous posting; maybe it was
> HTML and rejected by the mailing list?
> 
> On Mon, Apr 15, 2019 at 04:59:03PM +0300, Alexander Fomichev wrote:
> > PLX switches have an issue that their internal registers become inaccessible
> > when runtime PM is enabled. Therefore PLX service tools can't communicate
> > with the hardware. A kernel option "pcie_port_pm=off" can be used as a
> > workaround. But it affects all the devices.
> > So this solution is to add PLX switch devices to the quirk list for
> > disabling runtime PM only for them.
> 
> I assume the problem is actually that the config space registers are
> inaccessible when the device is in D3hot?

Reading this again, I realize you said "internal registers".  I don't
know whether that actually means config space registers (which
*should* work even when the device is in D3hot (see the PCIe reference
below and PCI Power Management Spec r1.2, sec 5.4.1)), or MMIO
registers (which are not expected to work while in D3hot).

If the service tools read MMIO registers, presumably that goes through
some driver that should be able to manage runtime PM.  Or, if there's
no driver, I think your service tool could prevent runtime power
management by changing /sys/devices/.../power/control to "on" (see
Documentation/power/runtime_pm.txt).

Please repost this with more details.

> I think config space access is supposed to work when a device is in D3hot
> (see PCIe r4.0, sec 5.3.1.4).
> 
> If it doesn't work, wouldn't that mean that we couldn't even bring the
> device *out* of D3hot, since that requires a config write?
> 
> If this is really the problem, it'd be nice to identify this specifically
> instead of piggy-backing on the "is_hotplug_bridge" thing, which might be
> coincidentally related, but also carries other meanings.
> 
> > ---
> >  drivers/pci/quirks.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index a59ad09..8ea99aa 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -2923,6 +2923,17 @@ static void quirk_hotplug_bridge(struct pci_dev *dev)
> >  	dev->is_hotplug_bridge = 1;
> >  }
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HINT, 0x0020, quirk_hotplug_bridge);
> > +/*
> > + * Disable runtime PM for PLX Draco (1,2), Capella (1,2) series PCIe switches
> > + * to prevent service tools from failing to access hardware registers.
> > + */
> > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PLX, 0x8712, quirk_hotplug_bridge);
> > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PLX, 0x8733, quirk_hotplug_bridge);
> > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PLX, 0x8734, quirk_hotplug_bridge);
> > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PLX, 0x8780, quirk_hotplug_bridge);
> > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PLX, 0x8796, quirk_hotplug_bridge);
> > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PLX, 0x9781, quirk_hotplug_bridge);
> > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PLX, 0x9797, quirk_hotplug_bridge);
> >  
> >  /*
> >   * This is a quirk for the Ricoh MMC controller found as a part of some
> > -- 
> > 2.7.4
