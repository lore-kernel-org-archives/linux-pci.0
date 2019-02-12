Return-Path: <SRS0=P0ok=QT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A53C282C4
	for <linux-pci@archiver.kernel.org>; Tue, 12 Feb 2019 10:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1671D21901
	for <linux-pci@archiver.kernel.org>; Tue, 12 Feb 2019 10:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbfBLKhC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 12 Feb 2019 05:37:02 -0500
Received: from bmailout1.hostsharing.net ([83.223.95.100]:48015 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbfBLKhC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Feb 2019 05:37:02 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 5013A300002BC;
        Tue, 12 Feb 2019 11:37:00 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 2C0C757528; Tue, 12 Feb 2019 11:37:00 +0100 (CET)
Date:   Tue, 12 Feb 2019 11:37:00 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Alex_Gagniuc@Dellteam.com
Cc:     mr.nuke.me@gmail.com, bhelgaas@google.com, Austin.Bolen@dell.com,
        keith.busch@intel.com, Shyam.Iyer@dell.com, gustavo@embeddedor.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: pciehp: Do not turn off slot if presence comes up
 after link
Message-ID: <20190212103700.iqhprfelukalbhdl@wunner.de>
References: <20190205210701.25387-1-mr.nuke.me@gmail.com>
 <20190209115849.244u67h7wmn3eb7o@wunner.de>
 <52afa1c45f684dbda6a8771b65583a22@ausx13mps321.AMER.DELL.COM>
 <20190212083031.2no7mzn5xug7nba3@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212083031.2no7mzn5xug7nba3@wunner.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 12, 2019 at 09:30:31AM +0100, Lukas Wunner wrote:
> Instead of modifying the logic in pciehp_handle_presence_or_link_change(),
> you could amend pcie_wait_for_link() to poll PDS until it's set, in
> addition to DLLLA.  The rationale would be that although the link is up,
> the hot-added device cannot really be considered accessible until PDS
> is also set.  Unfortunately we cannot do this for all devices because
> (as I've said before), some broken devices hardwire PDS to zero.  But
> it should be safe to constrain it to those which can disable in-band
> presence.

An alternative approach would of course be to only enable one of PDC or
DLLSC events if in-band presence is disabled.  In the case of DLLSC,
you'd also need to modify pciehp_reset_slot() in addition to
pcie_enable_notification().

Thanks,

Lukas
