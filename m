Return-Path: <SRS0=+kTV=QQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8D0C282C4
	for <linux-pci@archiver.kernel.org>; Sat,  9 Feb 2019 11:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22EE620818
	for <linux-pci@archiver.kernel.org>; Sat,  9 Feb 2019 11:58:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfBIL6w (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 9 Feb 2019 06:58:52 -0500
Received: from bmailout1.hostsharing.net ([83.223.95.100]:51929 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbfBIL6w (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 9 Feb 2019 06:58:52 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id B47C830000D2F;
        Sat,  9 Feb 2019 12:58:49 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 8A537AEC8D; Sat,  9 Feb 2019 12:58:49 +0100 (CET)
Date:   Sat, 9 Feb 2019 12:58:49 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc:     bhelgaas@google.com, austin_bolen@dell.com,
        alex_gagniuc@dellteam.com, keith.busch@intel.com,
        Shyam_Iyer@Dell.com,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: pciehp: Do not turn off slot if presence comes up
 after link
Message-ID: <20190209115849.244u67h7wmn3eb7o@wunner.de>
References: <20190205210701.25387-1-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190205210701.25387-1-mr.nuke.me@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 05, 2019 at 03:06:56PM -0600, Alexandru Gagniuc wrote:
> According to PCIe 3.0, the presence detect state is a logical OR of
> in-band and out-of-band presence.

Since Bjorn asked for a spec reference:

PCIe r4.0 sec 7.8.11: "Presence Detect State - This bit indicates the
presence of an adapter in the slot, reflected by the logical OR of the
Physical Layer in-band presence detect mechanism and, if present, any
out-of-band presence detect mechanism defined for the slot's
corresponding form factor."

Table 4-14 in sec 4.2.6 is also important because it shows the difference
between Link Up and in-band presence.


> With this, we'd expect the presence
> state to always be asserted when the link comes up.
> 
> Not all hardware follows this, and it is possible for the presence to
> come up after the link. In this case, the PCIe device would be
> erroneously disabled and re-probed. It is possible to distinguish
> between a delayed presence and a card swap by looking at the DLL state
> changed bit -- The link has to come down if the card is removed.

So in reality, PDC and DLLSC events rarely come in simultaneously and
we do allow some leeway in pcie_wait_for_link(), it's just not enough
in your particular case due to the way presence is detected by the
platform.

I think in this case instead of changing the behavior for everyone,
it's more appropriate to add a quirk for your hardware.  Two ideas:

* Amend pcie_init() to set slot_cap |= PCI_EXP_SLTCAP_ABP.  Insert
  this as a quirk right below the existing Thunderbolt quirk and
  use PCI vendor/device IDs and/or DMI checks to identify your
  particular hardware.  If the ABP bit is set, PDC events are not
  enabled by pcie_enable_notification(), so you will solely rely on
  DLLSC events.  Problem solved.  (Hopefully.)

* Alternatively, add a DECLARE_PCI_FIXUP_FINAL() quirk which sets
  pdev->link_active_reporting = false.  This causes pcie_wait_for_link()
  to wait 1100 msec before the hot-added device's config space is
  accessed for the first time.

Would this work for you?

Thanks,

Lukas
