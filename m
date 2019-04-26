Return-Path: <SRS0=ROz5=S4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C724C43218
	for <linux-pci@archiver.kernel.org>; Fri, 26 Apr 2019 17:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FFC82146E
	for <linux-pci@archiver.kernel.org>; Fri, 26 Apr 2019 17:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbfDZRQd (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 26 Apr 2019 13:16:33 -0400
Received: from foss.arm.com ([217.140.101.70]:46888 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726271AbfDZRQd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 26 Apr 2019 13:16:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A624AA78;
        Fri, 26 Apr 2019 10:16:32 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 40DFD3F5AF;
        Fri, 26 Apr 2019 10:16:31 -0700 (PDT)
Date:   Fri, 26 Apr 2019 18:16:26 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Remi Pommarel <repk@triplefau.lt>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH] pci: aardvark: Wait for endpoint to be ready before
 training link
Message-ID: <20190426171626.GA11753@e121166-lin.cambridge.arm.com>
References: <20190313213752.1246-1-repk@triplefau.lt>
 <20190423163215.GB26523@red-moon>
 <20190423222917.GN2754@voidbox.localdomain>
 <20190424165002.GA26089@e121166-lin.cambridge.arm.com>
 <20190425210826.GQ2754@voidbox.localdomain>
 <20190426161050.GA189964@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426161050.GA189964@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 26, 2019 at 11:10:50AM -0500, Bjorn Helgaas wrote:
> On Thu, Apr 25, 2019 at 11:08:27PM +0200, Remi Pommarel wrote:
> > On Wed, Apr 24, 2019 at 05:50:02PM +0100, Lorenzo Pieralisi wrote:
> > > On Wed, Apr 24, 2019 at 12:29:18AM +0200, Remi Pommarel wrote:
> > > > On Tue, Apr 23, 2019 at 05:32:15PM +0100, Lorenzo Pieralisi wrote:
> > > > > On Wed, Mar 13, 2019 at 10:37:52PM +0100, Remi Pommarel wrote:
> > > > > > When configuring pcie reset pin from gpio (e.g. initially set by
> > > > > > u-boot) to pcie function this pin goes low for a brief moment
> > > > > > asserting the PERST# signal. Thus connected device enters fundamental
> > > > > > reset process and link configuration can only begin after a minimal
> > > > > > 100ms delay (see [1]).
> > > > > > 
> > > > > > This makes sure that link is configured after at least 100ms from
> > > > > > beginning of probe() callback (shortly after the reset pin function
> > > > > > configuration switch through pinctrl subsytem).
> > > 
> > > I am a bit lost, what's the connection between the probe() callback
> > > and the reset pin function configuration ?
> > 
> > So currently u-boot configures the reset pin as a GPIO set to high. The
> > espressobin devicetree defines a default pinctrl to configure this pin
> > as a PCIe reset function.
> > 
> > As you can see in drivers/base/dd.c, driver_probe_device() calls
> > really_probe() which first calls pinctrl_bind_pins() then shortly after
> > drv->probe() callback. The pinctrl_bind_pins() function applies the
> > default state. So here, just before drv->probe() gets called our reset
> > pin goes from GPIO function to PCIe reset one making it going low for a
> > short time during this transition.
> > 
> > Because the pin goes low then gets back to high, PERST# signal is
> > asserted then deasserted and device enters fundamental reset process
> > just before drv->probe() is called. So in order to reduce the waiting
> > time to a minimum I sample jiffies at the very beginning of the probe
> > function, which is the closer spot from where PERST# is deasserted.
> > 
> > To sum up:
> > 
> > driver_probe_device() {
> > 	...
> > 	really_probe() {
> > 		...
> > 		pinctrl_bind_pins(); /* Here PERST# is asserted because pin configuration changes */
> > 		...
> > 		drv->probe();
> 
> Ah, I see.  Hmmm.  This definitely warrants a comment in
> advk_pcie_probe() about the connection.
> 
> I appreciate that ab78029ecc34 ("drivers/pinctrl: grab default handles
> from device core") saves some boilerplate from drivers, but ... at the
> same time, it makes for some non-obvious implicit connections like
> this.  I'm not sure whether having the boilerplate or the comment is
> worse.  But I'm pretty sure the "no boilerplate, no comment" option is
> the worst of the three :)

Yes, it is horrible. Can't this be managed explicitly through
the reset core code (drivers/reset/) ? I really do not like
this implicit reset going on behind the scenes, I will have
a look to understand how other controllers handle this.

Lorenzo
