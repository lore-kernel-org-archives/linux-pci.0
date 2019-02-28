Return-Path: <SRS0=y4Wk=RD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD25BC43381
	for <linux-pci@archiver.kernel.org>; Thu, 28 Feb 2019 06:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6095214D8
	for <linux-pci@archiver.kernel.org>; Thu, 28 Feb 2019 06:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731068AbfB1Gnx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 28 Feb 2019 01:43:53 -0500
Received: from bmailout2.hostsharing.net ([83.223.90.240]:45713 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730977AbfB1Gnw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Feb 2019 01:43:52 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id CBEAF2800B3C2;
        Thu, 28 Feb 2019 07:43:50 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 524576F40E; Thu, 28 Feb 2019 07:43:50 +0100 (CET)
Date:   Thu, 28 Feb 2019 07:43:50 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Alex_Gagniuc@Dellteam.com
Cc:     mr.nuke.me@gmail.com, helgaas@kernel.org, Austin.Bolen@dell.com,
        Shyam.Iyer@dell.com, bhelgaas@google.com,
        rafael.j.wysocki@intel.com, keith.busch@intel.com,
        poza@codeaurora.org, mika.westerberg@linux.intel.com,
        fred@fredlawl.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: pciehp: Report degraded links via link bandwidth
 notification
Message-ID: <20190228064350.zqq6gl6l4pxlj45x@wunner.de>
References: <20181129230454.GF178809@google.com>
 <20181207182021.16344-1-mr.nuke.me@gmail.com>
 <20190225022857.awuspuxb4bedirjp@wunner.de>
 <a941304f8cc244adb265aa7c27027938@ausx13mps317.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a941304f8cc244adb265aa7c27027938@ausx13mps317.AMER.DELL.COM>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 27, 2019 at 08:21:58PM +0000, Alex_Gagniuc@Dellteam.com wrote:
> On 2/24/19 8:29 PM, Lukas Wunner wrote:
> > On Fri, Dec 07, 2018 at 12:20:00PM -0600, Alexandru Gagniuc wrote:
> > > Q: Why is this unconditionally compiled in?
> > > A: The symmetrical check in pci probe() is also always compiled in.
> > 
> > Hm, it looks like the convention is to provide a separate Kconfig entry
> > for each port service.
> 
> Does the convention still make sense in light of the symmetry reason?

I don't know.  In the past we had OpenWRT/LEDE folks complain that
the PCI core is hogging too much memory on their space-constrained
Mips routers, so they #ifdef'ed a lot of x86-specific stuff in
quirks.c.  In the same vein they could argue that they'd like to
disable unneeded PCIe services.  That space argument and possibly
the reduction of attack surface on Linux firewalls is the only
justification I can come up with for a separate Kconfig option for
bandwidth notification.

Thanks,

Lukas
