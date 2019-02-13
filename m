Return-Path: <SRS0=kgfr=QU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDC3C282C2
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 08:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 266ED222B6
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 08:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733220AbfBMIqK (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 13 Feb 2019 03:46:10 -0500
Received: from mailout2.hostsharing.net ([83.223.90.233]:40147 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732843AbfBMIqK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Feb 2019 03:46:10 -0500
X-Greylist: delayed 574 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Feb 2019 03:46:09 EST
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout2.hostsharing.net (Postfix) with ESMTPS id 03D1B10189CEE;
        Wed, 13 Feb 2019 09:36:34 +0100 (CET)
Received: from localhost (p57BD742B.dip0.t-ipconnect.de [87.189.116.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 87C36603E21B;
        Wed, 13 Feb 2019 09:36:33 +0100 (CET)
Date:   Wed, 13 Feb 2019 09:36:32 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Alex_Gagniuc@Dellteam.com
Cc:     mr.nuke.me@gmail.com, bhelgaas@google.com, Austin.Bolen@dell.com,
        keith.busch@intel.com, Shyam.Iyer@dell.com, gustavo@embeddedor.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: pciehp: Do not turn off slot if presence comes up
 after link
Message-ID: <20190213083632.GA3387@wunner.de>
References: <20190205210701.25387-1-mr.nuke.me@gmail.com>
 <20190209115849.244u67h7wmn3eb7o@wunner.de>
 <52afa1c45f684dbda6a8771b65583a22@ausx13mps321.AMER.DELL.COM>
 <20190212083031.2no7mzn5xug7nba3@wunner.de>
 <b2fffa5beb7941ebaceb8b8ce6e5b133@ausx13mps321.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2fffa5beb7941ebaceb8b8ce6e5b133@ausx13mps321.AMER.DELL.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 12, 2019 at 11:57:55PM +0000, Alex_Gagniuc@Dellteam.com wrote:
> The recommendation is to set the "in-band PD disable" bit, and it's
> possible that platform firmware may have set it at boot time

Ok, then I'd suggest to check in pcie_init() whether the feature is
supported and enable it if so.  And store that fact in a flag, either
in struct pci_dev or struct controller.


> (*) A bit hypothetical: There is no hardware yet implementing the ECN.

Hm, this contradicts Austin Bolen's e-mail of Jan 25 that "Yes, this
platform disables in-band presence" (when asked whether your host
controller already adheres to the ECN).


> I'm 
> not sure that there is a spec-justifiable reason to not access a device 
> whose DLL is up, but PD isn't.

Austin asked in an e-mail of Jan 24 whether "the hot-inserted device's
config space [is] accessed immediately after waiting this 20 + 100 ms
delay", which sounded to me like you'd prefer the device not to be
accessed until PDS is 1.  This can be achieved by polling PDS in
pcie_wait_for_link() if in-band presence is disabled, which is why
I suggested it.


> > Be mindful however that pcie_wait_for_link() is also called from the
> > DPC driver.  Keith should be able to judge whether a change to that
> > function breaks DPC.
> 
> That's why I went for ammending pciehp_handle_presence_or_link_change(). 
> Smaller bug surface ;). What I'm thinking at this point is, keep the 
> patch as is, but, also check for in-band PD disable before aborting the 
> shutdown. Old behavior stays the same.

I'm worried that amending pciehp_handle_presence_or_link_change() makes
the event handling logic more difficult to understand.  Polling PDS in
pcie_wait_for_link() or disabling either PDC or DLLSC if in-band presence
is disabled seems simpler to reason about.


> in-band PD disable (what's a good acronym for that, BTW?)

I don't know, maybe inband_presence_disabled?

Thanks,

Lukas
