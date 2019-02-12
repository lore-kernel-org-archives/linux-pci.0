Return-Path: <SRS0=P0ok=QT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4253BC282C4
	for <linux-pci@archiver.kernel.org>; Tue, 12 Feb 2019 08:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A4CE218AD
	for <linux-pci@archiver.kernel.org>; Tue, 12 Feb 2019 08:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbfBLIae (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 12 Feb 2019 03:30:34 -0500
Received: from bmailout1.hostsharing.net ([83.223.95.100]:47383 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728218AbfBLIae (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Feb 2019 03:30:34 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id AB90C30000CD5;
        Tue, 12 Feb 2019 09:30:31 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 621403187A; Tue, 12 Feb 2019 09:30:31 +0100 (CET)
Date:   Tue, 12 Feb 2019 09:30:31 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Alex_Gagniuc@Dellteam.com
Cc:     mr.nuke.me@gmail.com, bhelgaas@google.com, Austin.Bolen@dell.com,
        keith.busch@intel.com, Shyam.Iyer@dell.com, gustavo@embeddedor.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: pciehp: Do not turn off slot if presence comes up
 after link
Message-ID: <20190212083031.2no7mzn5xug7nba3@wunner.de>
References: <20190205210701.25387-1-mr.nuke.me@gmail.com>
 <20190209115849.244u67h7wmn3eb7o@wunner.de>
 <52afa1c45f684dbda6a8771b65583a22@ausx13mps321.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52afa1c45f684dbda6a8771b65583a22@ausx13mps321.AMER.DELL.COM>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 11, 2019 at 11:48:12PM +0000, Alex_Gagniuc@Dellteam.com wrote:
> On 2/9/19 5:58 AM, Lukas Wunner wrote:
> ECN [1] was approved last November, so it's normative spec text. Sorry 
> if the Ukranians didn't get ahold of it yet. I'll try to explain the delta.
> There's an in-band PD supported/disable set of bits. If 'supported' is 
> set, then you can set 'disable', which removes the 'logical OR" and now 
> PD is only out-of-band presence.

I see, thanks a lot for relaying this information.  The PCI SIG
should probably consider granting access to specs to open source
developers to ease adoption of new features in Linux et al.


> > Table 4-14 in sec 4.2.6 is also important because it shows the difference
> > between Link Up and in-band presence.
> 
> So, we'd expect PD to come up at the same time or before DLL?

Per table 4-14 and figure 4-23 (immediately below the table) in r4.0,
PDC ought to be signaled before DLLSC.  As said, Linux can handle PDC
after DLLSC if they're not too far apart (100 ms, see pcie_wait_for_link()).


> I'd like a generic solution. I suspect supporting 'in-band PD disabled' 
> and quirking for that would be a saner way to do things. If we support 
> it, then we need to handle PDSC after DLLSC scenarios anyway.

I agree, having support for this new ECN would be great.

If you look at struct controller in drivers/pci/hotplug/pciehp.h,
there's a section labelled /* capabilities and quirks */.  An idea
would be to add an unsigned int there to indicate whether in-band
presence is disabled.  An alternative would be to add a flag to
struct pci_dev.

Instead of modifying the logic in pciehp_handle_presence_or_link_change(),
you could amend pcie_wait_for_link() to poll PDS until it's set, in
addition to DLLLA.  The rationale would be that although the link is up,
the hot-added device cannot really be considered accessible until PDS
is also set.  Unfortunately we cannot do this for all devices because
(as I've said before), some broken devices hardwire PDS to zero.  But
it should be safe to constrain it to those which can disable in-band
presence.

Be mindful however that pcie_wait_for_link() is also called from the
DPC driver.  Keith should be able to judge whether a change to that
function breaks DPC.

You'll probably also need to add code to disable in-band presence if
that is supported, either in pcie_init() in pciehp_hpc.c or in generic
PCI code.

Thanks,

Lukas
