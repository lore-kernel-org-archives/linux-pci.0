Return-Path: <SRS0=ROz5=S4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C9CC43219
	for <linux-pci@archiver.kernel.org>; Fri, 26 Apr 2019 16:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93960208CB
	for <linux-pci@archiver.kernel.org>; Fri, 26 Apr 2019 16:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556295053;
	bh=AdIVBpnWD4EKRko4Qg1W+qoIdwT0atGxH5KyjTAjmLY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lJjvYXRwKV8fdoNBfN7cqfNZ/UIjni6M7nhMCnGeQj6E4131YqKa8Re1QL1a81exU
	 YF7l7WzMtWlPY7aZmDo+fFo2c/3aLBvWMhivGx5se3L34K+906QqmXxBnvqX3OLHVg
	 lwABDvqdz8N2vMOjE0Xlg/WeZUgbAlb2+t51KWh4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbfDZQKx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 26 Apr 2019 12:10:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:54604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbfDZQKw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 26 Apr 2019 12:10:52 -0400
Received: from localhost (173-25-63-173.client.mchsi.com [173.25.63.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE1C820B7C;
        Fri, 26 Apr 2019 16:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556295051;
        bh=AdIVBpnWD4EKRko4Qg1W+qoIdwT0atGxH5KyjTAjmLY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NblDReoEcEdKXjkOnUMB3hntAPt6i8qWP0cbksb59jsvVofe8n26ccSx++CJcH6TA
         gstldZ+aLEByveeMspV33ZGgll/aZW2RM5X9urMuzgIrxt/C0KcVbXD+8WzHBRVoYy
         13E4n0CdIIy/WTkpKR23mrMPc4kCTiNIQLPHSsiw=
Date:   Fri, 26 Apr 2019 11:10:50 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Remi Pommarel <repk@triplefau.lt>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH] pci: aardvark: Wait for endpoint to be ready before
 training link
Message-ID: <20190426161050.GA189964@google.com>
References: <20190313213752.1246-1-repk@triplefau.lt>
 <20190423163215.GB26523@red-moon>
 <20190423222917.GN2754@voidbox.localdomain>
 <20190424165002.GA26089@e121166-lin.cambridge.arm.com>
 <20190425210826.GQ2754@voidbox.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425210826.GQ2754@voidbox.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 25, 2019 at 11:08:27PM +0200, Remi Pommarel wrote:
> On Wed, Apr 24, 2019 at 05:50:02PM +0100, Lorenzo Pieralisi wrote:
> > On Wed, Apr 24, 2019 at 12:29:18AM +0200, Remi Pommarel wrote:
> > > On Tue, Apr 23, 2019 at 05:32:15PM +0100, Lorenzo Pieralisi wrote:
> > > > On Wed, Mar 13, 2019 at 10:37:52PM +0100, Remi Pommarel wrote:
> > > > > When configuring pcie reset pin from gpio (e.g. initially set by
> > > > > u-boot) to pcie function this pin goes low for a brief moment
> > > > > asserting the PERST# signal. Thus connected device enters fundamental
> > > > > reset process and link configuration can only begin after a minimal
> > > > > 100ms delay (see [1]).
> > > > > 
> > > > > This makes sure that link is configured after at least 100ms from
> > > > > beginning of probe() callback (shortly after the reset pin function
> > > > > configuration switch through pinctrl subsytem).
> > 
> > I am a bit lost, what's the connection between the probe() callback
> > and the reset pin function configuration ?
> 
> So currently u-boot configures the reset pin as a GPIO set to high. The
> espressobin devicetree defines a default pinctrl to configure this pin
> as a PCIe reset function.
> 
> As you can see in drivers/base/dd.c, driver_probe_device() calls
> really_probe() which first calls pinctrl_bind_pins() then shortly after
> drv->probe() callback. The pinctrl_bind_pins() function applies the
> default state. So here, just before drv->probe() gets called our reset
> pin goes from GPIO function to PCIe reset one making it going low for a
> short time during this transition.
> 
> Because the pin goes low then gets back to high, PERST# signal is
> asserted then deasserted and device enters fundamental reset process
> just before drv->probe() is called. So in order to reduce the waiting
> time to a minimum I sample jiffies at the very beginning of the probe
> function, which is the closer spot from where PERST# is deasserted.
> 
> To sum up:
> 
> driver_probe_device() {
> 	...
> 	really_probe() {
> 		...
> 		pinctrl_bind_pins(); /* Here PERST# is asserted because pin configuration changes */
> 		...
> 		drv->probe();

Ah, I see.  Hmmm.  This definitely warrants a comment in
advk_pcie_probe() about the connection.

I appreciate that ab78029ecc34 ("drivers/pinctrl: grab default handles
from device core") saves some boilerplate from drivers, but ... at the
same time, it makes for some non-obvious implicit connections like
this.  I'm not sure whether having the boilerplate or the comment is
worse.  But I'm pretty sure the "no boilerplate, no comment" option is
the worst of the three :)

> > > > > [1] "PCI Express Base Specification", REV. 2.1
> > > > >         PCI Express, March 4 2009, 6.6.1 Conventional Reset

> > > > > +/* Endpoint can take up to 100ms to be ready after a reset */
> > > > > +#define ENDPOINT_RST_MS			100

> So doing that I do a msleep() of around 75-80ms instead of 100ms. So,
> yes, are 20ms enough to justify that, or should we just go with a plain
> msleep(100) to improve legibility.

I vote for 100ms so it's easily tied to the spec.  We *should* have a
PCI core #define for that to make it even easier.

PCI_PM_D3COLD_WAIT might be close, but we might need some cleanup in
this area.  There are a whole bunch of "msleep(100)" calls in
drivers/pci that probably should use the same #define.  Somebody
should look through pci_af_flr(), pcie_flr(), pci_pm_reset(),
pcie_wait_for_link(), to see if we can use a common constant.

Bjorn
