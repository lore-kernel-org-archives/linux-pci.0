Return-Path: <SRS0=s0ql=P7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E9CC282C0
	for <linux-pci@archiver.kernel.org>; Wed, 23 Jan 2019 19:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2628F218A1
	for <linux-pci@archiver.kernel.org>; Wed, 23 Jan 2019 19:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbfAWTP3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 23 Jan 2019 14:15:29 -0500
Received: from bmailout1.hostsharing.net ([83.223.95.100]:58687 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfAWTP2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Jan 2019 14:15:28 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 31AC630000CCF;
        Wed, 23 Jan 2019 20:15:27 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 15DFD31B0F; Wed, 23 Jan 2019 20:15:27 +0100 (CET)
Date:   Wed, 23 Jan 2019 20:15:27 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Keith Busch <keith.busch@intel.com>
Cc:     Alex_Gagniuc@Dellteam.com, linux-pci@vger.kernel.org,
        bhelgaas@google.com, Austin.Bolen@dell.com
Subject: Re: PCI: hotplug: Erroneous removal of hotplug PCI devices
Message-ID: <20190123191527.sp44r4la5vgln4el@wunner.de>
References: <356432a0556d4da59f8ba5cf1d750019@ausx13mps317.AMER.DELL.COM>
 <20190123184453.GB6629@localhost.localdomain>
 <20190123190204.csjedbvcxkjlr43d@wunner.de>
 <20190123190738.GC6629@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123190738.GC6629@localhost.localdomain>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 23, 2019 at 12:07:38PM -0700, Keith Busch wrote:
> Right, so in Alex's case, it looks like we are observing
> pcie_wait_for_link() returning true before the PDC event.
> 
> I'm wondering about PDS because if the link is up but Presence reports an
> empty slot, does that matter for any implementations? Or is it perfectly
> fine to enumerate an active link on an empty slot? An empty slot and
> active link doesn't make a lot of sense, but that observation appears to
> be what is reported here.

We allow enumeration with an active link of an allegedly empty slot
because some hardware hardwires PDS to zero, see commit 80696f991424
("PCI: pciehp: Tolerate Presence Detect hardwired to zero").

The brokenness of PCIe hotplug implementations found in the wild is
astonishing.

Thanks,

Lukas
